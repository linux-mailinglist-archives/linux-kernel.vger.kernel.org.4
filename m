Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC2705D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjEQC2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjEQC2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:28:08 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 34CF5469E;
        Tue, 16 May 2023 19:27:46 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 9CD0B180120CAB;
        Wed, 17 May 2023 10:27:06 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   wuych <yunchuan@nfschina.com>
To:     rmody@marvell.com, skalluru@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, wuych <yunchuan@nfschina.com>
Subject: [PATCH net-next] net: bna: bnad:  Remove unnecessary (void*) conversions
Date:   Wed, 17 May 2023 10:27:05 +0800
Message-Id: <20230517022705.112448-1-yunchuan@nfschina.com>
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

Pointer variables of void * type do not require type cast.

Signed-off-by: wuych <yunchuan@nfschina.com>
---
 drivers/net/ethernet/brocade/bna/bnad.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index d6d90f9722a7..31191b520b58 100644
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
 
@@ -1149,7 +1148,7 @@ bnad_cb_tx_cleanup(struct bnad *bnad, struct bna_tx *tx)
 static void
 bnad_cb_rx_stall(struct bnad *bnad, struct bna_rx *rx)
 {
-	struct bnad_rx_info *rx_info = (struct bnad_rx_info *)rx->priv;
+	struct bnad_rx_info *rx_info = rx->priv;
 	struct bna_ccb *ccb;
 	struct bnad_rx_ctrl *rx_ctrl;
 	int i;
@@ -1208,7 +1207,7 @@ bnad_rx_cleanup(void *work)
 static void
 bnad_cb_rx_cleanup(struct bnad *bnad, struct bna_rx *rx)
 {
-	struct bnad_rx_info *rx_info = (struct bnad_rx_info *)rx->priv;
+	struct bnad_rx_info *rx_info = rx->priv;
 	struct bna_ccb *ccb;
 	struct bnad_rx_ctrl *rx_ctrl;
 	int i;
@@ -1231,7 +1230,7 @@ bnad_cb_rx_cleanup(struct bnad *bnad, struct bna_rx *rx)
 static void
 bnad_cb_rx_post(struct bnad *bnad, struct bna_rx *rx)
 {
-	struct bnad_rx_info *rx_info = (struct bnad_rx_info *)rx->priv;
+	struct bnad_rx_info *rx_info = rx->priv;
 	struct bna_ccb *ccb;
 	struct bna_rcb *rcb;
 	struct bnad_rx_ctrl *rx_ctrl;
-- 
2.30.2

