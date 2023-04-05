Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A55C6D73F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbjDEFu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbjDEFuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:50:22 -0400
X-Greylist: delayed 74 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Apr 2023 22:49:55 PDT
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AF21BEF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 22:49:55 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202304050548380861f07e5c4f7ec6b0
        for <linux-kernel@vger.kernel.org>;
        Wed, 05 Apr 2023 07:48:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=eaofLLxNrKLouJpv9xBZNno2aDJjC1A6uNHxejf6/ws=;
 b=e8Ukaa/HzGzvXcqtUvbQdG5KcX2P/0y9PDnqTdEYsORtJQFZfi2xjCxy4xYFM2/JcGc9YL
 Sxg5qzx/0dY36h77qkhpOEEGSY9bw9Q6dJoKxArmeSzf+PLcVLYdoPiZohXvjsn5JV/u1Aiv
 HvsXzSDLzKV8vIeqY1oqSxkd9t3AI=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/9] tty: n_gsm: fix redundant assignment of gsm->encoding
Date:   Wed,  5 Apr 2023 07:47:22 +0200
Message-Id: <20230405054730.3850-1-daniel.starke@siemens.com>
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

The function gsmld_open() contains a redundant assignment of gsm->encoding.
The same value of GSM_ADV_OPT is already assigned to it during the
initialization of the struct in gsm_alloc_mux() a few lines earlier.

Fix this by removing the redundant second assignment of gsm->encoding in
gsmld_open().

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b7e1369a035c..c42c8b89fd46 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3585,7 +3585,6 @@ static int gsmld_open(struct tty_struct *tty)
 	tty->receive_room = 65536;
 
 	/* Attach the initial passive connection */
-	gsm->encoding = GSM_ADV_OPT;
 	gsmld_attach_gsm(tty, gsm);
 
 	/* The mux will not be activated yet, we wait for correct
-- 
2.34.1

