Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8AC65F780
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 00:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbjAEXOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 18:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjAEXOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 18:14:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1673A676E3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 15:14:15 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA1B31EC068E;
        Fri,  6 Jan 2023 00:14:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672960453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MNSXfz4m5shOmHSh2WUVIS4WJOht1d11VQUN1BAQyAQ=;
        b=Tj1AmzT6HkBmnWWY+h6OT0DBaVXA4PS7z1JyoElSP4qyy/LfF8MzT0xpGbJBQhDpEFlihE
        4brdy9Bfoq9bC7IoMIocjbUPdTxbmKdoyRYL8lMYWtHK3age3EJETwOMSL65MsHc3kaMsU
        kDMTdwIlS9aRSpMlWrIekJZgQ9jkUrc=
Date:   Fri, 6 Jan 2023 00:14:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com
Subject: Re: [BUG Report] undefined reference to `convert_to_fxsr'
Message-ID: <Y7dZwWsiUfHKxN3S@zn.tnic>
References: <50aa72a7-043d-8091-78de-458cbcc6c356@huawei.com>
 <Y6w49Y1d3lpv3KFn@zn.tnic>
 <23e2907c-5188-5ac6-3db8-1c5a12120bf2@huawei.com>
 <Y62vbjBzHF4rmh1V@zn.tnic>
 <e041533c-4005-b9bc-3985-02224985aa28@huawei.com>
 <Y67IlthBqaX69RwN@zn.tnic>
 <64fe1be4-954f-fe6f-44f0-59b572548663@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64fe1be4-954f-fe6f-44f0-59b572548663@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:05:01AM +0800, Miaohe Lin wrote:
> Yes, it still reproduces in my working server. It might be the problem of gcc
> version.

What is that compiler you're using? Where did you get the package from? Does it
have some out-of-tree patches in it?

> I think it's because convert_to_fxsr() is only defined when CONFIG_X86_32 or
> CONFIG_IA32_EMULATION is enabled.

No, convert_to_fxsr() is part of arch/x86/kernel/fpu/regset.c which is built-in
unconditionally.

What happens is this here:

bool fpu__restore_sig(void __user *buf, int ia32_frame)

	...

        } else {
                success = __fpu_restore_sig(buf, buf_fx, ia32_fxstate);
        }

That ia32_fxstate is false because

        ia32_frame &= (IS_ENABLED(CONFIG_X86_32) ||
                       IS_ENABLED(CONFIG_IA32_EMULATION));


neither of those config items are set...

        /*
         * Only FXSR enabled systems need the FX state quirk.
         * FRSTOR does not need it and can use the fast path.
         */
        if (ia32_frame && use_fxsr()) {
                buf_fx = buf + sizeof(struct fregs_state);
                size += sizeof(struct fregs_state);
                ia32_fxstate = true;
		^^^^^^^^^^^^^^^^^^^

... so this doesn't happen.

        }

Then, in __fpu_restore_sig() you have:

        if (likely(!ia32_fxstate)) {
                /* Restore the FPU registers directly from user memory. */
                return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
                                                state_size);
        }

and since ia32_fxstate is false, we return here, the compiler sees that
everything behind that code is dead code and eliminates it.

Your compiler doesn't, apparently.

It does remove it from regset.c, though, as it sees it is an unused function,
which leads to this undefined reference.

So it looks like a funky compiler to me...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
