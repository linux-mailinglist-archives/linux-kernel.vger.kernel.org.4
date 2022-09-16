Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C1A5BAC9C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiIPLkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiIPLkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:40:00 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4C52B602;
        Fri, 16 Sep 2022 04:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663328398;
  x=1694864398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0O+QKem305LoINGTWe8PLbq0UAM4vzWU5ktHn5B5a3A=;
  b=L5guGB2OTf6KAA7BAswqBS/MOwYQk0GNo5Mkyyv5kuS+WzlohbYhJ6IP
   NjGl9aOAe6yke3BZulIikuVE7jd7xvpZCgJlwG3SuwbSojDAC/3r0m43W
   1x+s/YhQahY12QQL9N6ySV4IOql0MrZgF+R9KApRkxtZXjGZ5XncS00MT
   MOKAkChA1tqIs0qGFbWxjNuAeXGOtYcGzv+zSw2O+Fe3AWLPTDG2Ar4gc
   aBDHM4RYp5ZKHBrLHgCabe3THMwkSs46MAjIomh5q+j56ULUZZEqorFXm
   dqOAqftNCpQw72E0v/Ky6amnl17JCkJf0NB5C3yK7E43YSf6/GGaRP5zQ
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <broonie@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <andi@etezian.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <alim.akhtar@samsung.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/4] spi: spi-loopback-test: Add test to trigger DMA/PIO mixing
Date:   Fri, 16 Sep 2022 13:39:48 +0200
Message-ID: <20220916113951.228398-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220916113951.228398-1-vincent.whitchurch@axis.com>
References: <20220916113951.228398-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test where a small and a large transfer in a message hit the same
cache line.  This test currently fails on spi-s3c64xx on in DMA mode
since it ends up mixing DMA and PIO without proper cache maintenance.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/spi/spi-loopback-test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 4d4f77a186a9..dd7de8fa37d0 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -313,6 +313,33 @@ static struct spi_test spi_tests[] = {
 			},
 		},
 	},
+	{
+		.description	= "three tx+rx transfers with overlapping cache lines",
+		.fill_option	= FILL_COUNT_8,
+		/*
+		 * This should be large enough for the controller driver to
+		 * choose to transfer it with DMA.
+		 */
+		.iterate_len    = { 512, -1 },
+		.iterate_transfer_mask = BIT(1),
+		.transfer_count = 3,
+		.transfers		= {
+			{
+				.len = 1,
+				.tx_buf = TX(0),
+				.rx_buf = RX(0),
+			},
+			{
+				.tx_buf = TX(1),
+				.rx_buf = RX(1),
+			},
+			{
+				.len = 1,
+				.tx_buf = TX(513),
+				.rx_buf = RX(513),
+			},
+		},
+	},
 
 	{ /* end of tests sequence */ }
 };
-- 
2.34.1

