Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FFD706D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjEQP6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjEQP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:58:35 -0400
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B572C659B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:58:29 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202305171558270ef22220b1dbdd5194
        for <linux-kernel@vger.kernel.org>;
        Wed, 17 May 2023 17:58:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=hLYDLew2BnYtz1yW2u/0Fx5TXlG323HFpawW+DCWpzs=;
 b=Fqfhp1cD0EJa9fFC2xJ8Z/9CSQcupvI8O/bp8c5vIAutEnR19ycF8fvP4O+gmlkgOXkf/n
 lrRDLnfjngvNIs/8gf95e539zjWt88BJ8mhLaEMzCk9Xox9AADDI9OtfmX6/PNMa9RoNpiPU
 xjH1rHgia9rJCIlM1UatJ154LFEpU=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        felix-haase@siemens.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v5 03/10] tty: n_gsm: remove unneeded initialization of ret in gsm_dlci_config
Date:   Wed, 17 May 2023 17:56:57 +0200
Message-Id: <20230517155704.5701-3-daniel.starke@siemens.com>
In-Reply-To: <20230517155704.5701-1-daniel.starke@siemens.com>
References: <20230517155704.5701-1-daniel.starke@siemens.com>
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

The variable 'ret' is not used before assignment from gsm_activate_mux().
Still it gets initialized to zero at declaration.

Fix this as remarked in the link below by moving the declaration to the
first assignment.

Link: https://lore.kernel.org/all/b42bc4d1-cc9d-d115-c981-aaa053bdc59f@kernel.org/

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

v4 -> v5:
No changes.

Please note that I cannot response to emails until August 7th. Felix Haase
will take over from our side for questions regarding this patch series or
the n_gsm.

Link: https://lore.kernel.org/all/20230426080315.7595-3-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 66edcf65a4dd..ebb71957f783 100644
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

