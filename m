Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D846655CAD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 09:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiLYIwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 03:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYIwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 03:52:31 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9662C1;
        Sun, 25 Dec 2022 00:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671958337; bh=I5CZdbiOIfEVnkVnvSmsFr+giPvETja9h6PJ6ngbCfc=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=Ltr7bBrD75NWwpC30GJqRYeeNTqoM/zL8XeXO6W1AG6U128c0QB8KzAAhTMIrnPUc
         5USAgzSTdNY4nxceHOnXMrBeHA4Gcq7qouVWCmEcHcLxwMXzOkf8QV3ukWDSC9rt0M
         bQQHaGx4mRzZLVtwrK4SJkG5w5S75rB8VLJYz9Tk=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 25 Dec 2022 09:52:17 +0100 (CET)
X-EA-Auth: ltHlxnXlWaywR0ExxwSaRHOSNbllF5x5r4aSEgduth5IUWxFWrYNvc23zDL1RfjJn6VStuQPeqS9w+8dMWMbr/6mn3ffI4cg
Date:   Sun, 25 Dec 2022 14:22:12 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: fnic: Use sysfs_emit in show function callsbacks
Message-ID: <Y6gPPLI3nfKoDVVe@qemulion>
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
of sprintf() family functions. So, make this change.
Issue identified using the coccinelle device_attr_show.cocci script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/fnic/fnic_attrs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_attrs.c b/drivers/scsi/fnic/fnic_attrs.c
index a61e0c5e6506..1798d1e6318f 100644
--- a/drivers/scsi/fnic/fnic_attrs.c
+++ b/drivers/scsi/fnic/fnic_attrs.c
@@ -14,13 +14,13 @@ static ssize_t fnic_show_state(struct device *dev,
 	struct fc_lport *lp = shost_priv(class_to_shost(dev));
 	struct fnic *fnic = lport_priv(lp);

-	return snprintf(buf, PAGE_SIZE, "%s\n", fnic_state_str[fnic->state]);
+	return sysfs_emit(buf, "%s\n", fnic_state_str[fnic->state]);
 }

 static ssize_t fnic_show_drv_version(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", DRV_VERSION);
+	return sysfs_emit(buf, "%s\n", DRV_VERSION);
 }

 static ssize_t fnic_show_link_state(struct device *dev,
@@ -28,7 +28,7 @@ static ssize_t fnic_show_link_state(struct device *dev,
 {
 	struct fc_lport *lp = shost_priv(class_to_shost(dev));

-	return snprintf(buf, PAGE_SIZE, "%s\n", (lp->link_up)
+	return sysfs_emit(buf, "%s\n", (lp->link_up)
 			? "Link Up" : "Link Down");
 }

--
2.34.1



