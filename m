Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814B473B02A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjFWFj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFWFjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:39:48 -0400
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913DE1A4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1687498782;
        bh=NDFiwj2jmnIltHpVBQdpLmWhqFLwjPdlk5qSTa6ONks=;
        h=From:To:Cc:Subject:Date;
        b=KbcBfqpzkI+OH1meha/++gUwKhibpeblZ4vmivRENr15Z5cG2JEUvhDSSsytAadsu
         sKEwDBSuo+Q0mdsEMvnNAwVA3aeCJoa1xILQ+Rb1X6pnXFKJGSlGRfYG9xowbmTOB9
         Zi1U4uvXd9DFjYy9O5FSjqpSECCX5cbo6x6t1xeE=
Received: from localhost.localdomain ([122.14.229.248])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 9E7042E7; Fri, 23 Jun 2023 13:39:39 +0800
X-QQ-mid: xmsmtpt1687498779t9pdo2mqh
Message-ID: <tencent_3B3D24B66ED66A6BB73CC0E63C6A14E45109@qq.com>
X-QQ-XMAILINFO: M0PjjqbLT90wUvlVOqntVEtkil74jGwBvxgJe2fQVtjXbypDeJWI8jCgYSFeh7
         0U4ZBin3+OK1JVC06M+Wm4I4BuJGdJx8NKskaGBXmfqSz1zfgicJYCx0c021ykZr2u0ssl4LTIci
         PZFA7jqARgi4++2aTlMVCUHgO3ODOVKtE4H25OGPa/+wgIAZlbRH1JaG29hzuURr0hLdY36qVLQn
         c2K7C5JhVdkSjlGO3TKBAeyFHjTvENtzKc6ZlsdxiH2tjkSGgc/55jTV6+1whV+pIjnOlPpKJVv0
         tlT7BZdOW4Hr9LJaM6P/+uF2ZrO8FjGfFg8Xs/jZqK7VR2yinRGtZySiqD2A/HAcKV9ba+56LuiD
         T5Q3COUSbdfTg2SogDpUZA60lZu1YMHPLPKdG81FM5h3EU/9p5PWYfzzX55Gf+a706PjwO+8upk1
         cQmpJsmKMo2uQUcffwK9jdMVHU23IP9ji4ZIgmmgn+dRKgTaR05fsE1Z+zPt0Wj1RxedPajP8Fud
         l2TDQiUCMA1qiuW7+bYnhWbPX+z1o+05CMJXROWCYv51Wmx9x+ojrzD3TVckZOffsnf9++GEFdZn
         6xveQt5aQM+ORILiUDM62tucyv48DjpS9Ly6ZZh955SMn7gyFPbCezmrB07+KyM/dXF3XDdlaLVs
         fPJGJ2/I96MIf66EM23VqWXp6hHC9L/vwmf9zpsuACdYFdZDtCR7guTQn4l6/EcJP9E/i2lejzPW
         GBr+3p5DRigqoQ721AefloZRitqSG+StWewFrSinIefjhJ5/K0eJR05kf0Ix/aInjLKUMWPGKTTd
         W5feUVnDpmQn6X1pM9NUi9mwDlE7QidAiEZVvbu0qPv4h4stVCVklCu3dSmVdn5w5ipYH68o3o9p
         Nzk/8Uo/enYeUZCfiywl0P8gRHsv+a8yAXE1dukTHSlPUN8PKhZfKur4kcIu+m3TX2O+jZWnkxzJ
         pIibPgAMJyYoEEYt9LIQ9pX3PKS4nedIejddIf+PeGo0Rl5gcLFO2UHVmf0lcW
X-QQ-XMRINFO: Mu10XATLq/IERfXGovp1cJndKWH8Kl+aSQ==
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     o-takashi@sakamocchi.jp
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] firewire: net: fix use after free in fwnet_finish_incoming_packet()
Date:   Fri, 23 Jun 2023 13:39:35 +0800
X-OQ-MSGID: <20230623053935.4192-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The netif_rx() function frees the skb so we can't dereference it to
save the skb->len.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/firewire/net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index 538bd677c254..7a4d1a478e33 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -479,7 +479,7 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 					struct sk_buff *skb, u16 source_node_id,
 					bool is_broadcast, u16 ether_type)
 {
-	int status;
+	int status, len;
 
 	switch (ether_type) {
 	case ETH_P_ARP:
@@ -533,13 +533,15 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 		}
 		skb->protocol = protocol;
 	}
+
+	len = skb->len;
 	status = netif_rx(skb);
 	if (status == NET_RX_DROP) {
 		net->stats.rx_errors++;
 		net->stats.rx_dropped++;
 	} else {
 		net->stats.rx_packets++;
-		net->stats.rx_bytes += skb->len;
+		net->stats.rx_bytes += len;
 	}
 
 	return 0;
-- 
2.41.0

