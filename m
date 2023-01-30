Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1821681A89
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbjA3TdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbjA3TdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:33:11 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89230C157;
        Mon, 30 Jan 2023 11:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675107170; bh=8Ch26340bGNGh7MvxCuYz9qLE9EjgUyzkgWt1CvrVRQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=oSFXQK5pxF3Bg82t71nZec3Vq1/4FUH8Rq/C3pvQyOoTVBBRsrmMfCMd7UWg8HrPq
         Xc9V6UGNSQBvdVsw0TpaP/getMFG06x5gO8PIheN7luOWhnRwLSjQP0dH4i1kEcdq3
         rTS+caJqRLTEghmBItJ+h/s3PuPPLePBDNox3kdU=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 30 Jan 2023 20:32:50 +0100 (CET)
X-EA-Auth: TipJ+Tj7bxj605b6/oLpSLv33BDc31aMb1KsTH0jQhdw/J29WH1jtfjUw+iP3i0COi2GLYG84O3Rvw8BjTMQDaR3tD7fJJmg
Date:   Tue, 31 Jan 2023 01:02:45 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Ketan Mukadam <ketan.mukadam@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: be2iscsi: Use sysfs_emit in show function callback
Message-ID: <Y9gbXY3+Ln+X2qMY@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/filesystems/sysfs.rst, the show() callback
function of kobject attributes should strictly use sysfs_emit() instead
of sprintf() family functions.
Issue identified using the device_attr_show.cocci Coccinelle script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/be2iscsi/be_mgmt.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_mgmt.c b/drivers/scsi/be2iscsi/be_mgmt.c
index 4e899ec1477d..cb74524fa516 100644
--- a/drivers/scsi/be2iscsi/be_mgmt.c
+++ b/drivers/scsi/be2iscsi/be_mgmt.c
@@ -1142,7 +1142,7 @@ ssize_t
 beiscsi_drvr_ver_disp(struct device *dev, struct device_attribute *attr,
 		       char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, BE_NAME "\n");
+	return sysfs_emit(buf, BE_NAME "\n");
 }
 
 /**
@@ -1161,7 +1161,7 @@ beiscsi_fw_ver_disp(struct device *dev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct beiscsi_hba *phba = iscsi_host_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", phba->fw_ver_str);
+	return sysfs_emit(buf, "%s\n", phba->fw_ver_str);
 }
 
 /**
@@ -1248,16 +1248,14 @@ beiscsi_adap_family_disp(struct device *dev, struct device_attribute *attr,
 	case BE_DEVICE_ID1:
 	case OC_DEVICE_ID1:
 	case OC_DEVICE_ID2:
-		return snprintf(buf, PAGE_SIZE,
-				"Obsolete/Unsupported BE2 Adapter Family\n");
+		return sysfs_emit(buf, "Obsolete/Unsupported BE2 Adapter Family\n");
 	case BE_DEVICE_ID2:
 	case OC_DEVICE_ID3:
-		return snprintf(buf, PAGE_SIZE, "BE3-R Adapter Family\n");
+		return sysfs_emit(buf, "BE3-R Adapter Family\n");
 	case OC_SKH_ID1:
-		return snprintf(buf, PAGE_SIZE, "Skyhawk-R Adapter Family\n");
+		return sysfs_emit(buf, "Skyhawk-R Adapter Family\n");
 	default:
-		return snprintf(buf, PAGE_SIZE,
-				"Unknown Adapter Family: 0x%x\n", dev_id);
+		return sysfs_emit(buf, "Unknown Adapter Family: 0x%x\n", dev_id);
 	}
 }
 
@@ -1277,8 +1275,7 @@ beiscsi_phys_port_disp(struct device *dev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct beiscsi_hba *phba = iscsi_host_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "Port Identifier : %u\n",
-			phba->fw_config.phys_port);
+	return sysfs_emit(buf, "Port Identifier : %u\n", phba->fw_config.phys_port);
 }
 
 void beiscsi_offload_cxn_v0(struct beiscsi_offload_params *params,
-- 
2.34.1



