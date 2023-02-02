Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBAE6882EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBBPnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjBBPni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:43:38 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E959EB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:43:15 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3128sUnb006230;
        Thu, 2 Feb 2023 09:42:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=qHX4Vtwm/1eGcLZA2epkScZnQv8rS+tXSdtmt+QwEQQ=;
 b=G4zay/EvBXtFIUwSz/uCferu0OcgNSslHqNRcMCrO9UWDt/KXeImhfPeEvMPI1K0Yxb+
 k5mYZiTIujY9ylkIBue1DuDL1KJzQfuwhuIH/A9LZn8u39yCA++uaLFRl9M0XcyFc2zK
 VUoF9KhQKXjCQQKTv/DhdpwHigvUr0QPEDMcM7AmjPJlPtLE0yVTweX2qur8obwdKIIh
 XdathYKjvsaC35Q/yRlhQNt+WFLbxwDlokD8p3B7ewQUg7XbMIbKi3PmJnIMneX+aCh4
 FST9pvmd6oQGxXrRS68CiRBe7HnyE1bS6TvLbcJK8j/uqU3tlwMQFoYofxhuyMe4nQiO jw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3nfqvj1qk6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 09:42:14 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 2 Feb
 2023 09:42:12 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Thu, 2 Feb 2023 09:42:12 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 377BD15A0;
        Thu,  2 Feb 2023 15:42:12 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] soundwire: bandwidth allocation: Use hweight32() to calculate set bits
Date:   Thu, 2 Feb 2023 15:42:12 +0000
Message-ID: <20230202154212.1098736-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230202154212.1098736-1-rf@opensource.cirrus.com>
References: <20230202154212.1098736-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uqgusPKHeFYIjWDNcIzxx8WygJvQTzXu
X-Proofpoint-ORIG-GUID: uqgusPKHeFYIjWDNcIzxx8WygJvQTzXu
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the call to sdw_ch_mask_to_ch() with a call to hweight32().

sdw_ch_mask_to_ch() is counting the number of set bits. The hweight()
family of functions already do this, and they have an advantage of
using a bit-counting instruction if it is available on the target CPU.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/bus.h                          | 11 -----------
 drivers/soundwire/generic_bandwidth_allocation.c |  3 ++-
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 28bedc919b78..4ce8d708a39c 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -159,17 +159,6 @@ int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
 int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
 		 u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf);
 
-/* Retrieve and return channel count from channel mask */
-static inline int sdw_ch_mask_to_ch(unsigned int ch_mask)
-{
-	int c = 0;
-
-	for (c = 0; ch_mask; ch_mask >>= 1)
-		c += ch_mask & 1;
-
-	return c;
-}
-
 /* Fill transport parameter data structure */
 static inline void sdw_fill_xport_params(struct sdw_transport_params *params,
 					 int port_num, bool grp_ctrl_valid,
diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index f7c66083a4dd..ea3e8ef408e4 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -54,7 +55,7 @@ static void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
 		slave_total_ch = 0;
 
 		list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
-			ch = sdw_ch_mask_to_ch(p_rt->ch_mask);
+			ch = hweight32(p_rt->ch_mask);
 
 			sdw_fill_xport_params(&p_rt->transport_params,
 					      p_rt->num, false,
-- 
2.30.2

