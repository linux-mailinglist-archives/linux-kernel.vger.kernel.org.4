Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B596767EB94
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjA0Qv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjA0Qvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:51:41 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7447E041
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:51:40 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R9k8LU030633;
        Fri, 27 Jan 2023 10:51:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=UKQWjZMRpH18L587sSkNIJ8o9vGPgCnYzfg3iXOkhH0=;
 b=e+TEgArEZTsw4lZgKHzWOqhi00hiHOS/dCTidvVZHfzQ0C8Fy8nfmUS9l2KAChZmROxo
 ZLPhaku0Yfg1p3J1/6Ok5dRxwyVuEnwUbITJuxNUAAfb76mTJEHAHOZ4WEIA5xm5Yv7d
 pFVqumPX3THRHrJn8t/nIL9XL83BfDayDpFgQqmUjLso5tdH1d+3/uld0LV3to4cUYaU
 l9jAgjB4JVMoLF40gpWj0vnPUeddytrIpitE7XzM5vDJJeEOhwb3lWb90bURrQ3YfBhr
 galFePNI6uuvAR4E0MO27ps5bZ/X3GgDCl3/FStKgVk0d7yLbVqAXQqaQkz6oECt0vzB 0g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n8dbsvrd1-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 10:51:33 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 27 Jan
 2023 10:51:29 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Fri, 27 Jan 2023 10:51:29 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5612911CC;
        Fri, 27 Jan 2023 16:51:29 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 7/8] ASoC: cs42l42: Don't set idle_bias_on
Date:   Fri, 27 Jan 2023 16:51:10 +0000
Message-ID: <20230127165111.3010960-8-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZkKw86l3ICspP3onazchIyxGitXF6FCH
X-Proofpoint-GUID: ZkKw86l3ICspP3onazchIyxGitXF6FCH
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

idle_bias_on was set because cs42l42 has a "VMID" type pseudo-midrail
supply (named FILT+), and these typically take a long time to charge.
But the driver never enabled pm_runtime so it would never have powered-
down the cs42l42 anyway.

In fact, FILT+ can charge to operating voltage within 12.5 milliseconds
of enabling HP or ADC. This time is already covered by the startup
delay of the HP/ADC.

The datasheet warning about FILT+ taking up to 1 second to charge only
applies in the special cases that either the PLL is started or
DETECT_MODE set to non-zero while both HP and ADC are off. The driver
never does either of these.

Removing idle_bias_on allows the Soundwire host controller to suspend
if there isn't a snd_soc_jack handler registered.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index aa8d724432ab8..e3edaa1a2761e 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -597,7 +597,6 @@ const struct snd_soc_component_driver cs42l42_soc_component = {
 	.num_dapm_routes	= ARRAY_SIZE(cs42l42_audio_map),
 	.controls		= cs42l42_snd_controls,
 	.num_controls		= ARRAY_SIZE(cs42l42_snd_controls),
-	.idle_bias_on		= 1,
 	.endianness		= 1,
 };
 EXPORT_SYMBOL_NS_GPL(cs42l42_soc_component, SND_SOC_CS42L42_CORE);
-- 
2.34.1

