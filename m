Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EA1672299
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjARQKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjARQJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:09:05 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D7145890
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:05:16 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IEDgr6022836;
        Wed, 18 Jan 2023 10:05:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=RrsmUAoPfdKz/GjTW3d2CI1v1QDtyYNp4XQoW8Gfmu4=;
 b=lQ6o62LkRIncspk6CTo7TCqKVATdDk0oiVuVG99ajX5AaiO7NHtPCwg18mLY3uvS/JWz
 OySbtAXgH06LDTOeOAKEJBtBQedcZjuznz4efhO+7VPUxrgAoI9NSwQdFQsQMvup1dSA
 mg4YVy+JdkfSRh6KPARNEP9taMBjss5FqzDc5cwBC44ao/fVldacntdSGBRa3anaXN7B
 qt0EjydzzJOL7SWD/VN1jfXDpBmdmRRPwzFTLp107EAsU2ExQ5KZQ+JKZ5hrGUB2e4ul
 7EdoSPriJUxlvLjYRJrtOoNuUjhC9EFZrvoMqLYus4Hd3dgNrQ4BlJPgVT1UW742HKkg Vw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n3spx6vk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 10:05:00 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 18 Jan
 2023 10:04:57 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.7 via Frontend Transport; Wed, 18 Jan 2023 10:04:57 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0BA1EB12;
        Wed, 18 Jan 2023 16:04:57 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 1/8] soundwire: stream: Add specific prep/deprep commands to port_prep callback
Date:   Wed, 18 Jan 2023 16:04:45 +0000
Message-ID: <20230118160452.2385494-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -czQAVRU0DdhMIyzE7Xe7chznsaOXhYp
X-Proofpoint-ORIG-GUID: -czQAVRU0DdhMIyzE7Xe7chznsaOXhYp
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, port_prep callback only has commands for PRE_PREP, PREP,
and POST_PREP, which doesn't directly say whether this is for a
prepare or deprepare call. Extend the command list enum to say
whether the call is for prepare or deprepare aswell.

Also remove SDW_OPS_PORT_PREP from sdw_port_prep_ops as this is unused,
and update this enum to be simpler and more consistent with enum
sdw_clk_stop_type.

Note: Currently, the only users of SDW_OPS_PORT_POST_PREP are codec
drivers sound/soc/codecs/wsa881x.c and sound/soc/codecs/wsa883x.c, both
of which seem to assume that POST_PREP only occurs after a prepare,
even though it would also have occurred after a deprepare. Since it
doesn't make sense to mark the port prepared after a deprepare, changing
the enum to separate PORT_DEPREP from PORT_PREP should make the check
for PORT_PREP in those drivers be more logical.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 drivers/soundwire/stream.c    | 4 ++--
 include/linux/soundwire/sdw.h | 8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index df3b36670df4c..1652fb5737d9d 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -469,7 +469,7 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 	}
 
 	/* Inform slave about the impending port prepare */
-	sdw_do_port_prep(s_rt, prep_ch, SDW_OPS_PORT_PRE_PREP);
+	sdw_do_port_prep(s_rt, prep_ch, prep ? SDW_OPS_PORT_PRE_PREP : SDW_OPS_PORT_PRE_DEPREP);
 
 	/* Prepare Slave port implementing CP_SM */
 	if (!dpn_prop->simple_ch_prep_sm) {
@@ -501,7 +501,7 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 	}
 
 	/* Inform slaves about ports prepared */
-	sdw_do_port_prep(s_rt, prep_ch, SDW_OPS_PORT_POST_PREP);
+	sdw_do_port_prep(s_rt, prep_ch, prep ? SDW_OPS_PORT_POST_PREP : SDW_OPS_PORT_POST_DEPREP);
 
 	/* Disable interrupt after Port de-prepare */
 	if (!prep && intr)
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 3cd2a761911ff..547fc1b30a51a 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -569,13 +569,15 @@ struct sdw_prepare_ch {
  * enum sdw_port_prep_ops: Prepare operations for Data Port
  *
  * @SDW_OPS_PORT_PRE_PREP: Pre prepare operation for the Port
- * @SDW_OPS_PORT_PREP: Prepare operation for the Port
+ * @SDW_OPS_PORT_PRE_DEPREP: Pre deprepare operation for the Port
  * @SDW_OPS_PORT_POST_PREP: Post prepare operation for the Port
+ * @SDW_OPS_PORT_POST_DEPREP: Post deprepare operation for the Port
  */
 enum sdw_port_prep_ops {
 	SDW_OPS_PORT_PRE_PREP = 0,
-	SDW_OPS_PORT_PREP = 1,
-	SDW_OPS_PORT_POST_PREP = 2,
+	SDW_OPS_PORT_PRE_DEPREP,
+	SDW_OPS_PORT_POST_PREP,
+	SDW_OPS_PORT_POST_DEPREP,
 };
 
 /**
-- 
2.34.1

