Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2018706D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjEQP7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjEQP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:58:59 -0400
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CD16A5F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:58:34 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230517155832d1db49695436981b53
        for <linux-kernel@vger.kernel.org>;
        Wed, 17 May 2023 17:58:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sXrwJ9Suw+eRO3K7fPMPI+/OulstW6ToHU5QLmyRPdg=;
 b=poCQmV7v3sTU0jmYQLtrkyfHOnvWb/Pxh9cnrogAs+k9+cjXKKth4xhS48mQXkXHoDZf3Q
 yTAlJNEIId/7caobzzxczFOarsi/blCvxQ0OO+7dGDWKli7XJs8+VmpRVW4ejoGvc8ixJTtI
 kMchkQlzQWnlJswdZPBAF18HGXqGk=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        felix-haase@siemens.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v5 10/10] tty: n_gsm: add restart flag to extended ioctl config
Date:   Wed, 17 May 2023 17:57:04 +0200
Message-Id: <20230517155704.5701-10-daniel.starke@siemens.com>
In-Reply-To: <20230517155704.5701-1-daniel.starke@siemens.com>
References: <20230517155704.5701-1-daniel.starke@siemens.com>
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

Currently, changing the parameters of the n_gsm mux gives no direct control
to the user whether this should trigger a mux reset or not. The decision is
solely made by the driver based on the assumption which parameter changes
are compatible or not. Therefore, the user has no means to perform an
automatic mux reset after parameter configuration for non-conflicting
changes.

Add the parameter 'flags' to 'gsm_config_ext' to force a mux reset after
ioctl setting regardless of whether the changes made require this or not
by setting this to 'GSM_FL_RESTART'. This is done similar to
'GSM_FL_RESTART' in gsm_dlci_config.flags.

Note that 'GSM_FL_RESTART' is currently the only allowed flag to allow
additions here.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c         | 23 +++++++++++++++++++++++
 include/uapi/linux/gsmmux.h |  5 ++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

v4 -> v5:
Newly added patch. This adds the missing equivalent from
struct gsm_dlci_config to struct gsm_config_ext.
See also the link below regarding the initial remark for this.

Please note that I cannot response to emails until August 7th. Felix Haase
will take over from our side for questions regarding this patch series or
the n_gsm.

Link: https://lore.kernel.org/all/cd7c33c8-2634-382d-cf62-3785e391af2@linux.intel.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 30f73ab2491f..362a42bdc072 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3578,6 +3578,7 @@ static void gsm_copy_config_ext_values(struct gsm_mux *gsm,
 
 static int gsm_config_ext(struct gsm_mux *gsm, struct gsm_config_ext *ce)
 {
+	bool need_restart = false;
 	unsigned int i;
 
 	/*
@@ -3587,6 +3588,20 @@ static int gsm_config_ext(struct gsm_mux *gsm, struct gsm_config_ext *ce)
 	for (i = 0; i < ARRAY_SIZE(ce->reserved); i++)
 		if (ce->reserved[i])
 			return -EINVAL;
+	if (ce->flags & ~GSM_FL_RESTART)
+		return -EINVAL;
+
+	/* Requires care */
+	if (ce->flags & GSM_FL_RESTART)
+		need_restart = true;
+
+	/*
+	 * Close down what is needed, restart and initiate the new
+	 * configuration. On the first time there is no DLCI[0]
+	 * and closing or cleaning up is not necessary.
+	 */
+	if (need_restart)
+		gsm_cleanup_mux(gsm, true);
 
 	/*
 	 * Setup the new configuration values
@@ -3594,6 +3609,14 @@ static int gsm_config_ext(struct gsm_mux *gsm, struct gsm_config_ext *ce)
 	gsm->wait_config = ce->wait_config ? true : false;
 	gsm->keep_alive = ce->keep_alive;
 
+	if (gsm->dead) {
+		int ret = gsm_activate_mux(gsm);
+		if (ret)
+			return ret;
+		if (gsm->initiator)
+			gsm_dlci_begin_open(gsm->dlci[0]);
+	}
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index 3bd6f03a8293..4c878d84dbda 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -11,6 +11,7 @@
  * flags definition for n_gsm
  *
  * Used by:
+ * struct gsm_config_ext.flags
  * struct gsm_dlci_config.flags
  */
 /* Forces a DLCI reset if set. Otherwise, a DLCI reset is only done if
@@ -98,12 +99,14 @@ struct gsm_netconfig {
  *
  * @keep_alive:  Control channel keep-alive in 1/100th of a second (0 to disable).
  * @wait_config: Wait for DLCI config before opening virtual link?
+ * @flags:       Mux specific flags.
  * @reserved:    For future use, must be initialized to zero.
  */
 struct gsm_config_ext {
 	__u32 keep_alive;
 	__u32 wait_config;
-	__u32 reserved[6];
+	__u32 flags;
+	__u32 reserved[5];
 };
 
 #define GSMIOC_GETCONF_EXT	_IOR('G', 5, struct gsm_config_ext)
-- 
2.34.1

