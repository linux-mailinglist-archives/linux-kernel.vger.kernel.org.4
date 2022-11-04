Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67AE6197AB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiKDNWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiKDNWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:22:33 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E81A2EF35
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:22:31 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A47mkSU006593;
        Fri, 4 Nov 2022 08:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=4pgVcvB8mbH5TGlS6atFEpzhB/zYR1p6PQrBMN0cqpE=;
 b=m7O9pLOWTcFuu6yfVu0TBrpSPnpyV5nGCEPlWXY+A6eUxmkUKaq8P4oW9GTnlCU5PfPo
 99wsOpMfcjIcoAQc/K4GQoio40pd36kZ02TTyQYKPQapZP+WAdQhgNlyjXU84hWaklJg
 lCTUuUMbmalrzTa1cbpjMd2fe3bIPAIVVGx6+eHgUBrPQ5RjYJT++odIQ0SS2z2jAp1V
 9DgOGgShqkCldavHwxUF85puRRIzjJ7lyn7DfJV7Xd9Xg3Zt1lXOZbJh0oMu0kOzpX/C
 Gw/FiOw9vbjmm2Z+t5DMBwjgW8BeSv75ACYeizuLLJJlyl5/U3wpe1Z5yEXvuBC2Ldqj 3Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kmpgcgt98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 08:22:21 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Fri, 4 Nov
 2022 08:22:20 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.15 via Frontend
 Transport; Fri, 4 Nov 2022 08:22:20 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.97])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CEFF946C;
        Fri,  4 Nov 2022 13:22:19 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <bcousson@baylibre.com>, <fparent@baylibre.com>,
        <misael.lopez@ti.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: soc-pcm: Don't zero TDM masks in __soc_pcm_open()
Date:   Fri, 4 Nov 2022 13:22:13 +0000
Message-ID: <20221104132213.121847-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fWI2S9PPXl7eF3HV6NjbLqkcIhYbmdIQ
X-Proofpoint-GUID: fWI2S9PPXl7eF3HV6NjbLqkcIhYbmdIQ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DAI tx_mask and rx_mask are set by snd_soc_dai_set_tdm_slot()
and used by later code that depends on the TDM settings. So
__soc_pcm_open() should not be obliterating those mask values.

The code in __soc_pcm_hw_params() uses these masks to calculate the
active channels so that only the AIF_IN/AIF_OUT widgets for the
active TDM slots are enabled. The zeroing of the masks in
__soc_pcm_open() disables this functionality so all AIF widgets
were enabled even for channels that are not assigned to a TDM slot.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2e5894d73789 ("ASoC: pcm: Add support for DAI multicodec")
---
 sound/soc/soc-pcm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index d8e4677f3002..493f003273d0 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -822,11 +822,6 @@ static int __soc_pcm_open(struct snd_soc_pcm_runtime *rtd,
 		ret = snd_soc_dai_startup(dai, substream);
 		if (ret < 0)
 			goto err;
-
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			dai->tx_mask = 0;
-		else
-			dai->rx_mask = 0;
 	}
 
 	/* Dynamic PCM DAI links compat checks use dynamic capabilities */
-- 
2.30.2

