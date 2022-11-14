Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3210C627A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbiKNKal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbiKNKaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:30:16 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26486F596
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:30:14 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AE8Wcif019990;
        Mon, 14 Nov 2022 04:29:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=MkrQQO/rMS+/NwhSJyDSR/0qlVfWLkI1ekIUmlwClk8=;
 b=SYjzWDktP9/zUEfocjVG8Y3be1bsi3Fxyx86bZz53nw2Kex4jsTM35cak8qy1xMgPXxC
 ZkgAniXvMIxFgtQWLE7Xa3nrvTb2uPgR+//veGNk4+CHIZrNp9csyS7+/wXKcabQBqgC
 bXi9kUVAOO7i0CKTb2FSWHh8cPP8EIzx2f4X7oDFpXGLB2oD+j666g3bV1sZzIbh4RXL
 P/vaVS8IHm1F9xYua546bN01k1vcM90ToqPAj90qTzZiDTQ8dn9ROinTsvPkJspdNlj6
 MSj4N0gyGBoPOuh2+ypiee3QP491VFctzqvoacBOmlweCta7Bl3lPcdZGPqx6bR0eZY7 sQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kt8sst0cm-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 04:29:59 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Mon, 14 Nov
 2022 04:29:56 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.15 via Frontend
 Transport; Mon, 14 Nov 2022 04:29:56 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6C48EB38;
        Mon, 14 Nov 2022 10:29:56 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 4/4] soundwire: stream: Move remaining register accesses over to no_pm
Date:   Mon, 14 Nov 2022 10:29:56 +0000
Message-ID: <20221114102956.914468-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221114102956.914468-1-ckeepax@opensource.cirrus.com>
References: <20221114102956.914468-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: eEFxQxHBInaqwQyfmT2KyYsPujWPgq8T
X-Proofpoint-ORIG-GUID: eEFxQxHBInaqwQyfmT2KyYsPujWPgq8T
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to play with the runtime reference everytime a register
is accessed. All the remaining "pm" style register accesses trace back
to 4 functions:

sdw_prepare_stream
sdw_deprepare_stream
sdw_enable_stream
sdw_disable_stream

Any sensible implementation will need to hold a runtime reference
across all those functions, it makes no sense to be allowing the
device/bus to suspend whilst streams are being prepared/enabled. And
certainly in the case of the all existing users, they all call these
functions from hw_params/prepare/trigger/hw_free callbacks in ALSA,
which will have already runtime resumed all the audio devices
associated during the open callback.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/soundwire/bus.c    |  2 +-
 drivers/soundwire/stream.c | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index ef4878258afad..d87a188fcce1e 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1214,7 +1214,7 @@ int sdw_configure_dpn_intr(struct sdw_slave *slave,
 		val &= ~SDW_DPN_INT_PORT_READY;
 	}
 
-	ret = sdw_update(slave, addr, (mask | SDW_DPN_INT_PORT_READY), val);
+	ret = sdw_update_no_pm(slave, addr, (mask | SDW_DPN_INT_PORT_READY), val);
 	if (ret < 0)
 		dev_err(&slave->dev,
 			"SDW_DPN_INTMASK write failed:%d\n", val);
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index bd502368339e5..df3b36670df4c 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -81,14 +81,14 @@ static int _sdw_program_slave_port_params(struct sdw_bus *bus,
 	}
 
 	/* Program DPN_OffsetCtrl2 registers */
-	ret = sdw_write(slave, addr1, t_params->offset2);
+	ret = sdw_write_no_pm(slave, addr1, t_params->offset2);
 	if (ret < 0) {
 		dev_err(bus->dev, "DPN_OffsetCtrl2 register write failed\n");
 		return ret;
 	}
 
 	/* Program DPN_BlockCtrl3 register */
-	ret = sdw_write(slave, addr2, t_params->blk_pkg_mode);
+	ret = sdw_write_no_pm(slave, addr2, t_params->blk_pkg_mode);
 	if (ret < 0) {
 		dev_err(bus->dev, "DPN_BlockCtrl3 register write failed\n");
 		return ret;
@@ -105,7 +105,7 @@ static int _sdw_program_slave_port_params(struct sdw_bus *bus,
 	/* Program DPN_SampleCtrl2 register */
 	wbuf = FIELD_GET(SDW_DPN_SAMPLECTRL_HIGH, t_params->sample_interval - 1);
 
-	ret = sdw_write(slave, addr3, wbuf);
+	ret = sdw_write_no_pm(slave, addr3, wbuf);
 	if (ret < 0) {
 		dev_err(bus->dev, "DPN_SampleCtrl2 register write failed\n");
 		return ret;
@@ -115,7 +115,7 @@ static int _sdw_program_slave_port_params(struct sdw_bus *bus,
 	wbuf = FIELD_PREP(SDW_DPN_HCTRL_HSTART, t_params->hstart);
 	wbuf |= FIELD_PREP(SDW_DPN_HCTRL_HSTOP, t_params->hstop);
 
-	ret = sdw_write(slave, addr4, wbuf);
+	ret = sdw_write_no_pm(slave, addr4, wbuf);
 	if (ret < 0)
 		dev_err(bus->dev, "DPN_HCtrl register write failed\n");
 
@@ -163,7 +163,7 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 	wbuf = FIELD_PREP(SDW_DPN_PORTCTRL_DATAMODE, p_params->data_mode);
 	wbuf |= FIELD_PREP(SDW_DPN_PORTCTRL_FLOWMODE, p_params->flow_mode);
 
-	ret = sdw_update(s_rt->slave, addr1, 0xF, wbuf);
+	ret = sdw_update_no_pm(s_rt->slave, addr1, 0xF, wbuf);
 	if (ret < 0) {
 		dev_err(&s_rt->slave->dev,
 			"DPN_PortCtrl register write failed for port %d\n",
@@ -173,7 +173,7 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 
 	if (!dpn_prop->read_only_wordlength) {
 		/* Program DPN_BlockCtrl1 register */
-		ret = sdw_write(s_rt->slave, addr2, (p_params->bps - 1));
+		ret = sdw_write_no_pm(s_rt->slave, addr2, (p_params->bps - 1));
 		if (ret < 0) {
 			dev_err(&s_rt->slave->dev,
 				"DPN_BlockCtrl1 register write failed for port %d\n",
@@ -184,7 +184,7 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 
 	/* Program DPN_SampleCtrl1 register */
 	wbuf = (t_params->sample_interval - 1) & SDW_DPN_SAMPLECTRL_LOW;
-	ret = sdw_write(s_rt->slave, addr3, wbuf);
+	ret = sdw_write_no_pm(s_rt->slave, addr3, wbuf);
 	if (ret < 0) {
 		dev_err(&s_rt->slave->dev,
 			"DPN_SampleCtrl1 register write failed for port %d\n",
@@ -193,7 +193,7 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 	}
 
 	/* Program DPN_OffsetCtrl1 registers */
-	ret = sdw_write(s_rt->slave, addr4, t_params->offset1);
+	ret = sdw_write_no_pm(s_rt->slave, addr4, t_params->offset1);
 	if (ret < 0) {
 		dev_err(&s_rt->slave->dev,
 			"DPN_OffsetCtrl1 register write failed for port %d\n",
@@ -203,7 +203,7 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 
 	/* Program DPN_BlockCtrl2 register*/
 	if (t_params->blk_grp_ctrl_valid) {
-		ret = sdw_write(s_rt->slave, addr5, t_params->blk_grp_ctrl);
+		ret = sdw_write_no_pm(s_rt->slave, addr5, t_params->blk_grp_ctrl);
 		if (ret < 0) {
 			dev_err(&s_rt->slave->dev,
 				"DPN_BlockCtrl2 reg write failed for port %d\n",
@@ -214,7 +214,7 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 
 	/* program DPN_LaneCtrl register */
 	if (slave_prop->lane_control_support) {
-		ret = sdw_write(s_rt->slave, addr6, t_params->lane_ctrl);
+		ret = sdw_write_no_pm(s_rt->slave, addr6, t_params->lane_ctrl);
 		if (ret < 0) {
 			dev_err(&s_rt->slave->dev,
 				"DPN_LaneCtrl register write failed for port %d\n",
@@ -319,9 +319,9 @@ static int sdw_enable_disable_slave_ports(struct sdw_bus *bus,
 	 * it is safe to reset this register
 	 */
 	if (en)
-		ret = sdw_write(s_rt->slave, addr, p_rt->ch_mask);
+		ret = sdw_write_no_pm(s_rt->slave, addr, p_rt->ch_mask);
 	else
-		ret = sdw_write(s_rt->slave, addr, 0x0);
+		ret = sdw_write_no_pm(s_rt->slave, addr, 0x0);
 
 	if (ret < 0)
 		dev_err(&s_rt->slave->dev,
@@ -476,9 +476,9 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 		addr = SDW_DPN_PREPARECTRL(p_rt->num);
 
 		if (prep)
-			ret = sdw_write(s_rt->slave, addr, p_rt->ch_mask);
+			ret = sdw_write_no_pm(s_rt->slave, addr, p_rt->ch_mask);
 		else
-			ret = sdw_write(s_rt->slave, addr, 0x0);
+			ret = sdw_write_no_pm(s_rt->slave, addr, 0x0);
 
 		if (ret < 0) {
 			dev_err(&s_rt->slave->dev,
@@ -491,7 +491,7 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 		wait_for_completion_timeout(port_ready,
 			msecs_to_jiffies(dpn_prop->ch_prep_timeout));
 
-		val = sdw_read(s_rt->slave, SDW_DPN_PREPARESTATUS(p_rt->num));
+		val = sdw_read_no_pm(s_rt->slave, SDW_DPN_PREPARESTATUS(p_rt->num));
 		if ((val < 0) || (val & p_rt->ch_mask)) {
 			ret = (val < 0) ? val : -ETIMEDOUT;
 			dev_err(&s_rt->slave->dev,
-- 
2.30.2

