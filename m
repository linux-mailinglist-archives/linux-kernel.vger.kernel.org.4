Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D53765B4C5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjABQJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjABQJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:09:03 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F10DAE70;
        Mon,  2 Jan 2023 08:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1672675743;
  x=1704211743;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iP33hlrhB9wWueTXIDCyi4gTYEeLyDUJ0/Qk+A7NRVo=;
  b=ThRqm/SuCUMbSwRqTWWqHzv0kDpO80NXkZFCL310FJN6n1QELNDfThVO
   O7NP90Me4RLU73oMJF4klw1PGHnWrY287jM1HV9Y34LUx4XRemzNWvHll
   LvqtWngXoMKl6U/rYxq2S6m6fPQXv2xci+X/LyhygcDBaamsWxD5aUc6e
   1TwUt3bauRFOuIMdlfMwX4nR+xbZ/N9XBOwKuWSZ4WJFxUumXEBwr5LOn
   j5cRsg2TkTcpNc7hGIcf+dm7K1ADqSVUkiKdN2hCmfTRhvT3HYXeFwPq2
   mI5PIBJdFQhBKdONnNPplaIYEbN4gVruI7GHpOC239LOPxHF9rDtb+G3C
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: pl022: Only use DT-specified DMA channels
Date:   Mon, 2 Jan 2023 17:08:51 +0100
Message-ID: <20230102160852.3090202-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
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

When a platform is booted with devicetree and does not provide a
platform data structure, the driver creates one internally.  enable_dma
should not be set in this structure when creating it; the probe function
will set it later if DMA channels are specified via the devicetree.

Setting enable_dma = 1 when creating this internal platform data can
lead to pl022_dma_probe() finding bogus DMA channels (since there is no
channel filter specified) when no DMA channels are specified in the
devicetree.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/spi/spi-pl022.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index e4484ace584e..a17ff839117f 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2091,7 +2091,6 @@ pl022_platform_data_dt_get(struct device *dev)
 		return NULL;
 
 	pd->bus_id = -1;
-	pd->enable_dma = 1;
 	of_property_read_u32(np, "pl022,autosuspend-delay",
 			     &pd->autosuspend_delay);
 	pd->rt = of_property_read_bool(np, "pl022,rt");
-- 
2.34.1

