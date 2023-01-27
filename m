Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9887267EB92
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjA0Qvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjA0Qvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:51:40 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083CD7DBD4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:51:38 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R9k8LO030633;
        Fri, 27 Jan 2023 10:51:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=9NBwQFihxbBRft8De/peYvRRDe6I86jB+XvrUzUj0D0=;
 b=DeKKj5twgGNb5sPqnqjxN3T3qbtq7Ltxmd4Je7Uf4MBo2vlQ+xHKZGmk3QJLuJ5PLvFx
 GrcvM2qR2jQySJ+Ih/nBQ852cmiEUFiGg+rSmwntQT8lWl+4a1N4/zrleXA+B1UTj3Na
 csMtQaRSf8QG/1ykPt1q2+Rip5/9FRjST822f1G8uxHyJGaJIPrnMjjEi6SQJCX3LM+Z
 EopzIySZ0XKd84u2l+xRfjL56vDAW6QiAfNpBqJl7Gu+i9DJKud2C4JHOywPXH0Eq19y
 FJdLTs6g+Y30OKzz8xOjZWfm5v7H0TYOtRcG2C9zDNfm7En/BvhrQhK5/Twx45+loBt2 Sw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n8dbsvrd1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 10:51:30 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 27 Jan
 2023 10:51:28 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Fri, 27 Jan 2023 10:51:28 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5B82E11CC;
        Fri, 27 Jan 2023 16:51:28 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 1/8] soundwire: stream: Add specific prep/deprep commands to port_prep callback
Date:   Fri, 27 Jan 2023 16:51:04 +0000
Message-ID: <20230127165111.3010960-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CxLf_buNzoRLQwSMCYMrX3WwyrU1tuC8
X-Proofpoint-GUID: CxLf_buNzoRLQwSMCYMrX3WwyrU1tuC8
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
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

