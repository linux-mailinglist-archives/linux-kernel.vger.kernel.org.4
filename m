Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88EC69B058
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjBQQO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjBQQOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:14:32 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DE170962
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:14:29 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HFgnU6014021;
        Fri, 17 Feb 2023 10:14:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=BTzjXHS8eGJxhVWLT03TdB551hVigNKYmkSmV3VC72k=;
 b=pN5baqNAzos9zTAUCDG08LxOESwchhnD/w4UVCnBRuwhy+pB7cqipWYf+D22yQBmGrWI
 TleYihdhcks1/3y5JhLNuJ9oVbSiUZT6mau+9q8w9Vx8zOUsGKzScLY8wwhAk4cHdUDg
 ++wM8+5S6kgkEInvBuXunPMnVS8B9Ky7lMwNXwIrQieu/QZls0G2+cj/fjqkmOneBkzE
 neWOKDFM3wdPS7cN0VkjRJbZPmDNLaiZZE9zr8OdHBtArxT8YWjmpnlE97xmFieMrD2Z
 5sVVXEVQP94uCqAN5ByCKFA0UKHQG3QzVlt4xswxT5EkKQ4HN7Bb9P3hcALmLcp+bGXQ 8w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nrm8wm7t6-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 10:14:13 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 17 Feb
 2023 10:14:10 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Fri, 17 Feb 2023 10:14:10 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DE46745;
        Fri, 17 Feb 2023 16:14:10 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <cezary.rojewski@intel.com>, <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kai.vehmanen@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 10/10] ASoC: Intel: soc-acpi: Add CS35L56 Soundwire to TGL
Date:   Fri, 17 Feb 2023 16:14:10 +0000
Message-ID: <20230217161410.915202-11-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230217161410.915202-1-rf@opensource.cirrus.com>
References: <20230217161410.915202-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mqzk6flip_3wcJ6k9Ft6Lz4HKUzCdVT6
X-Proofpoint-ORIG-GUID: mqzk6flip_3wcJ6k9Ft6Lz4HKUzCdVT6
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds match entries for one or four CS35L56 on SDW0.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 .../intel/common/soc-acpi-intel-tgl-match.c   | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
index ef19150e7b2e..dae76c96d9fe 100644
--- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
@@ -414,6 +414,51 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_tgl_machines);
 
+static const struct snd_soc_acpi_adr_device cs35l56_sdw0_adr[] = {
+	{
+		.adr = 0x00003001fa355601,
+		.num_endpoints = 1,
+		.endpoints = &single_endpoint,
+		.name_prefix = "AMP1"
+	},
+	{
+		.adr = 0x00003101fa355601,
+		.num_endpoints = 1,
+		.endpoints = &single_endpoint,
+		.name_prefix = "AMP2"
+	},
+	{
+		.adr = 0x00003201fa355601,
+		.num_endpoints = 1,
+		.endpoints = &single_endpoint,
+		.name_prefix = "AMP3"
+	},
+	{
+		.adr = 0x00003301fa355601,
+		.num_endpoints = 1,
+		.endpoints = &single_endpoint,
+		.name_prefix = "AMP4"
+	},
+};
+
+static const struct snd_soc_acpi_link_adr up_extreme_cs35l56_sdw0_one[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = 1,
+		.adr_d = cs35l56_sdw0_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr up_extreme_cs35l56_sdw0_four[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = 4,
+		.adr_d = cs35l56_sdw0_adr,
+	},
+	{}
+};
+
 /* this table is used when there is no I2S codec present */
 struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_sdw_machines[] = {
 	/* mockup tests need to be first */
@@ -501,6 +546,18 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-tgl-rt711.tplg",
 	},
+	{
+		.link_mask = BIT(0),
+		.links = up_extreme_cs35l56_sdw0_four,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-tgl-cs35l56-sdw0.tplg"
+	},
+	{
+		.link_mask = BIT(0),
+		.links = up_extreme_cs35l56_sdw0_one,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-tgl-cs35l56-sdw0.tplg"
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_tgl_sdw_machines);
-- 
2.30.2

