Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8A460BBEC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiJXVR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiJXVRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:17:17 -0400
X-Greylist: delayed 1889 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 12:23:18 PDT
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567852D2D5E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:23:18 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20221024130239ff05e52880d9cf551f
        for <linux-kernel@vger.kernel.org>;
        Mon, 24 Oct 2022 15:02:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=K2kGQ1uzzqA0xWymbFltF9V6/W7ChuSY3sWXqrXX9m8=;
 b=iCo9+oytoKkqsi8D6FE1CqIrKRjRBDp0s+x9g85W4BMGVfZAjDlMJCk0M8NCG3YgAXHg1Y
 UknYlfcxZN7zk9hKtLB/4hNCrwX4cPP/EiBlR3VHPSwIfGqZhCVy1Gh1lXj2/FAVOAvfCHVy
 ej/gR5+Z+wXC/8GDp9yPdAd/ojYU0=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 1/3] tty: n_gsm: introduce macro for minimal unit size
Date:   Mon, 24 Oct 2022 15:01:12 +0200
Message-Id: <20221024130114.2070-1-daniel.starke@siemens.com>
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

n_gsm has a minimal protocol overhead of 7 bytes. The current code already
checks whether the configured MRU/MTU size is at least one byte more than
this.

Introduce the macro MIN_MTU to make this value more obvious.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

v1 -> v2:
Incorporated review comments.

Link: https://lore.kernel.org/all/fe537e8-7b2-61e2-767d-787b923c7456@linux.intel.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5e516f5cac5a..570c40a3d78f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -89,6 +89,7 @@ module_param(debug, int, 0600);
  */
 #define MAX_MRU 1500
 #define MAX_MTU 1500
+#define MIN_MTU (PROT_OVERHEAD + 1)
 /* SOF, ADDR, CTRL, LEN1, LEN2, ..., FCS, EOF */
 #define PROT_OVERHEAD 7
 #define	GSM_NET_TX_TIMEOUT (HZ*10)
@@ -2712,7 +2713,9 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 	if ((c->adaption != 1 && c->adaption != 2) || c->k)
 		return -EOPNOTSUPP;
 	/* Check the MRU/MTU range looks sane */
-	if (c->mru > MAX_MRU || c->mtu > MAX_MTU || c->mru < 8 || c->mtu < 8)
+	if (c->mru < MIN_MTU || c->mtu < MIN_MTU)
+		return -EINVAL;
+	if (c->mru > MAX_MRU || c->mtu > MAX_MTU)
 		return -EINVAL;
 	if (c->n2 > 255)
 		return -EINVAL;
@@ -3296,7 +3299,7 @@ static int gsm_create_network(struct gsm_dlci *dlci, struct gsm_netconfig *nc)
 		return -ENOMEM;
 	}
 	net->mtu = dlci->gsm->mtu;
-	net->min_mtu = 8;
+	net->min_mtu = MIN_MTU;
 	net->max_mtu = dlci->gsm->mtu;
 	mux_net = netdev_priv(net);
 	mux_net->dlci = dlci;
-- 
2.34.1

