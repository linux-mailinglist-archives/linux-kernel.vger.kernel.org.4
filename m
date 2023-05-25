Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564BD711623
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243440AbjEYS5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243224AbjEYSy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21E04204;
        Thu, 25 May 2023 11:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E96DC6497D;
        Thu, 25 May 2023 18:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B750AC4339B;
        Thu, 25 May 2023 18:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040239;
        bh=mQZOCKaKu/hy1ed/IVeQUFZPlBqiN0A0UWtyYRHjdh8=;
        h=From:To:Cc:Subject:Date:From;
        b=PNKuDSq3ppJoagBmHEK4uP9ITaRrzbWs0thK96/hIxTn3mUXHLm0/8kEnqwxTr7iN
         gwrWvpJCrwlmtVWut20DJMSneDJG3f/kJgIz7Ms2iChyRsiH9JPDp/jLI3ZAEgu6n9
         qZJf8Wj3ti9Y56y9crCAID9UdzsFNaowyBv5mHj2xLjFlTDiGNt1t7fSjsd51KpxuF
         ywt7l73QPv1VqEpq7f7vbQUlGa5T9amkWnlFKkm8mDHTqK8DS7DYLwvhcyDn/LbShN
         sIzro2bCbagWueYY3+oDlnerxwCa0JW4kvqxWpin3ga2PeLGPreVXIhTncyLLlOjtn
         OoBakceLcOg2w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, nicolas.ferre@microchip.com,
        u.kleine-koenig@pengutronix.de, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 01/27] ASoC: dwc: limit the number of overrun messages
Date:   Thu, 25 May 2023 14:43:27 -0400
Message-Id: <20230525184356.1974216-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 65112b9d8588a..90b8814d7506a 100644
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

