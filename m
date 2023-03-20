Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235836C10AF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCTLXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCTLW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:22:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80E6114
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:22:56 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K6xMZf028388;
        Mon, 20 Mar 2023 06:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=pKF0uI7lm6EPpC6Qzi9YRJ+YwdwwOiOgrKlQyRUjDH0=;
 b=aJq0d7eOqPh3fDY/cEVN4n+vmmJ7tbE3EBDhnvKqAPy8ZPmoWcfwFONMVUUP+CqZy+C4
 aTPiZDh+2PIyRWGNlws3a7oGuObxEYo0Ny5sLEB3utrxVFYeaPs4p3RdrnXI7PrtKCdD
 n4ddhN5gbByTXCKRoZDClAY7HBukl9Tdgt4evfzGxQ+BC6UjH4tp8zpr6/92Q0iGcT3W
 YpUhWbJAKvj/Lz8/dj92kQ4PSCpeZMnGrBcLe0z2sEUO5uwJazy2W3vUdenUmiwTmwht
 Eo7ShnxfRQWHPkJyf/2Wp5ksl4UDT5Zlq1VD5zJhU1x26pzsJZGwJlGxJdFtDgD+ismK kw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pd9qptc80-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 06:22:47 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 20 Mar
 2023 06:22:45 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 20 Mar 2023 06:22:45 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8F386B0E;
        Mon, 20 Mar 2023 11:22:45 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 1/8] firmware: cs_dsp: Introduce no_core_startstop for self-booting DSPs
Date:   Mon, 20 Mar 2023 11:22:38 +0000
Message-ID: <20230320112245.115720-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230320112245.115720-1-rf@opensource.cirrus.com>
References: <20230320112245.115720-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 87Vl-qHZjsYT_z7Y3PqBjik6yzXav5o9
X-Proofpoint-ORIG-GUID: 87Vl-qHZjsYT_z7Y3PqBjik6yzXav5o9
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

There are devices containing Halo Core DSPs that self-boot, cs_dsp is
used to manage the running firmware but the host does not have direct
control over starting and stopping the DSP and so cs_dsp should consider
the DSP to be always running.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c       | 14 +++++++++++++-
 include/linux/firmware/cirrus/cs_dsp.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index f558b390fbfe..97b73a254380 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -301,6 +301,7 @@ struct cs_dsp_ops {
 static const struct cs_dsp_ops cs_dsp_adsp1_ops;
 static const struct cs_dsp_ops cs_dsp_adsp2_ops[];
 static const struct cs_dsp_ops cs_dsp_halo_ops;
+static const struct cs_dsp_ops cs_dsp_halo_ao_ops;
 
 struct cs_dsp_buf {
 	struct list_head list;
@@ -2821,7 +2822,10 @@ EXPORT_SYMBOL_NS_GPL(cs_dsp_adsp2_init, FW_CS_DSP);
  */
 int cs_dsp_halo_init(struct cs_dsp *dsp)
 {
-	dsp->ops = &cs_dsp_halo_ops;
+	if (dsp->no_core_startstop)
+		dsp->ops = &cs_dsp_halo_ao_ops;
+	else
+		dsp->ops = &cs_dsp_halo_ops;
 
 	return cs_dsp_common_init(dsp);
 }
@@ -3187,6 +3191,14 @@ static const struct cs_dsp_ops cs_dsp_halo_ops = {
 	.stop_core = cs_dsp_halo_stop_core,
 };
 
+static const struct cs_dsp_ops cs_dsp_halo_ao_ops = {
+	.parse_sizes = cs_dsp_adsp2_parse_sizes,
+	.validate_version = cs_dsp_halo_validate_version,
+	.setup_algs = cs_dsp_halo_setup_algs,
+	.region_to_reg = cs_dsp_halo_region_to_reg,
+	.show_fw_status = cs_dsp_halo_show_fw_status,
+};
+
 /**
  * cs_dsp_chunk_write() - Format data to a DSP memory chunk
  * @ch: Pointer to the chunk structure
diff --git a/include/linux/firmware/cirrus/cs_dsp.h b/include/linux/firmware/cirrus/cs_dsp.h
index cad828e21c72..29cd11d5a3cf 100644
--- a/include/linux/firmware/cirrus/cs_dsp.h
+++ b/include/linux/firmware/cirrus/cs_dsp.h
@@ -156,6 +156,7 @@ struct cs_dsp {
 	unsigned int sysclk_reg;
 	unsigned int sysclk_mask;
 	unsigned int sysclk_shift;
+	bool no_core_startstop;
 
 	struct list_head alg_regions;
 
-- 
2.30.2

