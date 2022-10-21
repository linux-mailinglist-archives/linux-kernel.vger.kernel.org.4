Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459AD6072D4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiJUIsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiJUIsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:48:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15EF11CB59
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:47:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w18so3738771wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbWZD88Csa/gnzCp+HMy/jlXVSOibosOwLIHUydjLSM=;
        b=SsKIYrb7OvBJOeb8oL4usYLyXghenrQID5yZvH3pX0XKPhJN1CG7V6x/U0nKj8osd7
         d808EvZBNDx/cY56qI+NXMpb+DZzaLrmrtRmbQ7SpR8d54YEQ5RgTmE4ra4VDJib2jam
         vwiVe8T34UXKId38I0e2iHZddayU5VEz8LCYizNDMlp6tnl/0+bNIdU7H0z0I6BUpV+B
         /ucURVgVWqJQXc+l9wJO1fW/vtVg3qM4neP415ndQIgao5xb30HpKN4zkISS9cUNDHFK
         cCOliYL9hfvCH0QOuEltYQVMAU4liP5W10nmN5U/k1E2c37GVmxup5pG0eXlYky1YvTU
         Yaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbWZD88Csa/gnzCp+HMy/jlXVSOibosOwLIHUydjLSM=;
        b=5AIPBHWfrXKS4ycNjP2kknyoljwAET+zgzeIWDPHmCShB+lwe8coO8M116IBadhPQB
         ScL24IPFheSjmaHwMskbvQnWA6jTRb5hllsoLynjyjHT6l2sSyKvgBukhdSDkulJrSyj
         0nlgWbunmhGlWxBIZyFN/9iWHXOywV+su2zsLuaFTLldQsWMyej9r7svAHCmABHJtQ3F
         nCla7TyMlBoMGR6Mdvr4ZpAbEFGTuNkfxvRuprWl5DO84GXuuaNUnxlg4AVaq6+cHlcU
         XAwcOgNm0F7zVO46r3MHtDxxp1/rze05N0TQubnqyxIg+mXUZcpfa5wU2NFdZLQBGLpV
         pLCg==
X-Gm-Message-State: ACrzQf1FRIVkTR7Jz0j7MxE+bLXGJK0jZ+tecNmyfykPnkFR2K9++WiT
        sqq6itg4rniTkATK/GqXspVsaw==
X-Google-Smtp-Source: AMsMyM7uFs9IFzNVInzdSUYlLwCAHeX5bF4kkYp9ut4AlH8VXFPaQellUjaw5YdFzfU/trLsLMNTig==
X-Received: by 2002:a5d:4cc2:0:b0:22e:372d:9c9 with SMTP id c2-20020a5d4cc2000000b0022e372d09c9mr11435346wrt.576.1666342077651;
        Fri, 21 Oct 2022 01:47:57 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c0b4500b003c41144b3cfsm2040233wmr.20.2022.10.21.01.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:47:57 -0700 (PDT)
From:   bchihi@baylibre.com
To:     sean.wang@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [v2, 2/2] pinctrl: mediatek: mt8365: use mt8365_set_clr_mode() callback
Date:   Fri, 21 Oct 2022 10:47:08 +0200
Message-Id: <20221021084708.1109986-3-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021084708.1109986-1-bchihi@baylibre.com>
References: <20221021084708.1109986-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

On MT8365, the SET/CLR of the mode is broken and some pin modes won't
be set correctly.
Use the mt8365_set_clr_mode() callback to fix the issue.

Co-developed-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8365.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8365.c b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
index 57f37a294063..42b48136ab77 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8365.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
@@ -416,6 +416,23 @@ static const struct mtk_pin_ies_smt_set mt8365_smt_set[] = {
 	MTK_PIN_IES_SMT_SPEC(144, 144, 0x480, 22),
 };
 
+static int mt8365_set_clr_mode(struct regmap *regmap,
+		unsigned int bit, unsigned int reg_pullen, unsigned int reg_pullsel,
+		bool enable, bool isup)
+{
+	int ret;
+
+	ret = regmap_update_bits(regmap, reg_pullen, BIT(bit), enable << bit);
+	if (ret)
+		return -EINVAL;
+
+	ret = regmap_update_bits(regmap, reg_pullsel, BIT(bit), isup << bit);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct mtk_pinctrl_devdata mt8365_pinctrl_data = {
 	.pins = mtk_pins_mt8365,
 	.npins = ARRAY_SIZE(mtk_pins_mt8365),
@@ -431,6 +448,7 @@ static const struct mtk_pinctrl_devdata mt8365_pinctrl_data = {
 	.n_spec_pupd = ARRAY_SIZE(mt8365_spec_pupd),
 	.spec_pull_set = mtk_pctrl_spec_pull_set_samereg,
 	.spec_ies_smt_set = mtk_pconf_spec_set_ies_smt_range,
+	.mt8365_set_clr_mode = mt8365_set_clr_mode,
 	.dir_offset = 0x0140,
 	.dout_offset = 0x00A0,
 	.din_offset = 0x0000,
-- 
2.34.1

