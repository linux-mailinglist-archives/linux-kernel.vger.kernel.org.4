Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858E3738056
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjFUJZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjFUJYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:24:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0D319B9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:24:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3112f5ab0b1so3626629f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339444; x=1689931444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DG8roE6DhQwhU2xd4+PBx8NOhVWjNvN1rf2zoTDzpOE=;
        b=zfMj4yE/E3JiduSidiDhmkVb1PXwnXSoIAD/BKOKSWThF0Medj9ixH10zxIDtLxPwi
         2u5tw1TqtyfHQ1Ctp/9EzjrlTcV6AszrGml9w9YE8qRNS/7YG9GBzZfpbjfBNM8jAHkU
         +fv7lEHKsdHaCFA0piyEIzF91CNZ64CXXBubRHgGuc1WjKzZDi6tPFhDT7ethE7Zdwsp
         dVLviscYJfyVQABy9gDorl63pM6C+IWVPjEnyn6YaWUBwLlbJbHDoiv6Olnn9f5k3w81
         sSJPU3pitUMYXAiknhVsoqycNSJYPjo0yPokeccIwxfDzqw5JfywxN9sK04wZICKixI6
         u3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339444; x=1689931444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DG8roE6DhQwhU2xd4+PBx8NOhVWjNvN1rf2zoTDzpOE=;
        b=N5JQzBqvHQcNVlTyQCgbBWvQq+O1IqUgS8acj4wJEqovQnoOqY+WP3ubCubnHCE5nE
         B8goXL4VM7P0BQEex19NVDjMbK1NFaL0kpPdsJDZM4bZ981rHlCA6IDN0m4dYHAdIUjm
         ow4G1db7+86TLLXrmmXTap7EIwzGIJEqZNocKKJ9DrC///CNbIGPItt1at7/Y+NSf66p
         1ZSFMZMg0aHn8x5IrguOS3a8fAb+tAPWtzTm1qskT5nA0GEytqfRfvx55vUizfuBBZ75
         jUz8d0EmJ1WbhCi+NgcEWKfpmCFtKpjV/9BhzZOEGKt7dqYQtcU3fh0ev1a4zbsm0zvm
         KgqQ==
X-Gm-Message-State: AC+VfDxopNicH9Jhh1TUNL9PLrhQx/SAHxDonCRViBrRViURPJZnKY3P
        REvb6G3gb0iZwft0nrs0olk9pw==
X-Google-Smtp-Source: ACHHUZ6sId7l7j6whJo/YkV2dFIsFAmiVsuGwurxB3iRA7J0C+YrFMOc/j4DJGLUWFIDR5obcw2EGQ==
X-Received: by 2002:a5d:628d:0:b0:30d:5cce:3bb5 with SMTP id k13-20020a5d628d000000b0030d5cce3bb5mr10729727wru.60.1687339444004;
        Wed, 21 Jun 2023 02:24:04 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b002fda1b12a0bsm4022115wrs.2.2023.06.21.02.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:24:03 -0700 (PDT)
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
Subject: [PATCH v4 07/12] can: m_can: Cache tx putidx
Date:   Wed, 21 Jun 2023 11:23:45 +0200
Message-Id: <20230621092350.3130866-8-msp@baylibre.com>
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

m_can_tx_handler is the only place where data is written to the tx fifo.
We can calculate the putidx in the driver code here to avoid the
dependency on the txfqs register.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 8 +++++++-
 drivers/net/can/m_can/m_can.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 6f8043636c54..40acd78cc0ed 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1482,6 +1482,10 @@ static int m_can_start(struct net_device *dev)
 
 	m_can_enable_all_interrupts(cdev);
 
+	if (cdev->version > 30)
+		cdev->tx_fifo_putidx = FIELD_GET(TXFQS_TFQPI_MASK,
+						 m_can_read(cdev, M_CAN_TXFQS));
+
 	return 0;
 }
 
@@ -1772,7 +1776,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		}
 
 		/* get put index for frame */
-		putidx = FIELD_GET(TXFQS_TFQPI_MASK, txfqs);
+		putidx = cdev->tx_fifo_putidx;
 
 		/* Construct DLC Field, with CAN-FD configuration.
 		 * Use the put index of the fifo as the message marker,
@@ -1806,6 +1810,8 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 
 		/* Enable TX FIFO element to start transfer  */
 		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
+		cdev->tx_fifo_putidx = (++cdev->tx_fifo_putidx >= cdev->can.echo_skb_max ?
+					0 : cdev->tx_fifo_putidx);
 
 		/* stop network queue if fifo full */
 		if (m_can_tx_fifo_full(cdev) ||
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index d0c21eddb6ec..548ae908ac4e 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -102,6 +102,9 @@ struct m_can_classdev {
 	u32 tx_max_coalesced_frames_irq;
 	u32 tx_coalesce_usecs_irq;
 
+	// Store this internally to avoid fetch delays on peripheral chips
+	int tx_fifo_putidx;
+
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 };
 
-- 
2.40.1

