Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D9E655418
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 21:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiLWUE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 15:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiLWUEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:04:25 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99D21A3BD;
        Fri, 23 Dec 2022 12:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671825797; bh=TU8Xna5FVtCrVWYoFZDQvx7FY3KCTsRcmqVSvN3iXdY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=icVhP19KW9QnEipzHhFYiprPx7poCvc2VKXINWcP7cj3cxaoY4OGH/ewWE9Md2Xze
         xfSdkqEAgoI7acqO4vHr5hFUo6WfjWYL4IZirlOXHCue/B33K4LsoDIh8ULjyre23l
         9X2SLAfFbM9ARPJCIuIpczeEyBRIy+vdO2B10OYA=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 23 Dec 2022 21:03:17 +0100 (CET)
X-EA-Auth: Vvw/Vkc+ZhIkPzlv6mlYP9tKYtT2P337DYCZnkUorn+nPCkSQd5KKptAaIOjnVxyQMQueae8HtydHEptrY96H/b72ozCbylu
Date:   Sat, 24 Dec 2022 01:33:12 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: scsi_transport_fc: Use sysfs_emit in show function
 callsbacks
Message-ID: <Y6YJgNv0GbdcPq2w@qemulion>
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
of sprintf() family functions. Also, merge split lines wherever possible
due to shortened length of lines.

Issue identified using the coccinelle device_attr_show.cocci script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/scsi_transport_fc.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 0965f8a7134f..ace0df098774 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -1117,7 +1117,7 @@ show_fc_rport_supported_classes (struct device *dev,
 {
 	struct fc_rport *rport = transport_class_to_rport(dev);
 	if (rport->supported_classes == FC_COS_UNSPECIFIED)
-		return snprintf(buf, 20, "unspecified\n");
+		return sysfs_emit(buf, "unspecified\n");
 	return get_fc_cos_names(rport->supported_classes, buf);
 }
 static FC_DEVICE_ATTR(rport, supported_classes, S_IRUGO,
@@ -1212,21 +1212,21 @@ show_fc_rport_roles (struct device *dev, struct device_attribute *attr,
 					FC_WELLKNOWN_PORTID_MASK) {
 		switch (rport->port_id & FC_WELLKNOWN_ROLE_MASK) {
 		case FC_FPORT_PORTID:
-			return snprintf(buf, 30, "Fabric Port\n");
+			return sysfs_emit(buf, "Fabric Port\n");
 		case FC_FABCTLR_PORTID:
-			return snprintf(buf, 30, "Fabric Controller\n");
+			return sysfs_emit(buf, "Fabric Controller\n");
 		case FC_DIRSRVR_PORTID:
-			return snprintf(buf, 30, "Directory Server\n");
+			return sysfs_emit(buf, "Directory Server\n");
 		case FC_TIMESRVR_PORTID:
-			return snprintf(buf, 30, "Time Server\n");
+			return sysfs_emit(buf, "Time Server\n");
 		case FC_MGMTSRVR_PORTID:
-			return snprintf(buf, 30, "Management Server\n");
+			return sysfs_emit(buf, "Management Server\n");
 		default:
-			return snprintf(buf, 30, "Unknown Fabric Entity\n");
+			return sysfs_emit(buf, "Unknown Fabric Entity\n");
 		}
 	} else {
 		if (rport->roles == FC_PORT_ROLE_UNKNOWN)
-			return snprintf(buf, 20, "unknown\n");
+			return sysfs_emit(buf, "unknown\n");
 		return get_fc_port_roles_names(rport->roles, buf);
 	}
 }
@@ -1280,7 +1280,7 @@ show_fc_rport_port_state(struct device *dev,
 	if (!name)
 		return -EINVAL;

-	return snprintf(buf, 20, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }

 static FC_DEVICE_ATTR(rport, port_state, 0444 | 0200,
@@ -1298,8 +1298,8 @@ show_fc_rport_fast_io_fail_tmo (struct device *dev,
 	struct fc_rport *rport = transport_class_to_rport(dev);

 	if (rport->fast_io_fail_tmo == -1)
-		return snprintf(buf, 5, "off\n");
-	return snprintf(buf, 20, "%d\n", rport->fast_io_fail_tmo);
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n", rport->fast_io_fail_tmo);
 }

 static ssize_t
@@ -1659,7 +1659,7 @@ show_fc_vport_roles (struct device *dev, struct device_attribute *attr,
 	struct fc_vport *vport = transport_class_to_vport(dev);

 	if (vport->roles == FC_PORT_ROLE_UNKNOWN)
-		return snprintf(buf, 20, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");
 	return get_fc_port_roles_names(vport->roles, buf);
 }
 static FC_DEVICE_ATTR(vport, roles, S_IRUGO, show_fc_vport_roles, NULL);
@@ -1885,7 +1885,7 @@ show_fc_host_supported_classes (struct device *dev,
 	struct Scsi_Host *shost = transport_class_to_shost(dev);

 	if (fc_host_supported_classes(shost) == FC_COS_UNSPECIFIED)
-		return snprintf(buf, 20, "unspecified\n");
+		return sysfs_emit(buf, "unspecified\n");

 	return get_fc_cos_names(fc_host_supported_classes(shost), buf);
 }
@@ -1909,7 +1909,7 @@ show_fc_host_supported_speeds (struct device *dev,
 	struct Scsi_Host *shost = transport_class_to_shost(dev);

 	if (fc_host_supported_speeds(shost) == FC_PORTSPEED_UNKNOWN)
-		return snprintf(buf, 20, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");

 	return get_fc_port_speed_names(fc_host_supported_speeds(shost), buf);
 }
@@ -1961,7 +1961,7 @@ show_fc_host_speed (struct device *dev,
 		i->f->get_host_speed(shost);

 	if (fc_host_speed(shost) == FC_PORTSPEED_UNKNOWN)
-		return snprintf(buf, 20, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");

 	return get_fc_port_speed_names(fc_host_speed(shost), buf);
 }
@@ -1994,7 +1994,7 @@ show_fc_private_host_tgtid_bind_type(struct device *dev,
 	name = get_fc_tgtid_bind_type_name(fc_host_tgtid_bind_type(shost));
 	if (!name)
 		return -EINVAL;
-	return snprintf(buf, FC_BINDTYPE_MAX_NAMELEN, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }

 #define get_list_head_entry(pos, head, member) 		\
--
2.34.1



