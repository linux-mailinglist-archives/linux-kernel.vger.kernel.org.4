Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1E45F5D0A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 01:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJEXEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 19:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiJEXEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 19:04:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ED5281
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:04:39 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d24so113969pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 16:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jgRj2ZCIBOPvv2vrQKP0ikzjUJMhfZt/TjHRjna0hT8=;
        b=OZJj8MPpJqsvyoDuOfDgThPOcY9022j7upMbXVbrpITsuDOZ/otUbTi8w8BzeisJjN
         YyGwKs5zVrVa6x1Ou1wLWXk/MdCV5yQRWTCYuCgW7Mzp8z5zxSJwXu89tv05KA5OZcir
         oTZ3Ctmxnx8evSj9tnWnLQooKEzSGpKzy/LOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgRj2ZCIBOPvv2vrQKP0ikzjUJMhfZt/TjHRjna0hT8=;
        b=F0d/MlfYC7LZHMeqPFDYpdAq/y2bNnfbxzEGZs7miME2gAQxSPG8eckrukm5iBK3ap
         JGygPkrqrA+EEPwnw+7dASCW8bCuDpI2frEuhJV2jZEkeOBgn3JP8wBS1L6ZeqZEormc
         CHDWRYw89gEH+QITxbW4P0FQXk1qKwV4tupktiAyJhdYopiuYbxGSokWtCgcTNI2qTIs
         dhmKP7SFAs9GSnFlIX0u5lNQ0sotkYTvTTDUMJP0Vq/NKChCivX/hHLjGqNyhYHxa5fJ
         In0fJTZwLcahP0EdyaTZl13cRmfboAy94GOfdaQ5+Au/ZpmHihOQNUfeVMTh8I1nH2op
         Z2Kg==
X-Gm-Message-State: ACrzQf3Ozvdjb7bndQQdPnWC0JccC+3ChceFIYndVuEQwJLghbGdcnph
        iMGvQUeWhkCCMVauH40X9pWY9/hBFxBXkjKj3E9GPw==
X-Google-Smtp-Source: AMsMyM7voRDrO+U4f9HHRvzDRite3Lp95pBLvBHqlnJYymAty/PuaoCe8kq53u7AypcSmqxJCeodgw==
X-Received: by 2002:a17:90b:2751:b0:20a:e437:a9e8 with SMTP id qi17-20020a17090b275100b0020ae437a9e8mr7268521pjb.181.1665011078236;
        Wed, 05 Oct 2022 16:04:38 -0700 (PDT)
Received: from arishabh.c.googlers.com.com (30.176.125.34.bc.googleusercontent.com. [34.125.176.30])
        by smtp.gmail.com with ESMTPSA id y1-20020a626401000000b0053e8f4a10c1sm11403322pfb.217.2022.10.05.16.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 16:04:37 -0700 (PDT)
From:   Rishabh Agrawal <rishabhagr@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     biernacki@google.com, mattedavis@google.com,
        vaibhav.shankar@intel.com, zwisler@google.com,
        Rishabh Agrawal <rishabhagr@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH] Add hardcoded crystal clock for KabyLake
Date:   Wed,  5 Oct 2022 23:04:21 +0000
Message-Id: <20221005230407.1.I918ccc908c5c836c1e21e01d2cf6f59b0157bcc3@changeid>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set KabyLake crystal clock manually since the TSC calibration is off
by 0.5%. All the tests that are based on the timer/clock will fail in
this case.

The HPET has been disabled by upstream due to PC10 issue causing the
3 hatch devices, dratini, jinlon, and kohaku to not calibrate the clock
precisely. These 3 devices are KabyLake devices. Intel team has verified
that all KBL devices have 24.0 MHz clock frequency, therefore this
change is valid.

Signed-off-by: Rishabh Agrawal <rishabhagr@chromium.org>
---

 arch/x86/kernel/tsc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2e58cc..63a06224fa48 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -644,10 +644,21 @@ unsigned long native_calibrate_tsc(void)
 	 * Denverton SoCs don't report crystal clock, and also don't support
 	 * CPUID.0x16 for the calculation below, so hardcode the 25MHz crystal
 	 * clock.
+	 *
+	 * Intel KabyLake devices' clocks are off by 0.5% when using the below
+	 * calculation, so hardcode 24.0 MHz crystal clock.
 	 */
-	if (crystal_khz == 0 &&
-			boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT_D)
-		crystal_khz = 25000;
+	if (crystal_khz == 0) {
+		switch (boot_cpu_data.x86_model) {
+		case INTEL_FAM6_ATOM_GOLDMONT_D:
+			crystal_khz = 25000;
+			break;
+		case INTEL_FAM6_KABYLAKE_L:
+			crystal_khz = 24000;
+			break;
+		}
+
+	}
 
 	/*
 	 * TSC frequency reported directly by CPUID is a "hardware reported"
-- 
2.38.0.rc1.362.ged0d419d3c-goog

