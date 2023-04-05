Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF106D73FB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbjDEFuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbjDEFuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:50:25 -0400
X-Greylist: delayed 72 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Apr 2023 22:49:56 PDT
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FD54EFD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 22:49:56 -0700 (PDT)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230405054842a1eb5d27e0917391df
        for <linux-kernel@vger.kernel.org>;
        Wed, 05 Apr 2023 07:48:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=1GS25vop8sxUpd2Jcu2/YctKoWgcop6YP071C0g8f7A=;
 b=p6+pVTkhM5dHMuDtxJ+UH1KIS+NvwW2qr4P8FNd+9AGfmKO28kGyEBq5/TmDeEiWqCnu4m
 O5rkj9Fe9FQWAWMW5I8aqd3auG9IzOWyRyWQLJ02CZoakX90NaVvKJ51z5tgXnF2S9c99myN
 XIndyBEAlHk73sljUrYeW/eSiD8yo=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 9/9] tty: n_gsm: cleanup gsm_control_command and gsm_control_reply
Date:   Wed,  5 Apr 2023 07:47:30 +0200
Message-Id: <20230405054730.3850-9-daniel.starke@siemens.com>
In-Reply-To: <20230405054730.3850-1-daniel.starke@siemens.com>
References: <20230405054730.3850-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

There are multiple places in gsm_control_command and gsm_control_reply that
derive the specific DLCI handle directly out of the DLCI table in gsm.

Add a local variable which holds this handle and use it instead to improve
code readability.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 61f9825fde3c..87720ebc38d7 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1454,16 +1454,17 @@ static int gsm_control_command(struct gsm_mux *gsm, int cmd, const u8 *data,
 			       int dlen)
 {
 	struct gsm_msg *msg;
+	struct gsm_dlci *dlci = gsm->dlci[0];
 
-	msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->dlci[0]->ftype);
+	msg = gsm_data_alloc(gsm, 0, dlen + 2, dlci->ftype);
 	if (msg == NULL)
 		return -ENOMEM;
 
 	msg->data[0] = (cmd << 1) | CR | EA;	/* Set C/R */
 	msg->data[1] = (dlen << 1) | EA;
 	memcpy(msg->data + 2, data, dlen);
-	gsm_data_queue(gsm->dlci[0], msg);
-	gsm->dlci[0]->tx += dlen;
+	gsm_data_queue(dlci, msg);
+	dlci->tx += dlen;
 
 	return 0;
 }
@@ -1482,15 +1483,16 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
 					int dlen)
 {
 	struct gsm_msg *msg;
+	struct gsm_dlci *dlci = gsm->dlci[0];
 
-	msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->dlci[0]->ftype);
+	msg = gsm_data_alloc(gsm, 0, dlen + 2, dlci->ftype);
 	if (msg == NULL)
 		return;
 	msg->data[0] = (cmd & 0xFE) << 1 | EA;	/* Clear C/R */
 	msg->data[1] = (dlen << 1) | EA;
 	memcpy(msg->data + 2, data, dlen);
-	gsm_data_queue(gsm->dlci[0], msg);
-	gsm->dlci[0]->tx += dlen;
+	gsm_data_queue(dlci, msg);
+	dlci->tx += dlen;
 }
 
 /**
-- 
2.34.1

