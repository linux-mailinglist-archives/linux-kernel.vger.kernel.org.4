Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5208373A167
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjFVNFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjFVNF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:05:26 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4796D1BD0;
        Thu, 22 Jun 2023 06:05:25 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qCJzn-00D3Ej-K7; Thu, 22 Jun 2023 14:05:08 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qCJzo-002XrD-0q;
        Thu, 22 Jun 2023 14:05:08 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, claudiu.beznea@microchip.com,
        nicolas.ferre@microchip.com, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/3] net: macb: check constant to define and fix __be32 warnings
Date:   Thu, 22 Jun 2023 14:05:05 +0100
Message-Id: <20230622130507.606713-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
References: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checks on ipv4 addresses in the filtering code check against
a constant of 0xFFFFFFFF, so replace it with MACB_IPV4_MASK and
then make sure it is of __be32 type to avoid the following
sparse warnigns:

drivers/net/ethernet/cadence/macb_main.c:3448:39: warning: restricted __be32 degrades to integer
drivers/net/ethernet/cadence/macb_main.c:3453:39: warning: restricted __be32 degrades to integer
drivers/net/ethernet/cadence/macb_main.c:3483:20: warning: restricted __be32 degrades to integer
drivers/net/ethernet/cadence/macb_main.c:3497:20: warning: restricted __be32 degrades to integer

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/ethernet/cadence/macb_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f20ec0d5260b..538d4c7e023b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3418,6 +3418,8 @@ static int macb_get_ts_info(struct net_device *netdev,
 	return ethtool_op_get_ts_info(netdev, info);
 }
 
+#define MACB_IPV4_MASK htonl(0xFFFFFFFF)
+
 static void gem_enable_flow_filters(struct macb *bp, bool enable)
 {
 	struct net_device *netdev = bp->dev;
@@ -3445,12 +3447,12 @@ static void gem_enable_flow_filters(struct macb *bp, bool enable)
 		/* only enable fields with no masking */
 		tp4sp_m = &(fs->m_u.tcp_ip4_spec);
 
-		if (enable && (tp4sp_m->ip4src == 0xFFFFFFFF))
+		if (enable && (tp4sp_m->ip4src == MACB_IPV4_MASK))
 			t2_scr = GEM_BFINS(CMPAEN, 1, t2_scr);
 		else
 			t2_scr = GEM_BFINS(CMPAEN, 0, t2_scr);
 
-		if (enable && (tp4sp_m->ip4dst == 0xFFFFFFFF))
+		if (enable && (tp4sp_m->ip4dst == MACB_IPV4_MASK))
 			t2_scr = GEM_BFINS(CMPBEN, 1, t2_scr);
 		else
 			t2_scr = GEM_BFINS(CMPBEN, 0, t2_scr);
@@ -3480,7 +3482,7 @@ static void gem_prog_cmp_regs(struct macb *bp, struct ethtool_rx_flow_spec *fs)
 	tp4sp_m = &(fs->m_u.tcp_ip4_spec);
 
 	/* ignore field if any masking set */
-	if (tp4sp_m->ip4src == 0xFFFFFFFF) {
+	if (tp4sp_m->ip4src == MACB_IPV4_MASK) {
 		/* 1st compare reg - IP source address */
 		w0 = 0;
 		w1 = 0;
@@ -3494,7 +3496,7 @@ static void gem_prog_cmp_regs(struct macb *bp, struct ethtool_rx_flow_spec *fs)
 	}
 
 	/* ignore field if any masking set */
-	if (tp4sp_m->ip4dst == 0xFFFFFFFF) {
+	if (tp4sp_m->ip4dst == MACB_IPV4_MASK) {
 		/* 2nd compare reg - IP destination address */
 		w0 = 0;
 		w1 = 0;
-- 
2.40.1

