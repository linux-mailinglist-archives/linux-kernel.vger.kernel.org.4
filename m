Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFE1646A51
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiLHIUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLHIUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:20:13 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BD256D50;
        Thu,  8 Dec 2022 00:20:12 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NSRsk2fNfz4xVnl;
        Thu,  8 Dec 2022 16:20:10 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B88K0JM013604;
        Thu, 8 Dec 2022 16:20:00 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 8 Dec 2022 16:20:03 +0800 (CST)
Date:   Thu, 8 Dec 2022 16:20:03 +0800 (CST)
X-Zmail-TransId: 2af963919e33fffffffff75454a4
X-Mailer: Zmail v1.0
Message-ID: <202212081620030740727@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <martin.petersen@oracle.com>
Cc:     <aacraid@microsemi.com>, <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBzY3NpOiBhYWNyYWlkOiBDb252ZXJ0IHRvIHVzZSBzeXNmc19lbWl0X2F0KCkgQVBJ?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B88K0JM013604
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63919E3A.001 by FangMail milter!
X-FangMail-Envelope: 1670487610/4NSRsk2fNfz4xVnl/63919E3A.001/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63919E3A.001/4NSRsk2fNfz4xVnl
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
 drivers/scsi/aacraid/linit.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 5ba5c18b77b4..83db3195cc1a 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1233,21 +1233,17 @@ static ssize_t aac_show_flags(struct device *cdev,
 	if (nblank(dprintk(x)))
 		len = snprintf(buf, PAGE_SIZE, "dprintk\n");
 #ifdef AAC_DETAILED_STATUS_INFO
-	len += scnprintf(buf + len, PAGE_SIZE - len,
-			 "AAC_DETAILED_STATUS_INFO\n");
+	len += sysfs_emit_at(buf, len, "AAC_DETAILED_STATUS_INFO\n");
 #endif
 	if (dev->raw_io_interface && dev->raw_io_64)
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-				 "SAI_READ_CAPACITY_16\n");
+		len += sysfs_emit_at(buf, len, "SAI_READ_CAPACITY_16\n");
 	if (dev->jbod)
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-				 "SUPPORTED_JBOD\n");
+		len += sysfs_emit_at(buf, len, "SUPPORTED_JBOD\n");
 	if (dev->supplement_adapter_info.supported_options2 &
 		AAC_OPTION_POWER_MANAGEMENT)
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-				 "SUPPORTED_POWER_MANAGEMENT\n");
+		len += sysfs_emit_at(buf, len, "SUPPORTED_POWER_MANAGEMENT\n");
 	if (dev->msi)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "PCI_HAS_MSI\n");
+		len += sysfs_emit_at(buf, len, "PCI_HAS_MSI\n");
 	return len;
 }

-- 
2.25.1
