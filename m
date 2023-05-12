Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5449F6FFF0A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 04:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbjELCoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 22:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjELCoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 22:44:11 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CC2CF55A2;
        Thu, 11 May 2023 19:44:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id B0960180028342;
        Fri, 12 May 2023 10:44:05 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   wuych <yunchuan@nfschina.com>
To:     dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, wuych <yunchuan@nfschina.com>
Subject: [PATCH net-next] net: liquidio: lio_main: Remove unnecessary (void*) conversions
Date:   Fri, 12 May 2023 10:44:03 +0800
Message-Id: <20230512024403.691018-1-yunchuan@nfschina.com>
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
 .../net/ethernet/cavium/liquidio/lio_main.c    | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 9bd1d2d7027d..100daadbea2a 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -191,8 +191,7 @@ static void octeon_droq_bh(struct tasklet_struct *t)
 
 static int lio_wait_for_oq_pkts(struct octeon_device *oct)
 {
-	struct octeon_device_priv *oct_priv =
-		(struct octeon_device_priv *)oct->priv;
+	struct octeon_device_priv *oct_priv = oct->priv;
 	int retry = 100, pkt_cnt = 0, pending_pkts = 0;
 	int i;
 
@@ -950,8 +949,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 {
 	int i, refcount;
 	struct msix_entry *msix_entries;
-	struct octeon_device_priv *oct_priv =
-		(struct octeon_device_priv *)oct->priv;
+	struct octeon_device_priv *oct_priv = oct->priv;
 
 	struct handshake *hs;
 
@@ -1211,8 +1209,7 @@ static int send_rx_ctrl_cmd(struct lio *lio, int start_stop)
 static void liquidio_destroy_nic_device(struct octeon_device *oct, int ifidx)
 {
 	struct net_device *netdev = oct->props[ifidx].netdev;
-	struct octeon_device_priv *oct_priv =
-		(struct octeon_device_priv *)oct->priv;
+	struct octeon_device_priv *oct_priv = oct->priv;
 	struct napi_struct *napi, *n;
 	struct lio *lio;
 
@@ -1774,8 +1771,7 @@ static int liquidio_open(struct net_device *netdev)
 {
 	struct lio *lio = GET_LIO(netdev);
 	struct octeon_device *oct = lio->oct_dev;
-	struct octeon_device_priv *oct_priv =
-		(struct octeon_device_priv *)oct->priv;
+	struct octeon_device_priv *oct_priv = oct->priv;
 	struct napi_struct *napi, *n;
 	int ret = 0;
 
@@ -1855,8 +1851,7 @@ static int liquidio_stop(struct net_device *netdev)
 {
 	struct lio *lio = GET_LIO(netdev);
 	struct octeon_device *oct = lio->oct_dev;
-	struct octeon_device_priv *oct_priv =
-		(struct octeon_device_priv *)oct->priv;
+	struct octeon_device_priv *oct_priv = oct->priv;
 	struct napi_struct *napi, *n;
 	int ret = 0;
 
@@ -4057,8 +4052,7 @@ static int octeon_device_init(struct octeon_device *octeon_dev)
 	char bootcmd[] = "\n";
 	char *dbg_enb = NULL;
 	enum lio_fw_state fw_state;
-	struct octeon_device_priv *oct_priv =
-		(struct octeon_device_priv *)octeon_dev->priv;
+	struct octeon_device_priv *oct_priv = octeon_dev->priv;
 	atomic_set(&octeon_dev->status, OCT_DEV_BEGIN_STATE);
 
 	/* Enable access to the octeon device and make its DMA capability
-- 
2.30.2

