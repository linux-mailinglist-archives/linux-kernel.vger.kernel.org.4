Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2106663E726
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 02:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLABi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 20:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiLABi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:38:26 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F9C99537
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:38:23 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NMzHK3LWxz4xyCG;
        Thu,  1 Dec 2022 09:38:21 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B11cDZZ011140;
        Thu, 1 Dec 2022 09:38:13 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 1 Dec 2022 09:38:14 +0800 (CST)
Date:   Thu, 1 Dec 2022 09:38:14 +0800 (CST)
X-Zmail-TransId: 2af96388058618668466
X-Mailer: Zmail v1.0
Message-ID: <202212010938142826551@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <sergey.semin@baikalelectronics.ru>
Cc:     <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBidXM6IHVzZSBzeXNmc19lbWl0KCkgdG8gaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B11cDZZ011140
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 6388058D.000 by FangMail milter!
X-FangMail-Envelope: 1669858701/4NMzHK3LWxz4xyCG/6388058D.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6388058D.000/4NMzHK3LWxz4xyCG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/bus/bt1-apb.c | 6 +++---
 drivers/bus/bt1-axi.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index 63b1b4a76671..bcf10f1d6dc1 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -265,7 +265,7 @@ static ssize_t count_show(struct device *dev, struct device_attribute *attr,
 {
 	struct bt1_apb *apb = dev_get_drvdata(dev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&apb->count));
+	return sysfs_emit(buf, "%d\n", atomic_read(&apb->count));
 }
 static DEVICE_ATTR_RO(count);

@@ -283,7 +283,7 @@ static ssize_t timeout_show(struct device *dev, struct device_attribute *attr,

 	timeout = bt1_apb_n_to_timeout_us(apb, n);

-	return scnprintf(buf, PAGE_SIZE, "%lu\n", timeout);
+	return sysfs_emit(buf, "%lu\n", timeout);
 }

 static ssize_t timeout_store(struct device *dev,
@@ -310,7 +310,7 @@ static DEVICE_ATTR_RW(timeout);
 static ssize_t inject_error_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "Error injection: nodev irq\n");
+	return sysfs_emit(buf, "Error injection: nodev irq\n");
 }

 static ssize_t inject_error_store(struct device *dev,
diff --git a/drivers/bus/bt1-axi.c b/drivers/bus/bt1-axi.c
index 70e49a6e5374..04c14821bb3c 100644
--- a/drivers/bus/bt1-axi.c
+++ b/drivers/bus/bt1-axi.c
@@ -197,14 +197,14 @@ static ssize_t count_show(struct device *dev,
 {
 	struct bt1_axi *axi = dev_get_drvdata(dev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&axi->count));
+	return sysfs_emit(buf, "%d\n", atomic_read(&axi->count));
 }
 static DEVICE_ATTR_RO(count);

 static ssize_t inject_error_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "Error injection: bus unaligned\n");
+	return sysfs_emit(buf, "Error injection: bus unaligned\n");
 }

 static ssize_t inject_error_store(struct device *dev,
-- 
2.25.1
