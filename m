Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8308C643D92
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 08:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiLFHT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 02:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiLFHTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 02:19:54 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AB2FD3F;
        Mon,  5 Dec 2022 23:19:52 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRBd314QDz8RV7N;
        Tue,  6 Dec 2022 15:19:51 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B67JgBu008998;
        Tue, 6 Dec 2022 15:19:42 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 6 Dec 2022 15:19:45 +0800 (CST)
Date:   Tue, 6 Dec 2022 15:19:45 +0800 (CST)
X-Zmail-TransId: 2af9638eed11ffffffff8d6e0d5a
X-Mailer: Zmail v1.0
Message-ID: <202212061519451024396@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <rafael@kernel.org>
Cc:     <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBBQ1BJOiBmYW46IENvbnZlcnQgdG8gdXNlIHN5c2ZzX2VtaXRfYXQoKSBBUEk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B67JgBu008998
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 638EED17.000 by FangMail milter!
X-FangMail-Envelope: 1670311191/4NRBd314QDz8RV7N/638EED17.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638EED17.000/4NRBd314QDz8RV7N
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
 drivers/acpi/fan_attr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
index f15157d40713..f4f6e2381f1d 100644
--- a/drivers/acpi/fan_attr.c
+++ b/drivers/acpi/fan_attr.c
@@ -27,24 +27,24 @@ static ssize_t show_state(struct device *dev, struct device_attribute *attr, cha
 		count = scnprintf(buf, PAGE_SIZE, "%lld:", fps->control);

 	if (fps->trip_point == 0xFFFFFFFF || fps->trip_point > 9)
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
+		count += sysfs_emit_at(buf, count, "not-defined:");
 	else
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->trip_point);
+		count += sysfs_emit_at(buf, count, "%lld:", fps->trip_point);

 	if (fps->speed == 0xFFFFFFFF)
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
+		count += sysfs_emit_at(buf, count, "not-defined:");
 	else
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->speed);
+		count += sysfs_emit_at(buf, count, "%lld:", fps->speed);

 	if (fps->noise_level == 0xFFFFFFFF)
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
+		count += sysfs_emit_at(buf, count, "not-defined:");
 	else
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->noise_level * 100);
+		count += sysfs_emit_at(buf, count, "%lld:", fps->noise_level * 100);

 	if (fps->power == 0xFFFFFFFF)
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined\n");
+		count += sysfs_emit_at(buf, count, "not-defined\n");
 	else
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld\n", fps->power);
+		count += sysfs_emit_at(buf, count, "%lld\n", fps->power);

 	return count;
 }
-- 
2.25.1
