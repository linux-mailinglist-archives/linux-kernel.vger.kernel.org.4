Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349C568A6E4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 00:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjBCXZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 18:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjBCXZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 18:25:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7894A07ED
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 15:25:55 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1ED0B1EC06DA;
        Sat,  4 Feb 2023 00:25:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675466754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pRJaX6UM8ZaX0NAjHi1vNdZCVq4AETDYUE9NPOtt05M=;
        b=d5Bd1hy5Kr/f0bpzDql7ygg7B4BedAoPheS4trklshPrUNRCMy2WEl1FoX/2apUlw+J9P2
        1aPMav9cp8sCYQ6tKQGH9KN0M1BJpEHKLeGXmPqZKxVhgLEpyw967eJXvN0/wcpcgt6481
        GfB2U3L/GP7KVs4CFjB6W3e4a76qH8k=
Date:   Sat, 4 Feb 2023 00:25:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86/alternative: Support relocations in alternatives
Message-ID: <Y92X/acVxZC84Zcm@zn.tnic>
References: <Y9py2a5Xw0xbB8ou@hirez.programming.kicks-ass.net>
 <Y90IaYHDbCN9P0OX@zn.tnic>
 <Y90ilxBFMAQZ/dRg@hirez.programming.kicks-ass.net>
 <Y90wk4FVBtmFJZ4s@zn.tnic>
 <Y906d8b6xhC17AAV@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y906d8b6xhC17AAV@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 05:46:47PM +0100, Borislav Petkov wrote:
> On Fri, Feb 03, 2023 at 05:04:35PM +0100, Borislav Petkov wrote:
> > Rest on IRC. :)
> 
> Here's what I'm thinking. It still fails somewhere while booting so it
> is not good yet but the idea is to show what I mean:

Yeah, forget it. I need both next_rip at the place we're patching and
next_rip in the .altinstr_replacement section. And by the time I do
that, it won't get any prettier.

And I think yours solves that more elegantly but please document the
math transformation to compute the new offset.

Also, pls do this:

	/*
	 * Do not recompute the offset if the target is within the
	 * patched insn block.
	 */
	if (target < repl || target > repl + repl_len)

to hint that you don't have to replace the offsets which are already
correct when a whole set of insns is being patched in.

FILL_RETURN_BUFFER was one example. :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
