Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F87628D77
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiKNXer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKNXep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:34:45 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1520AE6B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:34:44 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id m6-20020aa79006000000b0056bc283f477so6777740pfo.19
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2C+mEdWGRF7/5Wann0NujnMardQrr8Pv4jnCYIOIfiI=;
        b=KdNFTJ+kuX5LRPdITAEfyeE5gXPE4KELlxqjIkj/2C8ZNoZ5iZfHOVNDOOfbCszRT2
         EaHbD6iQ0CU8zAwaA6+iaPNkTOFNfl+7SI4hQ9w3qmWHphbSo8l+UcnrhrfcFxRUufWZ
         RC8hBKQGlGyoM+QDaYRdUAnHywNf8Z+239VTm1JOIFTx/M3ta+dz7FG9CH6TMiVV8fbQ
         0HxyUg2OeZDkIqp4q1UwzLYaKEiLBWCY8GQ7HDVo4w93hiRbYNXdW9SI7bCb/MUzSnOS
         M0md+d9QDWIxVbQgKli/kpzDulxMjA83byuaklikp6IKAYHFDbU3PJ+0feaaGPCd4Zbt
         E3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2C+mEdWGRF7/5Wann0NujnMardQrr8Pv4jnCYIOIfiI=;
        b=fCYgZV1O5XUCfyGHOY2cXkO/RNsAsW+/xj6GurMLiapG0iEvv/inbOzNJc9nQFHLrX
         wkVFO/+SRoAs9vPsXoQCpnE4ugKqelsLpttkxVbamnvPpL6ePmWVvMcPQuIqXBO/ExgI
         U+s+ZkZh6Xiqd3dvcjDTgRZy2bgOtTPNVdceEIQNEfDbQbkgJDfm8oU06Kwptdeftmbw
         C0n27dFwExbQMTy1p064v/IJJHzEHedYcB8PrtUOHIfNIx8YeMsVopqlR/1I0wVF5I7T
         vIw+O6anLJSTAG1nkjSz4VGJvxFROsObDC++pnBQl3/MecJQjgUbuBLyaAcdx0bYgfNP
         wtqA==
X-Gm-Message-State: ANoB5pnmWtx4vYklFH2JEYam5zPAyptIIpKSTPDPbOABfKAgfbxFkfXv
        PC9LruF5MhjS7GkXBsiQ8Ne4/p4JqvA=
X-Google-Smtp-Source: AA0mqf43xEFm+n2DcQgWiAGNQ5hf1jRgFH/hpiR4J/Hd/pbOkdug8JRkGl0N/bo1Ld0JTrpUae9+sFKZMR8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1c86:b0:56b:d027:214 with SMTP id
 y6-20020a056a001c8600b0056bd0270214mr15823140pfw.79.1668468884170; Mon, 14
 Nov 2022 15:34:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 14 Nov 2022 23:34:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221114233441.3895891-1-seanjc@google.com>
Subject: [PATCH v3 0/3] x86/crash: Fix double NMI shootdown bug
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>
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

Tom,

I Cc'd you this time around because the APM doesn't explicitly state that
GIF is set when EFER.SVME is disabled.  KVM's nSVM emulation does set GIF
in this case, but it's not clear whether or not KVM is making up behavior.
If clearing EFER.SVME doesn't set GIF, then patch 1 needs to be modified
to try STGI before clearing EFER.SVME, e.g. if a crash is initiated from
KVM between CLGI and STGI.  Responding CPUs are "safe" because GIF=0 also
blocks NMIs, but the initiating CPU might leave GIF=0 when jumping into
the new kernel.

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

Patch 2 is a related bug fix found while exploring ideas for patch 1.
Patch 3 is a cleanup to try to prevent future "fixed VMX but not SVM"
style bugs.

v3:
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

Sean Christopherson (3):
  x86/crash: Disable virt in core NMI crash handler to avoid double
    shootdown
  x86/reboot: Disable virtualization in an emergency if SVM is supported
  x86/virt: Fold __cpu_emergency_vmxoff() into its sole caller

 arch/x86/include/asm/reboot.h  |  1 +
 arch/x86/include/asm/virtext.h | 14 +-----
 arch/x86/kernel/crash.c        | 16 +-----
 arch/x86/kernel/reboot.c       | 89 +++++++++++++++++++++++++---------
 4 files changed, 69 insertions(+), 51 deletions(-)


base-commit: dacca1e5e75d7c1297f1334cdc10491dcdd1b2b8
-- 
2.38.1.431.g37b22c650d-goog

