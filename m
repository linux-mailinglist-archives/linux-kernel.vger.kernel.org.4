Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EC171EE8A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjFAQRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjFAQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:16:50 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BB41A7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:16:47 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351BpAhQ020645;
        Thu, 1 Jun 2023 11:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=4bof8nBseyDbvNFvNKVeZgVmTN/4A2KqkGyonD3SDoo=;
 b=bIDo2vpnCwrHVAWqaEfOJHEtkOPL2/1g/hDKEW8ZgyXGoT+9eFRMDthUVCxKfJ5z5aFR
 vZisPCZPSi/ncY7V5MhadUDEYbMgwsxOshkSU99LoT61227CpsExLNvcEUXXSh2NGh2G
 LTtqfvsgCdT8PV8WQEKvfC+mtHSu3L1F5RYzZbOXGhjf43zYWVUXK7iJ9QZmHXISbn6n
 yHAIeg/35fmCneuA5de/671BCFNHXvJDE2i2AX/hpKXMpxIYUs5JXnRIT4XQd24G7vcR
 49WLXZjyDW7dJqzBLQV0AK3sJKBypqc7AcdDNKQIeeuFRm6r1uWtNuW+GmCz07axo+qi /g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3que9mxmbs-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 11:16:25 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 1 Jun
 2023 17:16:22 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 17:16:22 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D9D9611C6;
        Thu,  1 Jun 2023 16:16:22 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 3/4] soundwire: stream: Remove unnecessary gotos
Date:   Thu, 1 Jun 2023 17:16:21 +0100
Message-ID: <20230601161622.1808135-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230601161622.1808135-1-ckeepax@opensource.cirrus.com>
References: <20230601161622.1808135-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nVWJLd2g_bmK5eV8r0sQiZap5HBz0RG6
X-Proofpoint-ORIG-GUID: nVWJLd2g_bmK5eV8r0sQiZap5HBz0RG6
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a lot of code using gotos to skip small sections of code, this
is a fairly dubious use of a goto, especially when the level of
intentation is really low. Most of this code doesn't even breach 80
characters when naively shifted over.

Simplify the code a bit, by replacing these unnecessary gotos with
simple ifs.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/soundwire/stream.c | 131 +++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 72 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 379228f221869..248ab243ec6e4 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1355,25 +1355,23 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 			return -EINVAL;
 		}
 
-		if (!update_params)
-			goto program_params;
-
-		/* Increment cumulative bus bandwidth */
-		/* TODO: Update this during Device-Device support */
-		bus->params.bandwidth += m_rt->stream->params.rate *
-			m_rt->ch_count * m_rt->stream->params.bps;
-
-		/* Compute params */
-		if (bus->compute_params) {
-			ret = bus->compute_params(bus);
-			if (ret < 0) {
-				dev_err(bus->dev, "Compute params failed: %d\n",
-					ret);
-				goto restore_params;
+		if (update_params) {
+			/* Increment cumulative bus bandwidth */
+			/* TODO: Update this during Device-Device support */
+			bus->params.bandwidth += m_rt->stream->params.rate *
+				m_rt->ch_count * m_rt->stream->params.bps;
+
+			/* Compute params */
+			if (bus->compute_params) {
+				ret = bus->compute_params(bus);
+				if (ret < 0) {
+					dev_err(bus->dev, "Compute params failed: %d\n",
+						ret);
+					goto restore_params;
+				}
 			}
 		}
 
-program_params:
 		/* Program params */
 		ret = sdw_program_params(bus, true);
 		if (ret < 0) {
@@ -1864,7 +1862,7 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 			  struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt;
-	bool alloc_master_rt = true;
+	bool alloc_master_rt = false;
 	int ret;
 
 	mutex_lock(&bus->bus_lock);
@@ -1886,30 +1884,25 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	 * it first), if so skip allocation and go to configuration
 	 */
 	m_rt = sdw_master_rt_find(bus, stream);
-	if (m_rt) {
-		alloc_master_rt = false;
-		goto skip_alloc_master_rt;
-	}
-
-	m_rt = sdw_master_rt_alloc(bus, stream);
 	if (!m_rt) {
-		dev_err(bus->dev, "%s: Master runtime alloc failed for stream:%s\n",
-			__func__, stream->name);
-		ret = -ENOMEM;
-		goto unlock;
-	}
-skip_alloc_master_rt:
-
-	if (sdw_master_port_allocated(m_rt))
-		goto skip_alloc_master_port;
+		m_rt = sdw_master_rt_alloc(bus, stream);
+		if (!m_rt) {
+			dev_err(bus->dev, "%s: Master runtime alloc failed for stream:%s\n",
+				__func__, stream->name);
+			ret = -ENOMEM;
+			goto unlock;
+		}
 
-	ret = sdw_master_port_alloc(m_rt, num_ports);
-	if (ret)
-		goto alloc_error;
+		alloc_master_rt = true;
+	}
 
-	stream->m_rt_count++;
+	if (!sdw_master_port_allocated(m_rt)) {
+		ret = sdw_master_port_alloc(m_rt, num_ports);
+		if (ret)
+			goto alloc_error;
 
-skip_alloc_master_port:
+		stream->m_rt_count++;
+	}
 
 	ret = sdw_master_rt_config(m_rt, stream_config);
 	if (ret < 0)
@@ -1990,8 +1983,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 {
 	struct sdw_slave_runtime *s_rt;
 	struct sdw_master_runtime *m_rt;
-	bool alloc_master_rt = true;
-	bool alloc_slave_rt = true;
+	bool alloc_master_rt = false;
+	bool alloc_slave_rt = false;
 
 	int ret;
 
@@ -2002,47 +1995,41 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	 * and go to configuration
 	 */
 	m_rt = sdw_master_rt_find(slave->bus, stream);
-	if (m_rt) {
-		alloc_master_rt = false;
-		goto skip_alloc_master_rt;
-	}
-
-	/*
-	 * If this API is invoked by Slave first then m_rt is not valid.
-	 * So, allocate m_rt and add Slave to it.
-	 */
-	m_rt = sdw_master_rt_alloc(slave->bus, stream);
 	if (!m_rt) {
-		dev_err(&slave->dev, "%s: Master runtime alloc failed for stream:%s\n",
-			__func__, stream->name);
-		ret = -ENOMEM;
-		goto unlock;
-	}
+		/*
+		 * If this API is invoked by Slave first then m_rt is not valid.
+		 * So, allocate m_rt and add Slave to it.
+		 */
+		m_rt = sdw_master_rt_alloc(slave->bus, stream);
+		if (!m_rt) {
+			dev_err(&slave->dev, "%s: Master runtime alloc failed for stream:%s\n",
+				__func__, stream->name);
+			ret = -ENOMEM;
+			goto unlock;
+		}
 
-skip_alloc_master_rt:
-	s_rt = sdw_slave_rt_find(slave, stream);
-	if (s_rt) {
-		alloc_slave_rt = false;
-		goto skip_alloc_slave_rt;
+		alloc_master_rt = true;
 	}
 
-	s_rt = sdw_slave_rt_alloc(slave, m_rt);
+	s_rt = sdw_slave_rt_find(slave, stream);
 	if (!s_rt) {
-		dev_err(&slave->dev, "Slave runtime alloc failed for stream:%s\n", stream->name);
-		alloc_slave_rt = false;
-		ret = -ENOMEM;
-		goto alloc_error;
-	}
+		s_rt = sdw_slave_rt_alloc(slave, m_rt);
+		if (!s_rt) {
+			dev_err(&slave->dev, "Slave runtime alloc failed for stream:%s\n",
+				stream->name);
+			ret = -ENOMEM;
+			goto alloc_error;
+		}
 
-skip_alloc_slave_rt:
-	if (sdw_slave_port_allocated(s_rt))
-		goto skip_port_alloc;
+		alloc_slave_rt = true;
+	}
 
-	ret = sdw_slave_port_alloc(slave, s_rt, num_ports);
-	if (ret)
-		goto alloc_error;
+	if (!sdw_slave_port_allocated(s_rt)) {
+		ret = sdw_slave_port_alloc(slave, s_rt, num_ports);
+		if (ret)
+			goto alloc_error;
+	}
 
-skip_port_alloc:
 	ret =  sdw_master_rt_config(m_rt, stream_config);
 	if (ret)
 		goto unlock;
-- 
2.30.2

