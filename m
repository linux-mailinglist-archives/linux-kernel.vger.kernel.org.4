Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6064B70F6F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbjEXMxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjEXMxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:53:09 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE560B0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:53:01 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O7EHi8016889;
        Wed, 24 May 2023 07:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=58Kmklmo85pMmm6rKi1qDz7LQqbxVEf8Bnt8pzdan2s=;
 b=AEt5e2SSTeI6sIZ5KcIqRqKsHjV8yjyNTdIn/nALQCTjVKT2DfXm6aqHfxWMZB3iZTkP
 uxOS/VbmQKD3QjJhPe+FyFuxlagMDxJlLe26nbb8mdIhP9CG+zh6gNDjnh0qyvlyWKVs
 ItOifItfVusIRCd7fBV5bWFCZ7AOvzCThLtTUiqUCTS7oMvXJ27PoGD1JBTh4TkhWE7g
 0uoyXfiku8nUxZmv0ce/YnKB8dWln5451PIPlEjCCCI8lPaMEiEmBPPpCK8FVCakAHI3
 CdC+89cFRW4LJf6bRmEGJs+sf6AZSF+vAs8Bwm3P03dQ073fyJ91BdYtXwsq/PvUlPgh iA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm579h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 07:52:42 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 24 May
 2023 07:52:40 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 May 2023 07:52:40 -0500
Received: from lon-bigdaddy.ad.cirrus.com (unknown [198.61.64.168])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AEE74B2F;
        Wed, 24 May 2023 12:52:40 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l42: Add PLL ratio table values
Date:   Wed, 24 May 2023 13:52:36 +0100
Message-ID: <20230524125236.57149-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8v6aVXJaTUTlk3K8eyW9-3V6ula6VOD6
X-Proofpoint-GUID: 8v6aVXJaTUTlk3K8eyW9-3V6ula6VOD6
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 4.8Mhz 9.6Mhz and 19.2MHz SCLK values
for MCLK 12MHz and 12.288MHz requested by Intel.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index e3edaa1a2761..8aa6af21e52c 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -646,12 +646,19 @@ static const struct cs42l42_pll_params pll_ratio_table[] = {
 	{ 3072000,  1, 0x00, 0x3E, 0x800000, 0x03, 0x10, 12000000, 125, 1},
 	{ 4000000,  1, 0x00, 0x30, 0x800000, 0x03, 0x10, 12000000,  96, 1},
 	{ 4096000,  1, 0x00, 0x2E, 0xE00000, 0x03, 0x10, 12000000,  94, 1},
+	{ 4800000,  1, 0x01, 0x50, 0x000000, 0x03, 0x10, 12000000,  80, 2},
+	{ 4800000,  1, 0x01, 0x50, 0x000000, 0x01, 0x10, 12288000,  82, 2},
 	{ 5644800,  1, 0x01, 0x40, 0x000000, 0x03, 0x10, 11289600, 128, 1},
 	{ 6000000,  1, 0x01, 0x40, 0x000000, 0x03, 0x10, 12000000, 128, 1},
 	{ 6144000,  1, 0x01, 0x3E, 0x800000, 0x03, 0x10, 12000000, 125, 1},
+	{ 6144000,  1, 0x01, 0x40, 0x000000, 0x03, 0x10, 12288000, 128, 1},
+	{ 9600000,  1, 0x02, 0x50, 0x000000, 0x03, 0x10, 12000000,  80, 2},
+	{ 9600000,  1, 0x02, 0x50, 0x000000, 0x01, 0x10, 12288000,  82, 2},
 	{ 11289600, 0, 0, 0, 0, 0, 0, 11289600, 0, 1},
 	{ 12000000, 0, 0, 0, 0, 0, 0, 12000000, 0, 1},
 	{ 12288000, 0, 0, 0, 0, 0, 0, 12288000, 0, 1},
+	{ 19200000, 1, 0x03, 0x50, 0x000000, 0x03, 0x10, 12000000,  80, 2},
+	{ 19200000, 1, 0x03, 0x50, 0x000000, 0x01, 0x10, 12288000,  82, 2},
 	{ 22579200, 1, 0x03, 0x40, 0x000000, 0x03, 0x10, 11289600, 128, 1},
 	{ 24000000, 1, 0x03, 0x40, 0x000000, 0x03, 0x10, 12000000, 128, 1},
 	{ 24576000, 1, 0x03, 0x40, 0x000000, 0x03, 0x10, 12288000, 128, 1}
-- 
2.34.1

