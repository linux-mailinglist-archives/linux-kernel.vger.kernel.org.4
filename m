Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A6F632553
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiKUOPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiKUOPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:15:25 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DB762E6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:14:16 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALCtMm7002614;
        Mon, 21 Nov 2022 08:14:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=WILxXOGhVNe0I1FxujLIVVqB4+tPaZ++Vr7hhtDWbqs=;
 b=ioerokhuKZoqvR3K7pix02NpMfGyL5qqW/rEMGyoyPYhLNNWG8p5v0sUuylsvXhA3TGM
 WFLXnRTT/bEWsWraN17qyfuxjACGpxfJBH0Lv/85J3/viX27+UU7Oft2m/A12NsHkhHG
 lP3pVekYOm12/9iguPtag9SIMSU99db7quQThGvaTbh5uq6MYgVrv7WmWT0g+r6d5Gyv
 cD3jnkx2PfNtg0dB18yU+14vUZ1z1Sa2w2f6JxnCwkqKHuCRC4pQaEFTxBECh1l3AzWJ
 E8P/9fISQXJDtL+Ytrvtoa5FGqYeZAhGzhKrnZXItGlp0K4jmjBGU9LYtfqcbBzJzNSn NQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kxwe6t7hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 08:14:08 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Mon, 21 Nov
 2022 08:14:06 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Mon, 21 Nov 2022 08:14:06 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6CB70B12;
        Mon, 21 Nov 2022 14:14:06 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 1/4] soundwire: bus: export sdw_nwrite_no_pm and sdw_nread_no_pm functions
Date:   Mon, 21 Nov 2022 14:14:03 +0000
Message-ID: <20221121141406.3840561-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221121141406.3840561-1-ckeepax@opensource.cirrus.com>
References: <20221121141406.3840561-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: T_-eze7Qsgl43ayYLL3p2fVkp_rWd3ob
X-Proofpoint-GUID: T_-eze7Qsgl43ayYLL3p2fVkp_rWd3ob
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

The commit 167790abb90f ("soundwire: export sdw_write/read_no_pm
functions") exposed the single byte no_pm versions of the IO functions
that can be used without touching PM, export the multi byte no_pm
versions for the same reason.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v2:
 - Added Pierre's reviewed-by.

 drivers/soundwire/bus.c       | 8 ++++----
 include/linux/soundwire/sdw.h | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 76515c33e639e..ef4878258afad 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -414,8 +414,7 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
  * all clients need to use the pm versions
  */
 
-static int
-sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
+int sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 {
 	struct sdw_msg msg;
 	int ret;
@@ -430,9 +429,9 @@ sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 		ret = 0;
 	return ret;
 }
+EXPORT_SYMBOL(sdw_nread_no_pm);
 
-static int
-sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
+int sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
 {
 	struct sdw_msg msg;
 	int ret;
@@ -447,6 +446,7 @@ sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
 		ret = 0;
 	return ret;
 }
+EXPORT_SYMBOL(sdw_nwrite_no_pm);
 
 int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
 {
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 9e4537f409c29..902ed46f76c80 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1047,7 +1047,9 @@ int sdw_write(struct sdw_slave *slave, u32 addr, u8 value);
 int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value);
 int sdw_read_no_pm(struct sdw_slave *slave, u32 addr);
 int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
+int sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
 int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val);
+int sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val);
 int sdw_update(struct sdw_slave *slave, u32 addr, u8 mask, u8 val);
 int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val);
 
-- 
2.30.2

