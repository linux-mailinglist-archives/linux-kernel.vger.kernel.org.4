Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4F95BA627
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 06:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIPE65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 00:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIPE6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 00:58:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0767A1D0C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:58:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r62-20020a252b41000000b006af00577c42so13542979ybr.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=FfGEH82Goix2SWCi/zuywSATdy3fBWTr6hkvcyAr5AE=;
        b=SaTCaJ0WrTR2A06woxfLg28wNkvqb43/YLMZaOcg0UMlHIJE+zrKK9a9YQ9Wpt7A+R
         9Ow9HZtCjL5HyK1Lfrv7RAqVqHe9rRRmBQN9C1tuAJToZaK1uptkXli3R6wOf7a6FbcX
         VJiTkPSEGVyFZ0ovxouTzOSXlKSvv1X/IVBcIn/ZAmG6i52/kvc2Khp30cEBmPdfsdbc
         x73ILiVAQazDQUEGfoMFmhFk4xO4Go2SacKC4WfIDYJZU+CmhdoF9T/2DflpN9LKxTaN
         8PWCncwWtFDY04ZkWI/nNcaV3v1Y1Vd0LGuG8I/QxXhmTHXHsbAVN1Qhx91xUc9fL1NC
         +2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=FfGEH82Goix2SWCi/zuywSATdy3fBWTr6hkvcyAr5AE=;
        b=T2yGDNenVdbqPCa77cM+Sg2zLZ3zMLTVaszraiZE/cftki/Ys2PhF0hgfPny2o8eLH
         xg9hP1HQVyAjBOjGkXCsl5ahPct1aYXTK5LW/0IJ1RTFVHltq1Xvi1yDg1TOZcxu6Rhi
         stc9FrT8f4gDbpfuW4gxAHmhcCEiiuOhHl4VyM5HVnr3MH4XZ94LvUR6b0dLvjt0b/Wt
         a5N0tLyv5eAPjm7N/C2LruMSB/9PVPvP+ydPqg/QJlC5mc4cfEz0yHahaAcnhmRKLQY1
         3nhwuPJTM6uILPAzP905kcOnbmXGYbEU7o9NEOuvkGT3br63J1A/dQ71LwwEQFD6up93
         VKYA==
X-Gm-Message-State: ACrzQf1/Zrp7qsWObPqbHuQBtuD9Zv8KBXXIAklKHGEx/BFnAhSFy3m0
        HRaTM5cDuhsI04jd5h0Km4kXrFoesO3nkg==
X-Google-Smtp-Source: AMsMyM6rqUNrVNeqWPjgWxenHtSFFiSUeMHOzcEuilRyiGdPgLAEJ+K0BjENaD2mdrxoxRcqzK/7736w4gAJxg==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:29a])
 (user=jmattson job=sendgmr) by 2002:a05:6902:120f:b0:668:2228:9627 with SMTP
 id s15-20020a056902120f00b0066822289627mr3101150ybu.134.1663304331955; Thu,
 15 Sep 2022 21:58:51 -0700 (PDT)
Date:   Thu, 15 Sep 2022 21:58:27 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220916045832.461395-1-jmattson@google.com>
Subject: [PATCH 0/5] KVM: EFER.LMSLE cleanup
From:   Jim Mattson <jmattson@google.com>
To:     Avi Kivity <avi@redhat.com>, Babu Moger <babu.moger@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wyes Karny <wyes.karny@amd.com>, x86@kernel.org
Cc:     Jim Mattson <jmattson@google.com>
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

KVM has never properly virtualized EFER.LMSLE. However, when the
"nested" module parameter is set, KVM lets the guest set EFER.LMSLE.
Ostensibly, this is so that SLES11 Xen 4.0 will boot as a nested
hypervisor.

KVM passes EFER.LMSLE to the hardware through the VMCB, so
the setting works most of the time, but the KVM instruction emulator
completely ignores the bit, so incorrect guest behavior is almost
certainly assured.

With Zen3, AMD has abandoned EFER.LMSLE. KVM still allows it, though, as
long as "nested" is set. However, since the hardware doesn't support it,
the next VMRUN after the emulated WRMSR will fail with "invalid VMCB."

My preference would be to simply scrub all references to LMSLE from the
Linux kernel, but I don't want to break any guests that rely in it (on
hardware that supports it).

So, here's a series to clean things up.

I have not been successful in getting new macros into cpufeatures.h in
the past, but I'm going to try again, because I am a glutton for
punishment.

Jim Mattson (5):
  x86/cpufeatures: Introduce X86_FEATURE_NO_LMSLE
  KVM: svm: Disallow EFER.LMSLE on hardware that doesn't support it
  KVM: x86: Report host's X86_FEATURE_NO_LMSLE in
    KVM_GET_SUPPORTED_CPUID
  KVM: x86: Enforce X86_FEATURE_NO_LMSLE in guest cpuid
  KVM: svm: Set X86_FEATURE_NO_LMSLE when !nested

 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kvm/cpuid.c               | 2 +-
 arch/x86/kvm/svm/svm.c             | 6 +++++-
 arch/x86/kvm/x86.c                 | 3 +++
 4 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.37.3.968.ga6b4b080e4-goog

