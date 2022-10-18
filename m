Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED656032F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJRTB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJRTBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:01:42 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D98BB5FF0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:01:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id bh13so14118038pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RrBZLYnCa4U73RZ7+IkOsQJp1B4oNHg37PxVo0ipMHk=;
        b=CDodwI1d1Nfp8ue1Psca1kFKUqqynntNxl8Z4zwNUvPoeRrcDQAxG6Qa10JQWBT51P
         u6wJko/fLiJcGY3JOZT65vrBbXNbHh+Kbm40jsdi67K5pBfo5v2XkUrOYSInbWs8jr8P
         zUPwcT2J1mvcNJUGMQYBi9twA5YrWvGGeOgl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrBZLYnCa4U73RZ7+IkOsQJp1B4oNHg37PxVo0ipMHk=;
        b=nn6IyYNDyqYfpCkBpZtLffxOszc1cMQfTyzsKVWhxcYuwDNvGXjHvRHxnZShqeOQGE
         1am8m31rkFr0LZhHljKjM56V4Xdzd+Gr58dW7T2qwhIjemE5TZa243cJFNOgXMHyQgeI
         libDjQ1ziW/yAJc2KUrzl/uoOp8aewr5UEUti6LRuBE6wzhRvW6OEWo9lf2mRpwgjS6x
         5rm009NhE6JvmShoVpGKhnslRI4Yf1V37d5L4caXDXB6jSPn/IkrFTwuT55ab7icgQV2
         o9bFnvrlzeQrz866aE5hGH1uh/7veYsOG9IIuOzhZbByHj/O8wWWrwXKWs5AjWlkfOqJ
         b1Xw==
X-Gm-Message-State: ACrzQf1vSYojxm27SZw1J3v6JUq0Y7E1aulAA4y5tvG49pa44SNnMajV
        HFR87nXFi33vzjXoSLJdjeU1JsvOoZfpiQ==
X-Google-Smtp-Source: AMsMyM61CpVebTvyRrXuJOE0noiEkr1686XyDfY8ypcAz1Wv04eZTtt9O+KAi/Lzcd9rmtKyw5n5Vg==
X-Received: by 2002:a63:881:0:b0:43a:c80a:bea4 with SMTP id 123-20020a630881000000b0043ac80abea4mr3871144pgi.329.1666119699295;
        Tue, 18 Oct 2022 12:01:39 -0700 (PDT)
Received: from arishabh.c.googlers.com.com (30.176.125.34.bc.googleusercontent.com. [34.125.176.30])
        by smtp.gmail.com with ESMTPSA id h3-20020aa796c3000000b0055fc0a132aasm9863407pfq.92.2022.10.18.12.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 12:01:38 -0700 (PDT)
From:   Rishabh Agrawal <rishabhagr@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
        drake@endlessm.com, rafael.j.wysocki@intel.com, mingo@redhat.com,
        tglx@linutronix.de
Cc:     vaibhav.shankar@intel.com, biernacki@google.com,
        zwisler@google.com, mattedavis@google.com,
        Rishabh Agrawal <rishabhagr@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: [PATCH v2] Add hardcoded crystal clock for KabyLake
Date:   Tue, 18 Oct 2022 19:01:32 +0000
Message-Id: <20221018190124.v2.1.I918ccc908c5c836c1e21e01d2cf6f59b0157bcc3@changeid>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes in v2:
  - Adding Thomas Gleixner, Daniel Drake, Rafael Wysocki, Len brown and Ingo to review since you worked on this.

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
2.38.0.413.g74048e4d9e-goog

