Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990DA73801F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjFUJY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjFUJYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:24:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFA11BE1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:23:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f9bff0a543so3543865e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339437; x=1689931437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IztrjGfMix5tskQ3YAq+GbppbknMQpNbHYwT+eFcuyg=;
        b=SSp73YYGJCLinA3gBiXji4iBZRTLr1zODBJib8/+eDTd0p8hHxbpzpM4rDaJTwBI2q
         wUXpB2ygTtS94+2COr8bDgaPanKW63gfCFh8/wUg0IxDRX1gjlJZwbSnb626jiDo8gaf
         VUzhtMUnB8UGGPKQD3cV5kEMtsMlUPtg+ydQr0DRUnOOT6d7kEAyuEs36aMiVDVXMVS5
         M8SpQtwBxKw/HIZpqdgdixsdKHnbZpzrVMsyD4tJC0Ooaked6WlOqngC6HkK5U1rDriR
         hW+86VycgFP9UpOLwPDHBfgK4bxIvKl52rvFKyjT9maD01ncc+frQmQ2c4O8C5GI+GyG
         LzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339437; x=1689931437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IztrjGfMix5tskQ3YAq+GbppbknMQpNbHYwT+eFcuyg=;
        b=GA1NwqxU6+4FB5hM8JgolgRj3fILOct5WidEeds770Ygo4FmxqkZTq95vzNwSMgE5j
         2UICcQX6psY0Sdn0zXJyYHq7R52LchanMJyngcv/PAqKyeVi2GZYYQCaP+brk1a9iEPD
         2j/X36YrXOU5ujlCVPIhze8oRgcTpTnP/PPCjKgt6xMdaPAqPbBbDGFhTaEz4jkve+JW
         11Nc7GaUi08RGYwu8L4dbc3SHjqYKXyrbwD/P4/JYY5S6Q6x4CppYqjM4FEItCTLwaVD
         xKW5suGH8gycwhK5AkB+6wTQ5gZgoHjB4gCOMHHaMi3HdWIbeYpC2PYIB1LJPIznnVcb
         9FJQ==
X-Gm-Message-State: AC+VfDwUqLFziO0kdhhRCcL/nOsG5nhz6f+6xB60SPCxMA94gV7uYTIm
        RnmWN/+3MOricmk30+nXpc8AnQ==
X-Google-Smtp-Source: ACHHUZ7Vo13JGDVZQSjULWo0WPguFw67QsOvIqSW0HuJYblfXvkL1s9M7ZcAEi86X/sdw/NPQyzlbQ==
X-Received: by 2002:a7b:c405:0:b0:3f9:b1c5:ece0 with SMTP id k5-20020a7bc405000000b003f9b1c5ece0mr5500353wmi.10.1687339437046;
        Wed, 21 Jun 2023 02:23:57 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b002fda1b12a0bsm4022115wrs.2.2023.06.21.02.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:23:56 -0700 (PDT)
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
Subject: [PATCH v4 01/12] can: m_can: Write transmit header and data in one transaction
Date:   Wed, 21 Jun 2023 11:23:39 +0200
Message-Id: <20230621092350.3130866-2-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621092350.3130866-1-msp@baylibre.com>
References: <20230621092350.3130866-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine header and data before writing to the transmit fifo to reduce
the overhead for peripheral chips.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a5003435802b..5251073987ee 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -317,6 +317,12 @@ struct id_and_dlc {
 	u32 dlc;
 };
 
+struct m_can_fifo_element {
+	u32 id;
+	u32 dlc;
+	u8 data[CANFD_MAX_DLEN];
+};
+
 static inline u32 m_can_read(struct m_can_classdev *cdev, enum m_can_reg reg)
 {
 	return cdev->ops->read_reg(cdev, reg);
@@ -1622,6 +1628,8 @@ static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
 static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 {
 	struct canfd_frame *cf = (struct canfd_frame *)cdev->tx_skb->data;
+	u8 len_padded = DIV_ROUND_UP(cf->len, 4);
+	struct m_can_fifo_element fifo_element;
 	struct net_device *dev = cdev->net;
 	struct sk_buff *skb = cdev->tx_skb;
 	struct id_and_dlc fifo_header;
@@ -1635,27 +1643,27 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	/* Generate ID field for TX buffer Element */
 	/* Common to all supported M_CAN versions */
 	if (cf->can_id & CAN_EFF_FLAG) {
-		fifo_header.id = cf->can_id & CAN_EFF_MASK;
-		fifo_header.id |= TX_BUF_XTD;
+		fifo_element.id = cf->can_id & CAN_EFF_MASK;
+		fifo_element.id |= TX_BUF_XTD;
 	} else {
-		fifo_header.id = ((cf->can_id & CAN_SFF_MASK) << 18);
+		fifo_element.id = ((cf->can_id & CAN_SFF_MASK) << 18);
 	}
 
 	if (cf->can_id & CAN_RTR_FLAG)
-		fifo_header.id |= TX_BUF_RTR;
+		fifo_element.id |= TX_BUF_RTR;
 
 	if (cdev->version == 30) {
 		netif_stop_queue(dev);
 
-		fifo_header.dlc = can_fd_len2dlc(cf->len) << 16;
+		fifo_element.dlc = can_fd_len2dlc(cf->len) << 16;
 
 		/* Write the frame ID, DLC, and payload to the FIFO element. */
-		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, &fifo_header, 2);
+		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, &fifo_element, 2);
 		if (err)
 			goto out_fail;
 
 		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_DATA,
-				       cf->data, DIV_ROUND_UP(cf->len, 4));
+				       cf->data, len_padded);
 		if (err)
 			goto out_fail;
 
@@ -1717,15 +1725,15 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 				fdflags |= TX_BUF_BRS;
 		}
 
-		fifo_header.dlc = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
+		fifo_element.dlc = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
 			FIELD_PREP(TX_BUF_DLC_MASK, can_fd_len2dlc(cf->len)) |
 			fdflags | TX_BUF_EFC;
-		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, &fifo_header, 2);
-		if (err)
-			goto out_fail;
 
-		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DATA,
-				       cf->data, DIV_ROUND_UP(cf->len, 4));
+		memcpy_and_pad(fifo_element.data, CANFD_MAX_DLEN, &cf->data,
+			       cf->len, 0);
+
+		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID,
+				       &fifo_element, 2 + len_padded);
 		if (err)
 			goto out_fail;
 
-- 
2.40.1

