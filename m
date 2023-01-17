Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5541666E71F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjAQTja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbjAQTfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:35:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8627F59EB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:40:36 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 12FA61EC05F1;
        Tue, 17 Jan 2023 19:40:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673980835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1F8maljyKQNt6VcbQsZw48UBmwgKmU5r3RYOnKqnc6w=;
        b=OQW61y0WZJIhpiZ8GSDtNld9hj1Ja13IX/+s1jkrVSH+d8geiOWNO+bHDtLuM9dkdC1GFg
        07TvawWaYzjjwg8q8/jIayM+7MZFmrHEfXwjzo7ZhsePAS4+AJkgWqnWooA0nSrkWuA2vs
        NyvTYmqF9a/FtAR2+pGfjgh6ObGBx6I=
Date:   Tue, 17 Jan 2023 19:40:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, alison.schofield@intel.com,
        reinette.chatre@intel.com, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Message-ID: <Y8brnyIltcgtUvPn@zn.tnic>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-7-ashok.raj@intel.com>
 <Y8ROaoJtUtj5bPcx@zn.tnic>
 <Y8bI4BBst78qrApD@a4bf019067fa.jf.intel.com>
 <e491fe87-2c2a-e9d2-3cd9-dfc7535f7c27@intel.com>
 <Y8bnEgP6iXCL+QmX@zn.tnic>
 <832b5c6c-cafa-e9e6-6e52-b741315d0865@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <832b5c6c-cafa-e9e6-6e52-b741315d0865@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:32:50AM -0800, Dave Hansen wrote:
> Well, we have an awful lot of pr_warn()'s in the kernel that talk about
> something that was tried and failed.

Well, is microcode loading failure worth to warn about?

What if there's no microcode for that CPU?

Now imagine in that case you issue a warning and then you get all those
bugzillas opened:

"Heeey, is my CPU broken, it says it cannot load microcode"

I sure don't want to be on the receiving end of this.

I don't think you wanna be there either.

> I actually kinda like the inverse.
> 
> The common (boring) case where an update was needed and was successful.
> It's the one we don't need to tell users about at all.  It barely
> deserves a message.  Users expect that if there's an early update
> available, it'll get attempted, it will be successful and the kernel
> won't say much.

No argument there.

> The time we need to spam dmesg is when something upends user
> expectations and they might need to go do something.  An early loading
> failure is exactly the place where they want to know.  They want to know
> if they're running with known CPU bugs that would have been fixed by the
> early update

No, we already warn about that in the CPU mitigations code.

> or if they somehow have a botched early loading image.

If you can pick apart from this here:

        /* write microcode via MSR 0x79 */
        native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);

what type of failure it is, then sure, let's warn.

But we should not warn just for every revision mismatch in there...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
