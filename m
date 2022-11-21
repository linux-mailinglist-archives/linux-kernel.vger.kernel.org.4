Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235B0632D07
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiKUTcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKUTcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:32:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9014DB94AE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:32:23 -0800 (PST)
Received: from zn.tnic (p200300ea9733e725329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e725:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1776E1EC03EA;
        Mon, 21 Nov 2022 20:32:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669059142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HQpY3CQUegTWmCkXgl99eMU+GJMLVl1pHik0VEKN398=;
        b=RpyjW+RnJoei/zRyuH5PLniHkwML66D2kzVkDqU03MjOfwAwSZUcs701swyCcc50YZHq3w
        Q6P0d4inEnm5SyPxaeRq2FdfyRUWu9JXtk+pqoAfQIqpzzY1sqSpe3ALUZ6SMblKkZ5eWi
        BlwulgbSmUFNyZ6OUie9wa+fVz8NTUI=
Date:   Mon, 21 Nov 2022 20:32:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>, Chris Mason <clm@meta.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] error-injection: Add prompt for function error injection
Message-ID: <Y3vSQo85ofkfD/L8@zn.tnic>
References: <20221121104403.1545f9b5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221121104403.1545f9b5@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:44:03AM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The config to be able to inject error codes into any function annotated
> with ALLOW_ERROR_INJECTION() is enabled when CONFIG_FUNCTION_ERROR_INJECTION
> is enabled. But unfortunately, this is always enabled on x86 when KPROBES
> is enabled, and there's no way to turn it off.
> 
> As kprobes is useful for observability of the kernel, it is useful to have
> it enabled in production environments. But error injection should be
> avoided. Add a prompt to the config to allow it to be disabled even when
> kprobes is enabled, and get rid of the "def_bool y".
> 
> This is a kernel debug feature (it's in Kconfig.debug), and should have
> never been something enabled by default.
> 
> Cc: stable@vger.kernel.org
> Fixes: 540adea3809f6 ("error-injection: Separate error-injection from kprobe")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  lib/Kconfig.debug | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

As stated on another thread, debugging production kernels where folks
have been injecting errors into functions is not something anyone would
like to and have to do. Especially if from looking at system dumps, it
is not even clear what has been injected and why, rendering the system
unstable and the issue probably unreproducible.

Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
