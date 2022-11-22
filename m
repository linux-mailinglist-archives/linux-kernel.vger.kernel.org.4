Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DBA634375
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiKVSQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiKVSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:16:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9A9729A7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 10:16:46 -0800 (PST)
Received: from zn.tnic (p200300ea9733e79b329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e79b:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8DE8F1EC0532;
        Tue, 22 Nov 2022 19:16:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669141004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NOAwg1GH4Aeud6ZcXb4+YxTLG8/FMKmU+z9fzWBgP3k=;
        b=qp5uxKNc8hFWbLuZTSNGhTNaXhPQw44nS0DXtgX0NCNpNRop6+HVtwrYiB6pfAMnfExyFH
        00BXwUkTQnFOx6f6RDtIXaRvbQV1PsKg3LpvdrFSFclXU5rqR4LXFslZWKQTTs8sQexlZt
        +w7tP0L+oPMj/ttVfn/pxqe8UA7Z3c8=
Date:   Tue, 22 Nov 2022 19:16:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chris Mason <clm@meta.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] error-injection: Add prompt for function error injection
Message-ID: <Y30SCIY8RvtGkU6V@zn.tnic>
References: <20221121104403.1545f9b5@gandalf.local.home>
 <Y3vSQo85ofkfD/L8@zn.tnic>
 <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
 <Y3ymzAYRyH5IWEe/@zn.tnic>
 <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 12:42:33PM -0500, Chris Mason wrote:
> I think there are a few different sides to this:
> 
> - it makes total sense that we all have wildly different ideas about
> which tools should be available in prod.  Making this decision more fine
> grained seems reasonable.
> 
> - fault injection for testing: we have a stage of qualification that
> does error injection against the prod kernel.  It helps to have this
> against the debug kernel too, but that misses some races etc.  I always
> just assumed distros and partners did some fault injection tests against
> the prod kernel builds?

That's what the debug kernel flavor is for. At least on SLES.

That's why we have the MCE injection module in the debug flavor and not
in the production one. For the very same reason.

> - overriding return values for security fixes: also not a common thing,
> but it's a tool we've used.  There are usually better long term fixes,
> but it happens.

Yeah, that's what live patching is for.

> In other words, I really do care about the concerns you're expressing
> here, and I'm usually first in line to complain when random people make
> my job harder.  I'm just not seeing these issues with BPF, and I see
> them actively trying to increase safety over time.

So this might be your opinion and I respect it but your first paragraph
was spot on: to *have* the option to decide whether a company wants to
support that in production or not.

I'm sure it makes sense for you in your production scenarios but it
doesn't for us. At least not at this point.

And I think this should be disabled in our kernels for now. When the
team decides someday that they wanna deal with bug reports of people
doing fault injection, then sure by all means.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
