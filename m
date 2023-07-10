Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639E274CD42
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjGJGkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjGJGkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:40:36 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5AF768E;
        Sun,  9 Jul 2023 23:40:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 49965602B2DC6;
        Mon, 10 Jul 2023 14:40:32 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     mostrows@earthlink.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, xeb@mail.ru
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, wuych <yunchuan@nfschina.com>
Subject: [PATCH net-next v2 03/10] net: ppp: Remove unnecessary (void*) conversions
Date:   Mon, 10 Jul 2023 14:40:27 +0800
Message-Id: <20230710064027.173298-1-suhui@nfschina.com>
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
 drivers/net/ppp/pppoe.c | 4 ++--
 drivers/net/ppp/pptp.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 3b79c603b936..ba8b6bd8233c 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -968,7 +968,7 @@ static int __pppoe_xmit(struct sock *sk, struct sk_buff *skb)
  ***********************************************************************/
 static int pppoe_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 {
-	struct sock *sk = (struct sock *)chan->private;
+	struct sock *sk = chan->private;
 	return __pppoe_xmit(sk, skb);
 }
 
@@ -976,7 +976,7 @@ static int pppoe_fill_forward_path(struct net_device_path_ctx *ctx,
 				   struct net_device_path *path,
 				   const struct ppp_channel *chan)
 {
-	struct sock *sk = (struct sock *)chan->private;
+	struct sock *sk = chan->private;
 	struct pppox_sock *po = pppox_sk(sk);
 	struct net_device *dev = po->pppoe_dev;
 
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 32183f24e63f..6b3d3df99549 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -148,7 +148,7 @@ static struct rtable *pptp_route_output(struct pppox_sock *po,
 
 static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 {
-	struct sock *sk = (struct sock *) chan->private;
+	struct sock *sk = chan->private;
 	struct pppox_sock *po = pppox_sk(sk);
 	struct net *net = sock_net(sk);
 	struct pptp_opt *opt = &po->proto.pptp;
@@ -575,7 +575,7 @@ static int pptp_create(struct net *net, struct socket *sock, int kern)
 static int pptp_ppp_ioctl(struct ppp_channel *chan, unsigned int cmd,
 	unsigned long arg)
 {
-	struct sock *sk = (struct sock *) chan->private;
+	struct sock *sk = chan->private;
 	struct pppox_sock *po = pppox_sk(sk);
 	struct pptp_opt *opt = &po->proto.pptp;
 	void __user *argp = (void __user *)arg;
-- 
2.30.2

