Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16502640105
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiLBH2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiLBH2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:28:43 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E318B181
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 23:28:42 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NNl143nJnz501Qh;
        Fri,  2 Dec 2022 15:28:40 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B27SYq9055125;
        Fri, 2 Dec 2022 15:28:34 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 2 Dec 2022 15:28:36 +0800 (CST)
Date:   Fri, 2 Dec 2022 15:28:36 +0800 (CST)
X-Zmail-TransId: 2af96389a92462a65f16
X-Mailer: Zmail v1.0
Message-ID: <202212021528368292334@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <lee@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtZmQ6IHVzZSBzeXNmc19lbWl0KCkgdG8gaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B27SYq9055125
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 6389A928.000 by FangMail milter!
X-FangMail-Envelope: 1669966120/4NNl143nJnz501Qh/6389A928.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6389A928.000/4NNl143nJnz501Qh
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
 drivers/mfd/kempld-core.c | 7 +++----
 drivers/mfd/lm3533-core.c | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index bb26241c73bd..33c6cfe9fe42 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -349,7 +349,7 @@ static ssize_t pld_version_show(struct device *dev,
 {
 	struct kempld_device_data *pld = dev_get_drvdata(dev);

-	return scnprintf(buf, PAGE_SIZE, "%s\n", pld->info.version);
+	return sysfs_emit(buf, "%s\n", pld->info.version);
 }

 static ssize_t pld_specification_show(struct device *dev,
@@ -357,8 +357,7 @@ static ssize_t pld_specification_show(struct device *dev,
 {
 	struct kempld_device_data *pld = dev_get_drvdata(dev);

-	return scnprintf(buf, PAGE_SIZE, "%d.%d\n", pld->info.spec_major,
-		       pld->info.spec_minor);
+	return sysfs_emit(buf, "%d.%d\n", pld->info.spec_major, pld->info.spec_minor);
 }

 static ssize_t pld_type_show(struct device *dev,
@@ -366,7 +365,7 @@ static ssize_t pld_type_show(struct device *dev,
 {
 	struct kempld_device_data *pld = dev_get_drvdata(dev);

-	return scnprintf(buf, PAGE_SIZE, "%s\n", kempld_get_type_string(pld));
+	return sysfs_emit(buf, "%s\n", kempld_get_type_string(pld));
 }

 static DEVICE_ATTR_RO(pld_version);
diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index be32ffc5af38..b353d93b0939 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -286,7 +286,7 @@ static ssize_t show_output(struct device *dev,

 	val = (val & mask) >> shift;

-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }

 static ssize_t store_output(struct device *dev,
-- 
2.25.1
