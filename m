Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D1670DE13
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbjEWNyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbjEWNyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:54:07 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC167109;
        Tue, 23 May 2023 06:54:04 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 2CD4F5FD68;
        Tue, 23 May 2023 16:54:03 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684850043;
        bh=QACcL2z5H0WiVPZBqWtG1qVoEZA/+FwC6rxiZKbXGhQ=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=d7cjZgy6FmwELYdiPA/MahxZUvDN4IL/6S6Sq6CN7KFg1OqB1O7fjfOezdXdi/og9
         dqr4k9yNlx1UAJSQgBx4F7+DjoxAgRQl0CTzYMrm6EuPFA+gAHXWHNylRoQ5ufjT3v
         vRxtb5+1KzzIXcbyGJkNLyYTNfX6dFkt1z9cxyVTdQrQ7ph0i/qX3I107yONEBFTy3
         FYb/lU59ijivs/2T5Q9f9A0kDvgmRDwmyO0G3cCg9B9CynqCRdfadaaoRHEUBLL4+/
         OhTaOkTNuJMZD+9gZpGPb2EIBKb4zwKsNVWpMYgSwjSkOMpS4v5BnNDLlMkihOSCmM
         a9OWH9aXhvRCA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 23 May 2023 16:54:03 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v16 2/6] clk: meson: introduce new pll power-on sequence for A1 SoC family
Date:   Tue, 23 May 2023 16:53:47 +0300
Message-ID: <20230523135351.19133-3-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230523135351.19133-1-ddrokosov@sberdevices.ru>
References: <20230523135351.19133-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/23 12:15:00 #21372692
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern meson PLL IPs are a little bit different from early known PLLs.
The main difference is located in the init/enable/disable sequences; the
rate logic is the same.

In A1 PLL, the PLL enable sequence is different, so add new optional pll
reg bits and use the new power-on sequence to enable the PLL:
    1. enable the pll, delay for 10us
    2. enable the pll self-adaption current module, delay for 40us
    3. enable the lock detect module

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/clk/meson/clk-pll.c | 23 +++++++++++++++++++++++
 drivers/clk/meson/clk-pll.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 314ca945a4d0..56ec2210f1ad 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -358,6 +358,25 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 	if (MESON_PARM_APPLICABLE(&pll->rst))
 		meson_parm_write(clk->map, &pll->rst, 0);
 
+	/*
+	 * Compared with the previous SoCs, self-adaption current module
+	 * is newly added for A1, keep the new power-on sequence to enable the
+	 * PLL. The sequence is:
+	 * 1. enable the pll, delay for 10us
+	 * 2. enable the pll self-adaption current module, delay for 40us
+	 * 3. enable the lock detect module
+	 */
+	if (MESON_PARM_APPLICABLE(&pll->current_en)) {
+		usleep_range(10, 20);
+		meson_parm_write(clk->map, &pll->current_en, 1);
+		usleep_range(40, 50);
+	};
+
+	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
+		meson_parm_write(clk->map, &pll->l_detect, 1);
+		meson_parm_write(clk->map, &pll->l_detect, 0);
+	}
+
 	if (meson_clk_pll_wait_lock(hw))
 		return -EIO;
 
@@ -375,6 +394,10 @@ static void meson_clk_pll_disable(struct clk_hw *hw)
 
 	/* Disable the pll */
 	meson_parm_write(clk->map, &pll->en, 0);
+
+	/* Disable PLL internal self-adaption current module */
+	if (MESON_PARM_APPLICABLE(&pll->current_en))
+		meson_parm_write(clk->map, &pll->current_en, 0);
 }
 
 static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
index 367efd0f6410..a2228c0fdce5 100644
--- a/drivers/clk/meson/clk-pll.h
+++ b/drivers/clk/meson/clk-pll.h
@@ -36,6 +36,8 @@ struct meson_clk_pll_data {
 	struct parm frac;
 	struct parm l;
 	struct parm rst;
+	struct parm current_en;
+	struct parm l_detect;
 	const struct reg_sequence *init_regs;
 	unsigned int init_count;
 	const struct pll_params_table *table;
-- 
2.36.0

