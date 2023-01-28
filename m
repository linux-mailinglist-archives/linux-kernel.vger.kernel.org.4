Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A7667F8D9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 15:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjA1Ox2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 09:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjA1Ox0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 09:53:26 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223BE23C70
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 06:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MQ3QZ2n9H8qxeqethQACSEWQ81zQlJU6T89IcrWBRi4=; b=MvXPIVQyoGomFxpO4BbciyJ8Kv
        IevWctnAom+sXDHAMjQ7LIHcogKDIqqxLXqUoftPGn7XtDWY5mhmvF8Zdh8FQrKMYV9R0Ff2xhcvp
        Dba9VzmybpdWjH48Svax0eShzNY+9xKuladTUIuGs3CREBmGERRasDPPPyOg3iJ7N9Y4G2WNXNhsE
        WR2VVYKTNK1Xk4dNkT3C6mNpsf9M11d/n2Ifx/1xDRx8nDvpK+3x9zFZvTfIbTCEM8mOxLQlFUKJo
        LC8rE9lPP+qDpmPmny9FvX5uxsw3SYTmXPONCGNbbaL4lu1vGbLDaH+USY+gjEx/Nwt2TqxVxsnAZ
        fF2gDl0Q==;
Received: from [187.56.70.205] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pLmZR-0037p3-RC; Sat, 28 Jan 2023 15:52:46 +0100
Message-ID: <aab8c21c-45c4-c931-31f8-ba175bbe6a5a@igalia.com>
Date:   Sat, 28 Jan 2023 11:52:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 0/4] x86/crash: Fix double NMI shootdown bug
To:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, stable@vger.kernel
References: <20221130233650.1404148-1-seanjc@google.com>
 <167424175801.2640527.5679926568908656054.b4-ty@google.com>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <167424175801.2640527.5679926568908656054.b4-ty@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 21:05, Sean Christopherson wrote:
> On Wed, 30 Nov 2022 23:36:46 +0000, Sean Christopherson wrote:
>> Fix a double NMI shootdown bug found and debugged by Guilherme, who did all
>> the hard work.  NMI shootdown is a one-time thing; the handler leaves NMIs
>> blocked and enters halt.  At best, a second (or third...) shootdown is an
>> expensive nop, at worst it can hang the kernel and prevent kexec'ing into
>> a new kernel, e.g. prior to the hardening of register_nmi_handler(), a
>> double shootdown resulted in a double list_add(), which is fatal when running
>> with CONFIG_BUG_ON_DATA_CORRUPTION=y.
>>
>> [...]
> 
> Applied to kvm-x86 misc, thanks!
> 
> [1/4] x86/crash: Disable virt in core NMI crash handler to avoid double shootdown
>       https://github.com/kvm-x86/linux/commit/26044aff37a5
> [2/4] x86/virt: Force GIF=1 prior to disabling SVM (for reboot flows)
>       https://github.com/kvm-x86/linux/commit/6a3236580b0b
> [3/4] x86/reboot: Disable virtualization in an emergency if SVM is supported
>       https://github.com/kvm-x86/linux/commit/d81f952aa657
> [4/4] x86/reboot: Disable SVM, not just VMX, when stopping CPUs
>       https://github.com/kvm-x86/linux/commit/a2b07fa7b933
> 
> --
> https://github.com/kvm-x86/linux/tree/next
> https://github.com/kvm-x86/linux/tree/fixes


Thanks a bunch Sean!
