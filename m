Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDFA706D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjEQP6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjEQP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:58:35 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34F230FD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:58:29 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202305171558264d7acbcc892648136f
        for <linux-kernel@vger.kernel.org>;
        Wed, 17 May 2023 17:58:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=myO+P8WOEjna9leIj0Mi2o9ZV1FzreaUuCy/6birCxg=;
 b=h3OcECnT2RGiwr8E/X3Favf64LAC/N6yEQ2xq/npJpR5AyqhgZAu5fG3ZH8xpYBRo1jNlM
 747whGj63viyftONRAziDSdytMJNK+SJ97KtC6j0dQs9hSv+u9HPd5bHvzk/BRBO+pwWYQT7
 I3eOpTDThIN85c2OlwXNn5ZV4fx+E=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        felix-haase@siemens.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v5 01/10] tty: n_gsm: add restart flag to DLC specific ioctl config
Date:   Wed, 17 May 2023 17:56:55 +0200
Message-Id: <20230517155704.5701-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Currently, changing the parameters of a DLCI gives no direct control to the
user whether this should trigger a channel reset or not. The decision is
solely made by the driver based on the assumption which parameter changes
are compatible or not. Therefore, the user has no means to perform an
automatic channel reset after parameter configuration for non-conflicting
changes.

Add the parameter 'flags' to 'gsm_dlci_config' to force a channel reset
after ioctl setting regardless of whether the changes made require this or
not by setting this to 'GSM_FL_RESTART'.

Note that 'GSM_FL_RESTART' is currently the only allow flag to allow
additions here.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c         |  4 ++++
 include/uapi/linux/gsmmux.h | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

v4 -> v5:
Changed GSM_FL_RESTART comment to be more specific about its use as
suggested in the review comment.

Please note that I cannot response to emails until August 7th. Felix Haase
will take over from our side for questions regarding this patch series or
the n_gsm.

Link: https://lore.kernel.org/all/DB9PR10MB5881B63FBBA7912DF5A7A6A8E0789@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b411a26cc092..66edcf65a4dd 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2532,6 +2532,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
 		return -EINVAL;
 	if (dc->k > 7)
 		return -EINVAL;
+	if (dc->flags & ~GSM_FL_RESTART)   /* allow future extensions */
+		return -EINVAL;
 
 	/*
 	 * See what is needed for reconfiguration
@@ -2546,6 +2548,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
 	/* Requires care */
 	if (dc->priority != dlci->prio)
 		need_restart = true;
+	if (dc->flags & GSM_FL_RESTART)
+		need_restart = true;
 
 	if ((open && gsm->wait_config) || need_restart)
 		need_open = true;
diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index eb67884e5f38..e56e2d7ea6eb 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -2,10 +2,22 @@
 #ifndef _LINUX_GSMMUX_H
 #define _LINUX_GSMMUX_H
 
+#include <linux/const.h>
 #include <linux/if.h>
 #include <linux/ioctl.h>
 #include <linux/types.h>
 
+/*
+ * flags definition for n_gsm
+ *
+ * Used by:
+ * struct gsm_dlci_config.flags
+ */
+/* Forces a DLCI reset if set. Otherwise, a DLCI reset is only done if
+ * incompatible settings were provided. Always cleared on retrieval.
+ */
+#define GSM_FL_RESTART	_BITUL(0)
+
 struct gsm_config
 {
 	unsigned int adaption;
@@ -58,7 +70,8 @@ struct gsm_dlci_config {
 	__u32 priority;		/* Priority (0 for default value) */
 	__u32 i;		/* Frame type (1 = UIH, 2 = UI) */
 	__u32 k;		/* Window size (0 for default value) */
-	__u32 reserved[8];	/* For future use, must be initialized to zero */
+	__u32 flags;		/* DLCI specific flags. */
+	__u32 reserved[7];	/* For future use, must be initialized to zero */
 };
 
 #define GSMIOC_GETCONF_DLCI	_IOWR('G', 7, struct gsm_dlci_config)
-- 
2.34.1

