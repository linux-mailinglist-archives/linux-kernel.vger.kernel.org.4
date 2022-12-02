Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C64640A86
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiLBQWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiLBQVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:21:45 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE143EF0CE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:19:00 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B25sRqn018164;
        Fri, 2 Dec 2022 10:18:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=4x7T5bgGFPWeQVLPmho0vqjLN8bDaVdyGpmi80dmNJI=;
 b=qxDK9pff+D/ZotG1XFjBPfBtQb0dIH32FT4fsjI8C2nnwB2B7O60EQzIkdYiFExUegwY
 YtN8m315vz3LjAdrmKP8KuMka99lqlQSuNhqyb2r5Gw4I1B8Gv6i00OjE3hPO3ty32Oo
 hKm8vC6VlMHVv7ii3ldzH4HPAJb9tJwG/Wu9UvihAEpUo3aFh9PXCyubrpRP0tarb6mK
 739hoKJnmb4GLWWhEMiZVEbq7BzTLOCaz+d195UkyZGoLetOMjT3k6HuiI/tSl8Z6TO/
 E1otqEEPC9CrZng7kJlZSmWsWdqUdfHSpQkN2w06CnZGejDu6G7z7sCS14q8vDV1CW6V WA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3m6k2vt0n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 10:18:14 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 2 Dec
 2022 10:18:12 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Fri, 2 Dec 2022 10:18:12 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 83230B12;
        Fri,  2 Dec 2022 16:18:12 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 1/3] soundwire: cadence: Don't overflow the command FIFOs
Date:   Fri, 2 Dec 2022 16:18:10 +0000
Message-ID: <20221202161812.4186897-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202161812.4186897-1-rf@opensource.cirrus.com>
References: <20221202161812.4186897-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Hgsr-ASjt8q9cyhzOQadwna_WAjYWdep
X-Proofpoint-ORIG-GUID: Hgsr-ASjt8q9cyhzOQadwna_WAjYWdep
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command FIFOs in the Cadence IP can be configured during design
up to 32 entries, and the code in cadence_master.c was assuming the
full 32-entry FIFO. But all current Intel implementations use an 8-entry
FIFO.

Up to now the longest message used was 6 entries so this wasn't
causing any problem. But future Cirrus Logic codecs have downloadable
firmware or tuning blobs. It is more efficient for the codec driver to
issue long transfers that can take advantage of any queuing in the
Soundwire controller and avoid the overhead of repeatedly writing the
page registers.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Fixes: 2f52a5177caa ("soundwire: cdns: Add cadence library")
---
Changes since v1:
Commit description rewritten. No code change.
---
 drivers/soundwire/cadence_master.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index a1de363eba3f..27699f341f2c 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -127,7 +127,8 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 
 #define CDNS_MCP_CMD_BASE			0x80
 #define CDNS_MCP_RESP_BASE			0x80
-#define CDNS_MCP_CMD_LEN			0x20
+/* FIFO can hold 8 commands */
+#define CDNS_MCP_CMD_LEN			8
 #define CDNS_MCP_CMD_WORD_LEN			0x4
 
 #define CDNS_MCP_CMD_SSP_TAG			BIT(31)
-- 
2.30.2

