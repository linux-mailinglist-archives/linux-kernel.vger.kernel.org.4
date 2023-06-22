Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD51673A165
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjFVNF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjFVNFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:05:25 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BEF10F8;
        Thu, 22 Jun 2023 06:05:23 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qCJzn-00D3El-Lw; Thu, 22 Jun 2023 14:05:08 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qCJzo-002XrN-0x;
        Thu, 22 Jun 2023 14:05:08 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, claudiu.beznea@microchip.com,
        nicolas.ferre@microchip.com, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 3/3] net: macb: fix __be32 warnings in debug code
Date:   Thu, 22 Jun 2023 14:05:07 +0100
Message-Id: <20230622130507.606713-4-ben.dooks@codethink.co.uk>
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

The netdev_dbg() calls in gem_add_flow_filter() and gem_del_flow_filter()
call ntohl() on the ipv4 addresses, which will put them into the host order
but not the right type (returns a __be32, not an u32 as would be expected).

Chaning the htonl() to nthol() should still do the right conversion, return
the correct u32 type and  should not change any functional to remove the
following sparse warnings:

drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: incorrect type in argument 1 (different base types)
drivers/net/ethernet/cadence/macb_main.c:3568:9:    expected unsigned int [usertype] val
drivers/net/ethernet/cadence/macb_main.c:3568:9:    got restricted __be32 [usertype] ip4src
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: incorrect type in argument 1 (different base types)
drivers/net/ethernet/cadence/macb_main.c:3568:9:    expected unsigned int [usertype] val
drivers/net/ethernet/cadence/macb_main.c:3568:9:    got restricted __be32 [usertype] ip4dst
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
d
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: incorrect type in argument 1 (different base types)
drivers/net/ethernet/cadence/macb_main.c:3622:25:    expected unsigned int [usertype] val
drivers/net/ethernet/cadence/macb_main.c:3622:25:    got restricted __be32 [usertype] ip4src
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: incorrect type in argument 1 (different base types)
drivers/net/ethernet/cadence/macb_main.c:3622:25:    expected unsigned int [usertype] val
drivers/net/ethernet/cadence/macb_main.c:3622:25:    got restricted __be32 [usertype] ip4dst
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/ethernet/cadence/macb_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 56e202b74bd7..59a90c2b307f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3568,8 +3568,8 @@ static int gem_add_flow_filter(struct net_device *netdev,
 	netdev_dbg(netdev,
 			"Adding flow filter entry,type=%u,queue=%u,loc=%u,src=%08X,dst=%08X,ps=%u,pd=%u\n",
 			fs->flow_type, (int)fs->ring_cookie, fs->location,
-			htonl(fs->h_u.tcp_ip4_spec.ip4src),
-			htonl(fs->h_u.tcp_ip4_spec.ip4dst),
+			ntohl(fs->h_u.tcp_ip4_spec.ip4src),
+			ntohl(fs->h_u.tcp_ip4_spec.ip4dst),
 			be16_to_cpu(fs->h_u.tcp_ip4_spec.psrc),
 			be16_to_cpu(fs->h_u.tcp_ip4_spec.pdst));
 
@@ -3622,8 +3622,8 @@ static int gem_del_flow_filter(struct net_device *netdev,
 			netdev_dbg(netdev,
 					"Deleting flow filter entry,type=%u,queue=%u,loc=%u,src=%08X,dst=%08X,ps=%u,pd=%u\n",
 					fs->flow_type, (int)fs->ring_cookie, fs->location,
-					htonl(fs->h_u.tcp_ip4_spec.ip4src),
-					htonl(fs->h_u.tcp_ip4_spec.ip4dst),
+					ntohl(fs->h_u.tcp_ip4_spec.ip4src),
+					ntohl(fs->h_u.tcp_ip4_spec.ip4dst),
 					be16_to_cpu(fs->h_u.tcp_ip4_spec.psrc),
 					be16_to_cpu(fs->h_u.tcp_ip4_spec.pdst));
 
-- 
2.40.1

