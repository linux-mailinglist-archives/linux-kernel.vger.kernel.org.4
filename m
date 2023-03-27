Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3CB6CB025
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC0Uwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjC0Uwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:52:39 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3963ED1;
        Mon, 27 Mar 2023 13:52:38 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso10647041fac.12;
        Mon, 27 Mar 2023 13:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679950357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCokmroWwO4VufX7A6mOYl3GgmQFzU+xi4IMBIypRNk=;
        b=69JZJ4TqcT0ZA697HRqBOcKsTprR/jP3ATD3q5fSycl7BZmDMcRK1k4F5R83wLy5d2
         FSJSqpgEx+YEVwJt+cOVKfSccfq7CwgvpniZxozmLCHHJcCDNkvqhlMSghQNwTV4+cj3
         iSQVVrzpvoIbsD65mGWblb/ud/sW0EMyeGJm+G4Z6WBWW4MO2QVFHbubUORonpyNVlYL
         wx4jRujFykS+9qHd4WMickeqald2qvWkRx2PXWqyutWhsowh74I1r6fiMxQT+Y7gPsbm
         i4DwyuZbz0FvfHIr+HoecPQAVphaOKcZfuidZWLM056j+9jVmGQFce610UwYw2m5mD62
         7HTQ==
X-Gm-Message-State: AAQBX9cpKZPMWn/2BsuLo8aN7FuCGu7K4WIrW/5+5TSPnIEAVRKzy3CW
        PlljONrqgoQZYk+S6xsWuQ==
X-Google-Smtp-Source: AK7set+8JPEPqeE9hXVijJtbMJer5bZDZeNugXZaxtUt4ndBavVZ+nQHJVymYACFFPbFLtprz+KixQ==
X-Received: by 2002:a05:6870:899c:b0:17b:1a4f:adfe with SMTP id f28-20020a056870899c00b0017b1a4fadfemr7706053oaq.10.1679950357540;
        Mon, 27 Mar 2023 13:52:37 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eh1-20020a056808274100b00383ece4c29bsm11562672oib.6.2023.03.27.13.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:52:36 -0700 (PDT)
Received: (nullmailer pid 573623 invoked by uid 1000);
        Mon, 27 Mar 2023 20:52:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: sh-mobile: Use of_cpu_node_to_id() to read CPU node 'reg'
Date:   Mon, 27 Mar 2023 15:52:28 -0500
Message-Id: <20230327205228.573456-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded CPU nodes reading of "reg" and translation to logical
ID with of_cpu_node_to_id().

The original code called of_parse_phandle() CONFIG_NR_CPUS times
regardless of the length of 'cpus'. Optimize the loop to bail out once
of_parse_phandle() fails as the end of 'cpus' property has been reached.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Optimize the number of loop iterations
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 36 ++++++++++++---------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index e771ce70e132..ec6f421c0f4d 100644
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
@@ -218,33 +218,29 @@ static void apmu_parse_dt(void (*fn)(struct resource *res, int cpu, int bit))
 
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
+			if (!np_cpu)
+				break;
+			if (of_cpu_node_to_id(np_cpu) == 0) {
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
+				break;
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

