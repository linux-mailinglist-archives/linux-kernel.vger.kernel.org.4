Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A64C7115BF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbjEYSqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242330AbjEYSoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:44:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DBBE54;
        Thu, 25 May 2023 11:40:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 400CF64958;
        Thu, 25 May 2023 18:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9611CC433A4;
        Thu, 25 May 2023 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039942;
        bh=442x6XFaqm87DzDkUkHzMtwIJS5bMTZ9ioKgIvjhuW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qNbZWsEwHPfeP2CDtBJIRr/ZnA/wXk4xGYfCB16gX27UXCEo1dwBugtb5eExR1IB3
         RSr3M6hn4hObY8ABjqJsqcjV8FWaz5ND8PGhjtIuigYx3qP5XyGNs8UkfzinZD7oVG
         Dv4PqGWbq6HKxVqIlKxXG747gxutFQfzyXVjN5ibZ+C/waWCWHE3cOoTyjPj1/UvZY
         XReLdZtvbS2TFLTsEWkjNFkE1ET/7jRr51DD3OCPB7erwz7QKUwoIkYZwLnCi9KsGY
         FcOlvb3596Yrof2GO0ajdzy3fobhopSBwmZsLvbv0CgcCJM3iGDXz/E2nwr6Fijkev
         rjAeae0S3Q7NQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, u.kleine-koenig@pengutronix.de,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.15 03/43] ASoC: dwc: limit the number of overrun messages
Date:   Thu, 25 May 2023 14:38:14 -0400
Message-Id: <20230525183854.1855431-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183854.1855431-1-sashal@kernel.org>
References: <20230525183854.1855431-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Kochetkov <fido_max@inbox.ru>

[ Upstream commit ab6ecfbf40fccf74b6ec2ba7ed6dd2fc024c3af2 ]

On slow CPU (FPGA/QEMU emulated) printing overrun messages from
interrupt handler to uart console may leads to more overrun errors.
So use dev_err_ratelimited to limit the number of error messages.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru
Link: https://lore.kernel.org/r/20230505062820.21840-1-fido_max@inbox.ru
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/dwc/dwc-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 315ca5c4b057a..14ad8023fcdcb 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -132,13 +132,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
 
 		/* Error Handling: TX */
 		if (isr[i] & ISR_TXFO) {
-			dev_err(dev->dev, "TX overrun (ch_id=%d)\n", i);
+			dev_err_ratelimited(dev->dev, "TX overrun (ch_id=%d)\n", i);
 			irq_valid = true;
 		}
 
 		/* Error Handling: TX */
 		if (isr[i] & ISR_RXFO) {
-			dev_err(dev->dev, "RX overrun (ch_id=%d)\n", i);
+			dev_err_ratelimited(dev->dev, "RX overrun (ch_id=%d)\n", i);
 			irq_valid = true;
 		}
 	}
-- 
2.39.2

