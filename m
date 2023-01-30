Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4C5681B20
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbjA3ULy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjA3ULw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:11:52 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47512FCF1;
        Mon, 30 Jan 2023 12:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675109502; bh=nC23UKSb0CmGocYhYebIyi10v6NzVHfWuPVuA9RD+5I=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=QuTK57b7o/69VDAZrW7lKs8+nJE7zG+fk6wAtsjgtMF6fUalsrWIgVOzYuoLFMfwv
         adxJ9jUqf7Y/M8OXiNG3PGli/FN2BhrKTYQHYoQ2YUTBPmkCxDZeOODGCNCEmPn8eJ
         zBrROeaQDSQD3tMrIsraAOV51Tx0APGRqjBITCFw=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 30 Jan 2023 21:11:42 +0100 (CET)
X-EA-Auth: 9BdPFPNc5sSrJyZcSmB10vMudrlezrc6mxTOerZXdgYNx8zZQVr5xiB7fuksed7xAGNutcqN2W47ExxVo319+oQkO1t/HNNZ
Date:   Tue, 31 Jan 2023 01:41:38 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: fcoe: Use sysfs_emit in show function callback
Message-ID: <Y9gkeqfw/v6/UGxA@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/filesystems/sysfs.rst, show() callback
function should only use sysfs_emit() or sysfs_emit_at() instead
of sprint() family functions when formatting the device attribute
values to be returned to user space.
Issue identified using the device_attr_show.cocci Coccinelle script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/fcoe/fcoe_sysfs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index 6260aa5ea6af..9c50971c4bba 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -250,7 +250,7 @@ static ssize_t show_fcf_state(struct device *dev,
 	name = get_fcoe_fcf_state_name(fcf->state);
 	if (!name)
 		return -EINVAL;
-	return snprintf(buf, FCOE_FCF_STATE_MAX_NAMELEN, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 static FCOE_DEVICE_ATTR(fcf, state, S_IRUGO, show_fcf_state, NULL);
 
@@ -265,8 +265,7 @@ static ssize_t show_ctlr_mode(struct device *dev,
 	name = get_fcoe_ctlr_mode_name(ctlr->mode);
 	if (!name)
 		return -EINVAL;
-	return snprintf(buf, FCOE_MAX_MODENAME_LEN,
-			"%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 static ssize_t store_ctlr_mode(struct device *dev,
@@ -373,8 +372,7 @@ static ssize_t show_ctlr_enabled_state(struct device *dev,
 	name = get_fcoe_ctlr_enabled_state_name(ctlr->enabled);
 	if (!name)
 		return -EINVAL;
-	return snprintf(buf, FCOE_CTLR_ENABLED_MAX_NAMELEN,
-			"%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 static FCOE_DEVICE_ATTR(ctlr, enabled, S_IRUGO | S_IWUSR,
@@ -412,7 +410,7 @@ static ssize_t show_ctlr_fip_resp(struct device *dev,
 	struct fcoe_ctlr_device *ctlr = dev_to_ctlr(dev);
 	struct fcoe_ctlr *fip = fcoe_ctlr_device_priv(ctlr);
 
-	return sprintf(buf, "%d\n", fip->fip_resp ? 1 : 0);
+	return sysfs_emit(buf, "%d\n", fip->fip_resp ? 1 : 0);
 }
 
 static FCOE_DEVICE_ATTR(ctlr, fip_vlan_responder, S_IRUGO | S_IWUSR,
@@ -455,7 +453,7 @@ static ssize_t show_ctlr_r_a_tov(struct device *dev,
 	struct fcoe_ctlr_device *ctlr_dev = dev_to_ctlr(dev);
 	struct fcoe_ctlr *ctlr = fcoe_ctlr_device_priv(ctlr_dev);
 
-	return sprintf(buf, "%d\n", ctlr->lp->r_a_tov);
+	return sysfs_emit(buf, "%d\n", ctlr->lp->r_a_tov);
 }
 
 static FCOE_DEVICE_ATTR(ctlr, r_a_tov, S_IRUGO | S_IWUSR,
@@ -482,7 +480,7 @@ static ssize_t show_ctlr_e_d_tov(struct device *dev,
 	struct fcoe_ctlr_device *ctlr_dev = dev_to_ctlr(dev);
 	struct fcoe_ctlr *ctlr = fcoe_ctlr_device_priv(ctlr_dev);
 
-	return sprintf(buf, "%d\n", ctlr->lp->e_d_tov);
+	return sysfs_emit(buf, "%d\n", ctlr->lp->e_d_tov);
 }
 
 static FCOE_DEVICE_ATTR(ctlr, e_d_tov, S_IRUGO | S_IWUSR,
-- 
2.34.1



