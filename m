Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD706EEFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbjDZIDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239943AbjDZIDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:03:36 -0400
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26233C39
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 01:03:33 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230426080331e894376af7320373af
        for <linux-kernel@vger.kernel.org>;
        Wed, 26 Apr 2023 10:03:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=n93VBue8YLe4OhiAewOGivq1aA7fZ4cftiwPcFyOEGA=;
 b=iHhg3PN6pCQYgTPCN2tI8Jn7nBEpR5m7L9OP1UZleR07/97xPskAQLDJAPcOpaj6/MLISf
 RxGW/4L8VGia4AjNB+bOs21NVemge0kmuMzc3N7d2S54tpe/V0FIsgP6o+L8E+/XWscLi98d
 HT3/Oz0kCM08cEwWspWuNjoy3a2dU=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v4 5/8] tty: n_gsm: increase malformed counter for malformed control frames
Date:   Wed, 26 Apr 2023 10:03:12 +0200
Message-Id: <20230426080315.7595-5-daniel.starke@siemens.com>
In-Reply-To: <20230426080315.7595-1-daniel.starke@siemens.com>
References: <20230426080315.7595-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

The malformed counter in gsm_mux is already increased in case of errors
detected in gsm_queue() and gsm1_receive(). gsm_dlci_command() also
detects a case for a malformed frame but does not increase the malformed
counter yet.

Fix this by also increasing the gsm_mux malformed counter in case of a
malformed frame in gsm_dlci_command().
Note that the malformed counter is not yet exposed and only set internally.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

v3 -> v4:
No changes.

Link: https://lore.kernel.org/all/20230424075251.5216-5-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 186f463f0f11..5b6a03668c78 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2455,8 +2455,10 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
 	data += dlen;
 
 	/* Malformed command? */
-	if (clen > len)
+	if (clen > len) {
+		dlci->gsm->malformed++;
 		return;
+	}
 
 	if (command & 1)
 		gsm_control_message(dlci->gsm, command, data, clen);
-- 
2.34.1

