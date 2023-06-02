Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C005271FEAB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbjFBKMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbjFBKMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:12:10 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AED132
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:12:09 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35260jsw004169;
        Fri, 2 Jun 2023 05:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=0oW6c0O7PIMw0dE08KvhlhAtSajGICopR4i8kG8wcME=;
 b=gyLkkm8O3KlbTvNnmk6WvVwBywdDuFsbRjEaKyjuafP96q9qi+oh9GI263hSR/zOBRkz
 oW6FM1uwimnbXkK1u9IgPvNr6jZ2l0EQsrvREm4khguD5nAKnCr7wSkEJxO9LF9qxhWl
 dtGmqM1iiroEZxvMR36v/v7BqTzLYHPfG00s/i5Wq2Sv9/wLUtdSg4L7Rj1ecqm7k+bK
 RdBClX3snO4QA/e+Rq9JKZcK60T9FIOpwK10Lr96xpSxo1Bzof4tnOgRaWVLNAYzaA9f
 zMFMS0DTzKRieGdQsY8xU/jDHLILmU9KmNsaLdlgD/QSJFWffsalYzWPlBbWtdBDeQhO IQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3que9myr1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 05:11:42 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 2 Jun
 2023 11:11:40 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 2 Jun 2023 11:11:40 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AD91211C6;
        Fri,  2 Jun 2023 10:11:40 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 2/5] soundwire: bandwidth allocation: Remove pointless variable
Date:   Fri, 2 Jun 2023 11:11:37 +0100
Message-ID: <20230602101140.2040141-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
References: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: To0M1bIXH1WGsEKk2leM4UQaVu5iD9rk
X-Proofpoint-ORIG-GUID: To0M1bIXH1WGsEKk2leM4UQaVu5iD9rk
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

The block_offset variable in _sdw_compute_port_params adds nothing
either functionally or in terms of code clarity, remove it.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

Thanks,
Charles

 drivers/soundwire/generic_bandwidth_allocation.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index 325c475b6a66d..31162f2b56381 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -139,20 +139,16 @@ static void _sdw_compute_port_params(struct sdw_bus *bus,
 {
 	struct sdw_master_runtime *m_rt;
 	int hstop = bus->params.col - 1;
-	int block_offset, port_bo, i;
+	int port_bo, i;
 
 	/* Run loop for all groups to compute transport parameters */
 	for (i = 0; i < count; i++) {
 		port_bo = 1;
-		block_offset = 1;
 
 		list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
-			sdw_compute_master_ports(m_rt, &params[i],
-						 port_bo, hstop);
+			sdw_compute_master_ports(m_rt, &params[i], port_bo, hstop);
 
-			block_offset += m_rt->ch_count *
-					m_rt->stream->params.bps;
-			port_bo = block_offset;
+			port_bo += m_rt->ch_count * m_rt->stream->params.bps;
 		}
 
 		hstop = hstop - params[i].hwidth;
-- 
2.30.2

