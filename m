Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0527380F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjFUJZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjFUJY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:24:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262B81BE2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:24:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3112d202363so4084797f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339449; x=1689931449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSaqA2+LFEta6gdn/o/4wTZ/gzZyVMVxUFSu8tBDIgo=;
        b=PIgwGsjqRRBnD4wUED0zMgDd90izGj+VUDD9EgoqqxSaxj/EA/sixV9j0Puhbj6yvd
         i1Ac0Rlms2EVdNwTS5h1sPCi/JjPPAK6m66f+HEwmgOh8D8uZMrVbGn/biLYxZI+BECq
         XpkAWKQlObsxZ/I51tzMmRbncT39WnbXS+8nl9N5uTZhSuuTZfacrHmIfwjzyHlPZsKB
         aNAtUdSAbjgLFLrTvaE0GMxn4YiN0CZOBqxzkMr3lFGuEwx9aqn/Vg5a3G+9ZUchNjL+
         Yk0OrNCbOU/PGc9uO3FRpdu9urD98t0PRfv23kLIMGEvZ9KcdBruuqTU7Y9EsBjTkh72
         YvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339449; x=1689931449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSaqA2+LFEta6gdn/o/4wTZ/gzZyVMVxUFSu8tBDIgo=;
        b=dABOf8LN5Cx2iQe4rLEV8gfL4Ap8fKqoASnEcpq592Wna/pz7UOXOPkpq1X68YX9YK
         jpipeAJfK1sbw7uRyksoliF6jJqj6AZGZA4DNmMqOeeGpsgV9aC67XHS1ByLZi0TyG/o
         B+wI1FXWCZmFA++op5edA3DLHxiZS5l/agZBU7KjEyb72YfJCjjbGTxMbmIc9fQCA/0H
         t0s9P5EDi3jnNt1L1eCa/bI4GG5Wb5C+BV6E/V5IqVMF8k5/BdTL7K2q+KRqNe+WtWka
         gTH1SgPtXU6nKrPup1O6Si2uFtMOwWvYC+k5EEw9a32+U3ZRDO7Wige3emguTrv8whDg
         lioA==
X-Gm-Message-State: AC+VfDz1aCYqLGaUYWr+N4urb6GUeQQZq18R96J94H+9/BI6qyfiXmNL
        tpJWkB4yiCy/h6myJEvvPLnPaQ==
X-Google-Smtp-Source: ACHHUZ5eMijZ66B67qzvTYMfOslqJVRgfNlBhd2Q6VbMh1hl/bA8gcUR75BYlVUAvnnZHPXYM8lJ+Q==
X-Received: by 2002:adf:f203:0:b0:30f:ca58:39ca with SMTP id p3-20020adff203000000b0030fca5839camr11486248wro.31.1687339449246;
        Wed, 21 Jun 2023 02:24:09 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b002fda1b12a0bsm4022115wrs.2.2023.06.21.02.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:24:08 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v4 12/12] can: m_can: Implement transmit submission coalescing
Date:   Wed, 21 Jun 2023 11:23:50 +0200
Message-Id: <20230621092350.3130866-13-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621092350.3130866-1-msp@baylibre.com>
References: <20230621092350.3130866-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

m_can supports submitting multiple transmits with one register write.
This is an interesting option to reduce the number of SPI transfers for
peripheral chips.

The m_can_tx_op is extended with a bool that signals if it is the last
transmission and the submit should be executed immediately.

The worker then writes the skb to the FIFO and submits it only if the
submit bool is set. If it isn't set, the worker will write the next skb
which is waiting in the workqueue to the FIFO, etc.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---

Notes:
    Notes:
    - I ran into lost messages in the receive FIFO when using this
      implementation. I guess this only shows up with my test setup in
      loopback mode and maybe not enough CPU power.
    - I put this behind the tx-frames ethtool coalescing option as we do
      wait before submitting packages but it is something different than the
      tx-frames-irq option. I am not sure if this is the correct option,
      please let me know.

 drivers/net/can/m_can/m_can.c | 55 ++++++++++++++++++++++++++++++++---
 drivers/net/can/m_can/m_can.h |  6 ++++
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 62e275c87c29..50909b9c0e7c 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1515,6 +1515,9 @@ static int m_can_start(struct net_device *dev)
 	if (ret)
 		return ret;
 
+	netdev_queue_set_dql_min_limit(netdev_get_tx_queue(cdev->net, 0),
+				       cdev->tx_max_coalesced_frames);
+
 	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	m_can_enable_all_interrupts(cdev);
@@ -1812,8 +1815,13 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 		 */
 		can_put_echo_skb(skb, dev, putidx, frame_len);
 
-		/* Enable TX FIFO element to start transfer  */
-		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
+		if (cdev->is_peripheral) {
+			/* Delay enabling TX FIFO element */
+			cdev->tx_peripheral_submit |= BIT(putidx);
+		} else {
+			/* Enable TX FIFO element to start transfer  */
+			m_can_write(cdev, M_CAN_TXBAR, BIT(putidx));
+		}
 		cdev->tx_fifo_putidx = (++cdev->tx_fifo_putidx >= cdev->can.echo_skb_max ?
 					0 : cdev->tx_fifo_putidx);
 	}
@@ -1826,6 +1834,17 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 	return NETDEV_TX_BUSY;
 }
 
+static void m_can_tx_submit(struct m_can_classdev *cdev)
+{
+	if (cdev->version == 30)
+		return;
+	if (!cdev->is_peripheral)
+		return;
+
+	m_can_write(cdev, M_CAN_TXBAR, cdev->tx_peripheral_submit);
+	cdev->tx_peripheral_submit = 0;
+}
+
 static void m_can_tx_work_queue(struct work_struct *ws)
 {
 	struct m_can_tx_op *op = container_of(ws, struct m_can_tx_op, work);
@@ -1834,11 +1853,15 @@ static void m_can_tx_work_queue(struct work_struct *ws)
 
 	op->skb = NULL;
 	m_can_tx_handler(cdev, skb);
+	if (op->submit)
+		m_can_tx_submit(cdev);
 }
 
-static void m_can_tx_queue_skb(struct m_can_classdev *cdev, struct sk_buff *skb)
+static void m_can_tx_queue_skb(struct m_can_classdev *cdev, struct sk_buff *skb,
+			       bool submit)
 {
 	cdev->tx_ops[cdev->next_tx_op].skb = skb;
+	cdev->tx_ops[cdev->next_tx_op].submit = submit;
 	queue_work(cdev->tx_wq, &cdev->tx_ops[cdev->next_tx_op].work);
 
 	++cdev->next_tx_op;
@@ -1850,6 +1873,7 @@ static netdev_tx_t m_can_start_peripheral_xmit(struct m_can_classdev *cdev,
 					       struct sk_buff *skb)
 {
 	netdev_tx_t err;
+	bool submit;
 
 	if (cdev->can.state == CAN_STATE_BUS_OFF) {
 		m_can_clean(cdev->net);
@@ -1860,7 +1884,15 @@ static netdev_tx_t m_can_start_peripheral_xmit(struct m_can_classdev *cdev,
 	if (err != NETDEV_TX_OK)
 		return err;
 
-	m_can_tx_queue_skb(cdev, skb);
+	++cdev->nr_txs_without_submit;
+	if (cdev->nr_txs_without_submit >= cdev->tx_max_coalesced_frames ||
+	    !netdev_xmit_more()) {
+		cdev->nr_txs_without_submit = 0;
+		submit = true;
+	} else {
+		submit = false;
+	}
+	m_can_tx_queue_skb(cdev, skb, submit);
 
 	return NETDEV_TX_OK;
 }
@@ -1992,6 +2024,7 @@ static int m_can_get_coalesce(struct net_device *dev,
 
 	ec->rx_max_coalesced_frames_irq = cdev->rx_max_coalesced_frames_irq;
 	ec->rx_coalesce_usecs_irq = cdev->rx_coalesce_usecs_irq;
+	ec->tx_max_coalesced_frames = cdev->tx_max_coalesced_frames;
 	ec->tx_max_coalesced_frames_irq = cdev->tx_max_coalesced_frames_irq;
 	ec->tx_coalesce_usecs_irq = cdev->tx_coalesce_usecs_irq;
 
@@ -2036,6 +2069,18 @@ static int m_can_set_coalesce(struct net_device *dev,
 		netdev_err(dev, "tx-frames-irq and tx-usecs-irq can only be set together\n");
 		return -EINVAL;
 	}
+	if (ec->tx_max_coalesced_frames > cdev->mcfg[MRAM_TXE].num) {
+		netdev_err(dev, "tx-frames %u greater than the TX event FIFO %u\n",
+			   ec->tx_max_coalesced_frames,
+			   cdev->mcfg[MRAM_TXE].num);
+		return -EINVAL;
+	}
+	if (ec->tx_max_coalesced_frames > cdev->mcfg[MRAM_TXB].num) {
+		netdev_err(dev, "tx-frames %u greater than the TX FIFO %u\n",
+			   ec->tx_max_coalesced_frames,
+			   cdev->mcfg[MRAM_TXB].num);
+		return -EINVAL;
+	}
 	if (ec->rx_coalesce_usecs_irq != 0 && ec->tx_coalesce_usecs_irq != 0 &&
 	    ec->rx_coalesce_usecs_irq != ec->tx_coalesce_usecs_irq) {
 		netdev_err(dev, "rx-usecs-irq %u needs to be equal to tx-usecs-irq %u if both are enabled\n",
@@ -2046,6 +2091,7 @@ static int m_can_set_coalesce(struct net_device *dev,
 
 	cdev->rx_max_coalesced_frames_irq = ec->rx_max_coalesced_frames_irq;
 	cdev->rx_coalesce_usecs_irq = ec->rx_coalesce_usecs_irq;
+	cdev->tx_max_coalesced_frames = ec->tx_max_coalesced_frames;
 	cdev->tx_max_coalesced_frames_irq = ec->tx_max_coalesced_frames_irq;
 	cdev->tx_coalesce_usecs_irq = ec->tx_coalesce_usecs_irq;
 
@@ -2063,6 +2109,7 @@ static const struct ethtool_ops m_can_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
 		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
 		ETHTOOL_COALESCE_TX_USECS_IRQ |
+		ETHTOOL_COALESCE_TX_MAX_FRAMES |
 		ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
 	.get_ts_info = ethtool_op_get_ts_info,
 	.get_coalesce = m_can_get_coalesce,
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 5c182aece15c..54af26a94042 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -74,6 +74,7 @@ struct m_can_tx_op {
 	struct m_can_classdev *cdev;
 	struct work_struct work;
 	struct sk_buff *skb;
+	bool submit;
 };
 
 struct m_can_classdev {
@@ -103,6 +104,7 @@ struct m_can_classdev {
 	u32 active_interrupts;
 	u32 rx_max_coalesced_frames_irq;
 	u32 rx_coalesce_usecs_irq;
+	u32 tx_max_coalesced_frames;
 	u32 tx_max_coalesced_frames_irq;
 	u32 tx_coalesce_usecs_irq;
 
@@ -117,6 +119,10 @@ struct m_can_classdev {
 	int tx_fifo_size;
 	int next_tx_op;
 
+	int nr_txs_without_submit;
+	/* bitfield of fifo elements that will be submitted together */
+	u32 tx_peripheral_submit;
+
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 };
 
-- 
2.40.1

