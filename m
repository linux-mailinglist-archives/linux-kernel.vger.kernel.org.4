Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A16693958
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 19:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBLSV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 13:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBLSV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 13:21:28 -0500
Received: from mx.flying-snail.de (mx.flying-snail.de [IPv6:2a06:1c40:3::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577A81025E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 10:21:25 -0800 (PST)
Received: from [2a02:908:1b0:8800:2ff:ffff:fe11:2236] (helo=mondbasis.internal.flying-snail.de)
        by mx.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pRGyN-002vxr-UT; Sun, 12 Feb 2023 19:21:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=feldner-bv.de; s=s1; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=S4eMM/Ni/1THzQ6AsWye0pgbL3S8Ck4ZUQKNSjmDg90=; b=R4HIaQTZpT3xitUTor7oeHuIft
        QAm4Y7Mf5W3PytfbjE3Lxb06SBnDfbv45QYiR8pzGzFFAvKhnsZp/C4U06qVaGVmdfo4CdRlllUci
        ATVmnyYr8g4IJTlhI3WMVXM2lJngKIV2EDyfGdY7KCG5fHNIBPQom0gGD0Xe42jb6aQbeTPNWaInR
        aa6K44kPMQRElJu7CLhlmnTG1Dtw7NJPM4PdqUDDRpiTA1R2pFSgkRVmFU723bq7PBF2QIF/ZoHp1
        nI2zSuo/304IPWEg5GwfgRUXPt7FqGSAOtPLRWsqqeZPv9rJSHOocVJdJT0wFu/G+pkB1TTClhxm7
        IVjypYhg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=flying-snail.de; s=s1; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To
        :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=S4eMM/Ni/1THzQ6AsWye0pgbL3S8Ck4ZUQKNSjmDg90=; b=QXYsV5raxeP8886jyYVl3kXwPc
        1fz5BMvo75L1zXBayWNv+kZXVa8k/u9fXKHGlqYCLn0bXy8eHZlQJU7XTBmvscG7BvSSJDhnDq38w
        5JWFMSrfOE2O3ElxowUrJvioOYDiXoZEI+Am7KboQkccXF7714HOa95V+jV2bEdPuBMtwoLWs4noh
        8Iu7ai7KuyTX8nQO0P0EUc5v/i2dwR4eghgPKh4l4nl/59drKYjDQwjKM/10KleKMgRq7/VJ/RTmi
        qon1ojdh39mJiEb6MnwXpInBcQNvKBzEjiO720UHmEGi2ayGaZChHhwNmcRXd0vb2Dk/T6Bff+kX6
        MvncLsgw==;
Received: from [fde6:2538:5b30:3b53:146b:5d45:c296:7cff] (helo=debian-qemu)
        by mondbasis.internal.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pRGyF-000lvu-Kt; Sun, 12 Feb 2023 19:21:11 +0100
Date:   Sun, 12 Feb 2023 19:21:03 +0100
From:   Andreas Feldner <pelzi@flying-snail.de>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] pinctrl: sunxi: set minimal debounce on input-debounce 0
Message-ID: <Y+kuD+/v3+N1vwxR@debian-qemu.internal.flying-snail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sunxi-h3-h5 based boards have no support for switching
off IRQ debouncing filter. This would be the expected
behaviour of value 0 for the general pinctl parameter
input-debounce.
The current driver implementation ignores value 0
for input-debounce, leaving the chip's default. This
default, however, is not minimal, but equivalent to
value 31 (microseconds).

This patch does not ignore value 0 but instead makes
sure the corresponding IRQ debounce filter is set
to the shortest time selectable, i. e. the fast
oscillator with a divider of 1 == (2 ^ 0).

Fixes: 7c926492d38a ("pinctrl: sunxi: Add support for interrupt debouncing")

Signed-off-by: Andreas Feldner <pelzi@flying-snail.de>
---
Changes in v2:
  - Posted as separate mail thread
  - Made sure tabs are kept
  - Excluded patch to devicetree

 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 40 +++++++++++++++------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index f35179eceb4e..6798c8f4067e 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1444,29 +1444,35 @@ static int sunxi_pinctrl_setup_debounce(struct sunxi_pinctrl *pctl,
 		if (ret)
 			return ret;
 
-		if (!debounce)
-			continue;
-
-		debounce_freq = DIV_ROUND_CLOSEST(USEC_PER_SEC, debounce);
-		losc_div = sunxi_pinctrl_get_debounce_div(losc,
-							  debounce_freq,
-							  &losc_diff);
-
-		hosc_div = sunxi_pinctrl_get_debounce_div(hosc,
-							  debounce_freq,
-							  &hosc_diff);
-
-		if (hosc_diff < losc_diff) {
-			div = hosc_div;
-			src = 1;
+		if (debounce) {
+			debounce_freq = DIV_ROUND_CLOSEST(USEC_PER_SEC, debounce);
+			losc_div = sunxi_pinctrl_get_debounce_div(losc,
+								  debounce_freq,
+								  &losc_diff);
+
+			hosc_div = sunxi_pinctrl_get_debounce_div(hosc,
+								  debounce_freq,
+								  &hosc_diff);
+
+			if (hosc_diff < losc_diff) {
+				div = hosc_div;
+				src = 1;
+			} else {
+				div = losc_div;
+				src = 0;
+			}
 		} else {
-			div = losc_div;
-			src = 0;
+			/* lowest time as best approximation to "off" */
+			div = 0;
+			src = 1;
 		}
 
 		writel(src | div << 4,
 		       pctl->membase +
 		       sunxi_irq_debounce_reg_from_bank(pctl->desc, i));
+
+		pr_info("Debounce filter for IRQ bank %d configured to %d us (reg %x)\n",
+			i, debounce, src | div << 4);
 	}
 
 	return 0;
-- 
2.30.2

