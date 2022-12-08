Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C4A646A5A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiLHIV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLHIVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:21:24 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8F759178;
        Thu,  8 Dec 2022 00:21:23 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NSRv55mX6z4xVnf;
        Thu,  8 Dec 2022 16:21:21 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl1.zte.com.cn with SMTP id 2B88LGWi014440;
        Thu, 8 Dec 2022 16:21:16 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 8 Dec 2022 16:21:18 +0800 (CST)
Date:   Thu, 8 Dec 2022 16:21:18 +0800 (CST)
X-Zmail-TransId: 2af963919e7effffffff8cb47df7
X-Mailer: Zmail v1.0
Message-ID: <202212081621189260759@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <martin.petersen@oracle.com>
Cc:     <ketan.mukadam@broadcom.com>, <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBzY3NpOiBiZTJpc2NzaTogQ29udmVydCB0byB1c2Ugc3lzZnNfZW1pdF9hdCgpIEFQSQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B88LGWi014440
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63919E81.000 by FangMail milter!
X-FangMail-Envelope: 1670487681/4NSRv55mX6z4xVnf/63919E81.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63919E81.000/4NSRv55mX6z4xVnf
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
 drivers/scsi/be2iscsi/be_mgmt.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_mgmt.c b/drivers/scsi/be2iscsi/be_mgmt.c
index 4e899ec1477d..bf39140250bc 100644
--- a/drivers/scsi/be2iscsi/be_mgmt.c
+++ b/drivers/scsi/be2iscsi/be_mgmt.c
@@ -1185,12 +1185,10 @@ beiscsi_active_session_disp(struct device *dev, struct device_attribute *attr,
 		if (test_bit(ulp_num, (void *)&phba->fw_config.ulp_supported)) {
 			avlbl_cids = BEISCSI_ULP_AVLBL_CID(phba, ulp_num);
 			total_cids = BEISCSI_GET_CID_COUNT(phba, ulp_num);
-			len += scnprintf(buf+len, PAGE_SIZE - len,
-					 "ULP%d : %d\n", ulp_num,
-					 (total_cids - avlbl_cids));
+			len += sysfs_emit_at(buf, len, "ULP%d : %d\n",
+					     ulp_num, (total_cids - avlbl_cids));
 		} else
-			len += scnprintf(buf+len, PAGE_SIZE - len,
-					 "ULP%d : %d\n", ulp_num, 0);
+			len += sysfs_emit_at(buf, len, "ULP%d : %d\n", ulp_num, 0);
 	}

 	return len;
@@ -1215,12 +1213,10 @@ beiscsi_free_session_disp(struct device *dev, struct device_attribute *attr,

 	for (ulp_num = 0; ulp_num < BEISCSI_ULP_COUNT; ulp_num++) {
 		if (test_bit(ulp_num, (void *)&phba->fw_config.ulp_supported))
-			len += scnprintf(buf+len, PAGE_SIZE - len,
-					 "ULP%d : %d\n", ulp_num,
-					 BEISCSI_ULP_AVLBL_CID(phba, ulp_num));
+			len += sysfs_emit_at(buf, len, "ULP%d : %d\n", ulp_num,
+					     BEISCSI_ULP_AVLBL_CID(phba, ulp_num));
 		else
-			len += scnprintf(buf+len, PAGE_SIZE - len,
-					 "ULP%d : %d\n", ulp_num, 0);
+			len += sysfs_emit_at(buf, len, "ULP%d : %d\n", ulp_num, 0);
 	}

 	return len;
-- 
2.25.1
