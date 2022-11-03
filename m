Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEED6179B9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiKCJV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKCJVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:21:18 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 02:21:15 PDT
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30062DEAD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:21:15 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2022110309200924e90a3c9e57b9dbd6
        for <linux-kernel@vger.kernel.org>;
        Thu, 03 Nov 2022 10:20:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ymHU3X/qr6+q1iY2LysQF2vzhHX/JM5cmkF/ZciRuKw=;
 b=m3Y1LgnTK9GD/M6e5Eesa6/4c5nbgngUeunmNE09fE8Jngw2IcNfHQOIwiOQjzdM+DF0Q/
 oWKAxlzd5ix83MOzbIGM18o4xWGek2qQp6GXbS5y5DBPuXB1mP5T/Pey+OH7RCxWCy2aVoUj
 +GACObHy4uk5QZ0zWvqC8kmm+Hwjc=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 1/3] tty: n_gsm: introduce macro for minimal unit size
Date:   Thu,  3 Nov 2022 10:17:41 +0100
Message-Id: <20221103091743.2119-1-daniel.starke@siemens.com>
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

v2 -> v3:
No changes.

Link: https://lore.kernel.org/all/20221024130114.2070-1-daniel.starke@siemens.com/

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

