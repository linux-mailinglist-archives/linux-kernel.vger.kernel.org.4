Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E161E5BFF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiIUNpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIUNph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:45:37 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6214361DBA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 06:45:36 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-11eab59db71so9067825fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 06:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=daM5SZuwdOe2eGE+YL1ULmOjBp3NnXTMo4uiOWS2OVE=;
        b=aGH0TbhAfgk6UcR3AI8lvnSS0bGyuDs8bIOFRCGclOMU7vt2EIWwv8lvc1sGRgxz2e
         LogUgmIaGgiZl+ht3rm7OQT3Vo6VyWT5kLXh3wVzD5THB6318xi1t9B50JZmd90QU2MD
         RMsvifUw9Tfo7N4mmcI80hFM5njRE7ZZaLRRnwBcoZ46yE5GhgAJYTpc+s8oDYBzeorA
         E2+kjC/2CB/yTTpnKHrSvtsX0GwkJYwFWVnikwMPPH2f//sexa89ZaeZGlgo1lALlE/1
         wCwGkSgBuHqtyTvGDol/8BgXD4vejhqEIRMUECDZrMDsqenDeFgu24AI2bVeUf6FO/II
         Av0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=daM5SZuwdOe2eGE+YL1ULmOjBp3NnXTMo4uiOWS2OVE=;
        b=an5x4E3vGqz7DQhvwjd7dhE0Z6I2hBysuR8gb58/l4R99l0kUzZsD3Kl0rn8IzoXN5
         pnAWT77mAi2YEuhx3EpYqKP7jK1j6BFLTVlWuU3gGrl32aSo6W5RguFX7Aqwg9eD6enY
         7Xzu76AR4UL90WHu98MPJiC+4d0N7CDilR/XDUmH/28BTZle4z/fM9y93a1LE4fFuA8z
         Nm1CK/l1TQGDWcwnRsqtWR0LLFNgaXwI1YUbHKrqaIRe2cwZOeJN466unIvVLMaCA0Hm
         elr/tEzDxORYz3MJNjEcHKaBxTS8NT/EBMmd9cFGagYNbC/vc6/FPupzcAB+XBbqzk67
         OS/A==
X-Gm-Message-State: ACrzQf3CxMFXqVyng5fwJq5X8dfrtu+65oc3fJym2oOz+11QGn4/KdTy
        XiDgvnBE2oszjBKYNsiK3BxKfNF4GXMvuzqc0NiBdQ==
X-Google-Smtp-Source: AMsMyM6kDCucurtRzljq5Vk7PcEyMfqTtEicuc3Flh+wvpieWHr91t5EPzb/GYRQVkuJ5G1vo/Rt24YVcr8roDhjucs=
X-Received: by 2002:a05:6870:580c:b0:12a:f136:a8f5 with SMTP id
 r12-20020a056870580c00b0012af136a8f5mr4956761oap.269.1663767935409; Wed, 21
 Sep 2022 06:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220920205922.1564814-1-jmattson@google.com> <Yyot34LGkFR2/j5f@zn.tnic>
 <CALMp9eQijCKS-E_OWJkxdqAur3BthciOWEtEPH5YKd0-HJiQQA@mail.gmail.com> <YyrZOLq8z+lIORvP@zn.tnic>
In-Reply-To: <YyrZOLq8z+lIORvP@zn.tnic>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 21 Sep 2022 06:45:24 -0700
Message-ID: <CALMp9eRG6g-95zCxTD1NnxpZ+Vm6VMTA0_uaHV=b-hDkeOYSuA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] KVM: EFER.LMSLE cleanup
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 2:28 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 20, 2022 at 09:36:18PM +0000, Sean Christopherson wrote:
> > Yes, but ideally KVM would explicitly tell the guest "you don't have LMSLE".
> > Probably a moot point, but at the same time I don't see a reason not to be
> > explicit.
>
> Yes but...
>
> On Tue, Sep 20, 2022 at 02:36:34PM -0700, Jim Mattson wrote:
> > Reporting that CPUID bit gives us the right to raise #GP. AMD CPUs
> > (going way back) that don't report EferLmsleUnsupported do not raise
> > #GP.
>
> ... what does "gives us the right" mean exactly?
>
> I'm pretty sure I'm missing something about how KVM works but wouldn't
> it raise a guest #GP when the guest tries to set an unsupported EFER
> bit? I.e., why do you need to explicitly do
>
>         kvm_cpu_cap_set(X86_FEATURE_NO_LMSLE);
>
> and not handle this like any other EFER reserved bit?

EFER.LMLSE is not a reserved bit on AMD64 CPUs, unless
CPUID.80000008:EBX[20] is set (or you're running very, very old
hardware).

We really shouldn't just decide on a whim to treat EFER.LMSLE as
reserved under KVM. The guest CPUID information represents our
detailed contract with the guest software. By setting
CPUID.80000008:EBX[20], we are telling the guest that if it tries to
set EFER.LMSLE, we will raise a #GP.

If we don't set that bit in the guest CPUID information and we raise
#GP on an attempt to set EFER.LMSLE, the virtual hardware is
defective. We could document this behavior as an erratum, but since a
mechanism exists to declare that the guest can expect EFER.LMSLE to
#GP, doesn't it make sense to use it?
