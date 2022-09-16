Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D082C5BAC9B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiIPLkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiIPLkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:40:00 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC972CC97;
        Fri, 16 Sep 2022 04:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663328398;
  x=1694864398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=522Kxf6U1q7s2dtT3SsExSNapFPwyU8RLSswskWzai8=;
  b=TfneD9eTL6XivhGCtWAcEhjTVLROmOQBXNFGkByRRWKCXS3gojsIEUJ+
   +JstlQrYh/ONRk/RdkJ2sTBYkK2XxQkGADU6p/JBWRyZYKzTRcy/41EVV
   PzT1Za44VbqDsB1hZ/9dw73sXN3QQXbGA1by870v6dFWy1slk+X8iwKd5
   TzA5KHPkZaJ+oex1F9lv5NhcEUBej9sG6S8PIb6d+/y55RUAnpoqJ0UM6
   zlibkTW1SJhHbuzBYexO3UY5Tw5ZQgCSVl3VYjZTLlzxbHAFEIi06pdcP
   p+od6pD8W4RMrnmkRq+Hq0tszA+IWEe+NrKGuaU3RQc8PuRSI/iPL3YDn
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
Subject: [PATCH 4/4] spi: s3c64xx: Fix large transfers with DMA
Date:   Fri, 16 Sep 2022 13:39:51 +0200
Message-ID: <20220916113951.228398-5-vincent.whitchurch@axis.com>
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

The COUNT_VALUE in the PACKET_CNT register is 16-bit so the maximum
value is 65535.  Asking the driver to transfer a larger size currently
leads to the DMA transfer timing out.  Fix this by splitting the
transfer as needed.

With this, the len>64 KiB tests in spi-loopback-test pass.

(Note that len==64 KiB tests work even without this patch for some reason.
 The driver programs 0 to the COUNT_VALUE field in that case, but it's
 unclear if it's by design, since the hardware documentation doesn't say
 anything about the behaviour when COUNT_VALUE == 0, so play it safe and
 split at 65535.)

Fixes: 230d42d422e7b69 ("spi: Add s3c64xx SPI Controller driver")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/spi/spi-s3c64xx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 7f346866614a..85e1d1f90109 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -701,6 +701,16 @@ static int s3c64xx_spi_prepare_message(struct spi_master *master,
 	struct spi_device *spi = msg->spi;
 	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
 
+	if (master->can_dma) {
+		int ret;
+
+		/* Limited by size of PACKET_CNT.COUNT_VALUE. */
+		ret = spi_split_transfers_maxsize(master, msg, 65535,
+						  GFP_KERNEL | GFP_DMA);
+		if (ret)
+			return ret;
+	}
+
 	/* Configure feedback delay */
 	if (!cs)
 		/* No delay if not defined */
-- 
2.34.1

