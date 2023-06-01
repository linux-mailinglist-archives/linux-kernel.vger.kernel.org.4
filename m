Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574857198AA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjFAKMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjFAKLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:11:34 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A12E48
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:10:49 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3515qxE9012309;
        Thu, 1 Jun 2023 05:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=n57MVcye861vqpd+7cbgKBm9G0JBu/LE6whTKr7WxlI=;
 b=UNuynko4ERYwUnoyhTmu23SbFs+TOrLsUcnyHY2urE1DaxYQHLyQ/gqNu1SZ70ma+yYT
 Ah8tA7198JwlbhUkSmut63pmUZQZmo69dsL3IGhagO35M6mC2nHBdqjdEM5rcA3l4AUd
 a1hV+rjD8OizS5TCvCFYyLB3LI0lhKV+9DODTGZ1Up7ljXPOqBPhubLGV5rbcDZcuhu0
 LDbHfKmvilWv1/qf5BBWCFw2iSmInRXzxzYsYegYrfpY0Wo3UjXln260Opq4x+GuaJbE
 gD8+51+oyLhd4Zng2s79MmF2Ur8DPLiXyqdp6OEOCeuS4rUQA5kb4gor+xGffY3N2iJZ 2g== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3quf90wqub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 05:10:45 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 1 Jun
 2023 11:10:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 11:10:36 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 110B745;
        Thu,  1 Jun 2023 10:10:36 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] regmap: regmap-irq: Move handle_post_irq to before pm_runtime_put
Date:   Thu, 1 Jun 2023 11:10:35 +0100
Message-ID: <20230601101036.1499612-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: LnamJCVghHxhPaqopfmDgt0U0VSt30OO
X-Proofpoint-ORIG-GUID: LnamJCVghHxhPaqopfmDgt0U0VSt30OO
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typically handle_post_irq is going to be used to manage some
additional chip specific hardware operations required on each IRQ,
these are very likely to want the chip to be resumed. For example the
current in tree user max77620 uses this to toggle a global mask bit,
which would obviously want the device resumed. It is worth noting this
device does not specify the runtime_pm flag in regmap_irq_chip, so
there is no actual issue.

Move the callback to before the pm_runtime_put, so it will be called
whilst the device is still resumed.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 330da5d6c8c3a..ced0dcf86e0bf 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -502,12 +502,12 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 	}
 
 exit:
-	if (chip->runtime_pm)
-		pm_runtime_put(map->dev);
-
 	if (chip->handle_post_irq)
 		chip->handle_post_irq(chip->irq_drv_data);
 
+	if (chip->runtime_pm)
+		pm_runtime_put(map->dev);
+
 	if (handled)
 		return IRQ_HANDLED;
 	else
-- 
2.30.2

