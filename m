Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C9167229C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjARQKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjARQJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:09:05 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3225E46171
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:05:17 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IEDgr7022836;
        Wed, 18 Jan 2023 10:05:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=k5oNoCYjcpl/Ta/zXWc2NtstMbInyOsQe4rw1amTQII=;
 b=VC3KI2qdVhc8l7oQFesA70bP5axv+8ui/dmgewZfaLSUVEqMTiruqc61OGcHzU4+HGkv
 SHRW9mlYjCMd9TlquQ+MnP8Uenel5lJLQM7rlQX8fPmjp3rXsP+kYyxgg4Gy42fu6dk7
 J5u/KR2Xb+WTr3LK+PNBfH4ZWq9MAQ/gdUl1p/ci0gS9b+ebcNiJFDaFlznQMvcJY9oM
 smt/ZMgUVlExDpNh7IthYR3ZU4AeUAo1PKVqJG0+p7ZXSt+crJUkwFLZb0yRXx9sbnDO
 B7SHBJsxkbdTf8gpRHT5Vpo0HA04axh/llBJVQmNVUCWzSF9X43CQXn0J9XSAf/JGNnD lQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n3spx6vk9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 10:05:02 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 18 Jan
 2023 10:04:57 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Wed, 18 Jan 2023 10:04:57 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2A39F11CC;
        Wed, 18 Jan 2023 16:04:57 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 2/8] ASoC: cs42l42: Add SOFT_RESET_REBOOT register
Date:   Wed, 18 Jan 2023 16:04:46 +0000
Message-ID: <20230118160452.2385494-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Qs0q9NiF4zbq3I7Fi1ZM13SbCK8xRqKM
X-Proofpoint-ORIG-GUID: Qs0q9NiF4zbq3I7Fi1ZM13SbCK8xRqKM
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

The SOFT_RESET_REBOOT register is needed to recover CS42L42 state after
a Soundwire bus reset.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 include/sound/cs42l42.h    | 5 +++++
 sound/soc/codecs/cs42l42.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/sound/cs42l42.h b/include/sound/cs42l42.h
index 1d1c24fdd0cae..3994e933db195 100644
--- a/include/sound/cs42l42.h
+++ b/include/sound/cs42l42.h
@@ -34,6 +34,7 @@
 #define CS42L42_PAGE_24		0x2400
 #define CS42L42_PAGE_25		0x2500
 #define CS42L42_PAGE_26		0x2600
+#define CS42L42_PAGE_27		0x2700
 #define CS42L42_PAGE_28		0x2800
 #define CS42L42_PAGE_29		0x2900
 #define CS42L42_PAGE_2A		0x2A00
@@ -720,6 +721,10 @@
 
 #define CS42L42_SRC_SDOUT_FS		(CS42L42_PAGE_26 + 0x09)
 
+/* Page 0x27 DMA */
+#define CS42L42_SOFT_RESET_REBOOT	(CS42L42_PAGE_27 + 0x01)
+#define CS42L42_SFT_RST_REBOOT_MASK	BIT(1)
+
 /* Page 0x28 S/PDIF Registers */
 #define CS42L42_SPDIF_CTL1		(CS42L42_PAGE_28 + 0x01)
 #define CS42L42_SPDIF_CTL2		(CS42L42_PAGE_28 + 0x02)
diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 2fefbcf7bd130..82aa11d6937be 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -293,6 +293,7 @@ bool cs42l42_readable_register(struct device *dev, unsigned int reg)
 	case CS42L42_SPDIF_SW_CTL1:
 	case CS42L42_SRC_SDIN_FS:
 	case CS42L42_SRC_SDOUT_FS:
+	case CS42L42_SOFT_RESET_REBOOT:
 	case CS42L42_SPDIF_CTL1:
 	case CS42L42_SPDIF_CTL2:
 	case CS42L42_SPDIF_CTL3:
@@ -358,6 +359,7 @@ bool cs42l42_volatile_register(struct device *dev, unsigned int reg)
 	case CS42L42_LOAD_DET_DONE:
 	case CS42L42_DET_STATUS1:
 	case CS42L42_DET_STATUS2:
+	case CS42L42_SOFT_RESET_REBOOT:
 		return true;
 	default:
 		return false;
-- 
2.34.1

