Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207F271FEAC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbjFBKMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjFBKMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:12:09 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854DCE7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:12:07 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35260jsx004169;
        Fri, 2 Jun 2023 05:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=VY/AOYGe8kE5LixgK7zc3+p/NvDWHs/M2Doh1utN4ws=;
 b=SMryi0aj85pSMAXaYHnR0aVrsbB9Y6Ypr9VL5Tm5N3nL1RF/JeyNxZ3s5ylsN7ZF6V2+
 pz+8halmhNxaJYQYkBV7bJi43Z7JvqFCLC77T+SScPxuBuorW+WEbCy/zgBw3v3zLUlu
 tw8zSnmrYSqDm9uGUXXOOzXXsVIfWux2Wf6ultfjZIUj09MB125kwhX3kaM1kOZLhxem
 g2W0KNkamyGfo8pcVSxvczarowoZdW2iRDim+Z3+/XGW1jdMgPeQSsh8V4+7TMBmlAJ4
 3bIZfQSCt11EwtpGTrEH+NDtCBRFBrBN00521GSn4sPU96VCU9diN8sh69CBP5VDm8d3 OA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3que9myr1p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 05:11:42 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 2 Jun
 2023 11:11:40 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 2 Jun 2023 11:11:40 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C6CF115B7;
        Fri,  2 Jun 2023 10:11:40 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 4/5] soundwire: stream: Invert logic on runtime alloc flags
Date:   Fri, 2 Jun 2023 11:11:39 +0100
Message-ID: <20230602101140.2040141-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
References: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Afi5gbP48EpeNbLOkZkYq-2s7ug2Ap7Z
X-Proofpoint-ORIG-GUID: Afi5gbP48EpeNbLOkZkYq-2s7ug2Ap7Z
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdw_stream_add_slave/master have flags to indicate if the master or
slave runtime where allocated in that call to the function. Currently
these flags are cleared on all the paths where the runtime is not
allocated, it is more logic and simpler to set the flag on the one path
where the runtime is allocated.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Split out of the goto patch to ease review

Also worth noting I guess this patch could be squashed with patch 1 in
the series really, but I opted to leave them separate as patch 1 is a
much simpler fix to be cherry-picked back to older kernels if someone
needs the fixup, rather than mixing the fixup and tidy up.

Thanks,
Charles

 drivers/soundwire/stream.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 6595f47b403b5..df5600a80c174 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1854,7 +1854,7 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 			  struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt;
-	bool alloc_master_rt = true;
+	bool alloc_master_rt = false;
 	int ret;
 
 	mutex_lock(&bus->bus_lock);
@@ -1876,10 +1876,8 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	 * it first), if so skip allocation and go to configuration
 	 */
 	m_rt = sdw_master_rt_find(bus, stream);
-	if (m_rt) {
-		alloc_master_rt = false;
+	if (m_rt)
 		goto skip_alloc_master_rt;
-	}
 
 	m_rt = sdw_master_rt_alloc(bus, stream);
 	if (!m_rt) {
@@ -1888,6 +1886,8 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 		ret = -ENOMEM;
 		goto unlock;
 	}
+
+	alloc_master_rt = true;
 skip_alloc_master_rt:
 
 	if (sdw_master_port_allocated(m_rt))
@@ -1980,8 +1980,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 {
 	struct sdw_slave_runtime *s_rt;
 	struct sdw_master_runtime *m_rt;
-	bool alloc_master_rt = true;
-	bool alloc_slave_rt = true;
+	bool alloc_master_rt = false;
+	bool alloc_slave_rt = false;
 
 	int ret;
 
@@ -1992,10 +1992,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	 * and go to configuration
 	 */
 	m_rt = sdw_master_rt_find(slave->bus, stream);
-	if (m_rt) {
-		alloc_master_rt = false;
+	if (m_rt)
 		goto skip_alloc_master_rt;
-	}
 
 	/*
 	 * If this API is invoked by Slave first then m_rt is not valid.
@@ -2009,21 +2007,22 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 		goto unlock;
 	}
 
+	alloc_master_rt = true;
+
 skip_alloc_master_rt:
 	s_rt = sdw_slave_rt_find(slave, stream);
-	if (s_rt) {
-		alloc_slave_rt = false;
+	if (s_rt)
 		goto skip_alloc_slave_rt;
-	}
 
 	s_rt = sdw_slave_rt_alloc(slave, m_rt);
 	if (!s_rt) {
 		dev_err(&slave->dev, "Slave runtime alloc failed for stream:%s\n", stream->name);
-		alloc_slave_rt = false;
 		ret = -ENOMEM;
 		goto alloc_error;
 	}
 
+	alloc_slave_rt = true;
+
 skip_alloc_slave_rt:
 	if (sdw_slave_port_allocated(s_rt))
 		goto skip_port_alloc;
-- 
2.30.2

