Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECE15F3312
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJCQEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJCQEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:04:44 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602785F88
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WKYiwSCjtxvEJXMFxE0ahcKH8izwbe3ZFwXnlirAzIk=; b=QzyOdM8u055EJnM/moxWEZhc/R
        xwzzJO/OTikE8D5QBeEsFHl2QnO5Dt6xHKvkOc+x5ghD4UHyyu1pU/3n9XI+SptEkwy13fSTS0bPW
        QSyXa7yypOtyxhewVp3rLGBkV+UCVys3Gj7+o4XZ4qtPV/IY3mbmtP2wm6mSxoZeSHxajK5n/sreV
        noFQ6W5u91CP0e2YN17GmzQ0MskmJDDgyOq/enuar4aPGLcw8OSCZgGKCgT5rWRLgysL6IPsslPov
        32O/c6Gfm0qEya+FpKUbeQoSnYq+3syoPp5KfLsQT+iFY36zgzUXYhwpaP8fpxAxLQ/Iz/PDYIuX0
        8slBqq4g==;
Received: from 201-13-158-111.dial-up.telesp.net.br ([201.13.158.111] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ofNvF-006AM4-4Q; Mon, 03 Oct 2022 18:04:01 +0200
Message-ID: <35593875-73d5-55dd-8f11-7c902023536d@igalia.com>
Date:   Mon, 3 Oct 2022 13:03:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/3] x86/crash: Fix double NMI shootdown bug
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org
References: <20220518001647.1291448-1-seanjc@google.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220518001647.1291448-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 21:16, Sean Christopherson wrote:
> Fix a double NMI shootdown bug found and debugged by Guilherme, who did all
> the hard work.  NMI shootdown is a one-time thing; the handler leaves NMIs
> blocked and enters halt.  At best, a second (or third...) shootdown is an
> expensive nop, at worst it can hang the kernel and prevent kexec'ing into
> a new kernel, e.g. prior to the hardening of register_nmi_handler(), a
> double shootdown resulted in a double list_add(), which is fatal when running
> with CONFIG_BUG_ON_DATA_CORRUPTION=y.
> 
> With the "right" kexec/kdump configuration, emergency_vmx_disable_all() can
> be reached after kdump_nmi_shootdown_cpus() (currently the only two users
> of nmi_shootdown_cpus()).
> 
> To fix, move the disabling of virtualization into crash_nmi_callback(),
> remove emergency_vmx_disable_all()'s callback, and do a shootdown for
> emergency_vmx_disable_all() if and only if a shootdown hasn't yet occurred.
> The only thing emergency_vmx_disable_all() cares about is disabling VMX/SVM
> (obviously), and since I can't envision a use case for an NMI shootdown that
> doesn't want to disable virtualization, doing that in the core handler means
> emergency_vmx_disable_all() only needs to ensure _a_ shootdown occurs, it
> doesn't care when that shootdown happened or what callback may have run.
> 
> Patch 2 is a related bug fix found while exploring ideas for patch 1.
> Patch 3 is a cleanup to try to prevent future "fixed VMX but not SVM"
> style bugs.
> 
> Guilherme and Vitaly, I dropped your Tested-by and Reviewed-by tags
> since the relevant patches changed a decent amount.
> 
> v2:
>   - Use a NULL handler and crash_ipi_issued instead of a magic nop
>     handler. [tglx]
>   - Add comments to call out that modifying the existing handler
>     once the NMI is sent may cause explosions.
>   - Add a patch to cleanup cpu_emergency_vmxoff().
> 
> v1: https://lore.kernel.org/all/20220511234332.3654455-1-seanjc@google.com
> 
> Sean Christopherson (3):
>   x86/crash: Disable virt in core NMI crash handler to avoid double
>     shootdown
>   x86/reboot: Disable virtualization in an emergency if SVM is supported
>   x86/virt: Fold __cpu_emergency_vmxoff() into its sole caller
> 
>  arch/x86/include/asm/reboot.h  |  1 +
>  arch/x86/include/asm/virtext.h | 14 +-----
>  arch/x86/kernel/crash.c        | 16 +-----
>  arch/x86/kernel/reboot.c       | 89 +++++++++++++++++++++++++---------
>  4 files changed, 69 insertions(+), 51 deletions(-)
> 
> 
> base-commit: a7fed5c0431dbfa707037848830f980e0f93cfb3

Hi folks, monthly ping!
Any news on this fix series? Just checked, still applies cleanly.

Thanks,


Guilherme
