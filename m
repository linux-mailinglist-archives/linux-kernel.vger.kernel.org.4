Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A1E60D89F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 02:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiJZA5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 20:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJZA5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 20:57:13 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50741B56F5;
        Tue, 25 Oct 2022 17:57:11 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1onUjB-0002Yp-PL; Wed, 26 Oct 2022 02:57:06 +0200
Date:   Wed, 26 Oct 2022 01:56:58 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Zhi Mao <zhi.mao@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH] pwm: mediatek: always use bus clock for PWM on MT7622
Message-ID: <Y1iF2slvSblf6bYK@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to MT7622 Reference Manual for Development Board v1.0 the PWM
unit found in the MT7622 SoC also comes with the PWM_CK_26M_SEL register
at offset 0x210 just like other modern MediaTek ARM64 SoCs.
And also MT7622 sets that register to 0x00000001 on reset which is
described as 'Select 26M fix CLK as BCLK' in the datasheet.
Hence set has_ck_26m_sel to true also for MT7622 which results in the
driver writing 0 to the PWM_CK_26M_SEL register which is described as
'Select bus CLK as BCLK'.

Fixes: 0c0ead76235db0 ("pwm: mediatek: Always use bus clock")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/pwm/pwm-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 2219cba033e348..5b5eeaff35da67 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -296,7 +296,7 @@ static const struct pwm_mediatek_of_data mt6795_pwm_data = {
 static const struct pwm_mediatek_of_data mt7622_pwm_data = {
 	.num_pwms = 6,
 	.pwm45_fixup = false,
-	.has_ck_26m_sel = false,
+	.has_ck_26m_sel = true,
 };
 
 static const struct pwm_mediatek_of_data mt7623_pwm_data = {
-- 
2.38.1

