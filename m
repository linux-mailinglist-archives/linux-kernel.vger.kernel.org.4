Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BF15BB932
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 17:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIQPsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 11:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIQPsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 11:48:43 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379952ED78
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 08:48:42 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28HEvR6I010074;
        Sat, 17 Sep 2022 10:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=TB36sGrqFlva4VA79Qj0rQIM5Mb0u8akbGYI3B1YqH8=;
 b=hPLlzzQHefNSLHKm2ObwbkV3lI1s+UMuR2lji3azldHAqo6iAaFnJGkf5yp1zxK1XQEH
 wPXLyHCZuKghJPRLfUTzZDXrvoJ0ggsfuk9PPXolGinQTcdc0r6OLjVkEnDbI2h3un6I
 70LaIEGC9NfilsOPV1l7AQuCw3Dc+XTAyG6OZ/e/Tx5A7/pjBAjlU7u3cF7Sc0OD7bzL
 xC4Ai91Pcf2GZ2c9TaK2d6/95NbEZyorRs5tsYeWP8YZ4BTKO+hvHaAjDFJwrO3wRhFM
 31BFPIz6K8LJXK0un8Jno+oDortDnpGIDnd+BwTv+Wxsmuq0Mu+Fec3cK8CxBB4ADxgk qQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jnanmgavj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Sep 2022 10:48:33 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Sat, 17 Sep
 2022 10:48:31 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Sat, 17 Sep 2022 10:48:31 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.112])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EDBB2468;
        Sat, 17 Sep 2022 15:48:24 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] soundwire: cadence: Fix error check in cdns_xfer_msg()
Date:   Sat, 17 Sep 2022 16:48:21 +0100
Message-ID: <20220917154822.690472-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: eUpNl5-D3xga4PDjQSa0UWmMPdyK_GEb
X-Proofpoint-ORIG-GUID: eUpNl5-D3xga4PDjQSa0UWmMPdyK_GEb
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_cdns_xfer_msg() returns an sdw_command_response value, not a
negative error code.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/cadence_master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index ca241bbeadd9..3543a923ee6b 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -708,7 +708,7 @@ cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
 	for (i = 0; i < msg->len / CDNS_MCP_CMD_LEN; i++) {
 		ret = _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
 				     CDNS_MCP_CMD_LEN, false);
-		if (ret < 0)
+		if (ret != SDW_CMD_OK)
 			goto exit;
 	}
 
-- 
2.30.2

