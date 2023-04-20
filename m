Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD13D6E8D46
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjDTIzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjDTIxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:53:45 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA975FE1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:52:00 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230420085158890bcb4770add0d669
        for <linux-kernel@vger.kernel.org>;
        Thu, 20 Apr 2023 10:51:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Y2LTmzdIUeHUdjGT1TEFeLvtTYBm6sbII2BeByX9Cyo=;
 b=TVE5mZ0ygCr3yjUkb74h5JCCCkbjlfuUUsG9EubKy+za7fBXiApvXJqU8xE6FFCwShHJIG
 zXjELbbG9bF7g2j0ZKrVWy7boHLYpCdfCyp0N8ECBHNTlN+75krikafr3SJu1zO3Pz7os5dW
 PabIdKzD6bBXunqVc6Sjmwse9+AkY=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 2/9] tty: n_gsm: add restart parameter to DLC specific ioctl config
Date:   Thu, 20 Apr 2023 10:50:10 +0200
Message-Id: <20230420085017.7314-2-daniel.starke@siemens.com>
In-Reply-To: <20230420085017.7314-1-daniel.starke@siemens.com>
References: <20230420085017.7314-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Add the parameter 'restart' to 'gsm_dlci_config' to force a channel reset
after ioctl setting regardless of whether the changes made require this or
not.

Note that the parameter is limited to the values 0 and 1 to allow future
additions here.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c         | 4 ++++
 include/uapi/linux/gsmmux.h | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

v1 -> v2:
Changed wording as remarked in the review.

Link: https://lore.kernel.org/all/AS4PR10MB5895BA5B2ECFFF74DDBAB571E0919@AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c42c8b89fd46..eb21ca583642 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2531,6 +2531,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
 		return -EINVAL;
 	if (dc->k > 7)
 		return -EINVAL;
+	if (dc->restart > 1)   /* allow future extensions */
+		return -EINVAL;
 
 	/*
 	 * See what is needed for reconfiguration
@@ -2545,6 +2547,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
 	/* Requires care */
 	if (dc->priority != dlci->prio)
 		need_restart = true;
+	if (dc->restart)
+		need_restart = true;
 
 	if ((open && gsm->wait_config) || need_restart)
 		need_open = true;
diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index eb67884e5f38..33ee7b857c52 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -58,7 +58,8 @@ struct gsm_dlci_config {
 	__u32 priority;		/* Priority (0 for default value) */
 	__u32 i;		/* Frame type (1 = UIH, 2 = UI) */
 	__u32 k;		/* Window size (0 for default value) */
-	__u32 reserved[8];	/* For future use, must be initialized to zero */
+	__u32 restart;		/* Force DLCI channel reset? */
+	__u32 reserved[7];	/* For future use, must be initialized to zero */
 };
 
 #define GSMIOC_GETCONF_DLCI	_IOWR('G', 7, struct gsm_dlci_config)
-- 
2.34.1

