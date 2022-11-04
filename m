Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364C961942B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiKDKG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiKDKG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:06:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E20B63C0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:06:55 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A49TAQM012440;
        Fri, 4 Nov 2022 05:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=0pR3TOrHMf9AHUYqBblJTRAag2PL/OTVWGjwi52/bj4=;
 b=hUxE2vhD19xFJ1uLc3wc3uzsm51JVbUMxArrs1m68Vtv+67h+hktqAUP7nj5bBMMLzXp
 pN9vbhg18Twred/ilxxns1KptnLg8l4UMIt58w2agRgusmBACxEp0v4FQ2t+4Ec5LtEY
 mN7maTbd4nJnYiOqXHWTNB+3i797oV8VBIgp7CibObllaCT99025OO6eFsyDkxUOmsb6
 PTOVT0MlPbyDVpUV5MAXQFUmiQgL2XKPgdrLZcLO2oqz1Qehnm1Q0lZ8n7iR38UGZz/N
 f6pSjC0W3CSMaWlTYE9QnmdB62msus1RtAg7zisOKsR4YBqCKwsT1MxhJpMifOxiyrOw 2g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kmph3gmea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 05:06:39 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Fri, 4 Nov
 2022 05:06:37 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.15 via Frontend
 Transport; Fri, 4 Nov 2022 05:06:37 -0500
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.212])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 86B862AA;
        Fri,  4 Nov 2022 10:06:37 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: amd: Fix SPI_SPD7 value
Date:   Fri, 4 Nov 2022 10:06:37 +0000
Message-ID: <20221104100637.13376-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BWIpw-d5CSFly8m_iAhM2k8SG_jgY4NS
X-Proofpoint-GUID: BWIpw-d5CSFly8m_iAhM2k8SG_jgY4NS
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to data sheet SPI_SPD7 should be set to 7.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 drivers/spi/spi-amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index e23121456c70..bfc3ab5f39ea 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -65,7 +65,7 @@ enum amd_spi_speed {
 	F_16_66MHz,
 	F_100MHz,
 	F_800KHz,
-	SPI_SPD7,
+	SPI_SPD7 = 0x7,
 	F_50MHz = 0x4,
 	F_4MHz = 0x32,
 	F_3_17MHz = 0x3F
-- 
2.34.1

