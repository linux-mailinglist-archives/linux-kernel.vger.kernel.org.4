Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020EC6BAE42
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCOKzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCOKzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:55:13 -0400
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE9638EBC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:55:10 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202303151055089a4d24496730b747b1
        for <linux-kernel@vger.kernel.org>;
        Wed, 15 Mar 2023 11:55:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=C9jVQsax7rNf7SECM7GOJBvTtjsbpKa4V0Mp2HvJECY=;
 b=gJW+zOCuROgUoy5+f6JQkODBgFkUskQJ1+WASY+i7uDr9Ih+3GEfCELS2mC57il5DnNS8b
 qZY1h3bbSaAU26UzCKHe982W4XVnHiuFrv+QSH1ic8ZHiNMVb4SPoTrSj87xrYaWF6TCkUVy
 AeXLLBMc9Infrnyl0GelmpabIpttc=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 3/3] tty: n_gsm: add ioctl for DLC config via ldisc handle
Date:   Wed, 15 Mar 2023 11:53:54 +0100
Message-Id: <20230315105354.6234-3-daniel.starke@siemens.com>
In-Reply-To: <20230315105354.6234-1-daniel.starke@siemens.com>
References: <20230315105354.6234-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

The application which initializes the n_gsm ldisc may like to set
individual default parameters for each DLCI or take over of the application
specific DLCI configuration completely. This is currently not possible.
It is either possible to set common default parameters for all DLCIs or let
the user application set its DLCI specific configuration parameters.

Add support of GSMIOC_GETCONF_DLCI and GSMIOC_SETCONF_DLCI for the n_gsm
ldisc handle to support DLCI specific parameter configuration upfront.

Add a code example for this use case to the n_gsm documentation.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 Documentation/driver-api/tty/n_gsm.rst | 16 ++++++++++++++
 drivers/tty/n_gsm.c                    | 29 ++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

v1 -> v2:
Added variable `dlci` in gsmld_ioctl(). It was removed in patch 1/3.

Link: https://lore.kernel.org/all/20230228062957.3150-3-daniel.starke@siemens.com/
Link: https://lore.kernel.org/oe-kbuild-all/202302281856.S9Lz4gHB-lkp@intel.com/

diff --git a/Documentation/driver-api/tty/n_gsm.rst b/Documentation/driver-api/tty/n_gsm.rst
index c2624546fb8f..120317ec990f 100644
--- a/Documentation/driver-api/tty/n_gsm.rst
+++ b/Documentation/driver-api/tty/n_gsm.rst
@@ -47,6 +47,7 @@ Config Initiator
       int ldisc = N_GSM0710;
       struct gsm_config c;
       struct gsm_config_ext ce;
+      struct gsm_dlci_config dc;
       struct termios configuration;
       uint32_t first;
 
@@ -83,6 +84,13 @@ Config Initiator
       c.mtu = 127;
       /* set the new configuration */
       ioctl(fd, GSMIOC_SETCONF, &c);
+      /* get DLC 1 configuration */
+      dc.channel = 1;
+      ioctl(fd, GSMIOC_GETCONF_DLCI, &dc);
+      /* the first user channel gets a higher priority */
+      dc.priority = 1;
+      /* set the new DLC 1 specific configuration */
+      ioctl(fd, GSMIOC_SETCONF_DLCI, &dc);
       /* get first gsmtty device node */
       ioctl(fd, GSMIOC_GETFIRST, &first);
       printf("first muxed line: /dev/gsmtty%i\n", first);
@@ -136,6 +144,7 @@ Config Requester
 	int ldisc = N_GSM0710;
 	struct gsm_config c;
 	struct gsm_config_ext ce;
+	struct gsm_dlci_config dc;
 	struct termios configuration;
 	uint32_t first;
 
@@ -165,6 +174,13 @@ Config Requester
 	c.mtu = 127;
 	/* set the new configuration */
 	ioctl(fd, GSMIOC_SETCONF, &c);
+	/* get DLC 1 configuration */
+	dc.channel = 1;
+	ioctl(fd, GSMIOC_GETCONF_DLCI, &dc);
+	/* the first user channel gets a higher priority */
+	dc.priority = 1;
+	/* set the new DLC 1 specific configuration */
+	ioctl(fd, GSMIOC_SETCONF_DLCI, &dc);
 	/* get first gsmtty device node */
 	ioctl(fd, GSMIOC_GETFIRST, &first);
 	printf("first muxed line: /dev/gsmtty%i\n", first);
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5bbedfc36fd1..b7e1369a035c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3716,7 +3716,9 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
 {
 	struct gsm_config c;
 	struct gsm_config_ext ce;
+	struct gsm_dlci_config dc;
 	struct gsm_mux *gsm = tty->disc_data;
+	struct gsm_dlci *dlci;
 	unsigned int base;
 
 	switch (cmd) {
@@ -3741,6 +3743,33 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
 		if (copy_from_user(&ce, (void __user *)arg, sizeof(ce)))
 			return -EFAULT;
 		return gsm_config_ext(gsm, &ce);
+	case GSMIOC_GETCONF_DLCI:
+		if (copy_from_user(&dc, (void __user *)arg, sizeof(dc)))
+			return -EFAULT;
+		if (dc.channel == 0 || dc.channel >= NUM_DLCI)
+			return -EINVAL;
+		dlci = gsm->dlci[dc.channel];
+		if (!dlci) {
+			dlci = gsm_dlci_alloc(gsm, dc.channel);
+			if (!dlci)
+				return -ENOMEM;
+		}
+		gsm_dlci_copy_config_values(dlci, &dc);
+		if (copy_to_user((void __user *)arg, &dc, sizeof(dc)))
+			return -EFAULT;
+		return 0;
+	case GSMIOC_SETCONF_DLCI:
+		if (copy_from_user(&dc, (void __user *)arg, sizeof(dc)))
+			return -EFAULT;
+		if (dc.channel == 0 || dc.channel >= NUM_DLCI)
+			return -EINVAL;
+		dlci = gsm->dlci[dc.channel];
+		if (!dlci) {
+			dlci = gsm_dlci_alloc(gsm, dc.channel);
+			if (!dlci)
+				return -ENOMEM;
+		}
+		return gsm_dlci_config(dlci, &dc, 0);
 	default:
 		return n_tty_ioctl_helper(tty, cmd, arg);
 	}
-- 
2.34.1

