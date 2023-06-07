Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FFA726F67
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbjFGU6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbjFGU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:57:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D3E2134;
        Wed,  7 Jun 2023 13:57:41 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 98E276606F0D;
        Wed,  7 Jun 2023 21:57:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686171459;
        bh=IHu+5VHbpn9tYN0aeoiKy2zTGue/frX6mQhuF4Dk/XE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O52Eho0T3yp7+0mui4z26cOHabKuCSsXrF2DqF5Rb3n1rZ/OJlP0F4Ip8oondaYoB
         bsAbsRrlpt1YddHdvHdksMQmjr7XfcXKUGtK4pdK3W+3qmNh/NjgKDMjxYq3WRZ5ni
         F88pQ6/PYBGb/08S+pr4ZinFmBYzZPHTKO1PlerLK6ynyiH0RD5olnAeWrthRovhfx
         lQqRVsiPQT4kLx/1sbzgOB1enepQ6Ja1/BzC6hGJ261RipK+A8Xi71WsFN07BHQMAI
         9Rquy2Y0VC1xXkh97Lpw7x31kfXrkCCPOU90qpH7l+Q49yQjORGanfMoDS2ouaIQW6
         mxI2GpseKK2jA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 4/5] clk: mediatek: mt8183: Add CLK_VDEC_ACTIVE to vdec
Date:   Wed,  7 Jun 2023 16:53:41 -0400
Message-ID: <20230607205714.510012-5-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607205714.510012-1-nfraprado@collabora.com>
References: <20230607205714.510012-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CLK_VDEC_ACTIVE clock to the vdec clock driver. This clock is
enabled by the VPU once it starts decoding.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Added CLK_IGNORE_UNUSED flag

 drivers/clk/mediatek/clk-mt8183-vdec.c | 5 +++++
 include/dt-bindings/clock/mt8183-clk.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8183-vdec.c b/drivers/clk/mediatek/clk-mt8183-vdec.c
index 513b7956cbea..03c4f1acfdb8 100644
--- a/drivers/clk/mediatek/clk-mt8183-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8183-vdec.c
@@ -27,6 +27,10 @@ static const struct mtk_gate_regs vdec1_cg_regs = {
 	GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift,	\
 		&mtk_clk_gate_ops_setclr_inv)
 
+#define GATE_VDEC0(_id, _name, _parent, _shift)		\
+	GATE_MTK_FLAGS(_id, _name, _parent, &vdec0_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr, CLK_IGNORE_UNUSED)
+
 #define GATE_VDEC1_I(_id, _name, _parent, _shift)		\
 	GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift,	\
 		&mtk_clk_gate_ops_setclr_inv)
@@ -34,6 +38,7 @@ static const struct mtk_gate_regs vdec1_cg_regs = {
 static const struct mtk_gate vdec_clks[] = {
 	/* VDEC0 */
 	GATE_VDEC0_I(CLK_VDEC_VDEC, "vdec_vdec", "mm_sel", 0),
+	GATE_VDEC0(CLK_VDEC_ACTIVE, "vdec_active", "mm_sel", 4),
 	/* VDEC1 */
 	GATE_VDEC1_I(CLK_VDEC_LARB1, "vdec_larb1", "mm_sel", 0),
 };
diff --git a/include/dt-bindings/clock/mt8183-clk.h b/include/dt-bindings/clock/mt8183-clk.h
index a7b470b0ec8a..32dd7d91dbe2 100644
--- a/include/dt-bindings/clock/mt8183-clk.h
+++ b/include/dt-bindings/clock/mt8183-clk.h
@@ -357,7 +357,8 @@
 /* VDEC_GCON */
 #define CLK_VDEC_VDEC			0
 #define CLK_VDEC_LARB1			1
-#define CLK_VDEC_NR_CLK			2
+#define CLK_VDEC_ACTIVE			2
+#define CLK_VDEC_NR_CLK			3
 
 /* VENC_GCON */
 #define CLK_VENC_LARB			0
-- 
2.41.0

