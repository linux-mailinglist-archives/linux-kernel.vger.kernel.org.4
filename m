Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF606E8D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjDTI4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbjDTIyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:54:45 -0400
X-Greylist: delayed 72 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Apr 2023 01:53:12 PDT
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD4B4C1E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:53:12 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230420085158fa117b030f0e7ba1f0
        for <linux-kernel@vger.kernel.org>;
        Thu, 20 Apr 2023 10:51:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=oSulKytkzWMOv+kgWgQEjqlRjBDH0GiaM4Nt6CmQ6uE=;
 b=H3Bf3XfsSLywLif6PpgsJJi4WNvmVpQOlZLznH+PPooqlzDhVpOPeQtn6BggKtXLtvTtGD
 TQpgfkfrpoI3pShOkwRM9Oi8qqZZrk8935yV5syD9+qaHX2+gh8fkMHSEmDNmob2WuOmzwXJ
 j47+FWaZfErSPfnJZ4yQSQE15xMX8=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 1/9] tty: n_gsm: fix redundant assignment of gsm->encoding
Date:   Thu, 20 Apr 2023 10:50:09 +0200
Message-Id: <20230420085017.7314-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 1 -
 1 file changed, 1 deletion(-)

v1 -> v2:
Added Reviewed-by tag.

Link: https://lore.kernel.org/all/adf7aae2-2fd8-b191-f37-75185167f418@linux.intel.com/

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

