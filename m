Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B506C0324
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjCSQdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjCSQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:32:47 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445881EFD9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 09:32:27 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id h11so5391599ild.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 09:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679243544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cae0i8JaCTjo4rUYT/R3b+i11mfGlF5/Y5DDWylcB0=;
        b=EuyQ8TXUTrR8JwWIz88gOI6b7c/g7v3bjIS0LqgRtNzh6DAGcHvshgiRuvIbkhBJmN
         52OlLAeQ+ZblT82AZ2LkzLtF+uQDnGcLgAE3dclyMaaGkNjL6cwRV+EWMmodXa9PguaL
         GyHu0cpLT4o/IVi3qt4dx8g3CmCXGjAfVUibx+IdHoYNxG4b7cFy9kCi8M8HqK5QhjOm
         iN1DxW/mBVt1JOLFNoJ0dBJQdBbXNlhMYNfsiseoqzBeeLKWVQaYO6oG6LNpk7ec1wb5
         1UvnnjPkiWRxAo9GXi+JjQw/RoL6aB2bBDcLT6kTURnlhtxU0ggNrUifeTpZjboVDDo1
         MMvA==
X-Gm-Message-State: AO0yUKWWMeraqtg3qXE6tWRuAFxZGD32ab/aiNku4fLhFgBClyFclAT3
        2mMmP2TeY4+fXex7Sh3fm25y4dfYYQ==
X-Google-Smtp-Source: AK7set+Wmp1QzSdu4VMQmB96ikKmoqugstCx4UyWAQB+4LrnA8/zYnn0v6hSC62L7gMHvjdL2o1MNA==
X-Received: by 2002:a92:d98d:0:b0:315:4793:f7b4 with SMTP id r13-20020a92d98d000000b003154793f7b4mr3403987iln.31.1679243544460;
        Sun, 19 Mar 2023 09:32:24 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c7:2689:137d:d795:47e4:3de1])
        by smtp.gmail.com with ESMTPSA id k16-20020a056e02135000b00313f2279f06sm2165966ilr.73.2023.03.19.09.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:32:24 -0700 (PDT)
Received: (nullmailer pid 226334 invoked by uid 1000);
        Sun, 19 Mar 2023 16:32:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers/timer-ti-dm: Use of_address_to_resource()
Date:   Sun, 19 Mar 2023 11:32:20 -0500
Message-Id: <20230319163220.226273-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace of_get_address() and of_translate_address() calls with single
call to of_address_to_resource().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clocksource/timer-ti-dm-systimer.c | 57 ++++++++++------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 632523c1232f..3b98a3c04f87 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -251,24 +251,22 @@ static void __init dmtimer_systimer_assign_alwon(void)
 		counter_32k = -ENODEV;
 
 	for_each_matching_node(np, dmtimer_match_table) {
+		struct resource res;
 		if (!dmtimer_is_preferred(np))
 			continue;
 
-		if (of_property_read_bool(np, "ti,timer-alwon")) {
-			const __be32 *addr;
-
-			addr = of_get_address(np, 0, NULL, NULL);
-			pa = of_translate_address(np, addr);
-			if (pa) {
-				/* Quirky omap3 boards must use dmtimer12 */
-				if (quirk_unreliable_oscillator &&
-				    pa == 0x48318000)
-					continue;
-
-				of_node_put(np);
-				break;
-			}
-		}
+		if (!of_property_read_bool(np, "ti,timer-alwon"))
+			continue;
+
+		if (of_address_to_resource(np, 0, &res))
+			continue;
+
+		/* Quirky omap3 boards must use dmtimer12 */
+		if (quirk_unreliable_oscillator && res.start == 0x48318000)
+			continue;
+
+		of_node_put(np);
+		break;
 	}
 
 	/* Usually no need for dmtimer clocksource if we have counter32 */
@@ -285,24 +283,22 @@ static void __init dmtimer_systimer_assign_alwon(void)
 static u32 __init dmtimer_systimer_find_first_available(void)
 {
 	struct device_node *np;
-	const __be32 *addr;
 	u32 pa = 0;
 
 	for_each_matching_node(np, dmtimer_match_table) {
+		struct resource res;
 		if (!dmtimer_is_preferred(np))
 			continue;
 
-		addr = of_get_address(np, 0, NULL, NULL);
-		pa = of_translate_address(np, addr);
-		if (pa) {
-			if (pa == clocksource || pa == clockevent) {
-				pa = 0;
-				continue;
-			}
-
-			of_node_put(np);
-			break;
-		}
+		if (of_address_to_resource(np, 0, &res))
+			continue;
+
+		if (res.start == clocksource || res.start == clockevent)
+			continue;
+
+		pa = res.start;
+		of_node_put(np);
+		break;
 	}
 
 	return pa;
@@ -812,7 +808,7 @@ static int __init dmtimer_clocksource_init(struct device_node *np)
  */
 static int __init dmtimer_systimer_init(struct device_node *np)
 {
-	const __be32 *addr;
+	struct resource res;
 	u32 pa;
 
 	/* One time init for the preferred timer configuration */
@@ -826,8 +822,9 @@ static int __init dmtimer_systimer_init(struct device_node *np)
 		return -EINVAL;
 	}
 
-	addr = of_get_address(np, 0, NULL, NULL);
-	pa = of_translate_address(np, addr);
+
+	of_address_to_resource(np, 0, &res);
+	pa = (u32)res.start;
 	if (!pa)
 		return -EINVAL;
 
-- 
2.39.2

