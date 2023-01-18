Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988CE67228E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjARQJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjARQJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:09:05 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D3446159
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:05:17 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IEDgrB022836;
        Wed, 18 Jan 2023 10:05:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=frUZfxKkTDkW87u5OQbfX6rw2QFXA5a5bNSyUepkgBc=;
 b=E3JIXvjHd/ksH23puwvZaV/38rQ5qDiH5szpk6owT2rX7sNDj9Ok5Ye+6U2MtHL3Vw1T
 FcAzKWiUca/5rPmnUJ76aFd4kIKioPDnav5Xx0i3Fxfj2CJLrmJhd8pAV5P8ymJ0TpPy
 OOucnoUgWROiEZ5UZVg3Dc3R0idqh5o5+qfAWDMvEY7eI6WJPinxMYLmDY0428xoAX1n
 hN1ie6extehDTziAHyqQ9ugPq+ReC7VbOxbSToeg9NvSbuuCJC6ce5ohvRu2EPWSpzG4
 amXYoqKZrIlWKhnUJKxA3USneIhvxASvivpkA0365vG7/CfS3PqlWXkDqeC22HICw7m7 og== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n3spx6vk9-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 10:05:08 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 18 Jan
 2023 10:04:58 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.7 via Frontend Transport; Wed, 18 Jan 2023 10:04:58 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ED30B11CB;
        Wed, 18 Jan 2023 16:04:57 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 7/8] ASoC: cs42l42: Don't set idle_bias_on
Date:   Wed, 18 Jan 2023 16:04:51 +0000
Message-ID: <20230118160452.2385494-8-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lo4yHFbhzh4p8Z6_5t_7Dhw_IJrSF4LQ
X-Proofpoint-ORIG-GUID: lo4yHFbhzh4p8Z6_5t_7Dhw_IJrSF4LQ
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
index a92499876ce2a..aa2223bfb885a 100644
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

