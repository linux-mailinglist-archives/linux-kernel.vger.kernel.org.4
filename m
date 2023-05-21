Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E08B70B1EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjEUW74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjEUW7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:59:50 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36CBBE;
        Sun, 21 May 2023 15:59:48 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPSA id 6424B1C0003;
        Sun, 21 May 2023 22:59:45 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 1/2] iio/adc: ingenic: Fix channel offsets in buffer
Date:   Mon, 22 May 2023 00:59:00 +0200
Message-Id: <20230521225901.388455-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230521225901.388455-1-contact@artur-rojek.eu>
References: <20230521225901.388455-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consumers expect the buffer to only contain enabled channels. While
preparing the buffer, the driver makes two mistakes:
1) It inserts empty data for disabled channels.
2) Each ADC readout contains samples for two 16-bit channels. If either
   of them is active, the whole 32-bit sample is pushed into the buffer
   as-is.

Both of those issues cause the active channels to appear at the wrong
offsets in the buffer. Fix the above by demuxing samples for active
channels only.

This has remained unnoticed, as all the consumers so far were only using
channels 0 and 1, leaving them unaffected by changes introduced in this
commit.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Paul Cercueil <paul@crapouillou.net>
---

v2: - demux active channels from ADC readouts 
    - clarify in the commit description that this patch doesn't impact
      existing consumers of this driver

 drivers/iio/adc/ingenic-adc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index a7325dbbb99a..093710a7ad4c 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -802,13 +802,19 @@ static irqreturn_t ingenic_adc_irq(int irq, void *data)
 	struct ingenic_adc *adc = iio_priv(iio_dev);
 	unsigned long mask = iio_dev->active_scan_mask[0];
 	unsigned int i;
-	u32 tdat[3];
-
-	for (i = 0; i < ARRAY_SIZE(tdat); mask >>= 2, i++) {
-		if (mask & 0x3)
-			tdat[i] = readl(adc->base + JZ_ADC_REG_ADTCH);
-		else
-			tdat[i] = 0;
+	u16 tdat[6];
+	u32 val;
+
+	memset(tdat, 0, ARRAY_SIZE(tdat));
+	for (i = 0; mask && i < ARRAY_SIZE(tdat); mask >>= 2) {
+		if (mask & 0x3) {
+			val = readl(adc->base + JZ_ADC_REG_ADTCH);
+			/* Two channels per sample. Demux active. */
+			if (mask & BIT(0))
+				tdat[i++] = val & 0xffff;
+			if (mask & BIT(1))
+				tdat[i++] = val >> 16;
+		}
 	}
 
 	iio_push_to_buffers(iio_dev, tdat);
-- 
2.40.1

