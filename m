Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83376C5132
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjCVQuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCVQuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:50:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160D25CEC2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:50:06 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MFCGu8005417;
        Wed, 22 Mar 2023 11:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=mquCtuwPBAYKtBO2y0kIfAC9f2JLfge3sJ7cZAhtsrg=;
 b=ZYchTHjuKLXj2UQmXz/84gs+JIC3qV3WlcoqXTjnv+CvI59bzawDnpWOPVRMSQpGEu4I
 fb6qTwByrNvKvYnTZ6d/KeD++Xue2+XZ7qilwCOlLr6gzHyttXgoES3cUt/0iC11pSAv
 Gt2dAWTRJPjGAJKNKuoB6cHgzfcffuVmnA/TWVsKGgG/l7ss8CuFXmKD9eRg6fYAy10t
 UT1prOMIkH0WD/Fqoow1qiAgRpeuIYkRh9HTGRg+mU1wsS30nPhdHHEHCQuTIBVRbMbQ
 u026Vhn8iSjNAH+TWu4A94kt+II0yzLaVx8ywKTTi7l46XtKC98h9qFpzsieeqtfCUGB yQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pdaq35kas-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 11:49:51 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 22 Mar
 2023 11:49:48 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 22 Mar 2023 11:49:48 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A1EE12A1;
        Wed, 22 Mar 2023 16:49:48 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 3/3] soundwire: bus: Update sdw_nread/nwrite_no_pm to handle page boundaries
Date:   Wed, 22 Mar 2023 16:49:48 +0000
Message-ID: <20230322164948.566962-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230322164948.566962-1-ckeepax@opensource.cirrus.com>
References: <20230322164948.566962-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mkq9JCy9hJCyG5xSvx8VijlZbo0oKhb7
X-Proofpoint-GUID: mkq9JCy9hJCyG5xSvx8VijlZbo0oKhb7
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently issuing a sdw_nread/nwrite_no_pm across a page boundary
will silently fail to write correctly as nothing updates the page
registers, meaning the same page of the chip will get rewritten
with each successive page of data.

As the sdw_msg structure contains page information it seems
reasonable that a single sdw_msg should always be within one
page. It is also mostly simpler to handle the paging at the
bus level rather than each master having to handle it in their
xfer_msg callback.

As such add handling to the bus code to split up a transfer into
multiple sdw_msg's when they go across page boundaries.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Switch from min to min_t to avoid the build issues on MIPs/i386
 - Added comments to the kernel doc to say that large transactions will
   be broken up.

Thanks,
Charles

 drivers/soundwire/bus.c | 63 +++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index f1ffb8e0839dd..e157a39a82ce5 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -386,27 +386,46 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
  * Read/Write IO functions.
  */
 
+static int sdw_ntransfer_no_pm(struct sdw_slave *slave, u32 addr, u8 flags,
+			       size_t count, u8 *val)
+{
+	struct sdw_msg msg;
+	size_t size;
+	int ret;
+
+	while (count) {
+		// Only handle bytes up to next page boundary
+		size = min_t(size_t, count, (SDW_REGADDR + 1) - (addr & SDW_REGADDR));
+
+		ret = sdw_fill_msg(&msg, slave, addr, size, slave->dev_num, flags, val);
+		if (ret < 0)
+			return ret;
+
+		ret = sdw_transfer(slave->bus, &msg);
+		if (ret < 0 && !slave->is_mockup_device)
+			return ret;
+
+		addr += size;
+		val += size;
+		count -= size;
+	}
+
+	return 0;
+}
+
 /**
  * sdw_nread_no_pm() - Read "n" contiguous SDW Slave registers with no PM
  * @slave: SDW Slave
  * @addr: Register address
  * @count: length
  * @val: Buffer for values to be read
+ *
+ * Note that if the message crosses a page boundary each page will be
+ * transferred under a separate invocation of the msg_lock.
  */
 int sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 {
-	struct sdw_msg msg;
-	int ret;
-
-	ret = sdw_fill_msg(&msg, slave, addr, count,
-			   slave->dev_num, SDW_MSG_FLAG_READ, val);
-	if (ret < 0)
-		return ret;
-
-	ret = sdw_transfer(slave->bus, &msg);
-	if (slave->is_mockup_device)
-		ret = 0;
-	return ret;
+	return sdw_ntransfer_no_pm(slave, addr, SDW_MSG_FLAG_READ, count, val);
 }
 EXPORT_SYMBOL(sdw_nread_no_pm);
 
@@ -416,21 +435,13 @@ EXPORT_SYMBOL(sdw_nread_no_pm);
  * @addr: Register address
  * @count: length
  * @val: Buffer for values to be written
+ *
+ * Note that if the message crosses a page boundary each page will be
+ * transferred under a separate invocation of the msg_lock.
  */
 int sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
 {
-	struct sdw_msg msg;
-	int ret;
-
-	ret = sdw_fill_msg(&msg, slave, addr, count,
-			   slave->dev_num, SDW_MSG_FLAG_WRITE, (u8 *)val);
-	if (ret < 0)
-		return ret;
-
-	ret = sdw_transfer(slave->bus, &msg);
-	if (slave->is_mockup_device)
-		ret = 0;
-	return ret;
+	return sdw_ntransfer_no_pm(slave, addr, SDW_MSG_FLAG_WRITE, count, (u8 *)val);
 }
 EXPORT_SYMBOL(sdw_nwrite_no_pm);
 
@@ -566,6 +577,8 @@ EXPORT_SYMBOL(sdw_update);
  *
  * This version of the function will take a PM reference to the slave
  * device.
+ * Note that if the message crosses a page boundary each page will be
+ * transferred under a separate invocation of the msg_lock.
  */
 int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 {
@@ -593,6 +606,8 @@ EXPORT_SYMBOL(sdw_nread);
  *
  * This version of the function will take a PM reference to the slave
  * device.
+ * Note that if the message crosses a page boundary each page will be
+ * transferred under a separate invocation of the msg_lock.
  */
 int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
 {
-- 
2.30.2

