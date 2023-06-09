Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362F7728DC2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbjFICXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237950AbjFICXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:23:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0BF2722
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:22:59 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b02085bf8dso2812735ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 19:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686277379; x=1688869379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUVBNCQGyo+QN3Hkp2oJ23QwW9HMZGUB1INfMEzS56M=;
        b=Y0jCoIRR5kFIDJcevgzt8JSOfThfEoJvqWgsx8u5RCINmYkEv1RaaahRM+BGYjjbzx
         aMQmwhh0D8AvW2vCjnnbcLus8Z5LDuIRiZJ1eDm626ySuiBCXz2KrkFlPr0E8AOHWhlE
         RLlVsVrGUpFeRwHlIOzcCI2RYaS1PlGWPqOfIoNTi+0gWFB8E6mnKoeE1DEFeaemqstz
         JAwaf+w3Y6qIgfNDAjFoIt5mJX81iQ8v8kkJz4leGuPpIGMJeS3nTfhakl5/ikEEZOtO
         S16Fn/AipROSuAmmHEtzSICyC/g5dAUn9vUYJaeARVweZf7TPndrBoeXJ1cSr6vQy0z5
         5Xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686277379; x=1688869379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUVBNCQGyo+QN3Hkp2oJ23QwW9HMZGUB1INfMEzS56M=;
        b=e6dO1t7NHANR2+7ZgAWMZtNBiK5dE/OsHM+gYBn83hQ0smahUuN1PzctTxcxIxSJXb
         jbLsjhhHCI36hAM1lF6f+kSunhNUGk5Tq6Ly2AjlTnvZnUk3wlpWP1MLUPpEVL6Tlman
         NWe3V+5vhl0IsCRJ9JRt6b4msyPmA7m6Go+Lnn6+Qv+t54iF/1ynog9jRDNKi6X0l/80
         vqRXwTD6V9ynDPmRVvRUKrO50Pi0O/XS9vF1JKoU00YC8gQwSNFbL2xVoHHVMmTYd1ew
         xaIJezS8L3JqE+kZd4uEt8MrvKoaO0285or4vNkmwpUKNfHZP5qoe+/JftY0WXvHfWcg
         nk6Q==
X-Gm-Message-State: AC+VfDyrNEV4G79NU4CCPPSf7RsVAbJ3UUVqwmuZ2LQo3NhXIkxXTuP1
        prunzNXY/DAVckSvNcTsfqnbdVpqrsU=
X-Google-Smtp-Source: ACHHUZ6oY/eQvf+W4ubAqcV6Laky7bKYH0/gMvowwHHoaoiuZq7+d4kirGr+OJ74EZPk8ap7JDkAuw==
X-Received: by 2002:a17:902:bc46:b0:1b1:8730:8d9f with SMTP id t6-20020a170902bc4600b001b187308d9fmr71673plz.14.1686277378987;
        Thu, 08 Jun 2023 19:22:58 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3aa3:2af1:e3f1:5039])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709027b9600b001ac95be5081sm2014846pll.307.2023.06.08.19.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 19:22:58 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5/5] xtensa: clean up default platform functions
Date:   Thu,  8 Jun 2023 19:22:40 -0700
Message-Id: <20230609022240.1694244-6-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609022240.1694244-1-jcmvbkbc@gmail.com>
References: <20230609022240.1694244-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop _F macro used to define default platform functions and rewrite
definitions as normal functions. Don't define separate __platform_*
function and platform_* weak alias, just define a weak function.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/platform.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/xtensa/kernel/platform.c b/arch/xtensa/kernel/platform.c
index 29fa5d659274..926b8bf0f14c 100644
--- a/arch/xtensa/kernel/platform.c
+++ b/arch/xtensa/kernel/platform.c
@@ -17,23 +17,28 @@
 #include <asm/platform.h>
 #include <asm/timex.h>
 
-#define _F(r,f,a,b)							\
-	r __platform_##f a b;                                   	\
-	r platform_##f a __attribute__((weak, alias("__platform_"#f)))
-
 /*
  * Default functions that are used if no platform specific function is defined.
- * (Please, refer to include/asm-xtensa/platform.h for more information)
+ * (Please, refer to arch/xtensa/include/asm/platform.h for more information)
  */
 
-_F(void, init, (bp_tag_t *first), { });
-_F(void, setup, (char** cmd), { });
-_F(void, idle, (void), { __asm__ __volatile__ ("waiti 0" ::: "memory"); });
+void __weak __init platform_init(bp_tag_t *first)
+{
+}
+
+void __weak __init platform_setup(char **cmd)
+{
+}
+
+void __weak platform_idle(void)
+{
+	__asm__ __volatile__ ("waiti 0" ::: "memory");
+}
 
 #ifdef CONFIG_XTENSA_CALIBRATE_CCOUNT
-_F(void, calibrate_ccount, (void),
+void __weak platform_calibrate_ccount(void)
 {
 	pr_err("ERROR: Cannot calibrate cpu frequency! Assuming 10MHz.\n");
 	ccount_freq = 10 * 1000000UL;
-});
+}
 #endif
-- 
2.30.2

