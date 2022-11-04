Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DD1619C72
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiKDQDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiKDQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:03:16 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAE432B9B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:03:15 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A47dElG022482;
        Fri, 4 Nov 2022 11:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=be1LUm+gxdaWFn7qcs+lBl2UTAJEdYF5CnIBGFt+dPM=;
 b=O5hkYCJylYSqADUmVWk1mQ6Rgru0jBwSMaDq1rdx6mTnGhoGHUvos5hCMu1RzigG4qqZ
 IN+l+OvBR1VrGYZxKnzKDZE9jslLORLF1tgWkwQV2pZjS7G1VCap73HsrhRbxmatqp73
 YX7jPSDjCzJb5qaCS4vsQ9ochaIKHNpe2bOO4BpzElZGRcpNKVQmabq5whS04QXBl/1W
 VqdPgbpsNKEFLRMdkfSSSyE5seX9TNDYpZz4t4N9ok+cPSm6S4JDDA/qW5AvdKRiouBQ
 ltlI86UUof9kHOnr7qC79Xo2d07MjxkHQYNRFzwz0Qe+xkXVL+vmoQoJQyglacif5ALD dQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kmpgch0nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 11:03:02 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Fri, 4 Nov
 2022 11:03:00 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Fri, 4 Nov 2022 11:03:00 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.97])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6481346C;
        Fri,  4 Nov 2022 16:03:00 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: soc-dai: Do not call snd_soc_link_be_hw_params_fixup() twice
Date:   Fri, 4 Nov 2022 16:02:52 +0000
Message-ID: <20221104160252.166114-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bM1Ef0lehXFyZpWQL2rxoAvWte-3i2qA
X-Proofpoint-GUID: bM1Ef0lehXFyZpWQL2rxoAvWte-3i2qA
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a BE link snd_soc_link_be_hw_params_fixup() is called by
dpcm_be_dai_hw_params() to initialize the params before it passes them
to __soc_pcm_hw_params(). Then __soc_pcm_hw_params() refines params to
match the BE codec and passes that to snd_soc_dai_hw_params().

The second call of snd_soc_link_be_hw_params_fixup() within
snd_soc_dai_hw_params() was overwriting the refined params with the
original BE CPU DAI params. This would then lead to various problems,
for example passing an invalid number of channels to the codec driver
hw_params(), or enabling more AIF widgets on the codec than are actually
mapped by TDM slots.

These errors may not be noticed on a simple 1:1 link between one CPU DAI
and one codec DAI, because most likely they have the same DAI config
(though this is not necessarily true, for example if the CPU end has dummy
TDM slots to achieve a desirable BCLK).

For 1:N mappings there are likely to be multiple codecs using different
subsets of the TDM slots and this overwriting of the refined params
can cause incorrect configuration of each codec on the link.

The erroneous extra call to the BE fixup function() was introduced
by:
commit a655de808cbd ("ASoC: core: Allow topology to override machine
driver FE DAI link config.")

at that time, the call to the BE fixup was already done by
dpcm_be_dai_hw_params(), which was introduced several years earlier
by:
commit 01d7584cd2e5 ("ASoC: dpcm: Add Dynamic PCM core operations.")

The erroneous code has changed and moved to a different source file
since the patch that introduced it, so this fix patch won't directly
apply as a fix on top of code older than:
commit 8b4ba1d31771 ("ASoC: soc-dai: fix up hw params only if it is
needed")

though it can be applied with some minor adjustment to code before
that patch but after:
commit aa6166c2ac28 ("ASoC: soc-dai: mv soc_dai_hw_params() to soc-dai")

On any tree older than that the code is in soc-pcm.c.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/soc-dai.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 49752af0e205..29a75fdf90e0 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -386,23 +386,16 @@ int snd_soc_dai_hw_params(struct snd_soc_dai *dai,
 			  struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	int ret = 0;
 
 	if (dai->driver->ops &&
-	    dai->driver->ops->hw_params) {
-		/* perform any topology hw_params fixups before DAI  */
-		ret = snd_soc_link_be_hw_params_fixup(rtd, params);
-		if (ret < 0)
-			goto end;
-
+	    dai->driver->ops->hw_params)
 		ret = dai->driver->ops->hw_params(substream, params, dai);
-	}
 
 	/* mark substream if succeeded */
 	if (ret == 0)
 		soc_dai_mark_push(dai, substream, hw_params);
-end:
+
 	return soc_dai_ret(dai, ret);
 }
 
-- 
2.30.2

