Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B810F63E590
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiK3Xg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK3Xgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:36:54 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C92102F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:36:53 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id g193-20020a636bca000000b00476a2298bd1so126644pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LHAjeFGVyGJ9z5fU3Zmqr4hZm5u5Rh6ii3uFhv6nts=;
        b=S+u6KKX8QhS0caWYg+R2lRXqvfnKq2FiHU48FSjquITy+V5U+/Kf5JqIGsQ+2VCO9B
         v99kVKkhipfETy/LfHRhEV42QZfxPkpIQEBQfzP/3ICKm6CFGiF+Lq2FuMr9UhUUOAzK
         M3yDO44BPJAsK2Jd5HU4xr2UyTXoXZzUg4JLTBgCGOe8/JZYSLMctlZtlDrU5pP0RyCG
         QjaN4EVVVh0RxuakAQQR0DXTNYQpvOMwgDgrQk/AeckIedHb/2yZj7y/TIHdqXVD5d+b
         HZWW9bvlCjWasfd8KoqjHWnxI0+iZC+IJ/dYqQuuySpwMQKWEZv3hHa/JdvusUVhCTEa
         Juog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LHAjeFGVyGJ9z5fU3Zmqr4hZm5u5Rh6ii3uFhv6nts=;
        b=23Kzo9ey9xohKRqHl+SerpNrX5xI/6o146/NgLMtt19ylJQb1TNKipSOhpOB6gakn+
         WTYo+ahMXYzC97pr2iq/Ehmj1nMOXsNjU9WuUrLU0syVfPxl9hcmvd/CtYOQ2GigfRoj
         y+3hq51XeAe3GhZbUNc6ZFTWPNuG4kitj1JMknkyKp5wzx22+myqlaDpJtFCmgnV8tEs
         +xHJhBZ487ytp+rZp/Ws6JQ3bZzjMOYIsKVlg8694PWmHyD18c5bFKywW7gEdw/KQM5g
         eBFbNpukN3hdBmDhJlY7mQ6mZoSKYQHBYBEaZ4hI6fgbiHC7BONegW5wdAG7fS2dw2Ba
         B8Jg==
X-Gm-Message-State: ANoB5pl2yMEjaPJcZSBtXp+wG4Qrfm1lfeUHSc7xjTA44FD6O0Nwn6+O
        tHLyr8RBlSs1qVBKL0XEMVaIK4U6bGY=
X-Google-Smtp-Source: AA0mqf5aKXj+mGrf906qVcVE4bmzOpaE8jj8a1cESr3iOVza5iaD4XC8IOBNiFcQwAy41zkN5B+ZhkB6s3g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:d510:b0:219:2f88:ae3a with SMTP id
 t16-20020a17090ad51000b002192f88ae3amr19868181pju.106.1669851412890; Wed, 30
 Nov 2022 15:36:52 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:36:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130233650.1404148-1-seanjc@google.com>
Subject: [PATCH v4 0/4] x86/crash: Fix double NMI shootdown bug
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, stable@vger.kernel
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a double NMI shootdown bug found and debugged by Guilherme, who did all
the hard work.  NMI shootdown is a one-time thing; the handler leaves NMIs
blocked and enters halt.  At best, a second (or third...) shootdown is an
expensive nop, at worst it can hang the kernel and prevent kexec'ing into
a new kernel, e.g. prior to the hardening of register_nmi_handler(), a
double shootdown resulted in a double list_add(), which is fatal when running
with CONFIG_BUG_ON_DATA_CORRUPTION=y.

With the "right" kexec/kdump configuration, emergency_vmx_disable_all() can
be reached after kdump_nmi_shootdown_cpus() (currently the only two users
of nmi_shootdown_cpus()).

To fix, move the disabling of virtualization into crash_nmi_callback(),
remove emergency_vmx_disable_all()'s callback, and do a shootdown for
emergency_vmx_disable_all() if and only if a shootdown hasn't yet occurred.
The only thing emergency_vmx_disable_all() cares about is disabling VMX/SVM
(obviously), and since I can't envision a use case for an NMI shootdown that
doesn't want to disable virtualization, doing that in the core handler means
emergency_vmx_disable_all() only needs to ensure _a_ shootdown occurs, it
doesn't care when that shootdown happened or what callback may have run.

Patches 2-4 bring SVM on par with VMX.

v4:
  - Set GIF=1 prior to disabling SVM. [Andrew, Tom]
  - Name new helper cpu_emergency_disable_virtualization() instead of
    cpu_crash_disable_virtualization().
  - Add patch to handle SVM in the stop/reboot case.
  - Drop patch to fold __cpu_emergency_vmxoff() into cpu_emergency_vmxoff(),
    will be sent as part of a larger cleanup.

v3:
  - https://lore.kernel.org/all/20221114233441.3895891-1-seanjc@google.com
  - Re-collect Guilherme's Tested-by.
  - Tweak comment in patch 1 to reference STGI instead of CLGI.
  - Celebrate this series' half-birthday.

v2:
  - Use a NULL handler and crash_ipi_issued instead of a magic nop
    handler. [tglx]
  - Add comments to call out that modifying the existing handler
    once the NMI is sent may cause explosions.
  - Add a patch to cleanup cpu_emergency_vmxoff().
  - https://lore.kernel.org/all/20220518001647.1291448-1-seanjc@google.com

v1: https://lore.kernel.org/all/20220511234332.3654455-1-seanjc@google.com

Sean Christopherson (4):
  x86/crash: Disable virt in core NMI crash handler to avoid double
    shootdown
  x86/virt: Force GIF=1 prior to disabling SVM (for reboot flows)
  x86/reboot: Disable virtualization in an emergency if SVM is supported
  x86/reboot: Disable SVM, not just VMX, when stopping CPUs

 arch/x86/include/asm/reboot.h  |  2 +
 arch/x86/include/asm/virtext.h | 13 ++++-
 arch/x86/kernel/crash.c        | 17 +------
 arch/x86/kernel/reboot.c       | 88 ++++++++++++++++++++++++----------
 arch/x86/kernel/smp.c          |  6 +--
 5 files changed, 82 insertions(+), 44 deletions(-)


base-commit: d800169041c0e035160c8b81f30d4b7e8f8ef777
-- 
2.38.1.584.g0f3c55d4c2-goog

