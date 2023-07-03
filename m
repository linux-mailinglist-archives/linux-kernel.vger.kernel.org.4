Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB991745385
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 03:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjGCB1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 21:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGCB1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 21:27:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE1A12E;
        Sun,  2 Jul 2023 18:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9802460CA5;
        Mon,  3 Jul 2023 01:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B2EC433C8;
        Mon,  3 Jul 2023 01:27:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mJm14A4X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1688347659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vuxOFbTAgQkfyy8cx4BstQShC0WcmX6WYAC5dTJO6NQ=;
        b=mJm14A4X2IsfgDgOG6ef2FcJixwMOAbINoDyQcvFS8mDN0nTop7I2IX7axXm0Pt9myPUEL
        k6eROId1VosI8tJJOeqnjVG8JJhAPLiAE9Rj1tlFssS0drTu5Ce3xqrHXA1aa7DJrNtNa0
        wFXvp9N9x7xq6axp12qHVbz8Ke48geM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 303a1b42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 3 Jul 2023 01:27:39 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Manuel Leiner <manuel.leiner@gmx.de>
Subject: [PATCH net 1/3] wireguard: queueing: use saner cpu selection wrapping
Date:   Mon,  3 Jul 2023 03:27:04 +0200
Message-ID: <20230703012723.800199-2-Jason@zx2c4.com>
In-Reply-To: <20230703012723.800199-1-Jason@zx2c4.com>
References: <20230703012723.800199-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using `% nr_cpumask_bits` is slow and complicated, and not totally
robust toward dynamic changes to CPU topologies. Rather than storing the
next CPU in the round-robin, just store the last one, and also return
that value. This simplifies the loop drastically into a much more common
pattern.

Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Cc: stable@vger.kernel.org
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Manuel Leiner <manuel.leiner@gmx.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/queueing.c |  1 +
 drivers/net/wireguard/queueing.h | 25 +++++++++++--------------
 drivers/net/wireguard/receive.c  |  2 +-
 drivers/net/wireguard/send.c     |  2 +-
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireguard/queueing.c b/drivers/net/wireguard/queueing.c
index 8084e7408c0a..26d235d15235 100644
--- a/drivers/net/wireguard/queueing.c
+++ b/drivers/net/wireguard/queueing.c
@@ -28,6 +28,7 @@ int wg_packet_queue_init(struct crypt_queue *queue, work_func_t function,
 	int ret;
 
 	memset(queue, 0, sizeof(*queue));
+	queue->last_cpu = -1;
 	ret = ptr_ring_init(&queue->ring, len, GFP_KERNEL);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 125284b346a7..1ea4f874e367 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -117,20 +117,17 @@ static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
 	return cpu;
 }
 
-/* This function is racy, in the sense that next is unlocked, so it could return
- * the same CPU twice. A race-free version of this would be to instead store an
- * atomic sequence number, do an increment-and-return, and then iterate through
- * every possible CPU until we get to that index -- choose_cpu. However that's
- * a bit slower, and it doesn't seem like this potential race actually
- * introduces any performance loss, so we live with it.
+/* This function is racy, in the sense that it's called while last_cpu is
+ * unlocked, so it could return the same CPU twice. Adding locking or using
+ * atomic sequence numbers is slower though, and the consequences of racing are
+ * harmless, so live with it.
  */
-static inline int wg_cpumask_next_online(int *next)
+static inline int wg_cpumask_next_online(int *last_cpu)
 {
-	int cpu = *next;
-
-	while (unlikely(!cpumask_test_cpu(cpu, cpu_online_mask)))
-		cpu = cpumask_next(cpu, cpu_online_mask) % nr_cpumask_bits;
-	*next = cpumask_next(cpu, cpu_online_mask) % nr_cpumask_bits;
+	int cpu = cpumask_next(*last_cpu, cpu_online_mask);
+	if (cpu >= nr_cpu_ids)
+		cpu = cpumask_first(cpu_online_mask);
+	*last_cpu = cpu;
 	return cpu;
 }
 
@@ -159,7 +156,7 @@ static inline void wg_prev_queue_drop_peeked(struct prev_queue *queue)
 
 static inline int wg_queue_enqueue_per_device_and_peer(
 	struct crypt_queue *device_queue, struct prev_queue *peer_queue,
-	struct sk_buff *skb, struct workqueue_struct *wq, int *next_cpu)
+	struct sk_buff *skb, struct workqueue_struct *wq)
 {
 	int cpu;
 
@@ -173,7 +170,7 @@ static inline int wg_queue_enqueue_per_device_and_peer(
 	/* Then we queue it up in the device queue, which consumes the
 	 * packet as soon as it can.
 	 */
-	cpu = wg_cpumask_next_online(next_cpu);
+	cpu = wg_cpumask_next_online(&device_queue->last_cpu);
 	if (unlikely(ptr_ring_produce_bh(&device_queue->ring, skb)))
 		return -EPIPE;
 	queue_work_on(cpu, wq, &per_cpu_ptr(device_queue->worker, cpu)->work);
diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
index 7135d51d2d87..0b3f0c843550 100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -524,7 +524,7 @@ static void wg_packet_consume_data(struct wg_device *wg, struct sk_buff *skb)
 		goto err;
 
 	ret = wg_queue_enqueue_per_device_and_peer(&wg->decrypt_queue, &peer->rx_queue, skb,
-						   wg->packet_crypt_wq, &wg->decrypt_queue.last_cpu);
+						   wg->packet_crypt_wq);
 	if (unlikely(ret == -EPIPE))
 		wg_queue_enqueue_per_peer_rx(skb, PACKET_STATE_DEAD);
 	if (likely(!ret || ret == -EPIPE)) {
diff --git a/drivers/net/wireguard/send.c b/drivers/net/wireguard/send.c
index 5368f7c35b4b..95c853b59e1d 100644
--- a/drivers/net/wireguard/send.c
+++ b/drivers/net/wireguard/send.c
@@ -318,7 +318,7 @@ static void wg_packet_create_data(struct wg_peer *peer, struct sk_buff *first)
 		goto err;
 
 	ret = wg_queue_enqueue_per_device_and_peer(&wg->encrypt_queue, &peer->tx_queue, first,
-						   wg->packet_crypt_wq, &wg->encrypt_queue.last_cpu);
+						   wg->packet_crypt_wq);
 	if (unlikely(ret == -EPIPE))
 		wg_queue_enqueue_per_peer_tx(first, PACKET_STATE_DEAD);
 err:
-- 
2.41.0

