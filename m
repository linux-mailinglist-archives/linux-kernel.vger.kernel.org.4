Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD326C028E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjCSPBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjCSPBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:01:05 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E0422DD5;
        Sun, 19 Mar 2023 08:00:43 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id o14so4416022ioa.3;
        Sun, 19 Mar 2023 08:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679238038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+yh1Iwz6GpGxVzG6CeG24b3aBWigOqdkkBWntDGMZY=;
        b=Ld9vF1oHcAIi4KliY9F6FzThVspjx+oRwr9S7EiwTWTWBnv7n7yh0tPNV9kZXlSuBz
         sNWLWPG5PgK/WRIE3DfTdnUOUOviN9FN7bnyWUoOoQ+gxH7QYwHgXZ3SekLC2LlyR9BO
         eT9SQu4iZ3nSwLuKGalwtn12cgqPZXQ3Xc0fC83LE6PzG6cih60FuzAjQmHK6XQrU/Lz
         6TY+S+6y2soJxPIH4zUXdKM2ntc/k1ZOlJw4nADRBDcvsL1OEFnmEnyrk0AiB7LG+6PC
         Ute+bKxqDITs0Ay7JJWd2QVPcyltM/CmM0bzpCV8zQpE3k00RrW0QG/RtGRHRF8i7jIm
         /SMA==
X-Gm-Message-State: AO0yUKWVjnbGMe6rDgGg/pVkjGlQTivvJpOzfVeqqgfry5QqPcQjZmGk
        LrEp3zbk/0Wx/xeOAYN+WQ==
X-Google-Smtp-Source: AK7set82e+A0Ra5xDg3iEg6mu505pJCKDywkfHvsolgYRYnvyKJbL7mZG6I7riL0gg+UZolbTIBVyQ==
X-Received: by 2002:a5d:8616:0:b0:755:7b0c:604a with SMTP id f22-20020a5d8616000000b007557b0c604amr3278553iol.2.1679238038667;
        Sun, 19 Mar 2023 08:00:38 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c4:7b93:58f2:478b:84fd:941e])
        by smtp.gmail.com with ESMTPSA id w29-20020a056638379d00b0040630f8625asm2486356jal.13.2023.03.19.08.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 08:00:38 -0700 (PDT)
Received: (nullmailer pid 66655 invoked by uid 1000);
        Sun, 19 Mar 2023 15:00:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: sh-mobile: Use of_cpu_node_to_id() to read CPU node 'reg'
Date:   Sun, 19 Mar 2023 10:00:27 -0500
Message-Id: <20230319150027.66475-1-robh@kernel.org>
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

Replace open coded CPU nodes reading of "reg" and translation to logical
ID with of_cpu_node_to_id().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 34 +++++++++++----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index e771ce70e132..27cfe753c467 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/smp.h>
 #include <linux/suspend.h>
@@ -210,7 +211,6 @@ static void apmu_parse_dt(void (*fn)(struct resource *res, int cpu, int bit))
 	struct device_node *np_apmu, *np_cpu;
 	struct resource res;
 	int bit, index;
-	u32 id;
 
 	for_each_matching_node(np_apmu, apmu_ids) {
 		/* only enable the cluster that includes the boot CPU */
@@ -218,33 +218,27 @@ static void apmu_parse_dt(void (*fn)(struct resource *res, int cpu, int bit))
 
 		for (bit = 0; bit < CONFIG_NR_CPUS; bit++) {
 			np_cpu = of_parse_phandle(np_apmu, "cpus", bit);
-			if (np_cpu) {
-				if (!of_property_read_u32(np_cpu, "reg", &id)) {
-					if (id == cpu_logical_map(0)) {
-						is_allowed = true;
-						of_node_put(np_cpu);
-						break;
-					}
-
-				}
+			if (np_cpu && of_cpu_node_to_id(np_cpu) == 0) {
+				is_allowed = true;
 				of_node_put(np_cpu);
+				break;
 			}
+			of_node_put(np_cpu);
 		}
 		if (!is_allowed)
 			continue;
 
 		for (bit = 0; bit < CONFIG_NR_CPUS; bit++) {
 			np_cpu = of_parse_phandle(np_apmu, "cpus", bit);
-			if (np_cpu) {
-				if (!of_property_read_u32(np_cpu, "reg", &id)) {
-					index = get_logical_index(id);
-					if ((index >= 0) &&
-					    !of_address_to_resource(np_apmu,
-								    0, &res))
-						fn(&res, index, bit);
-				}
-				of_node_put(np_cpu);
-			}
+			if (!np_cpu)
+				continue;
+
+			index = of_cpu_node_to_id(np_cpu);
+			if ((index >= 0) &&
+			    !of_address_to_resource(np_apmu, 0, &res))
+				fn(&res, index, bit);
+
+			of_node_put(np_cpu);
 		}
 	}
 }
-- 
2.39.2

