Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA52A74CD5C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjGJGmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjGJGmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:42:00 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 154B419F;
        Sun,  9 Jul 2023 23:41:53 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 27793602A8713;
        Mon, 10 Jul 2023 14:41:51 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     rmody@marvell.com, skalluru@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, wuych <yunchuan@nfschina.com>
Subject: [PATCH net-next v2 10/10] net: bna: Remove unnecessary (void*) conversions
Date:   Mon, 10 Jul 2023 14:41:48 +0800
Message-Id: <20230710064148.174011-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wuych <yunchuan@nfschina.com>

Pointer variables of void * type do not require type cast.

Signed-off-by: wuych <yunchuan@nfschina.com>
---
 drivers/net/ethernet/brocade/bna/bnad.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index d6d90f9722a7..fb2bef54d104 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -1037,8 +1037,7 @@ bnad_cb_ccb_destroy(struct bnad *bnad, struct bna_ccb *ccb)
 static void
 bnad_cb_tx_stall(struct bnad *bnad, struct bna_tx *tx)
 {
-	struct bnad_tx_info *tx_info =
-			(struct bnad_tx_info *)tx->priv;
+	struct bnad_tx_info *tx_info = tx->priv;
 	struct bna_tcb *tcb;
 	u32 txq_id;
 	int i;
@@ -1056,7 +1055,7 @@ bnad_cb_tx_stall(struct bnad *bnad, struct bna_tx *tx)
 static void
 bnad_cb_tx_resume(struct bnad *bnad, struct bna_tx *tx)
 {
-	struct bnad_tx_info *tx_info = (struct bnad_tx_info *)tx->priv;
+	struct bnad_tx_info *tx_info = tx->priv;
 	struct bna_tcb *tcb;
 	u32 txq_id;
 	int i;
@@ -1133,7 +1132,7 @@ bnad_tx_cleanup(struct delayed_work *work)
 static void
 bnad_cb_tx_cleanup(struct bnad *bnad, struct bna_tx *tx)
 {
-	struct bnad_tx_info *tx_info = (struct bnad_tx_info *)tx->priv;
+	struct bnad_tx_info *tx_info = tx->priv;
 	struct bna_tcb *tcb;
 	int i;
 
@@ -1149,9 +1148,9 @@ bnad_cb_tx_cleanup(struct bnad *bnad, struct bna_tx *tx)
 static void
 bnad_cb_rx_stall(struct bnad *bnad, struct bna_rx *rx)
 {
-	struct bnad_rx_info *rx_info = (struct bnad_rx_info *)rx->priv;
-	struct bna_ccb *ccb;
+	struct bnad_rx_info *rx_info = rx->priv;
 	struct bnad_rx_ctrl *rx_ctrl;
+	struct bna_ccb *ccb;
 	int i;
 
 	for (i = 0; i < BNAD_MAX_RXP_PER_RX; i++) {
@@ -1208,9 +1207,9 @@ bnad_rx_cleanup(void *work)
 static void
 bnad_cb_rx_cleanup(struct bnad *bnad, struct bna_rx *rx)
 {
-	struct bnad_rx_info *rx_info = (struct bnad_rx_info *)rx->priv;
-	struct bna_ccb *ccb;
+	struct bnad_rx_info *rx_info = rx->priv;
 	struct bnad_rx_ctrl *rx_ctrl;
+	struct bna_ccb *ccb;
 	int i;
 
 	for (i = 0; i < BNAD_MAX_RXP_PER_RX; i++) {
@@ -1231,10 +1230,10 @@ bnad_cb_rx_cleanup(struct bnad *bnad, struct bna_rx *rx)
 static void
 bnad_cb_rx_post(struct bnad *bnad, struct bna_rx *rx)
 {
-	struct bnad_rx_info *rx_info = (struct bnad_rx_info *)rx->priv;
+	struct bnad_rx_info *rx_info = rx->priv;
+	struct bnad_rx_ctrl *rx_ctrl;
 	struct bna_ccb *ccb;
 	struct bna_rcb *rcb;
-	struct bnad_rx_ctrl *rx_ctrl;
 	int i, j;
 
 	for (i = 0; i < BNAD_MAX_RXP_PER_RX; i++) {
-- 
2.30.2

