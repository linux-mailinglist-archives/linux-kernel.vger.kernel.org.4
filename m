Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56667198AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjFAKMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjFAKLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:11:34 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2372E49
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:10:49 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3515qxEA012309;
        Thu, 1 Jun 2023 05:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=CYjUlUokqgwvfm/eWCGzun35GxlTrPgpDxWqqtsJt6s=;
 b=GgoEvh/wmZtSEQZhKxSaZL2ozjG1nRLbK9GW52YTtWXC5mHYD4XVu8xPYaEM3NRPyAn7
 T7oDYvu8F6Z7IJjc7EBRoxZPoAth0ORCP7KoLDkQFu/cHjMba8eZxkyPiyLFjL8hKyNL
 bVNhv937OSmAlvA4seZJyJd0VOYlFtUGPQBYrEwvRF0Y36RmYGBeLZydpXm4zbEGEcQF
 YUH9NO3xQvx5VfMPG0cEB0X83yd7jl55ZiKNoqH88gbWp/MOM5xButF1blKkLsaVhVci
 Zo1Chnd8c6W7ox2sFaeDdEdvexWze03vVJNspI1pXaJb5IYdQ5zaLOmb3ATHM/HcR4GG zA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3quf90wqub-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 05:10:46 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 1 Jun
 2023 11:10:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 11:10:36 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2119C475;
        Thu,  1 Jun 2023 10:10:36 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] regmap: Add missing cache_only checks
Date:   Thu, 1 Jun 2023 11:10:36 +0100
Message-ID: <20230601101036.1499612-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230601101036.1499612-1-ckeepax@opensource.cirrus.com>
References: <20230601101036.1499612-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Liq_mNh9AWkq98Wsc3QFSaKV-UhO6GYd
X-Proofpoint-ORIG-GUID: Liq_mNh9AWkq98Wsc3QFSaKV-UhO6GYd
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current behaviour around cache_only is slightly inconsistent,
most paths will only check cache_only if cache_bypass is false,
and will return -EBUSY if a read attempts to go to the hardware
whilst cache_only is true. However, a couple of paths will not check
cache_only at all.  The most notable of these being regmap_raw_read
which will check cache_only in the case it processes the transaction
one register at a time, but not in the case it handles them as a
block. In the typical case a device has been put into cache_only
whilst powered down this can cause physical reads to happen whilst the
device is unavailable.

Add a check in regmap_raw_read and move the check in regmap_noinc_read,
adding a check for cache_bypass, such that all paths are covered and
consistent.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index fa2d3fba6ac9d..627a767fa0470 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2983,6 +2983,11 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 		size_t chunk_count, chunk_bytes;
 		size_t chunk_regs = val_count;
 
+		if (!map->cache_bypass && map->cache_only) {
+			ret = -EBUSY;
+			goto out;
+		}
+
 		if (!map->read) {
 			ret = -ENOTSUPP;
 			goto out;
@@ -3078,18 +3083,19 @@ int regmap_noinc_read(struct regmap *map, unsigned int reg,
 		goto out_unlock;
 	}
 
+	/*
+	 * We have not defined the FIFO semantics for cache, as the
+	 * cache is just one value deep. Should we return the last
+	 * written value? Just avoid this by always reading the FIFO
+	 * even when using cache. Cache only will not work.
+	 */
+	if (!map->cache_bypass && map->cache_only) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	/* Use the accelerated operation if we can */
 	if (map->bus->reg_noinc_read) {
-		/*
-		 * We have not defined the FIFO semantics for cache, as the
-		 * cache is just one value deep. Should we return the last
-		 * written value? Just avoid this by always reading the FIFO
-		 * even when using cache. Cache only will not work.
-		 */
-		if (map->cache_only) {
-			ret = -EBUSY;
-			goto out_unlock;
-		}
 		ret = regmap_noinc_readwrite(map, reg, val, val_len, false);
 		goto out_unlock;
 	}
-- 
2.30.2

