Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E375BD2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiISQ7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiISQ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:59:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C135911459
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:59:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 29so159809edv.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=pe51xvlTzoxvP1PkLEmQi5YJGHaBQkqHjYX/h+KRrX4=;
        b=B+X1p1fH4JpGs34rfSwYzzSHzwu5qnL83GcremhYxa34LPTfzyuT54Qx4NkUrP80pu
         pQuuF2QUVoy7vzZV3h6TrERow//gfDL5XfrnuPPuhc+B4RHI2qc+3ex/jWKQ63RA0DfF
         hBB0zWcx0Lk6XvWHsF7Jch4RHJgIiSY2LK6gxuWKN/rgLWdkiQ6mLPjpWh4cz4AHHPtT
         pC4zGQhthMR+WPSyxbXBMc3qQw3YfboFI7Q7Yy9Bgo6ddHWkCSfutvSn4/NE2FUgXx1e
         NM29wYa2a+PX3vs2XgVJk1y+K5rnO2tGCxRjBGuogh3F3cFoZXeNpiG1Tcq1hcgaNJxd
         w1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pe51xvlTzoxvP1PkLEmQi5YJGHaBQkqHjYX/h+KRrX4=;
        b=aa6k5pZFs+BtgwlSeOOd7gK1UAF7gE3VSr77CnwSf29hF+FcoZZv1t98xjjZQb/L31
         06BVGvHZfK2cawIitylErKuTXkOE5AzUS7e4qr/e+8BDCVyyKoaRQSMNZbpr9u/adp/I
         pj6xVeeWvwkx3wIhONJsObTk0FhNnQVoQlOrlSvyW9YtaXXLtfaBiZ9Hb02vpEaSiGIl
         ncSgGwe7CY5Gts1HP5bQ3v0KcVoEgQGpgVslok4z4r7AeV23Rc8J2zS14YupvtbEsmlK
         OVFE1fxD4aYiHURBQgziWOQHJeKK2MXnkYlVwiYQh6qhgBRjIMFtyTMItdCmLWTgQnXw
         AE8A==
X-Gm-Message-State: ACrzQf2mdVOk0U4HupQzGca4UU4t6zJbdLG2JapMND8L7u0e5h50pBTv
        +hE7g/cx596idVfVSw9wSbgT/w==
X-Google-Smtp-Source: AMsMyM4Kcqj7iaeTFSgnPboPDJcmYDvSGBzBAfopbwGlsGHAlwhMCX86GfBtADSsZGEx5aSm5j7eEQ==
X-Received: by 2002:a05:6402:2b8b:b0:43a:5475:f1ae with SMTP id fj11-20020a0564022b8b00b0043a5475f1aemr16246555edb.363.1663606787204;
        Mon, 19 Sep 2022 09:59:47 -0700 (PDT)
Received: from [127.0.0.1] (2a02-8440-6340-f287-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6340:f287:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id cf16-20020a0564020b9000b0044fc3c0930csm20424246edb.16.2022.09.19.09.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 09:59:46 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 19 Sep 2022 18:56:00 +0200
Subject: [PATCH v1 02/17] clk: mediatek: add VDOSYS1 clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220919-v1-2-4844816c9808@baylibre.com>
References: <20220919-v1-0-4844816c9808@baylibre.com>
In-Reply-To: <20220919-v1-0-4844816c9808@baylibre.com>
To:     Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org,
        Guillaume Ranquet <granquet@baylibre.com>,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.0-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Sun <pablo.sun@mediatek.com>

Add the clock gate definition for the DPI1 hardware
in VDOSYS1.

The parent clock "hdmi_txpll" is already defined in
`mt8195.dtsi`.

Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index d54d7726d186..835335b9d87b 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -34,6 +34,12 @@ static const struct mtk_gate_regs vdo1_3_cg_regs = {
 	.sta_ofs = 0x140,
 };
 
+static const struct mtk_gate_regs vdo1_4_cg_regs = {
+	.set_ofs = 0x400,
+	.clr_ofs = 0x400,
+	.sta_ofs = 0x400,
+};
+
 #define GATE_VDO1_0(_id, _name, _parent, _shift)			\
 	GATE_MTK(_id, _name, _parent, &vdo1_0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
@@ -50,6 +56,9 @@ static const struct mtk_gate_regs vdo1_3_cg_regs = {
 #define GATE_VDO1_3(_id, _name, _parent, _shift)			\
 	GATE_MTK(_id, _name, _parent, &vdo1_3_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
+#define GATE_VDO1_4(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdo1_4_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
 static const struct mtk_gate vdo1_clks[] = {
 	/* VDO1_0 */
 	GATE_VDO1_0(CLK_VDO1_SMI_LARB2, "vdo1_smi_larb2", "top_vpp", 0),
@@ -107,6 +116,8 @@ static const struct mtk_gate vdo1_clks[] = {
 	GATE_VDO1_2(CLK_VDO1_DISP_MONITOR_DPINTF, "vdo1_disp_monitor_dpintf", "top_vpp", 17),
 	/* VDO1_3 */
 	GATE_VDO1_3(CLK_VDO1_26M_SLOW, "vdo1_26m_slow", "clk26m", 8),
+	/* VDO1_4 */
+	GATE_VDO1_4(CLK_VDO1_DPI1_HDMI, "vdo1_dpi1_hdmi", "hdmi_txpll", 0),
 };
 
 static int clk_mt8195_vdo1_probe(struct platform_device *pdev)

-- 
b4 0.10.0-dev
