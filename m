Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F308654B42
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbiLWCq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbiLWCqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:46:53 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AAF140B8;
        Thu, 22 Dec 2022 18:46:52 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NdWmC2HpDz8R03x;
        Fri, 23 Dec 2022 10:46:51 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl1.zte.com.cn with SMTP id 2BN2kgId074391;
        Fri, 23 Dec 2022 10:46:42 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 23 Dec 2022 10:46:44 +0800 (CST)
Date:   Fri, 23 Dec 2022 10:46:44 +0800 (CST)
X-Zmail-TransId: 2b0463a5169476d9d856
X-Mailer: Zmail v1.0
Message-ID: <202212231046441052509@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <don.brace@microchip.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <storagedev@microchip.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNjc2k6IGhwc2E6IHVzZSBzdHJzY3B5IHRvIGluc3RlYWQgb2Ygc3RybmNweSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2BN2kgId074391
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63A5169B.000 by FangMail milter!
X-FangMail-Envelope: 1671763611/4NdWmC2HpDz8R03x/63A5169B.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63A5169B.000/4NdWmC2HpDz8R03x
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL-terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/scsi/hpsa.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 4dbf51e2623a..6898cad1074f 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -452,16 +452,14 @@ static ssize_t host_store_hp_ssd_smart_path_status(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t count)
 {
-	int status, len;
+	int status;
 	struct ctlr_info *h;
 	struct Scsi_Host *shost = class_to_shost(dev);
 	char tmpbuf[10];

 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
-	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
-	strncpy(tmpbuf, buf, len);
-	tmpbuf[len] = '\0';
+	strscpy(tmpbuf, buf, sizeof(tmpbuf));
 	if (sscanf(tmpbuf, "%d", &status) != 1)
 		return -EINVAL;
 	h = shost_to_hba(shost);
@@ -476,16 +474,14 @@ static ssize_t host_store_raid_offload_debug(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t count)
 {
-	int debug_level, len;
+	int debug_level;
 	struct ctlr_info *h;
 	struct Scsi_Host *shost = class_to_shost(dev);
 	char tmpbuf[10];

 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
-	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
-	strncpy(tmpbuf, buf, len);
-	tmpbuf[len] = '\0';
+	strscpy(tmpbuf, buf, sizeof(tmpbuf));
 	if (sscanf(tmpbuf, "%d", &debug_level) != 1)
 		return -EINVAL;
 	if (debug_level < 0)
@@ -7236,8 +7232,7 @@ static int hpsa_controller_hard_reset(struct pci_dev *pdev,

 static void init_driver_version(char *driver_version, int len)
 {
-	memset(driver_version, 0, len);
-	strncpy(driver_version, HPSA " " HPSA_DRIVER_VERSION, len - 1);
+	strscpy(driver_version, HPSA " " HPSA_DRIVER_VERSION, len);
 }

 static int write_driver_ver_to_cfgtable(struct CfgTable __iomem *cfgtable)
-- 
2.15.2
