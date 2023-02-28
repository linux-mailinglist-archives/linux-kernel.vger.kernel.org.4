Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D026A5307
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 07:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjB1Gc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 01:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjB1GcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:32:20 -0500
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E4629E03
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 22:32:17 -0800 (PST)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202302280632157f9ad6a9521dd73370
        for <linux-kernel@vger.kernel.org>;
        Tue, 28 Feb 2023 07:32:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tDSzegl8wRjGyTb80N1hE+w00MNy/G0rvVJNJbPavHY=;
 b=HPx/WSMAkv/9J2bd7VY6UZimwS3HJil+7kddYp4JQmIqP0z2ZuSHjQo8DzltM1u0xEjXOM
 G8/DibNx6MeiDLhfFFNXi3OyWL3gWOwJ0QI/9yp4ZxO4eGZYXvsCDJxQhuM1D+XMdU8QbCkf
 xDV77CQbnNXwqfgIlUOvhWL0Ed9EM=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 3/3] tty: n_gsm: add ioctl for DLC config via ldisc handle
Date:   Tue, 28 Feb 2023 07:29:57 +0100
Message-Id: <20230228062957.3150-3-daniel.starke@siemens.com>
In-Reply-To: <20230228062957.3150-1-daniel.starke@siemens.com>
References: <20230228062957.3150-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
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
 Documentation/driver-api/tty/n_gsm.rst | 16 +++++++++++++++
 drivers/tty/n_gsm.c                    | 28 ++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

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
index 494657e8535d..86f106545958 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3716,6 +3716,7 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
 {
 	struct gsm_config c;
 	struct gsm_config_ext ce;
+	struct gsm_dlci_config dc;
 	struct gsm_mux *gsm = tty->disc_data;
 	struct gsm_dlci *dlci;
 	unsigned int base;
@@ -3742,6 +3743,33 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
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

