Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44540665709
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbjAKJMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238479AbjAKJLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:11:31 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D797B15737;
        Wed, 11 Jan 2023 01:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1673428086; x=1704964086;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ktldcXxVnrk9cNFDRaUOrMoWTA9I+bDZmJoMwZ8rRTk=;
  b=jY0aKZHgFzuPiJNiox9aDrF+Z/wp6DADw+byMOX/gKbyo+JYfAPg46Hf
   G+vUY7mDiX3wssdTiXP35nvAfh3lgRq5QIB/7yLnDRRCPOWtFxZuca486
   GTO6s4MHMDUWM2TGnegaXRppPrUGshCqisPq2TYolRl/3fMT1gEVVX8Tl
   s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Jan 2023 01:08:06 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 01:08:06 -0800
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 11 Jan 2023 01:08:04 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>
CC:     <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH] pstore/ram: Rework logic for detecting ramoops
Date:   Wed, 11 Jan 2023 14:37:45 +0530
Message-ID: <1673428065-22356-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved memory region for ramoops is assumed to be at a fixed
and known location when read from the devicetree. This is not desirable
in environments where it is preferred the region to be dynamically
allocated at runtime, as opposed to being fixed at compile time.

Also, Some of the platforms might be still expecting dedicated
memory region for ramoops node where the region is known
beforehand and platform_get_resource() is used in that case.

So, Add logic to detect the start and size of the ramoops memory
region by looking up reserved memory region with
of_reserved_mem_lookup() when platform_get_resource() failed.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 fs/pstore/ram.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index ade66db..e4bbba1 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -20,6 +20,7 @@
 #include <linux/compiler.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 
 #include "internal.h"
 #include "ram_internal.h"
@@ -643,6 +644,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 {
 	struct device_node *of_node = pdev->dev.of_node;
 	struct device_node *parent_node;
+	struct reserved_mem *rmem;
 	struct resource *res;
 	u32 value;
 	int ret;
@@ -651,13 +653,20 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-		dev_err(&pdev->dev,
-			"failed to locate DT /reserved-memory resource\n");
-		return -EINVAL;
+		rmem = of_reserved_mem_lookup(of_node);
+		if (rmem) {
+			pdata->mem_size = rmem->size;
+			pdata->mem_address = rmem->base;
+		} else {
+			dev_err(&pdev->dev,
+				"failed to locate DT /reserved-memory resource\n");
+			return -EINVAL;
+		}
+	} else {
+		pdata->mem_size = resource_size(res);
+		pdata->mem_address = res->start;
 	}
 
-	pdata->mem_size = resource_size(res);
-	pdata->mem_address = res->start;
 	/*
 	 * Setting "unbuffered" is deprecated and will be ignored if
 	 * "mem_type" is also specified.
-- 
2.7.4

