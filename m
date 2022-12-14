Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C9F64D235
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiLNWQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLNWQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:16:47 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377C22CC81
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:16:46 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so753598pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NT/9Rh2N/j7novKGPUvYbhzVIukro1B6crk90dTmnGQ=;
        b=s6WmaR8nRnLYRP5mH3tZ1rUXeH2OVIT5OczB6E70qlbNeNXisqFCUdt275otNaFxQN
         t5kWSWch7rBqcHFERw3RFOL1UkmLET8H0cZSVjkiEFU4VG4NseulOBsb+9B9UY4OkAZU
         kLaj25J6znJ/E6Z1SXQwkuX44R5PyQED2i3WBQ/xtyi/+8WHphZoWJSTReIDm+gQ7eE5
         c0uy6o3Bf5xD0N3Nt++3nwsTltv+3ZoYgFHtWtsJfsqxKfJiQsxj+bn4NPYvPnxIDq7w
         B9R3dGX72tY1o5fZ17e9JUih+y6Ds6nxkOrCHHyxew0M8Co8ilgoedtSSg0KxrtY/vqW
         b3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NT/9Rh2N/j7novKGPUvYbhzVIukro1B6crk90dTmnGQ=;
        b=5szJfNGi17itkX9CVyUZBfSmw6X/I/yfzqbTZ0MGj3Z4xFWl1tXrKWJwpe4AFieo50
         CJTt3/dS4o/dmkw/P3OF4VbXM6OnMIpLqzTsWL7FcuwxcrvpP7sFzw5JnO149pwUkNYR
         UOvcKUODDnDdUa97bfuPha8uCYKftvVh3R2slod9cnYt3rgPsaRbrBBn9B5WybmteZWz
         S70YeFErZCvcHaF+EIssLy//2XqZaffs/gXRS3qKLG3gM59l05gLTOTF9vlttD0XRWpY
         UlRw7lIyYgprUsgoQu2vFfxu/fOa3gdEFDLEaYnA1ZVVRByTfisAYtRj4kHdFx71NsLV
         kBBg==
X-Gm-Message-State: ANoB5plnoaMPaJTr3dhuIpx7kzIrmvrpCTKO/L0Lf9/Bz7p4gAL+5kbw
        X/DJ2Va4X5wceXeN59Hh2mpnOA==
X-Google-Smtp-Source: AA0mqf6mKMITSx1PZVCVX96+zgkHuPvBD74UELeBi73qE4jfP8OeGEEO9Jau3nRjY0bXhNqZX8DHww==
X-Received: by 2002:a17:903:26c7:b0:189:b2b8:dbeb with SMTP id jg7-20020a17090326c700b00189b2b8dbebmr26211044plb.61.1671056205739;
        Wed, 14 Dec 2022 14:16:45 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:dd50:d021:2d62:a2ee])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b0017f7c4e260fsm2337263plg.150.2022.12.14.14.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:16:44 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     andersson@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.levinsky@xilinx.com
Subject: [PATCH] remoteproc: Make rproc_get_by_phandle() work for clusters
Date:   Wed, 14 Dec 2022 15:16:43 -0700
Message-Id: <20221214221643.1286585-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multi-cluster remoteproc designs typically have the following DT
declaration:

	remoteproc_cluster {
		compatible = "soc,remoteproc-cluster";

                core0: core0 {
			compatible = "soc,remoteproc-core"
                        memory-region;
                        sram;
                };

                core1: core1 {
			compatible = "soc,remoteproc-core"
                        memory-region;
                        sram;
                }
        };

A driver exists for the cluster rather than the individual cores
themselves so that operation mode and HW specific configurations
applicable to the cluster can be made.

Because the driver exists at the cluster level and not the individual
core level, function rproc_get_by_phandle() fails to return the
remoteproc associated with the phandled it is called for.

This patch enhances rproc_get_by_phandle() by looking for the cluster's
driver when the driver for the immediate remoteproc's parent is not
found.

Reported-by: Ben Levinsky <ben.levinsky@xilinx.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 1cd4815a6dd1..91f82886add9 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -33,6 +33,7 @@
 #include <linux/idr.h>
 #include <linux/elf.h>
 #include <linux/crc32.h>
+#include <linux/of_platform.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_ring.h>
@@ -2110,7 +2111,9 @@ EXPORT_SYMBOL(rproc_detach);
 #ifdef CONFIG_OF
 struct rproc *rproc_get_by_phandle(phandle phandle)
 {
+	struct platform_device *cluster_pdev;
 	struct rproc *rproc = NULL, *r;
+	struct device_driver *driver;
 	struct device_node *np;
 
 	np = of_find_node_by_phandle(phandle);
@@ -2121,7 +2124,30 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
 	list_for_each_entry_rcu(r, &rproc_list, node) {
 		if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
 			/* prevent underlying implementation from being removed */
-			if (!try_module_get(r->dev.parent->driver->owner)) {
+
+			/*
+			 * If the remoteproc's parent has a driver, the
+			 * remoteproc is not part of a cluster and we can use
+			 * that driver.
+			 */
+			driver = r->dev.parent->driver;
+
+			/*
+			 * If the remoteproc's parent does not have a driver,
+			 * look for the driver associated with the cluster.
+			 */
+			if (!driver) {
+				cluster_pdev = of_find_device_by_node(np->parent);
+				if (!cluster_pdev) {
+					dev_err(&r->dev, "can't get parent\n");
+					break;
+				}
+
+				driver = cluster_pdev->dev.driver;
+				put_device(&cluster_pdev->dev);
+			}
+
+			if (!try_module_get(driver->owner)) {
 				dev_err(&r->dev, "can't get owner\n");
 				break;
 			}
-- 
2.25.1

