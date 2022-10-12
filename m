Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125E05FC083
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJLGSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJLGSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:18:37 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Oct 2022 23:18:34 PDT
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF3D1D0C6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 23:18:34 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20221012061730c0cf472cc2ed5af1e1
        for <linux-kernel@vger.kernel.org>;
        Wed, 12 Oct 2022 08:17:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=VpHgegJB3cxiwO9lhfkYsrrSaUjQRVIJV9vdUJF51H8=;
 b=nsscUXCTxsVX0z3Q+X6tDXubII8YgnEcC5a1WcSzy1mmq2ZA2sdZjiieVzjeFzRn2lkekC
 Mpb7anBt35Q2KL1/RSWML2jxfcdNe2xqFXw+0I9xrh//h3geCT5NcALJlh8tFqTPbI8KbxuF
 hyO+weDSYVLiYvry73owEmEvhBz3w=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/1] tty: n_gsm: make n_gsm line number configurable
Date:   Wed, 12 Oct 2022 08:17:15 +0200
Message-Id: <20221012061715.4823-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Currently, the n_gsm line number and its derived virtual ttys are assigned
in the order of allocations with no means to change this.

Introduce additional ioctl parameters numValid and num to configure the
line number to allow predictable virtual tty allocation and numbering.
Especially when using multiple n_gsm instances at the same time.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c         | 85 +++++++++++++++++++++++++++++++++++--
 include/uapi/linux/gsmmux.h |  4 +-
 2 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5e516f5cac5a..fafef4edea4f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -228,7 +228,7 @@ struct gsm_mux {
 	struct tty_struct *tty;		/* The tty our ldisc is bound to */
 	spinlock_t lock;
 	struct mutex mutex;
-	unsigned int num;
+	unsigned short num;
 	struct kref ref;
 
 	/* Events on the GSM channel */
@@ -519,6 +519,64 @@ static void gsm_hex_dump_bytes(const char *fname, const u8 *data,
 	kfree(prefix);
 }
 
+/**
+ * gsm_get_mux	-	find a mux instance by line number
+ *
+ * @num:    the mux line number to search for may differ from the position
+ *          in the mux array.
+ *
+ * @return: Pointer of the mux instance with index <index> or
+ *          NULL if no instance with that index exists
+ */
+static struct gsm_mux *gsm_get_mux(unsigned int num)
+{
+	unsigned int i;
+	struct gsm_mux *gsm;
+
+	/* find the object with that line number */
+	spin_lock(&gsm_mux_lock);
+	for (i = 0, gsm = NULL; i < MAX_MUX; i++) {
+		if (gsm_mux[i]) {
+			if (num == gsm_mux[i]->num) {
+				gsm = gsm_mux[i];
+				break;
+			}
+		}
+	}
+	spin_unlock(&gsm_mux_lock);
+	return gsm;
+}
+
+/**
+ * gsm_assign_num	-	assigns a new mux line number
+ *
+ * @gsm: GSM mux
+ * @num: the desired new mux line number
+ *
+ * The global GSM mux line table is modified to reflect this change.
+ */
+static int gsm_assign_num(struct gsm_mux *gsm, unsigned int num)
+{
+	int ret = 0;
+
+	if (gsm->num >= MAX_MUX || num >= MAX_MUX)
+		return -EINVAL;
+
+	spin_lock(&gsm_mux_lock);
+	if (!gsm_mux[num]) {
+		if (gsm_mux[gsm->num])
+			gsm_mux[gsm->num] = NULL;
+		gsm_mux[num] = gsm;
+		gsm->num = num;
+	} else if (gsm->num != num) {
+		/* Setting an occupied line number is not allowed. */
+		ret = -EBUSY;
+	}
+	spin_unlock(&gsm_mux_lock);
+
+	return ret;
+}
+
 /**
  *	gsm_register_devices	-	register all tty devices for a given mux index
  *
@@ -2700,6 +2758,8 @@ static void gsm_copy_config_values(struct gsm_mux *gsm,
 	c->mru = gsm->mru;
 	c->mtu = gsm->mtu;
 	c->k = 0;
+	c->numValid = 1;
+	c->num = gsm->num;
 }
 
 static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
@@ -2707,6 +2767,7 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 	int ret = 0;
 	int need_close = 0;
 	int need_restart = 0;
+	struct gsm_mux *found;
 
 	/* Stuff we don't support yet - UI or I frame transport, windowing */
 	if ((c->adaption != 1 && c->adaption != 2) || c->k)
@@ -2722,10 +2783,22 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 		return -EINVAL;
 	if (c->i == 0 || c->i > 2)	/* UIH and UI only */
 		return -EINVAL;
+	if (c->numValid) {
+		if (c->num >= MAX_MUX)
+			return -EINVAL;
+		found = gsm_get_mux(c->num);
+		if (found) {
+			/* If there is a mux with that number then it must be the same. */
+			if (found != gsm)
+				return -EBUSY;
+		}
+	}
 	/*
 	 * See what is needed for reconfiguration
 	 */
-
+	/* Line number */
+	if (c->numValid && gsm->num != c->num)
+		need_restart = true;
 	/* Timing fields */
 	if (c->t1 != 0 && c->t1 != gsm->t1)
 		need_restart = 1;
@@ -2748,8 +2821,14 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 	 * configuration. On the first time there is no DLCI[0]
 	 * and closing or cleaning up is not necessary.
 	 */
-	if (need_close || need_restart)
+	if (need_close || need_restart) {
 		gsm_cleanup_mux(gsm, true);
+		if (c->numValid) {
+			ret = gsm_assign_num(gsm, c->num);
+			if (ret)
+				return ret;
+		}
+	}
 
 	gsm->initiator = c->initiator;
 	gsm->mru = c->mru;
diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index cb8693b39cb7..03b28a0076d8 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -19,7 +19,9 @@ struct gsm_config
 	unsigned int mtu;
 	unsigned int k;
 	unsigned int i;
-	unsigned int unused[8];		/* Padding for expansion without
+	unsigned short numValid;
+	unsigned short num;
+	unsigned int unused[7];		/* Padding for expansion without
 					   breaking stuff */
 };
 
-- 
2.34.1

