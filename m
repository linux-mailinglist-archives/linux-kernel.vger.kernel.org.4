Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE1562426E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiKJMhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKJMhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:37:45 -0500
X-Greylist: delayed 217 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 04:37:42 PST
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0FB6BDE7;
        Thu, 10 Nov 2022 04:37:42 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4N7Lvn041Tz4y0tx;
        Thu, 10 Nov 2022 20:37:41 +0800 (CST)
Received: from szxlzmapp06.zte.com.cn ([10.5.230.252])
        by mse-fl1.zte.com.cn with SMTP id 2AACbWBI049553;
        Thu, 10 Nov 2022 20:37:32 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 10 Nov 2022 20:37:35 +0800 (CST)
Date:   Thu, 10 Nov 2022 20:37:35 +0800 (CST)
X-Zmail-TransId: 2b05636cf08fffffffff92f28484
X-Mailer: Zmail v1.0
Message-ID: <202211102037359588718@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <njavali@marvell.com>
Cc:     <gr-qlogic-storage-upstream@marvell.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNjc2k6IHFsYTJ4eHg6IHVzZSBzdHJzY3B5KCkgaXMgbW9yZSByb2J1c3QgYW5kIHNhZmVy?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AACbWBI049553
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 636CF095.000 by FangMail milter!
X-FangMail-Envelope: 1668083861/4N7Lvn041Tz4y0tx/636CF095.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636CF095.000/4N7Lvn041Tz4y0tx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index ce4c5d728407..7b3782a212c0 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4843,7 +4843,7 @@ qla2x00_set_model_info(scsi_qla_host_t *vha, uint8_t *model, size_t len,
 		if (use_tbl &&
 		    ha->pdev->subsystem_vendor == PCI_VENDOR_ID_QLOGIC &&
 		    index < QLA_MODEL_NAMES)
-			strlcpy(ha->model_desc,
+			strscpy(ha->model_desc,
 			    qla2x00_model_name[index * 2 + 1],
 			    sizeof(ha->model_desc));
 	} else {
@@ -4851,14 +4851,14 @@ qla2x00_set_model_info(scsi_qla_host_t *vha, uint8_t *model, size_t len,
 		if (use_tbl &&
 		    ha->pdev->subsystem_vendor == PCI_VENDOR_ID_QLOGIC &&
 		    index < QLA_MODEL_NAMES) {
-			strlcpy(ha->model_number,
+			strscpy(ha->model_number,
 				qla2x00_model_name[index * 2],
 				sizeof(ha->model_number));
-			strlcpy(ha->model_desc,
+			strscpy(ha->model_desc,
 			    qla2x00_model_name[index * 2 + 1],
 			    sizeof(ha->model_desc));
 		} else {
-			strlcpy(ha->model_number, def,
+			strscpy(ha->model_number, def,
 				sizeof(ha->model_number));
 		}
 	}
-- 
2.15.2
