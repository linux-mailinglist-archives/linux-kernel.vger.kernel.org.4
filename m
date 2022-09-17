Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C6D5BB839
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 14:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIQMfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 08:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQMfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 08:35:46 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D982C12D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 05:35:45 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28HC1ILP026878;
        Sat, 17 Sep 2022 07:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=2hDA1iMB+MkH5X+KpV0Xzrm17zBNNXH45EZO+TrYQ2k=;
 b=B53HZiwwsNkFBLTWJ8spqIo5GkS6Zy6ci8rgAjPbZKWA/1PXUN+s8benA1PNcKSPEZ+L
 iNbR8BK52LCHEdK3/ojODiggM1ozn6pn1ChTXkjqM5H9lfl9XS8GBaTkDPflT1tn/tWE
 rYDcOnGoy7zyZBBlmJU9iWA/KxoSkmWleP/toPzPvm5zBpPGm4n/Dpg+wl1eZyVifzuT
 45fXkOfMw2mZ9XPpMA/RcfVaKe1iiuL958Ik5IFbGizKZP1zsK+7lIov/kLePtVaB45i
 N/vv9zhAjuIU+EeG0zEhgYt1kom6lqO7VAkZrb2sc9mYjpeSflxkzv1bDH48LvPy9Znd 5Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jnanmg60x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Sep 2022 07:35:29 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Sat, 17 Sep
 2022 07:35:27 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Sat, 17 Sep 2022 07:35:27 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.112])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 477EF2BA;
        Sat, 17 Sep 2022 12:35:21 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] soundwire: cadence: Write to correct address for each FIFO chunk
Date:   Sat, 17 Sep 2022 13:35:17 +0100
Message-ID: <20220917123517.229153-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: P01lUcnPOM-azedO6NTkqAeUasUKvcgi
X-Proofpoint-ORIG-GUID: P01lUcnPOM-azedO6NTkqAeUasUKvcgi
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_cdns_xfer_msg() must add the fragment offset to msg->addr to get the
base target address of each FIFO chunk. Otherwise every chunk will
be written to the first 32 register addresses.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/cadence_master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 3ef472049980..ca241bbeadd9 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -569,7 +569,7 @@ _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
 	}
 
 	base = CDNS_MCP_CMD_BASE;
-	addr = msg->addr;
+	addr = msg->addr + offset;
 
 	for (i = 0; i < count; i++) {
 		data = FIELD_PREP(CDNS_MCP_CMD_DEV_ADDR, msg->dev_num);
-- 
2.30.2

