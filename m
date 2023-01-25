Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D028667BB25
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbjAYTwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbjAYTvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:51:39 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1EE59574
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:51:15 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vw16so50582904ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfommV9SggPT6ODN0C3xf43Tcngh6JSfHsK3JHWDVGY=;
        b=EAVvGTpOTDJ6cVDVcMwO07k2FmJrvWy9qroV4RCQs5igp0Ik0sNwLhS8JY69vx4VwT
         1DVXvZcphS914vwdO2duYYrcf9NbRNHO9sieMavL4Ezetq648t2vET56QK6YHnABqkD+
         7fA53W2QfBWIvQmTHDf/3EqO4mQR57dKS1rEDiiJKmGwC351bVu6u2iUwTZXjd4ZWbGI
         8qDfHOh3tlXkrRCkFLseE4+KDTi0b20ftS3nZt/tF4F790dzrHfq/KK1F2UQobfbZSvj
         qPEZVoCxVEkwp8ycQQ0xCpRfrUnZ/EpHW2Ak+YWXbSCQyXiNzeGWEZmW8Ux5z8luTRps
         lnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfommV9SggPT6ODN0C3xf43Tcngh6JSfHsK3JHWDVGY=;
        b=lse0zKX/2aQ4kGBiUZ0yAVEgaVD99uAZ9aey2BiBrvnIz96wWW0yD2vwHf4eo2elb8
         hINwq1Vcl0nNCeEX5cIqWINqxytnzNPVCJOkHw5ZHRvhUZGHI5wEx1Hm3AwrJ/PeakdV
         eO5BrIk5/zPli2hoMAxJTkXZYRtf+1enoVrm0ywpYaGmmVlgRu55OZ4GxBxOVdCY4taA
         eW01r+A6+MLTEklssQj0vAY+C1sKU7rlcFud/Hl95o7pURhxg5lDwr2r45TbFET+e1kT
         I68quKqGDMuZGigwPaz3TaZJWUgTApEj0WHwTJmHrz3XUTR2RzB1h9j8d71QKIa+IB0O
         mQpA==
X-Gm-Message-State: AFqh2krmDb+oQvUoYTzQwnnWBznUnPaNbWWcu/3Wj8EejK4/orMcHEfN
        ZVWW7y9AM/wYbkUOYd5JI+y2Gw==
X-Google-Smtp-Source: AMrXdXt2v5TLWs1si2cdhP2MB7PyliyN6s2jqZoOi+m76tDCJ+PV6KnaAPx77ijVbClF7SBS6O0pBg==
X-Received: by 2002:a17:906:9c8b:b0:84d:ed5:a406 with SMTP id fj11-20020a1709069c8b00b0084d0ed5a406mr47950330ejc.14.1674676275056;
        Wed, 25 Jan 2023 11:51:15 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a247:815f:ef74:e427:628a:752c])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906454f00b00872c0bccab2sm2778830ejq.35.2023.01.25.11.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:51:14 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 12/18] can: m_can: Add tx coalescing ethtool support
Date:   Wed, 25 Jan 2023 20:50:53 +0100
Message-Id: <20230125195059.630377-13-msp@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125195059.630377-1-msp@baylibre.com>
References: <20230125195059.630377-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add get/set functions for ethtool coalescing. tx-frames-irq and
tx-usecs-irq can only be set/unset together. tx-frames-irq needs to be
less than TXE and TXB.

As rx and tx share the same timer, rx-usecs-irq and tx-usecs-irq can be
enabled/disabled individually but they need to have the same value if
enabled.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 38 ++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 35c38c230a00..9d2345f52ddc 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1944,6 +1944,8 @@ static int m_can_get_coalesce(struct net_device *dev,
 
 	ec->rx_max_coalesced_frames_irq = cdev->rx_max_coalesced_frames_irq;
 	ec->rx_coalesce_usecs_irq = cdev->rx_coalesce_usecs_irq;
+	ec->tx_max_coalesced_frames_irq = cdev->tx_max_coalesced_frames_irq;
+	ec->tx_coalesce_usecs_irq = cdev->tx_coalesce_usecs_irq;
 
 	return 0;
 }
@@ -1970,16 +1972,50 @@ static int m_can_set_coalesce(struct net_device *dev,
 		netdev_err(dev, "rx-frames-irq and rx-usecs-irq can only be set together\n");
 		return -EINVAL;
 	}
+	if (ec->tx_max_coalesced_frames_irq > cdev->mcfg[MRAM_TXE].num) {
+		netdev_err(dev, "tx-frames-irq (%u) greater than the TX event FIFO (%u)\n",
+			   ec->tx_max_coalesced_frames_irq,
+			   cdev->mcfg[MRAM_TXE].num);
+		return -EINVAL;
+	}
+	if (ec->tx_max_coalesced_frames_irq > cdev->mcfg[MRAM_TXB].num) {
+		netdev_err(dev, "tx-frames-irq (%u) greater than the TX FIFO (%u)\n",
+			   ec->tx_max_coalesced_frames_irq,
+			   cdev->mcfg[MRAM_TXB].num);
+		return -EINVAL;
+	}
+	if ((ec->tx_max_coalesced_frames_irq == 0) != (ec->tx_coalesce_usecs_irq == 0)) {
+		netdev_err(dev, "tx-frames-irq and tx-usecs-irq can only be set together\n");
+		return -EINVAL;
+	}
+	if (ec->rx_coalesce_usecs_irq != 0 && ec->tx_coalesce_usecs_irq != 0 &&
+	    ec->rx_coalesce_usecs_irq != ec->tx_coalesce_usecs_irq) {
+		netdev_err(dev, "rx-usecs-irq (%u) needs to be equal to tx-usecs-irq (%u) if both are enabled\n",
+			   ec->rx_coalesce_usecs_irq,
+			   ec->tx_coalesce_usecs_irq);
+		return -EINVAL;
+	}
 
 	cdev->rx_max_coalesced_frames_irq = ec->rx_max_coalesced_frames_irq;
 	cdev->rx_coalesce_usecs_irq = ec->rx_coalesce_usecs_irq;
+	cdev->tx_max_coalesced_frames_irq = ec->tx_max_coalesced_frames_irq;
+	cdev->tx_coalesce_usecs_irq = ec->tx_coalesce_usecs_irq;
+
+	if (cdev->rx_coalesce_usecs_irq)
+		cdev->irq_timer_wait =
+			ns_to_ktime(cdev->rx_coalesce_usecs_irq * NSEC_PER_USEC);
+	else
+		cdev->irq_timer_wait =
+			ns_to_ktime(cdev->tx_coalesce_usecs_irq * NSEC_PER_USEC);
 
 	return 0;
 }
 
 static const struct ethtool_ops m_can_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
-		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ,
+		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
+		ETHTOOL_COALESCE_TX_USECS_IRQ |
+		ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
 	.get_ts_info = ethtool_op_get_ts_info,
 	.get_coalesce = m_can_get_coalesce,
 	.set_coalesce = m_can_set_coalesce,
-- 
2.39.0

