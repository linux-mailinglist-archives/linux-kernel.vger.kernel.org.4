Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAA4655421
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 21:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiLWUJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 15:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiLWUIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:08:42 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B00114013;
        Fri, 23 Dec 2022 12:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671826053; bh=14iqMvlBXFPuwkQ+tLG2S5XN85mJQwSd2VCBQKPJQ2Y=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=f0BJtlf27AF0+t+MM3ffTfbc27/OI2QI5s8yF7lyYk5rFUwmhlbtPzrXHxKh3uujF
         MnffusfnpFL/TGEvFTKCd4sGZ4t2iE2zxSomAzblls8VrMt7ZgHEh4+TEUtfU+yVhm
         TxeH/lakgM8h4h/e6X2o4s/w1+VlTTarA1/Y3Ctc=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 23 Dec 2022 21:07:31 +0100 (CET)
X-EA-Auth: Po/4f9zZ+atWMjHK+A87Io28wXW8i5FBiLXWDIn25T46cPd5/Uz1Wn/w8JYRR2v0y1QrBCN0KtmTW1c08UzSGJFyccq4Ei6n
Date:   Sat, 24 Dec 2022 01:37:26 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: scsi_transport_sas: Use sysfs_emit in show function
 callsbacks
Message-ID: <Y6YKfp1bHZm3UZpf@qemulion>
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

Issue identified using the coccinelle device_attr_show.cocci script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/scsi_transport_sas.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index 74b99f2b0b74..5504067adcf1 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -522,7 +522,7 @@ show_sas_device_type(struct device *dev,
 	struct sas_phy *phy = transport_class_to_phy(dev);

 	if (!phy->identify.device_type)
-		return snprintf(buf, 20, "none\n");
+		return sysfs_emit(buf, "none\n");
 	return get_sas_device_type_names(phy->identify.device_type, buf);
 }
 static DEVICE_ATTR(device_type, S_IRUGO, show_sas_device_type, NULL);
@@ -569,7 +569,7 @@ show_sas_phy_enable(struct device *dev, struct device_attribute *attr,
 {
 	struct sas_phy *phy = transport_class_to_phy(dev);

-	return snprintf(buf, 20, "%d\n", phy->enabled);
+	return sysfs_emit(buf, "%d\n", phy->enabled);
 }

 static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR, show_sas_phy_enable,
@@ -1177,7 +1177,7 @@ show_sas_rphy_device_type(struct device *dev,
 	struct sas_rphy *rphy = transport_class_to_rphy(dev);

 	if (!rphy->identify.device_type)
-		return snprintf(buf, 20, "none\n");
+		return sysfs_emit(buf, "none\n");
 	return get_sas_device_type_names(
 			rphy->identify.device_type, buf);
 }
--
2.34.1



