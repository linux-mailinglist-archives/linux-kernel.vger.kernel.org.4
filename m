Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4AB6EC783
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjDXH4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXH4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:56:17 -0400
X-Greylist: delayed 78 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 00:55:55 PDT
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620872115
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:55:55 -0700 (PDT)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230424075435d30a07f002aacfd3a3
        for <linux-kernel@vger.kernel.org>;
        Mon, 24 Apr 2023 09:54:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HYL648Ckr8RAxIMexFhAOmGJuIagv55uONwQN9AZSlE=;
 b=UxpH9sQVTdMiZacKHkA4qRluMfxv+wC4NMvn1yR5OwpPJ+xSnSY8HjyBYn4I5AzdpCtsmF
 Rg8iOylfp2qu0pvnQutc8lNijVl2ZJrG1XzmN/Qrz1EqEfsib7BoqG+PuaaJLn4EhCq/X04E
 UluXDLbNxpdPPJBmuvvZ2FtB2t2Uw=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 3/8] tty: n_gsm: remove unneeded initialization of ret in gsm_dlci_config
Date:   Mon, 24 Apr 2023 09:52:46 +0200
Message-Id: <20230424075251.5216-3-daniel.starke@siemens.com>
In-Reply-To: <20230424075251.5216-1-daniel.starke@siemens.com>
References: <20230424075251.5216-1-daniel.starke@siemens.com>
MIME-Version: 1.0
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

The variable 'ret' is not used before assignment from gsm_activate_mux().
Still it gets initialized to zero at declaration.

Fix this as remarked in the link below by moving the declaration to the
first assignment.

Link: https://lore.kernel.org/all/b42bc4d1-cc9d-d115-c981-aaa053bdc59f@kernel.org/

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

v2 -> v3:
No changes.

Link: https://lore.kernel.org/all/20230420085017.7314-4-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 00f692e2e810..9a2cf3e14678 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3277,7 +3277,6 @@ static void gsm_copy_config_values(struct gsm_mux *gsm,
 
 static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 {
-	int ret = 0;
 	int need_close = 0;
 	int need_restart = 0;
 
@@ -3356,7 +3355,7 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 	 * and removing from the mux array
 	 */
 	if (gsm->dead) {
-		ret = gsm_activate_mux(gsm);
+		int ret = gsm_activate_mux(gsm);
 		if (ret)
 			return ret;
 		if (gsm->initiator)
-- 
2.34.1

