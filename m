Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22CF646B7C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiLHJIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiLHJIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:08:13 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883E930578;
        Thu,  8 Dec 2022 01:07:54 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NSSwm42rzz8QrkZ;
        Thu,  8 Dec 2022 17:07:52 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl1.zte.com.cn with SMTP id 2B897lb3054685;
        Thu, 8 Dec 2022 17:07:47 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 8 Dec 2022 17:07:50 +0800 (CST)
Date:   Thu, 8 Dec 2022 17:07:50 +0800 (CST)
X-Zmail-TransId: 2af96391a966ffffffff966a0e39
X-Mailer: Zmail v1.0
Message-ID: <202212081707505932014@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <rafael@kernel.org>
Cc:     <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <rui.zhang@intel.com>, <srinivas.pandruvada@linux.intel.com>,
        <dave@stgolabs.net>, <keescook@chromium.org>,
        <sumeet.r.pawnikar@intel.com>, <jiasheng@iscas.ac.cn>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB0aGVybWFsL2ludDM0MHhfdGhlcm1hbDogQ29udmVydCB0byB1c2Ugc3lzZnNfZW1pdF9hdCgpIEFQSQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B897lb3054685
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 6391A968.000 by FangMail milter!
X-FangMail-Envelope: 1670490472/4NSSwm42rzz8QrkZ/6391A968.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6391A968.000/4NSSwm42rzz8QrkZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../thermal/intel/int340x_thermal/int3400_thermal.c    | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index db8a6f63657d..c1fc4a78607c 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -130,10 +130,7 @@ static ssize_t available_uuids_show(struct device *dev,

 	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; i++) {
 		if (priv->uuid_bitmap & (1 << i))
-			length += scnprintf(&buf[length],
-					    PAGE_SIZE - length,
-					    "%s\n",
-					    int3400_thermal_uuids[i]);
+			length += sysfs_emit_at(buf, length, int3400_thermal_uuids[i]);
 	}

 	return length;
@@ -151,10 +148,7 @@ static ssize_t current_uuid_show(struct device *dev,

 	for (i = 0; i <= INT3400_THERMAL_CRITICAL; i++) {
 		if (priv->os_uuid_mask & BIT(i))
-			length += scnprintf(&buf[length],
-					    PAGE_SIZE - length,
-					    "%s\n",
-					    int3400_thermal_uuids[i]);
+			length += sysfs_emit_at(buf, length, int3400_thermal_uuids[i]);
 	}

 	if (length)
-- 
2.25.1
