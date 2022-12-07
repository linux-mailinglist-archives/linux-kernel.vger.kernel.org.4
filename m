Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440DE6454BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiLGHko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLGHke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:40:34 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AF22CE30;
        Tue,  6 Dec 2022 23:40:30 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRq2P2pGpz5BNS0;
        Wed,  7 Dec 2022 15:40:29 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl1.zte.com.cn with SMTP id 2B77eMlL057810;
        Wed, 7 Dec 2022 15:40:22 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 15:40:24 +0800 (CST)
Date:   Wed, 7 Dec 2022 15:40:24 +0800 (CST)
X-Zmail-TransId: 2af963904368ffffffffffb81ce6
X-Mailer: Zmail v1.0
Message-ID: <202212071540249842544@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jic23@kernel.org>
Cc:     <lorenzo@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IGltdTogc3RfbHNtNmRzeDogQ29udmVydCB0byB1c2Ugc3lzZnNfZW1pdF9hdCgpIEFQSQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B77eMlL057810
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6390436D.000 by FangMail milter!
X-FangMail-Envelope: 1670398829/4NRq2P2pGpz5BNS0/6390436D.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6390436D.000/4NRq2P2pGpz5BNS0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 9 ++++-----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 6 ++----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 3f6060c64f32..ac89978a6da1 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1993,9 +1993,9 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,

 	odr_table = &sensor->hw->settings->odr_table[sensor->id];
 	for (i = 0; i < odr_table->odr_len; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
-				 odr_table->odr_avl[i].milli_hz / 1000,
-				 odr_table->odr_avl[i].milli_hz % 1000);
+		len += sysfs_emit_at(buf, len, "%d.%03d ",
+				     odr_table->odr_avl[i].milli_hz / 1000,
+				     odr_table->odr_avl[i].milli_hz % 1000);
 	buf[len - 1] = '\n';

 	return len;
@@ -2012,8 +2012,7 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,

 	fs_table = &hw->settings->fs_table[sensor->id];
 	for (i = 0; i < fs_table->fs_len; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
-				 fs_table->fs_avl[i].gain);
+		len += sysfs_emit_at(buf, len, "0.%09u ", fs_table->fs_avl[i].gain);
 	buf[len - 1] = '\n';

 	return len;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index f2b64b4956a3..554b235f75a0 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -676,8 +676,7 @@ st_lsm6dsx_shub_sampling_freq_avail(struct device *dev,
 	for (i = 0; i < settings->odr_table.odr_len; i++) {
 		u32 val = settings->odr_table.odr_avl[i].milli_hz;

-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
-				 val / 1000, val % 1000);
+		len += sysfs_emit_at(buf, len, "%d.%03d ", val / 1000, val % 1000);
 	}
 	buf[len - 1] = '\n';

@@ -694,8 +693,7 @@ static ssize_t st_lsm6dsx_shub_scale_avail(struct device *dev,

 	settings = sensor->ext_info.settings;
 	for (i = 0; i < settings->fs_table.fs_len; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
-				 settings->fs_table.fs_avl[i].gain);
+		len += sysfs_emit_at(buf, len, "0.%06u ", settings->fs_table.fs_avl[i].gain);
 	buf[len - 1] = '\n';

 	return len;
-- 
2.25.1
