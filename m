Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2B0695F40
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjBNJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjBNJc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:32:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B3C1BCF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:32:27 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5FA501EC08BF;
        Tue, 14 Feb 2023 10:32:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676367146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fQgdfPdv5IbY5cjTtif8wZ2LVGgZcfMSUHyLgK6pkrs=;
        b=EB1Hnf7ESNTSiJOA07Nf1Fb2ktw9Lxhh60+dGPEBvYWvJRvEo3Ikum/jxkZc2AUgrmxX3r
        sq8Y0Sgu/gHHtvFzF0S5OiaUk6fgGBUrFQ9fLHzX0J13TwoGj3WEl89WJJbxiqvO1P5uWZ
        N2A/JA0a1OLoXvxCkokXWC9Zvhzv1h4=
Date:   Tue, 14 Feb 2023 10:32:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Message-ID: <Y+tVJkzkeVkf1q2a@zn.tnic>
References: <Y+pTDFQlX9qNL35z@zn.tnic>
 <85de8576-05b7-400d-6020-7dba519c1d2e@suse.com>
 <Y+pZ5ccprqequvpE@zn.tnic>
 <ca2e1560-5846-2a4b-6c27-aa8ceb17ee5c@suse.com>
 <Y+qHMsZhYaYEmtTo@zn.tnic>
 <6f561386-9bc4-a3bf-656d-db27a2275413@suse.com>
 <Y+tNQvpXdOAfZztQ@zn.tnic>
 <3520cd7f-0e60-b140-9fd3-032ddb6778b5@suse.com>
 <Y+tP7fvvSFSSCznH@zn.tnic>
 <807cca5b-06b9-da85-738b-d88fc10298cb@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <807cca5b-06b9-da85-738b-d88fc10298cb@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 10:17:12AM +0100, Juergen Gross wrote:
> I guess this largely depends on the functionality. I don't see why anyone
> would try to use MTRR overwrite functionality without really needing it.
>
> But maybe I'm wrong here and I'm under-estimating the "creativity" of
> kernel hackers.

This is exactly it - if it is there, it will get used eventually.

Think of it this way: this is a special, well, kinda hack, if you will,
which *nothing* else would need. We can always relax the condition for
using it if something else appears with a valid use case.

What we can't do nearly as easily is the reverse: remove it or tighten
the check later.

So the general policy is: workarounds like this need to be as
specialized as possible.

> Maybe I haven't seen enough crazy hacks yet. :-)

You're kidding, right? You hack on Xen for a long time... :-P

> No need to further discuss this topic from my side, as I have voiced my
> opinion and you did so, too. I will add the tests you are asking for.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
