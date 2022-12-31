Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CA065A39C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 11:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiLaKtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 05:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbiLaKsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 05:48:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AD5DF8C
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:48:10 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id u9so56514497ejo.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92vCEFunDnJilFe+WJ9pRjfQwG2b1QTD6AztiyuW5tU=;
        b=PMHwV0TLwHIOt66wq9WtBmkZDQs2mDIMPadIQmTX+2RDlOvOImQ0JnsOC7JO7m7TD+
         YI9SaGqZHtZAfdRGOpeTnuwvo8qERikm0aKEqEng6S8IJKTsNSK2ksIJI8opPigA8zGv
         i257MXlKMJDqPggzAC7RCBefEQVHW2bjDzJiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92vCEFunDnJilFe+WJ9pRjfQwG2b1QTD6AztiyuW5tU=;
        b=AH82PWOvoqHj3nl8TBKEm1DVHSRJo+6L7jy4J/HzhIO4N6oJOzWI5CDy+I2JWwUyYz
         NqQkfATbEmnV9pszcE7NwRp+Cu9935uKPVVi0TaLIiwU6C8AQ+WiMvvX+zUJqcebdY7S
         Ar8846lhLiNM52AvpMe2252Shxx3ni5OvblWc/Vk3ypXxIdVgUpWOtM7bEk8oD2sSb59
         BIHhUIkk/0nVW9DAjkLbfDkIWl91bR5A3wb3vHiaK2DwhDXh5jyGLghttHFsiwpX6uMH
         94vc78P4R2q6PObCYBiY7v1CEHv3C5zDaSexMWBgIxSnuzbgGKTNtLTURIC1+aiUVcEj
         S4Sw==
X-Gm-Message-State: AFqh2kopRggUZ4iV9ajR6pQK5oVJP3XiOdPB3x6VIaFdax61i6BaW6YY
        xnfQUTbf9wLQSC5zIXnEGG0DMTJeYWYfV0Zxx/Y=
X-Google-Smtp-Source: AMrXdXsabtdQQ5PR8zKCbnSi4vQMvT1MMqpDPbf7sk30gbrAc8cYJlinUTqhknMUFQUqjuvthyJxhQ==
X-Received: by 2002:a17:906:1e17:b0:84c:69f8:2ec2 with SMTP id g23-20020a1709061e1700b0084c69f82ec2mr13503668ejj.22.1672483688825;
        Sat, 31 Dec 2022 02:48:08 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090655c400b0083ffb81f01esm10765438ejp.136.2022.12.31.02.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 02:48:08 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     tommaso.merciai@amarulasolutions.com,
        linux-amarula@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>, jagan@amarulasolutions.com,
        angelo@amarulasolutions.com, anthony@amarulasolutions.com,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [RFC PATCH 11/11] arm64: dts: imx8mn: add clocks description
Date:   Sat, 31 Dec 2022 11:47:36 +0100
Message-Id: <20221231104736.12635-12-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221231104736.12635-1-dario.binacchi@amarulasolutions.com>
References: <20221231104736.12635-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch creates a unique node for each clock in the imx8mn clock
control module (CCM).

To ensure backwards compatibility it was not possible to separate the
changes to the device tree from those applied to the clocks setup code.
In doing so, all clocks are initialized from the device tree and the
legacy setup code with hardwired parameters is removed.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 .../boot/dts/freescale/imx8mn-clocks.dtsi     | 1885 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |   54 +-
 drivers/clk/imx/clk-imx8mn.c                  |  714 ++-----
 3 files changed, 2086 insertions(+), 567 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-clocks.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-clocks.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-clocks.dtsi
new file mode 100644
index 000000000000..21e02ea996d0
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mn-clocks.dtsi
@@ -0,0 +1,1885 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Device Tree Source for imx8mn clock data
+ *
+ * Copyright (c) 2022 Amarula Solutions
+ *
+ * Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+/ {
+	osc_32k: clock-osc-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "osc_32k";
+	};
+
+	osc_24m: clock-osc-24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "osc_24m";
+	};
+
+	clk_ext1: clock-ext1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <133000000>;
+		clock-output-names = "clk_ext1";
+	};
+
+	clk_ext2: clock-ext2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <133000000>;
+		clock-output-names = "clk_ext2";
+	};
+
+	clk_ext3: clock-ext3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <133000000>;
+		clock-output-names = "clk_ext3";
+	};
+
+	clk_ext4: clock-ext4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency= <133000000>;
+		clock-output-names = "clk_ext4";
+	};
+
+	clk_dummy: clock-dummy {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "dummy";
+	};
+};
+
+&anatop {
+	clk_sys_pll1: clock-sys-pll1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <800000000>;
+		clock-output-names = "sys_pll1";
+	};
+
+	clk_sys_pll2: clock-sys-pll2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1000000000>;
+		clock-output-names = "sys_pll2";
+	};
+
+	clk_sys_pll1_40m: clock-sys-pll1-40m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll1_out>;
+		clock-mult = <1>;
+		clock-div = <20>;
+		clock-output-names = "sys_pll1_40m";
+	};
+
+	clk_sys_pll1_80m: clock-sys-pll1-80m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll1_out>;
+		clock-mult = <1>;
+		clock-div = <10>;
+		clock-output-names = "sys_pll1_80m";
+	};
+
+	clk_sys_pll1_100m: clock-sys-pll1-100m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll1_out>;
+		clock-mult = <1>;
+		clock-div = <8>;
+		clock-output-names = "sys_pll1_100m";
+	};
+
+	clk_sys_pll1_133m: clock-sys-pll1-133m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll1_out>;
+		clock-mult = <1>;
+		clock-div = <6>;
+		clock-output-names = "sys_pll1_133m";
+	};
+
+	clk_sys_pll1_160m: clock-sys-pll1-160m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll1_out>;
+		clock-mult = <1>;
+		clock-div = <5>;
+	};
+
+	clk_sys_pll1_200m: clock-sys-pll1-200m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll1_out>;
+		clock-mult = <1>;
+		clock-div = <4>;
+		clock-output-names = "sys_pll1_200m";
+	};
+
+	clk_sys_pll1_266m: clock-sys-pll1-266m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll1_out>;
+		clock-mult = <1>;
+		clock-div = <3>;
+		clock-output-names = "sys_pll1_266m";
+	};
+
+	clk_sys_pll1_400m: clock-sys-pll1-400m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll1_out>;
+		clock-mult = <1>;
+		clock-div = <2>;
+		clock-output-names = "sys_pll1_400m";
+	};
+
+	clk_sys_pll1_800m: clock-sys-pll1-800m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll1_out>;
+		clock-mult = <1>;
+		clock-div = <1>;
+		clock-output-names = "sys_pll1_800m";
+	};
+
+	clk_sys_pll2_out: clock-sys-pll2-out@104 {
+		compatible = "fsl,imx8mn-gate-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll2>;
+		fsl,anatop = <&anatop 0x104>;
+		fsl,bit-shift = <11>;
+		clock-output-names = "sys_pll2_out";
+	};
+
+	clk_sys_pll2_50m: clock-sys-pll2-50m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll2_out>;
+		clock-mult = <1>;
+		clock-div = <20>;
+		clock-output-names = "sys_pll2_50m";
+	};
+
+	clk_sys_pll2_100m: clock-sys-pll2-100m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll2_out>;
+		clock-mult = <1>;
+		clock-div = <10>;
+		clock-output-names = "sys_pll2_100m";
+	};
+
+	clk_sys_pll2_125m: clock-sys-pll2-125m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll2_out>;
+		clock-mult = <1>;
+		clock-div = <8>;
+		clock-output-names = "sys_pll2_125m";
+	};
+
+	clk_sys_pll2_166m: clock-sys-pll2-166m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll2_out>;
+		clock-mult = <1>;
+		clock-div = <6>;
+		clock-output-names = "sys_pll2_166m";
+	};
+
+	clk_sys_pll2_200m: clock-sys-pll2-200m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll2_out>;
+		clock-mult = <1>;
+		clock-div = <5>;
+		clock-output-names = "sys_pll2_200m";
+	};
+
+	clk_sys_pll2_250m: clock-sys-pll2-250m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll2_out>;
+		clock-mult = <1>;
+		clock-div = <4>;
+		clock-output-names = "sys_pll2_250m";
+	};
+
+	clk_sys_pll2_333m: clock-sys-pll2-333m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll2_out>;
+		clock-mult = <1>;
+		clock-div = <3>;
+		clock-output-names = "sys_pll2_333m";
+	};
+
+	clk_sys_pll2_500m: clock-sys-pll2-500m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll2_out>;
+		clock-mult = <1>;
+		clock-div = <2>;
+		clock-output-names = "sys_pll2_500m";
+	};
+
+	clk_sys_pll2_1000m: clock-sys-pll2-1000m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll2_out>;
+		clock-mult = <1>;
+		clock-div = <1>;
+		clock-output-names = "sys_pll2_1000m";
+	};
+
+	clk_audio_pll1_ref_sel: clock-audio-pll1-ref-sel@0 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&osc_24m>, <&clk_dummy>, <&clk_dummy>, <&clk_dummy>;
+		fsl,anatop = <&anatop 0x0>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "audio_pll1_ref_sel";
+	};
+
+	clk_audio_pll1: clock-audio-pll1@0 {
+		compatible = "fsl,pll14xx-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_audio_pll1_ref_sel>;
+		fsl,anatop = <&anatop 0x0>;
+		fsl,type = "1443x";
+		clock-output-names = "audio_pll1";
+	};
+
+	clk_audio_pll1_bypass: clock-audio-pll1-bypass@0 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_audio_pll1>, <&clk_audio_pll1_ref_sel>;
+		fsl,anatop = <&anatop 0x0>;
+		fsl,bit-shift = <16>;
+		fsl,set-rate-parent;
+		clock-output-names = "audio_pll1_bypass";
+	};
+
+	clk_audio_pll1_out: clock-audio-pll1-out@0 {
+		compatible = "fsl,imx8mn-gate-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_audio_pll1_bypass>;
+		fsl,anatop = <&anatop 0x0>;
+		fsl,bit-shift = <13>;
+		clock-output-names = "audio_pll1_out";
+	};
+
+	clk_audio_pll2_ref_sel: clock-audio-pll2-ref-sel@14 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&osc_24m>, <&clk_dummy>, <&clk_dummy>, <&clk_dummy>;
+		fsl,anatop = <&anatop 0x14>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "audio_pll2_ref_sel";
+	};
+
+	clk_audio_pll2: clock-audio-pll2@14 {
+		compatible = "fsl,pll14xx-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_audio_pll2_ref_sel>;
+		fsl,anatop = <&anatop 0x14>;
+		fsl,type = "1443x";
+		clock-output-names = "audio_pll2";
+	};
+
+	clk_audio_pll2_bypass: clock-audio-pll2-bypass@14 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_audio_pll2>, <&clk_audio_pll2_ref_sel>;
+		fsl,anatop = <&anatop 0x14>;
+		fsl,bit-shift = <16>;
+		fsl,set-rate-parent;
+		clock-output-names = "audio_pll2_bypass";
+	};
+
+	clk_audio_pll2_out: clock-audio-pll2-out@14 {
+		compatible = "fsl,imx8mn-gate-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_audio_pll2_bypass>;
+		fsl,anatop = <&anatop 0x14>;
+		fsl,bit-shift = <13>;
+		clock-output-names = "audio_pll2_out";
+	};
+
+	clk_video_pll1_ref_sel: clock-video-pll1-ref-sel@28 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&osc_24m>, <&clk_dummy>, <&clk_dummy>, <&clk_dummy>;
+		fsl,anatop = <&anatop 0x28>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "video_pll1_ref_sel";
+	};
+
+	clk_video_pll1: clock-video-pll1@28 {
+		compatible = "fsl,pll14xx-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_video_pll1_ref_sel>;
+		fsl,anatop = <&anatop 0x28>;
+		fsl,type = "1443x";
+		clock-output-names = "video_pll1";
+	};
+
+	clk_video_pll1_bypass: clock-video-pll1-bypass@28 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_video_pll1>, <&clk_video_pll1_ref_sel>;
+		fsl,anatop = <&anatop 0x28>;
+		fsl,bit-shift = <16>;
+		fsl,set-rate-parent;
+		clock-output-names = "video_pll1_bypass";
+	};
+
+	clk_video_pll1_out: clock-video-pll1-out@28 {
+		compatible = "fsl,imx8mn-gate-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_video_pll1_bypass>;
+		fsl,anatop = <&anatop 0x28>;
+		fsl,bit-shift = <13>;
+		clock-output-names = "video_pll1_out";
+	};
+
+	clk_dram_pll_ref_sel: clock-dram-pll-ref-sel@50 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&osc_24m>, <&clk_dummy>, <&clk_dummy>, <&clk_dummy>;
+		fsl,anatop = <&anatop 0x50>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "dram_pll_ref_sel";
+	};
+
+	clk_dram_pll: clock-dram-pll@50 {
+		compatible = "fsl,pll14xx-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_dram_pll_ref_sel>;
+		fsl,anatop = <&anatop 0x50>;
+		fsl,get-rate-nocache;
+		fsl,type = "1443x";
+		clock-output-names = "dram_pll";
+	};
+
+	clk_dram_pll_bypass: clock-dram-pll-bypass@50 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_dram_pll>, <&clk_dram_pll_ref_sel>;
+		fsl,anatop = <&anatop 0x50>;
+		fsl,bit-shift = <16>;
+		fsl,set-rate-parent;
+		clock-output-names = "dram_pll_bypass";
+	};
+
+	clk_dram_pll_out: clock-dram-pll-out@50 {
+		compatible = "fsl,imx8mn-gate-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_dram_pll_bypass>;
+		fsl,anatop = <&anatop 0x50>;
+		fsl,bit-shift = <13>;
+		clock-output-names = "dram_pll_out";
+	};
+
+	clk_gpu_pll_ref_sel: clock-gpu-pll-ref-sel@64 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&osc_24m>, <&clk_dummy>, <&clk_dummy>, <&clk_dummy>;
+		fsl,anatop = <&anatop 0x64>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "gpu_pll_ref_sel";
+	};
+
+	clk_gpu_pll: clock-gpu-pll@64 {
+		compatible = "fsl,pll14xx-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_gpu_pll_ref_sel>;
+		fsl,anatop = <&anatop 0x64>;
+		fsl,type = "1416x";
+		clock-output-names = "gpu_pll";
+	};
+
+	clk_gpu_pll_bypass: clock-gpu-pll-bypass@64 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_gpu_pll>, <&clk_gpu_pll_ref_sel>;
+		fsl,anatop = <&anatop 0x64>;
+		fsl,bit-shift = <28>;
+		fsl,set-rate-parent;
+		clock-output-names = "gpu_pll_bypass";
+	};
+
+	clk_gpu_pll_out: clock-gpu-pll-out@64 {
+		compatible = "fsl,imx8mn-gate-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_gpu_pll_bypass>;
+		fsl,anatop = <&anatop 0x64>;
+		fsl,bit-shift = <11>;
+		clock-output-names = "gpu_pll_out";
+	};
+
+	clk_vpu_pll_ref_sel: clock-vpu-pll-ref-sel@74 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&osc_24m>, <&clk_dummy>, <&clk_dummy>, <&clk_dummy>;
+		fsl,anatop = <&anatop 0x74>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "vpu_pll_ref_sel";
+	};
+
+	clk_vpu_pll: clock-vpu-pll@74 {
+		compatible = "fsl,pll14xx-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_vpu_pll_ref_sel>;
+		fsl,anatop = <&anatop 0x74>;
+		fsl,type = "1416x";
+		clock-output-names = "vpu_pll";
+	};
+
+	clk_vpu_pll_bypass: clock-vpu-pll-bypass@74 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_vpu_pll>, <&clk_vpu_pll_ref_sel>;
+		fsl,anatop = <&anatop 0x74>;
+		fsl,bit-shift = <28>;
+		fsl,set-rate-parent;
+		clock-output-names = "vpu_pll_bypass";
+	};
+
+	clk_vpu_pll_out: clock-vpu-pll-out@74 {
+		compatible = "fsl,imx8mn-gate-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_vpu_pll_bypass>;
+		fsl,anatop = <&anatop 0x74>;
+		fsl,bit-shift = <11>;
+		clock-output-names = "vpu_pll_out";
+	};
+
+	clk_arm_pll_ref_sel: clock-arm-pll-ref-sel@84 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&osc_24m>, <&clk_dummy>, <&clk_dummy>, <&clk_dummy>;
+		fsl,anatop = <&anatop 0x84>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "arm_pll_ref_sel";
+	};
+
+	clk_arm_pll: clock-arm-pll@84 {
+		compatible = "fsl,pll14xx-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_arm_pll_ref_sel>;
+		fsl,anatop = <&anatop 0x84>;
+		fsl,type = "1416x";
+		clock-output-names = "arm_pll";
+	};
+
+	clk_arm_pll_bypass: clock-arm-pll-bypass@84 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_arm_pll>, <&clk_arm_pll_ref_sel>;
+		fsl,anatop = <&anatop 0x84>;
+		fsl,bit-shift = <28>;
+		fsl,set-rate-parent;
+		clock-output-names = "arm_pll_bypass";
+	};
+
+	clk_arm_pll_out: clock-arm-pll-out@84 {
+		compatible = "fsl,imx8mn-gate-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_arm_pll_bypass>;
+		fsl,anatop = <&anatop 0x84>;
+		fsl,bit-shift = <11>;
+		clock-output-names = "arm_pll_out";
+	};
+
+	clk_sys_pll1_out: clock-sys-pll1-out@94 {
+		compatible = "fsl,imx8mn-gate-clock";
+		clocks = <&clk_sys_pll1>;
+		fsl,anatop = <&anatop 0x94>;
+		fsl,bit-shift = <11>;
+		clock-output-names = "sys_pll1_out";
+		#clock-cells = <0>;
+	};
+
+	clk_sys_pll3_ref_sel: clock-sys-pll3-ref-sel@114 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&osc_24m>, <&clk_dummy>, <&clk_dummy>, <&clk_dummy>;
+		fsl,anatop = <&anatop 0x114>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "sys_pll3_ref_sel";
+	};
+
+	clk_sys_pll3: clock-sys-pll3@114 {
+		compatible = "fsl,pll14xx-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll3_ref_sel>;
+		fsl,anatop = <&anatop 0x114>;
+		fsl,type = "1416x";
+		clock-output-names = "sys_pll3";
+	};
+
+	clk_sys_pll3_bypass: clock-sys-pll3-bypass@114 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll3>, <&clk_sys_pll3_ref_sel>;
+		fsl,anatop = <&anatop 0x114>;
+		fsl,bit-shift = <28>;
+		fsl,set-rate-parent;
+		clock-output-names = "sys_pll3_bypass";
+	};
+
+	clk_sys_pll3_out: clock-sys-pll3-out@114 {
+		compatible = "fsl,imx8mn-gate-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_sys_pll3_bypass>;
+		fsl,anatop = <&anatop 0x114>;
+		fsl,bit-shift = <11>;
+		clock-output-names = "sys_pll3_out";
+	};
+
+	clk_out1_sel: clock-out1-sel@128 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_audio_pll1_out>, <&clk_audio_pll2_out>,
+			 <&clk_video_pll1_out>, <&clk_dummy>, <&clk_dummy>,
+			 <&clk_gpu_pll_out>, <&clk_dummy>, <&clk_arm_pll_out>,
+			 <&clk_sys_pll1>, <&clk_sys_pll2>, <&clk_sys_pll3>,
+			 <&clk_dummy>, <&clk_dummy>, <&osc_24m>, <&clk_dummy>,
+			 <&osc_32k>;
+		fsl,anatop = <&anatop 0x128>;
+		fsl,bit-shift = <4>;
+		fsl,ops-parent-enable;
+		clock-output-names = "clkout1_sel";
+	};
+
+	clk_out1_div: clock-out1-div@128 {
+		compatible = "fsl,imx8mn-divider-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_out1_sel>;
+		fsl,anatop = <&anatop 0x128>;
+		fsl,bit-shift = <0>;
+		fsl,width = <4>;
+		fsl,set-rate-parent;
+		clock-output-names = "clkout1_div";
+	};
+
+	clk_out1: clock-out1@128 {
+		compatible = "fsl,imx8mn-gate-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_out1_div>;
+		fsl,anatop = <&anatop 0x128>;
+		fsl,bit-shift = <8>;
+		clock-output-names = "clkout1";
+	};
+
+	clk_out2_sel: clock-out2-sel@128 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_audio_pll1_out>, <&clk_audio_pll2_out>,
+			 <&clk_video_pll1_out>, <&clk_dummy>, <&clk_dummy>,
+			 <&clk_gpu_pll_out>, <&clk_dummy>, <&clk_arm_pll_out>,
+			 <&clk_sys_pll1>, <&clk_sys_pll2>, <&clk_sys_pll3>,
+			 <&clk_dummy>, <&clk_dummy>, <&osc_24m>, <&clk_dummy>,
+			 <&osc_32k>;
+		fsl,anatop = <&anatop 0x128>;
+		fsl,bit-shift = <20>;
+		fsl,ops-parent-enable;
+		clock-output-names = "clkout2_sel";
+	};
+
+	clk_out2_div: clock-out2-div@128 {
+		compatible = "fsl,imx8mn-divider-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_out2_sel>;
+		fsl,anatop = <&anatop 0x128>;
+		fsl,bit-shift = <16>;
+		fsl,width = <4>;
+		fsl,set-rate-parent;
+		clock-output-names = "clkout2_div";
+	};
+
+	clk_out2: clock-out2@128 {
+		compatible = "fsl,imx8mn-gate-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_out2_div>;
+		fsl,anatop = <&anatop 0x128>;
+		fsl,bit-shift = <24>;
+		clock-output-names = "clkout2";
+	};
+};
+
+&clk {
+	clk_arm_a53_div: clock-arm-a53-div@30388000 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x30388000 0x4>;
+		clocks = <&osc_24m>, <&clk_arm_pll_out>, <&clk_sys_pll2_500m>,
+			 <&clk_sys_pll2_1000m>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll1_400m>, <&clk_audio_pll1_out>,
+			 <&clk_sys_pll3_out>;
+		clock-output-names = "arm_a53_div";
+	};
+
+	clk_arm_m7_core: clock-arm-m7-core@30388080 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x30388080 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_200m>, <&clk_sys_pll2_250m>,
+			 <&clk_vpu_pll_out>, <&clk_sys_pll1_800m>,
+			 <&clk_audio_pll1_out>, <&clk_video_pll1_out>,
+			 <&clk_sys_pll3_out>;
+		clock-output-names = "arm_m7_core";
+	};
+
+	clk_gpu_core: clock-gpu-core@30388180 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x30388180 0x4>;
+		clocks = <&osc_24m>, <&clk_gpu_pll_out>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll3_out>, <&clk_sys_pll2_1000m>,
+			 <&clk_audio_pll1_out>, <&clk_video_pll1_out>,
+			 <&clk_audio_pll2_out>;
+		clock-output-names = "gpu_core";
+	};
+
+	clk_gpu_shader: clock-gpu-shader@30388200 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x30388200 0x4>;
+		clocks = <&osc_24m>, <&clk_gpu_pll_out>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll3_out>, <&clk_sys_pll2_1000m>,
+			 <&clk_audio_pll1_out>, <&clk_video_pll1_out>,
+			 <&clk_audio_pll2_out>;
+		clock-output-names = "gpu_shader";
+	};
+
+	clk_arm_a53_core: clock-arm-a53-core@30389880 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		reg = <0x30389880 0x4>;
+		clocks = <&clk_arm_a53_div>, <&clk_arm_pll_out>;
+		fsl,bit-shift = <24>;
+		fsl,ops-parent-enable;
+		clock-output-names = "arm_a53_core";
+	};
+
+	clk_main_axi: clock-main-axi@30388800 {
+		compatible = "fsl,imx8m-composite-bus-clock";
+		#clock-cells = <0>;
+		reg = <0x30388800 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_333m>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll2_250m>, <&clk_sys_pll2_1000m>,
+			 <&clk_audio_pll1_out>, <&clk_video_pll1_out>,
+			 <&clk_sys_pll1_100m>;
+		fsl,is-critical;
+		clock-output-names = "main_axi";
+	};
+
+	clk_enet_axi: clock-enet-axi@30388880 {
+		compatible = "fsl,imx8m-composite-bus-clock";
+		#clock-cells = <0>;
+		reg = <0x30388880 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_266m>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll2_250m>, <&clk_sys_pll2_200m>,
+			 <&clk_audio_pll1_out>, <&clk_video_pll1_out>,
+			 <&clk_sys_pll3_out>;
+		clock-output-names = "enet_axi";
+	};
+
+	clk_nand_usdhc_bus: clock-nand-usdhc-bus@30388900 {
+		compatible = "fsl,imx8m-composite-bus-clock";
+		#clock-cells = <0>;
+		reg = <0x30388900 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_266m>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll2_200m>, <&clk_sys_pll1_133m>,
+			 <&clk_sys_pll3_out>, <&clk_sys_pll2_250m>,
+			 <&clk_audio_pll1_out>;
+		clock-output-names = "nand_usdhc_bus";
+	};
+
+	clk_disp_axi: clock-disp-axi@30388a00 {
+		compatible = "fsl,imx8m-composite-bus-clock";
+		#clock-cells = <0>;
+		reg = <0x30388a00 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_1000m>,
+			 <&clk_sys_pll1_800m>, <&clk_sys_pll3_out>,
+			 <&clk_sys_pll1_40m>, <&clk_audio_pll2_out>,
+			 <&clk_ext1>, <&clk_ext4>;
+		clock-output-names = "disp_axi";
+	};
+
+	clk_disp_apb: clock-disp-apb@30388a80 {
+		compatible = "fsl,imx8m-composite-bus-clock";
+		#clock-cells = <0>;
+		reg = <0x30388a80 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_125m>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll3_out>, <&clk_sys_pll1_40m>,
+			 <&clk_audio_pll2_out>, <&clk_ext1>, <&clk_ext3>;
+		clock-output-names = "disp_apb";
+	};
+
+	clk_usb_bus: clock-usb-bus@30388b80 {
+		compatible = "fsl,imx8m-composite-bus-clock";
+		#clock-cells = <0>;
+		reg = <0x30388b80 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_500m>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll2_100m>, <&clk_sys_pll2_200m>,
+			 <&clk_ext2>, <&clk_ext4>, <&clk_audio_pll2_out>;
+		clock-output-names = "usb_bus";
+	};
+
+	clk_gpu_axi: clock-gpu-axi@30388c00 {
+		compatible = "fsl,imx8m-composite-bus-clock";
+		#clock-cells = <0>;
+		reg = <0x30388c00 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_800m>, <&clk_gpu_pll_out>,
+			 <&clk_sys_pll3_out>, <&clk_sys_pll2_1000m>,
+			 <&clk_audio_pll1_out>, <&clk_video_pll1_out>,
+			 <&clk_audio_pll2_out>;
+		clock-output-names = "gpu_axi";
+	};
+
+	clk_gpu_ahb: clock-gpu-ahb@30388c80 {
+		compatible = "fsl,imx8m-composite-bus-clock";
+		#clock-cells = <0>;
+		reg = <0x30388c80 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_800m>, <&clk_gpu_pll_out>,
+			 <&clk_sys_pll3_out>, <&clk_sys_pll2_1000m>,
+			 <&clk_audio_pll1_out>, <&clk_video_pll1_out>,
+			 <&clk_audio_pll2_out>;
+		clock-output-names = "gpu_ahb";
+	};
+
+	clk_noc: clock-noc@30388d00 {
+		compatible = "fsl,imx8m-composite-bus-clock";
+		#clock-cells = <0>;
+		reg = <0x30388d00 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_800m>, <&clk_sys_pll3_out>,
+			 <&clk_sys_pll2_1000m>, <&clk_sys_pll2_500m>,
+			 <&clk_audio_pll1_out>, <&clk_video_pll1_out>,
+			 <&clk_audio_pll2_out>;
+		fsl,is-critical;
+		clock-output-names = "noc";
+	};
+
+	clk_ahb: clock-ahb@30389000 {
+		compatible = "fsl,imx8m-composite-bus-clock";
+		#clock-cells = <0>;
+		reg = <0x30389000 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_133m>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll1_400m>, <&clk_sys_pll2_125m>,
+			 <&clk_sys_pll3_out>, <&clk_audio_pll1_out>,
+			 <&clk_video_pll1_out>;
+		fsl,is-critical;
+		clock-output-names = "ahb";
+	};
+
+
+	clk_ipg_root: clock-ipg-root@30389080 {
+		compatible = "fsl,imx8mn-divider-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_ahb>;
+		reg = <0x30389080 0x4>;
+		fsl,bit-shift = <0>;
+		fsl,width = <1>;
+		fsl,ops-parent-enable;
+		fsl,set-rate-parent;
+		clock-output-names = "ipg_root";
+	};
+
+	clk_audio_ahb: clock-audio-ahb@30389100 {
+		compatible = "fsl,imx8m-composite-bus-clock";
+		#clock-cells = <0>;
+		reg = <0x30389100 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_500m>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll2_1000m>, <&clk_sys_pll2_166m>,
+			 <&clk_sys_pll3_out>, <&clk_audio_pll1_out>,
+			 <&clk_video_pll1_out>;
+		clock-output-names = "audio_ahb";
+	};
+
+	clk_ipg_audio_root: clock-ipg-audio-root@30389180 {
+		compatible = "fsl,imx8mn-divider-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_audio_ahb>;
+		reg = <0x30389180 0x4>;
+		fsl,bit-shift = <0>;
+		fsl,width = <1>;
+		fsl,ops-parent-enable;
+		fsl,set-rate-parent;
+		clock-output-names = "ipg_audio_root";
+	};
+
+	clk_dram_alt: clock-dram-alt@3038a000 {
+		compatible = "fsl,imx8m-composite-fw-managed-clock";
+		#clock-cells = <0>;
+		reg = <0x3038a000 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_800m>, <&clk_sys_pll1_100m>,
+			 <&clk_sys_pll2_500m>, <&clk_sys_pll2_1000m>,
+			 <&clk_sys_pll3_out>, <&clk_audio_pll1_out>,
+			 <&clk_sys_pll1_266m>;
+		fsl,get-rate-nocache;
+		clock-output-names = "dram_alt";
+	};
+
+	clk_dram_alt_root: clock-dram-alt-root {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_dram_alt>;
+		clock-mult = <1>;
+		clock-div = <4>;
+		clock-output-names = "dram_alt_root";
+	};
+
+	clk_dram_core: clock-dram-core@30389800 {
+		compatible = "fsl,imx8mn-mux-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_dram_pll_out>, <&clk_dram_alt_root>;
+		reg = <0x30389800 0x4>;
+		fsl,bit-shift = <24>;
+		fsl,is-critical;
+		fsl,ops-parent-enable;
+		clock-output-names = "dram_core_clk";
+	};
+
+	clk_dram_apb: clock-dram-apb@3038a080 {
+		compatible = "fsl,imx8m-composite-fw-managed-clock";
+		#clock-cells = <0>;
+		reg = <0x3038a080 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_200m>, <&clk_sys_pll1_40m>,
+			 <&clk_sys_pll1_160m>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll3_out>, <&clk_sys_pll2_250m>,
+			 <&clk_audio_pll2_out>;
+		fsl,get-rate-nocache;
+		fsl,is-critical;
+		clock-output-names = "dram_apb";
+	};
+
+	clk_disp_pixel: clock-disp-pixel@3038a500 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038a500 0x4>;
+		clocks = <&osc_24m>, <&clk_video_pll1_out>,
+			 <&clk_audio_pll2_out>, <&clk_audio_pll1_out>,
+			 <&clk_sys_pll1_800m>, <&clk_sys_pll2_1000m>,
+			 <&clk_sys_pll3_out>, <&clk_ext4>;
+		clock-output-names = "disp_pixel";
+	};
+
+	clk_sai2: clock-sai2@3038a600 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038a600 0x4>;
+		clocks = <&osc_24m>, <&clk_audio_pll1_out>,
+			 <&clk_audio_pll2_out>, <&clk_video_pll1_out>,
+			 <&clk_sys_pll1_133m>, <&clk_dummy>, <&clk_ext2>,
+			 <&clk_ext3>;
+		clock-output-names = "sai2";
+	};
+
+	clk_sai3: clock-sai3@3038a680 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038a680 0x4>;
+		clocks = <&osc_24m>, <&clk_audio_pll1_out>,
+			 <&clk_audio_pll2_out>, <&clk_video_pll1_out>,
+			 <&clk_sys_pll1_133m>, <&clk_dummy>, <&clk_ext3>,
+			 <&clk_ext4>;
+		clock-output-names = "sai3";
+	};
+
+	clk_sai5: clock-sai5@3038a780 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038a780 0x4>;
+		clocks = <&osc_24m>, <&clk_audio_pll1_out>,
+			 <&clk_audio_pll2_out>, <&clk_video_pll1_out>,
+			 <&clk_sys_pll1_133m>, <&clk_dummy>, <&clk_ext2>,
+			 <&clk_ext3>;
+		clock-output-names = "sai5";
+	};
+
+	clk_sai6: clock-sai6@3038a800 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038a800 0x4>;
+		clocks = <&osc_24m>, <&clk_audio_pll1_out>,
+			 <&clk_audio_pll2_out>, <&clk_video_pll1_out>,
+			 <&clk_sys_pll1_133m>, <&clk_dummy>, <&clk_ext3>,
+			 <&clk_ext4>;
+		clock-output-names = "sai6";
+	};
+
+	clk_spdif1: clock-spdif1@3038a880 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038a880 0x4>;
+		clocks = <&osc_24m>, <&clk_audio_pll1_out>,
+			 <&clk_audio_pll2_out>, <&clk_video_pll1_out>,
+			 <&clk_sys_pll1_133m>, <&clk_dummy>, <&clk_ext2>,
+			 <&clk_ext3>;
+		clock-output-names = "spdif1";
+	};
+
+	clk_enet_ref: clock-enet-ref@3038a980 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038a980 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_125m>, <&clk_sys_pll2_50m>,
+			 <&clk_sys_pll2_100m>, <&clk_sys_pll1_160m>,
+			 <&clk_audio_pll1_out>, <&clk_video_pll1_out>,
+			 <&clk_ext4>;
+		clock-output-names = "enet_ref";
+	};
+
+	clk_enet_timer: clock-enet-timer@3038aa00 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038aa00 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_100m>,
+			 <&clk_audio_pll1_out>, <&clk_ext1>, <&clk_ext2>,
+			 <&clk_ext3>, <&clk_ext4>, <&clk_video_pll1_out>;
+		clock-output-names = "enet_timer";
+	};
+
+	clk_enet_phy: clock-enet-phy@3038aa80 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038aa80 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_50m>, <&clk_sys_pll2_125m>,
+			 <&clk_sys_pll2_200m>, <&clk_sys_pll2_500m>,
+			 <&clk_audio_pll1_out>, <&clk_video_pll1_out>,
+			 <&clk_audio_pll2_out>;
+		clock-output-names = "enet_phy";
+	};
+
+	clk_nand: clock-nand@3038ab00 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038ab00 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_500m>,
+			 <&clk_audio_pll1_out>, <&clk_sys_pll1_400m>,
+			 <&clk_audio_pll2_out>, <&clk_sys_pll3_out>,
+			 <&clk_sys_pll2_250m>, <&clk_video_pll1_out>;
+		clock-output-names = "nand";
+	};
+
+	clk_qspi: clock-qspi@3038ab80 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038ab80 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_400m>, <&clk_sys_pll2_333m>,
+			 <&clk_sys_pll2_500m>, <&clk_audio_pll2_out>,
+			 <&clk_sys_pll1_266m>, <&clk_sys_pll3_out>,
+			 <&clk_sys_pll1_100m>;
+		clock-output-names = "qspi";
+	};
+
+	clk_usdhc1: clock-usdhc1@3038ac00 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038ac00 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_400m>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll2_500m>, <&clk_sys_pll3_out>,
+			 <&clk_sys_pll1_266m>, <&clk_audio_pll2_out>,
+			 <&clk_sys_pll1_100m>;
+		clock-output-names = "usdhc1";
+	};
+
+	clk_usdhc2: clock-usdhc2@3038ac80 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038ac80 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_400m>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll2_500m>, <&clk_sys_pll3_out>,
+			 <&clk_sys_pll1_266m>, <&clk_audio_pll2_out>,
+			 <&clk_sys_pll1_100m>;
+		clock-output-names = "usdhc2";
+	};
+
+	clk_i2c1: clock-i2c1@3038ad00 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038ad00 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_160m>, <&clk_sys_pll2_50m>,
+			 <&clk_sys_pll3_out>, <&clk_audio_pll1_out>,
+			 <&clk_video_pll1_out>, <&clk_audio_pll2_out>,
+			 <&clk_sys_pll1_133m>;
+		clock-output-names = "i2c1";
+	};
+
+	clk_i2c2: clock-i2c2@3038ad80 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038ad80 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_160m>, <&clk_sys_pll2_50m>,
+			 <&clk_sys_pll3_out>, <&clk_audio_pll1_out>,
+			 <&clk_video_pll1_out>, <&clk_audio_pll2_out>,
+			 <&clk_sys_pll1_133m>;
+		clock-output-names = "i2c2";
+	};
+
+	clk_i2c3: clock-i2c3@3038ae00 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038ae00 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_160m>, <&clk_sys_pll2_50m>,
+			 <&clk_sys_pll3_out>, <&clk_audio_pll1_out>,
+			 <&clk_video_pll1_out>, <&clk_audio_pll2_out>,
+			 <&clk_sys_pll1_133m>;
+		clock-output-names = "i2c3";
+	};
+
+	clk_i2c4: clock-i2c4@3038ae80 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038ae80 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_160m>, <&clk_sys_pll2_50m>,
+			 <&clk_sys_pll3_out>, <&clk_audio_pll1_out>,
+			 <&clk_video_pll1_out>, <&clk_audio_pll2_out>,
+			 <&clk_sys_pll1_133m>;
+		clock-output-names = "i2c4";
+	};
+
+	clk_uart1: clock-uart1@3038af00 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038af00 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_80m>, <&clk_sys_pll2_200m>,
+			 <&clk_sys_pll2_100m>, <&clk_sys_pll3_out>,
+			 <&clk_ext2>, <&clk_ext4>, <&clk_audio_pll2_out>;
+		clock-output-names = "uart1";
+	};
+
+	clk_uart2: clock-uart2@3038af80 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038af80 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_80m>, <&clk_sys_pll2_200m>,
+			 <&clk_sys_pll2_100m>, <&clk_sys_pll3_out>,
+			 <&clk_ext2>, <&clk_ext3>, <&clk_audio_pll2_out>;
+		clock-output-names = "uart2";
+	};
+
+	clk_uart3: clock-uart3@3038b000 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038b000 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_80m>, <&clk_sys_pll2_200m>,
+			 <&clk_sys_pll2_100m>, <&clk_sys_pll3_out>,
+			 <&clk_ext2>, <&clk_ext4>, <&clk_audio_pll2_out>;
+		clock-output-names = "uart3";
+	};
+
+	clk_uart4: clock-uart4@3038b080 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038b080 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_80m>, <&clk_sys_pll2_200m>,
+			 <&clk_sys_pll2_100m>, <&clk_sys_pll3_out>,
+			 <&clk_ext2>, <&clk_ext3>, <&clk_audio_pll2_out>;
+		clock-output-names = "uart4";
+	};
+
+	clk_usb_core_ref: clock-usb-core-ref@3038b100 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038b100 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_100m>, <&clk_sys_pll1_40m>,
+			 <&clk_sys_pll2_100m>, <&clk_sys_pll2_200m>,
+			 <&clk_ext2>, <&clk_ext3>, <&clk_audio_pll2_out>;
+		clock-output-names = "usb_core_ref";
+	};
+
+	clk_usb_phy_ref: clock-usb-phy-ref@3038b180 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038b180 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_100m>, <&clk_sys_pll1_40m>,
+			 <&clk_sys_pll2_100m>, <&clk_sys_pll2_200m>,
+			 <&clk_ext2>, <&clk_ext3>, <&clk_audio_pll2_out>;
+		clock-output-names = "usb_phy_ref";
+	};
+
+	clk_gic: clock-gic@3038b200 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038b200 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_200m>, <&clk_sys_pll1_40m>,
+			 <&clk_sys_pll2_100m>, <&clk_sys_pll1_800m>,
+			 <&clk_ext2>, <&clk_ext4>, <&clk_audio_pll2_out>;
+		fsl,is-critical;
+		clock-output-names = "gic";
+	};
+
+	clk_ecspi1: clock-ecspi1@3038b280 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038b280 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_200m>, <&clk_sys_pll1_40m>,
+			 <&clk_sys_pll1_160m>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll3_out>, <&clk_sys_pll2_250m>,
+			 <&clk_audio_pll2_out>;
+		clock-output-names = "ecspi1";
+	};
+
+	clk_ecspi2: clock-ecspi2@3038b300 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038b300 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_200m>, <&clk_sys_pll1_40m>,
+			 <&clk_sys_pll1_160m>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll3_out>, <&clk_sys_pll2_250m>,
+			 <&clk_audio_pll2_out>;
+		clock-output-names = "ecspi2";
+	};
+
+	clk_pwm1: clock-pwm1@3038b380 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038b380 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_100m>, <&clk_sys_pll1_160m>,
+			 <&clk_sys_pll1_40m>, <&clk_sys_pll3_out>, <&clk_ext1>,
+			 <&clk_sys_pll1_80m>, <&clk_video_pll1_out>;
+		clock-output-names = "pwm1";
+	};
+
+	clk_pwm2: clock-pwm2@3038b400 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038b400 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_100m>, <&clk_sys_pll1_160m>,
+			 <&clk_sys_pll1_40m>, <&clk_sys_pll3_out>, <&clk_ext1>,
+			 <&clk_sys_pll1_80m>, <&clk_video_pll1_out>;
+		clock-output-names = "pwm2";
+	};
+
+	clk_pwm3: clock-pwm3@3038b480 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038b480 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_100m>, <&clk_sys_pll1_160m>,
+			 <&clk_sys_pll1_40m>, <&clk_sys_pll3_out>, <&clk_ext2>,
+			 <&clk_sys_pll1_80m>, <&clk_video_pll1_out>;
+		clock-output-names = "pwm3";
+	};
+
+	clk_pwm4: clock-pwm4@3038b500 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038b500 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_100m>, <&clk_sys_pll1_160m>,
+			 <&clk_sys_pll1_40m>, <&clk_sys_pll3_out>, <&clk_ext2>,
+			 <&clk_sys_pll1_80m>, <&clk_video_pll1_out>;
+		clock-output-names = "pwm4";
+	};
+
+	clk_wdog: clock-wdog@3038b900 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038b900 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_133m>, <&clk_sys_pll1_160m>,
+			 <&clk_vpu_pll_out>, <&clk_sys_pll2_125m>,
+			 <&clk_sys_pll3_out>, <&clk_sys_pll1_80m>,
+			 <&clk_sys_pll2_166m>;
+		clock-output-names = "wdog";
+	};
+
+	clk_wrclk: clock-wrclk@3038b980 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038b980 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_40m>, <&clk_vpu_pll_out>,
+			 <&clk_sys_pll3_out>, <&clk_sys_pll2_200m>,
+			 <&clk_sys_pll1_266m>, <&clk_sys_pll2_500m>,
+			 <&clk_sys_pll1_100m>;
+		clock-output-names = "wrclk";
+	};
+
+	clk_clko1: clock-clko1@3038ba00 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038ba00 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_800m>, <&clk_dummy>,
+			 <&clk_sys_pll1_200m>, <&clk_audio_pll2_out>,
+			 <&clk_sys_pll2_500m>, <&clk_vpu_pll_out>,
+			 <&clk_sys_pll1_80m>;
+		clock-output-names = "clko1";
+	};
+
+	clk_clko2: clock-clko2@3038ba80 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038ba80 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_200m>, <&clk_sys_pll1_400m>,
+			 <&clk_sys_pll2_166m>, <&clk_sys_pll3_out>,
+			 <&clk_audio_pll1_out>, <&clk_video_pll1_out>,
+			 <&osc_32k>;
+		clock-output-names = "clko2";
+	};
+
+	clk_dsi_core: clock-dsi-core@3038bb00 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038bb00 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_266m>, <&clk_sys_pll2_250m>,
+			 <&clk_sys_pll1_800m>, <&clk_sys_pll2_1000m>,
+			 <&clk_sys_pll3_out>, <&clk_audio_pll2_out>,
+			 <&clk_video_pll1_out>;
+		clock-output-names = "dsi_core";
+	};
+
+	clk_dsi_phy_ref: clock-dsi-phy-ref@3038bb80 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038bb80 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_125m>, <&clk_sys_pll2_100m>,
+			 <&clk_sys_pll1_800m>, <&clk_sys_pll2_1000m>,
+			 <&clk_ext2>, <&clk_audio_pll2_out>,
+			 <&clk_video_pll1_out>;
+		clock-output-names = "dsi_phy_ref";
+	};
+
+	clk_dsi_dbi: clock-dsi-dbi@3038bc00 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038bc00 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_266m>, <&clk_sys_pll2_100m>,
+			 <&clk_sys_pll1_800m>, <&clk_sys_pll2_1000m>,
+			 <&clk_sys_pll3_out>, <&clk_audio_pll2_out>,
+			 <&clk_video_pll1_out>;
+		clock-output-names = "dsi_dbi";
+	};
+
+	clk_usdhc3: clock-usdhc3@3038bc80 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038bc80 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_400m>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll2_500m>, <&clk_sys_pll3_out>,
+			 <&clk_sys_pll1_266m>, <&clk_audio_pll2_out>,
+			 <&clk_sys_pll1_100m>;
+		clock-output-names = "usdhc3";
+	};
+
+	clk_camera_pixel: clock-camera-pixel@3038bd00 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038bd00 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll1_266m>, <&clk_sys_pll2_250m>,
+			 <&clk_sys_pll1_800m>, <&clk_sys_pll2_1000m>,
+			 <&clk_sys_pll3_out>, <&clk_audio_pll2_out>,
+			 <&clk_video_pll1_out>;
+		clock-output-names = "camera_pixel";
+	};
+
+	clk_csi1_phy_ref: clock-csi1-phy-ref@3038bd80 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038bd80 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_333m>, <&clk_sys_pll2_100m>,
+			 <&clk_sys_pll1_800m>, <&clk_sys_pll2_1000m>,
+			 <&clk_ext2>, <&clk_audio_pll2_out>,
+			 <&clk_video_pll1_out>;
+		clock-output-names = "csi1_phy_ref";
+	};
+
+	clk_csi2_phy_ref: clock-csi2-phy-ref@3038bf00 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038bf00 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_333m>, <&clk_sys_pll2_100m>,
+			 <&clk_sys_pll1_800m>, <&clk_sys_pll2_1000m>,
+			 <&clk_ext2>, <&clk_audio_pll2_out>,
+			 <&clk_video_pll1_out>;
+		clock-output-names = "csi2_phy_ref";
+	};
+
+	clk_csi2_esc: clock-csi2-esc@3038bf80 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038bf80 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_100m>, <&clk_sys_pll1_80m>,
+			 <&clk_sys_pll1_800m>, <&clk_sys_pll2_1000m>,
+			 <&clk_sys_pll3_out>, <&clk_ext3>,
+			 <&clk_audio_pll2_out>;
+		clock-output-names = "csi2_esc";
+	};
+
+	clk_ecspi3: clock-ecspi3@3038c180 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038c180 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_200m>, <&clk_sys_pll1_40m>,
+			 <&clk_sys_pll1_160m>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll3_out>, <&clk_sys_pll2_250m>,
+			 <&clk_audio_pll2_out>;
+		clock-output-names = "ecspi3";
+	};
+
+	clk_pdm: clock-pdm@3038c200 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038c200 0x4>;
+		clocks = <&osc_24m>, <&clk_sys_pll2_100m>,
+			 <&clk_audio_pll1_out>, <&clk_sys_pll1_800m>,
+			 <&clk_sys_pll2_1000m>, <&clk_sys_pll3_out>,
+			 <&clk_ext3>, <&clk_audio_pll2_out>;
+		clock-output-names = "pdm";
+	};
+
+	clk_sai7: clock-sai7@3038c300 {
+		compatible = "fsl,imx8m-composite-clock";
+		#clock-cells = <0>;
+		reg = <0x3038c300 0x4>;
+		clocks = <&osc_24m>, <&clk_audio_pll1_out>,
+			 <&clk_audio_pll2_out>, <&clk_video_pll1_out>,
+			 <&clk_sys_pll1_133m>, <&clk_dummy>, <&clk_ext3>,
+			 <&clk_ext4>;
+		clock-output-names = "sai7";
+	};
+
+	clk_ecspi1_root: clock-ecspi1-root@30384070 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384070 0x4>;
+		clocks = <&clk_ecspi1>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "ecspi1_root_clk";
+	};
+
+	clk_ecspi2_root: clock-ecspi2-root@30384080 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384080 0x4>;
+		clocks = <&clk_ecspi2>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "ecspi2_root_clk";
+	};
+
+	clk_ecspi3_root: clock-ecspi3-root@30384090 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384090 0x4>;
+		clocks = <&clk_ecspi3>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "ecspi3_root_clk";
+	};
+
+	clk_enet1_root: clock-enet1-root@303840a0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303840a0 0x4>;
+		clocks = <&clk_enet_axi>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "enet1_root_clk";
+	};
+
+	clk_gpio1_root: clock-gpio1-root@303840b0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303840b0 0x4>;
+		clocks = <&clk_ipg_root>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "gpio1_root_clk";
+	};
+
+	clk_gpio2_root: clock-gpio2-root@303840c0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303840c0 0x4>;
+		clocks = <&clk_ipg_root>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "gpio2_root_clk";
+	};
+
+	clk_gpio3_root: clock-gpio3-root@303840d0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303840d0 0x4>;
+		clocks = <&clk_ipg_root>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "gpio3_root_clk";
+	};
+
+	clk_gpio4_root: clock-gpio4-root@303840e0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303840e0 0x4>;
+		clocks = <&clk_ipg_root>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "gpio4_root_clk";
+	};
+
+	clk_gpio5_root: clock-gpio5-root@303840f0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303840f0 0x4>;
+		clocks = <&clk_ipg_root>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "gpio5_root_clk";
+	};
+
+	clk_i2c1_root: clock-i2c1-root@30384170 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384170 0x4>;
+		clocks = <&clk_i2c1>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "i2c1_root_clk";
+	};
+
+	clk_i2c2_root: clock-i2c2-root@30384180 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384180 0x4>;
+		clocks = <&clk_i2c2>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "i2c2_root_clk";
+	};
+
+	clk_i2c3_root: clock-i2c3-root@30384190 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384190 0x4>;
+		clocks = <&clk_i2c3>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "i2c3_root_clk";
+	};
+
+	clk_i2c4_root: clock-i2c4-root@303841a0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303841a0 0x4>;
+		clocks = <&clk_i2c4>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "i2c4_root_clk";
+	};
+
+	clk_mu_root: clock-mu-root@30384210 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384210 0x4>;
+		clocks = <&clk_ipg_root>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "mu_root_clk";
+	};
+
+	clk_ocotp_root: clock-ocotp-root@30384220 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384220 0x4>;
+		clocks = <&clk_ipg_root>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "ocotp_root_clk";
+	};
+
+	clk_pwm1_root: clock-pwm1-root@30384280 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384280 0x4>;
+		clocks = <&clk_pwm1>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "pwm1_root_clk";
+	};
+
+	clk_pwm2_root: clock-pwm2-root@30384290 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384290 0x4>;
+		clocks = <&clk_pwm2>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "pwm2_root_clk";
+	};
+
+	clk_pwm3_root: clock-pwm3-root@303842a0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303842a0 0x4>;
+		clocks = <&clk_pwm3>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "pwm3_root_clk";
+	};
+
+	clk_pwm4_root: clock-pwm4-root@303842b0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303842b0 0x4>;
+		clocks = <&clk_pwm4>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "pwm4_root_clk";
+	};
+
+	clk_qspi_root: clock-qspi-root@303842f0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303842f0 0x4>;
+		clocks = <&clk_qspi>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "qspi_root_clk";
+	};
+
+	clk_nand_root: clock-nand-root@30384300 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384300 0x4>;
+		clocks = <&clk_nand>;
+		fsl,bit-shift = <0>;
+		sharing-group = "nand";
+		clock-output-names = "nand_root_clk";
+	};
+
+	clk_nand_usdhc_rawnand: clock-nand-ushdc-rawnand@30384300 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384300 0x4>;
+		clocks = <&clk_nand_usdhc_bus>;
+		fsl,bit-shift = <0>;
+		sharing-group = "nand";
+		clock-output-names = "nand_usdhc_rawnand_clk";
+	};
+
+	clk_sai2_root: clock-sai2-root@30384340 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384340 0x4>;
+		clocks = <&clk_sai2>;
+		fsl,bit-shift = <0>;
+		sharing-group = "sai2";
+		clock-output-names = "sai2_root_clk";
+	};
+
+	clk_sai2_ipg: clock-sai2-ipg@30384340 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384340 0x4>;
+		clocks = <&clk_ipg_audio_root>;
+		fsl,bit-shift = <0>;
+		sharing-group = "sai2";
+		clock-output-names = "sai2_ipg_clk";
+	};
+
+	clk_sai3_root: clock-sai3-root@30384350 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384350 0x4>;
+		clocks = <&clk_sai3>;
+		fsl,bit-shift = <0>;
+		sharing-group = "sai3";
+		clock-output-names = "sai3_root_clk";
+	};
+
+	clk_sai3_ipg: clock-sai3-ipg@30384350 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384350 0x4>;
+		clocks = <&clk_ipg_audio_root>;
+		fsl,bit-shift = <0>;
+		sharing-group = "sai3";
+		clock-output-names = "sai3_ipg_clk";
+	};
+
+	clk_sai5_root: clock-sai5-root@30384370 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384370 0x4>;
+		clocks = <&clk_sai5>;
+		fsl,bit-shift = <0>;
+		sharing-group = "sai5";
+		clock-output-names = "sai5_root_clk";
+	};
+
+	clk_sai5_ipg: clock-sai5-ipg@30384370 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384370 0x4>;
+		clocks = <&clk_ipg_audio_root>;
+		fsl,bit-shift = <0>;
+		sharing-group = "sai5";
+		clock-output-names = "sai5_ipg_clk";
+	};
+
+	clk_sai6_root: clock-sai6-root@30384380 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384380 0x4>;
+		clocks = <&clk_sai6>;
+		fsl,bit-shift = <0>;
+		sharing-group = "sai6";
+		clock-output-names = "sai6_root_clk";
+	};
+
+	clk_sai6_ipg: clock-sai6-ipg@30384380 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384380 0x4>;
+		clocks = <&clk_ipg_audio_root>;
+		fsl,bit-shift = <0>;
+		sharing-group = "sai6";
+		clock-output-names = "sai6_ipg_clk";
+	};
+
+	clk_sdma1_root: clock-sdma1-root@303843a0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303843a0 0x4>;
+		clocks = <&clk_ipg_root>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "sdma1_clk";
+	};
+
+	clk_sdma2_root: clock-sdma2-root@303843b0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303843b0 0x4>;
+		clocks = <&clk_ipg_audio_root>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "sdma2_clk";
+	};
+
+	clk_snvs_root: clock-snvs-root@30384470 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384470 0x4>;
+		clocks = <&clk_ipg_root>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "snvs_root_clk";
+	};
+
+	clk_uart1_root: clock-uart1-root@30384490 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384490 0x4>;
+		clocks = <&clk_uart1>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "uart1_root_clk";
+	};
+
+	clk_uart2_root: clock-uart2-root@303844a0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303844a0 0x4>;
+		clocks = <&clk_uart2>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "uart2_root_clk";
+	};
+
+	clk_uart3_root: clock-uart3-root@303844b0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303844b0 0x4>;
+		clocks = <&clk_uart3>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "uart3_root_clk";
+	};
+
+	clk_uart4_root: clock-uart4-root@303844c0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303844c0 0x4>;
+		clocks = <&clk_uart4>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "uart4_root_clk";
+	};
+
+	clk_usb1_ctrl_root: clock-usb1-ctrl-root@303844d0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303844d0 0x4>;
+		clocks = <&clk_usb_bus>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "usb1_ctrl_root_clk";
+	};
+
+	clk_gpu_core_root: clock-gpu-core-root@303844f0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303844f0 0x4>;
+		clocks = <&clk_gpu_core>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "gpu_core_root_clk";
+	};
+
+	clk_usdhc1_root: clock-usdhc1-root@30384510 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384510 0x4>;
+		clocks = <&clk_usdhc1>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "usdhc1_root_clk";
+	};
+
+	clk_usdhc2_root: clock-usdhc2-root@30384520 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384520 0x4>;
+		clocks = <&clk_usdhc2>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "usdhc2_root_clk";
+	};
+
+	clk_wdog1_root: clock-wdog1-root@30384530 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384530 0x4>;
+		clocks = <&clk_wdog>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "wdog1_root_clk";
+	};
+
+	clk_wdog2_root: clock-wdog2-root@30384540 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384540 0x4>;
+		clocks = <&clk_wdog>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "wdog2_root_clk";
+	};
+
+	clk_wdog3_root: clock-wdog3-root@30384550 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384550 0x4>;
+		clocks = <&clk_wdog>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "wdog3_root_clk";
+	};
+
+	clk_gpu_root: clock-gpu-root@30384570 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384570 0x4>;
+		clocks = <&clk_gpu_axi>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "gpu_root_clk";
+	};
+
+	clk_asrc_root: clock-asrc-root@30384580 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384580 0x4>;
+		clocks = <&clk_audio_ahb>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "asrc_root_clk";
+	};
+
+	clk_pdm_root: clock-pdm-root@303845b0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303845b0 0x4>;
+		clocks = <&clk_pdm>;
+		fsl,bit-shift = <0>;
+		sharing-group = "pdm";
+		clock-output-names = "pdm_root_clk";
+	};
+
+	clk_pdm_ipg: clock-pdm-ipg@303845b0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303845b0 0x4>;
+		clocks = <&clk_ipg_audio_root>;
+		fsl,bit-shift = <0>;
+		sharing-group = "pdm";
+		clock-output-names = "pdm_ipg_clk";
+	};
+
+	clk_disp_axi_root: clock-disp-axi-root@303845d0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303845d0 0x4>;
+		clocks = <&clk_disp_axi>;
+		fsl,bit-shift = <0>;
+		sharing-group = "disp";
+		clock-output-names = "disp_axi_root_clk";
+	};
+
+	clk_disp_apb_root: clock-disp-apb-root@303845d0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303845d0 0x4>;
+		clocks = <&clk_disp_apb>;
+		fsl,bit-shift = <0>;
+		sharing-group = "disp";
+		clock-output-names = "disp_apb_root_clk";
+	};
+
+	clk_camera_pixel_root: clock-camera-pixel-root@303845d0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303845d0 0x4>;
+		clocks = <&clk_camera_pixel>;
+		fsl,bit-shift = <0>;
+		sharing-group = "disp";
+		clock-output-names = "camera_pixel_clk";
+	};
+
+	clk_disp_pixel_root: clock-disp-pixel-root@303845d0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303845d0 0x4>;
+		clocks = <&clk_disp_pixel>;
+		fsl,bit-shift = <0>;
+		sharing-group = "disp";
+		clock-output-names = "disp_pixel_clk";
+	};
+
+	clk_usdhc3_root: clock-usdhc3-root@303845e0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303845e0 0x4>;
+		clocks = <&clk_usdhc3>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "usdhc3_root_clk";
+	};
+
+	clk_sdma3_root: clock-sdma3-root@303845f0 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x303845f0 0x4>;
+		clocks = <&clk_ipg_audio_root>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "sdma3_clk";
+	};
+
+	clk_tmu_root: clock-tmu-root@30384620 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384620 0x4>;
+		clocks = <&clk_ipg_root>;
+		fsl,bit-shift = <0>;
+		clock-output-names = "tmu_root_clk";
+	};
+
+	clk_sai7_root: clock-sai7-root@30384650 {
+		compatible = "fsl,imx8mn-low-power-gate-clock";
+		#clock-cells = <0>;
+		reg = <0x30384650 0x4>;
+		clocks = <&clk_sai7>;
+		fsl,bit-shift = <0>;
+		sharing-group = "sai7";
+		clock-output-names = "sai7_root_clk";
+	};
+
+	clk_arm: clock-arm {
+		compatible = "fsl,cpu-clock";
+		#clock-cells = <0>;
+		clocks = <&clk_arm_a53_core>, <&clk_arm_a53_core>,
+			 <&clk_arm_a53_core>, <&clk_arm_pll_out>,
+			 <&clk_arm_a53_div>;
+		clock-names = "fck", "div-clk", "mux-clk", "pll-clk",
+			      "step-clk";
+		clock-output-names = "arm";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 1949db3e08f7..92b0196bbbd9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -175,55 +175,6 @@ opp-1500000000 {
 		};
 	};
 
-	osc_32k: clock-osc-32k {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "osc_32k";
-	};
-
-	osc_24m: clock-osc-24m {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <24000000>;
-		clock-output-names = "osc_24m";
-	};
-
-	clk_ext1: clock-ext1 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <133000000>;
-		clock-output-names = "clk_ext1";
-	};
-
-	clk_ext2: clock-ext2 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <133000000>;
-		clock-output-names = "clk_ext2";
-	};
-
-	clk_ext3: clock-ext3 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <133000000>;
-		clock-output-names = "clk_ext3";
-	};
-
-	clk_ext4: clock-ext4 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <133000000>;
-		clock-output-names = "clk_ext4";
-	};
-
-	clk_dummy: clock-dummy {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-		clock-output-names = "dummy";
-	};
-
 	pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7
@@ -619,6 +570,9 @@ snvs_pwrkey: snvs-powerkey {
 			clk: clock-controller@30380000 {
 				compatible = "fsl,imx8mn-ccm";
 				reg = <0x30380000 0x10000>;
+				ranges;
+				#address-cells = <1>;
+				#size-cells = <1>;
 				#clock-cells = <1>;
 				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
 					 <&clk_ext3>, <&clk_ext4>, <&clk_dummy>;
@@ -1185,3 +1139,5 @@ usbphynop1: usbphynop1 {
 		power-domains = <&pgc_otg1>;
 	};
 };
+
+#include "imx8mn-clocks.dtsi"
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index e1f059dc5afa..e17eaeb65cec 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -8,311 +8,12 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
 #include "clk.h"
 
-static u32 share_count_sai2;
-static u32 share_count_sai3;
-static u32 share_count_sai5;
-static u32 share_count_sai6;
-static u32 share_count_sai7;
-static u32 share_count_disp;
-static u32 share_count_pdm;
-static u32 share_count_nand;
-
-static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
-static const char * const audio_pll1_bypass_sels[] = {"audio_pll1", "audio_pll1_ref_sel", };
-static const char * const audio_pll2_bypass_sels[] = {"audio_pll2", "audio_pll2_ref_sel", };
-static const char * const video_pll_bypass_sels[] = {"video_pll", "video_pll_ref_sel", };
-static const char * const dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
-static const char * const gpu_pll_bypass_sels[] = {"gpu_pll", "gpu_pll_ref_sel", };
-static const char * const m7_alt_pll_bypass_sels[] = {"m7_alt_pll", "m7_alt_pll_ref_sel", };
-static const char * const arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
-static const char * const sys_pll3_bypass_sels[] = {"sys_pll3", "sys_pll3_ref_sel", };
-
-static const char * const imx8mn_a53_sels[] = {"osc_24m", "arm_pll_out", "sys_pll2_500m",
-					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
-					       "audio_pll1_out", "sys_pll3_out", };
-
-static const char * const imx8mn_a53_core_sels[] = {"arm_a53_div", "arm_pll_out", };
-
-static const char * const imx8mn_m7_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_250m", "m7_alt_pll_out",
-				       "sys_pll1_800m", "audio_pll1_out", "video_pll_out", "sys_pll3_out", };
-
-static const char * const imx8mn_gpu_core_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m",
-						    "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-						    "video_pll_out", "audio_pll2_out", };
-
-static const char * const imx8mn_gpu_shader_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m",
-						      "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-						      "video_pll_out", "audio_pll2_out", };
-
-static const char * const imx8mn_main_axi_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll1_800m",
-						    "sys_pll2_250m", "sys_pll2_1000m", "audio_pll1_out",
-						    "video_pll_out", "sys_pll1_100m",};
-
-static const char * const imx8mn_enet_axi_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m",
-						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
-						    "video_pll_out", "sys_pll3_out", };
-
-static const char * const imx8mn_nand_usdhc_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m",
-						      "sys_pll2_200m", "sys_pll1_133m", "sys_pll3_out",
-						      "sys_pll2_250m", "audio_pll1_out", };
-
-static const char * const imx8mn_disp_axi_sels[] = {"osc_24m", "sys_pll2_1000m", "sys_pll1_800m",
-						    "sys_pll3_out", "sys_pll1_40m", "audio_pll2_out",
-						    "clk_ext1", "clk_ext4", };
-
-static const char * const imx8mn_disp_apb_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll1_800m",
-						    "sys_pll3_out", "sys_pll1_40m", "audio_pll2_out",
-						    "clk_ext1", "clk_ext3", };
-
-static const char * const imx8mn_usb_bus_sels[] = {"osc_24m", "sys_pll2_500m", "sys_pll1_800m",
-						   "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
-						   "clk_ext4", "audio_pll2_out", };
-
-static const char * const imx8mn_gpu_axi_sels[] = {"osc_24m", "sys_pll1_800m", "gpu_pll_out",
-						   "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-						   "video_pll_out", "audio_pll2_out", };
-
-static const char * const imx8mn_gpu_ahb_sels[] = {"osc_24m", "sys_pll1_800m", "gpu_pll_out",
-						   "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
-						   "video_pll_out", "audio_pll2_out", };
-
-static const char * const imx8mn_noc_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll3_out",
-					       "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
-					       "video_pll_out", "audio_pll2_out", };
-
-static const char * const imx8mn_ahb_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_800m",
-					       "sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
-					       "audio_pll1_out", "video_pll_out", };
-
-static const char * const imx8mn_audio_ahb_sels[] = {"osc_24m", "sys_pll2_500m", "sys_pll1_800m",
-						     "sys_pll2_1000m", "sys_pll2_166m", "sys_pll3_out",
-						     "audio_pll1_out", "video_pll_out", };
-
-static const char * const imx8mn_dram_alt_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll1_100m",
-						    "sys_pll2_500m", "sys_pll2_1000m", "sys_pll3_out",
-						    "audio_pll1_out", "sys_pll1_266m", };
-
-static const char * const imx8mn_dram_apb_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
-						    "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
-						    "sys_pll2_250m", "audio_pll2_out", };
-
-static const char * const imx8mn_disp_pixel_sels[] = {"osc_24m", "video_pll_out", "audio_pll2_out",
-						      "audio_pll1_out", "sys_pll1_800m", "sys_pll2_1000m",
-						      "sys_pll3_out", "clk_ext4", };
-
-static const char * const imx8mn_sai2_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll_out", "sys_pll1_133m", "dummy",
-						"clk_ext2", "clk_ext3", };
-
-static const char * const imx8mn_sai3_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll_out", "sys_pll1_133m", "dummy",
-						"clk_ext3", "clk_ext4", };
-
-static const char * const imx8mn_sai5_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll_out", "sys_pll1_133m", "dummy",
-						"clk_ext2", "clk_ext3", };
-
-static const char * const imx8mn_sai6_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll_out", "sys_pll1_133m", "dummy",
-						"clk_ext3", "clk_ext4", };
-
-static const char * const imx8mn_sai7_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll_out", "sys_pll1_133m", "dummy",
-						"clk_ext3", "clk_ext4", };
-
-static const char * const imx8mn_spdif1_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						  "video_pll_out", "sys_pll1_133m", "dummy",
-						  "clk_ext2", "clk_ext3", };
-
-static const char * const imx8mn_enet_ref_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_50m",
-						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
-						    "video_pll_out", "clk_ext4", };
-
-static const char * const imx8mn_enet_timer_sels[] = {"osc_24m", "sys_pll2_100m", "audio_pll1_out",
-						      "clk_ext1", "clk_ext2", "clk_ext3",
-						      "clk_ext4", "video_pll_out", };
-
-static const char * const imx8mn_enet_phy_sels[] = {"osc_24m", "sys_pll2_50m", "sys_pll2_125m",
-						    "sys_pll2_200m", "sys_pll2_500m", "audio_pll1_out",
-						    "video_pll_out", "audio_pll2_out", };
-
-static const char * const imx8mn_nand_sels[] = {"osc_24m", "sys_pll2_500m", "audio_pll1_out",
-						"sys_pll1_400m", "audio_pll2_out", "sys_pll3_out",
-						"sys_pll2_250m", "video_pll_out", };
-
-static const char * const imx8mn_qspi_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll2_333m",
-						"sys_pll2_500m", "audio_pll2_out", "sys_pll1_266m",
-						"sys_pll3_out", "sys_pll1_100m", };
-
-static const char * const imx8mn_usdhc1_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m",
-						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
-						  "audio_pll2_out", "sys_pll1_100m", };
-
-static const char * const imx8mn_usdhc2_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m",
-						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
-						  "audio_pll2_out", "sys_pll1_100m", };
-
-static const char * const imx8mn_i2c1_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
-						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
-						"audio_pll2_out", "sys_pll1_133m", };
-
-static const char * const imx8mn_i2c2_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
-						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
-						"audio_pll2_out", "sys_pll1_133m", };
-
-static const char * const imx8mn_i2c3_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
-						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
-						"audio_pll2_out", "sys_pll1_133m", };
-
-static const char * const imx8mn_i2c4_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
-						"sys_pll3_out",	"audio_pll1_out", "video_pll_out",
-						"audio_pll2_out", "sys_pll1_133m", };
-
-static const char * const imx8mn_uart1_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
-						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
-						 "clk_ext4", "audio_pll2_out", };
-
-static const char * const imx8mn_uart2_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
-						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
-						 "clk_ext3", "audio_pll2_out", };
-
-static const char * const imx8mn_uart3_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
-						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
-						 "clk_ext4", "audio_pll2_out", };
-
-static const char * const imx8mn_uart4_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
-						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
-						 "clk_ext3", "audio_pll2_out", };
-
-static const char * const imx8mn_usb_core_sels[] = {"osc_24m", "sys_pll1_100m", "sys_pll1_40m",
-						    "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
-						    "clk_ext3", "audio_pll2_out", };
-
-static const char * const imx8mn_usb_phy_sels[] = {"osc_24m", "sys_pll1_100m", "sys_pll1_40m",
-						   "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
-						   "clk_ext3", "audio_pll2_out", };
-
-static const char * const imx8mn_gic_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
-					"sys_pll2_100m", "sys_pll1_800m", "clk_ext2",
-					"clk_ext4", "audio_pll2_out" };
-
-static const char * const imx8mn_ecspi1_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
-						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
-						  "sys_pll2_250m", "audio_pll2_out", };
-
-static const char * const imx8mn_ecspi2_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
-						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
-						  "sys_pll2_250m", "audio_pll2_out", };
-
-static const char * const imx8mn_pwm1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
-						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
-						"sys_pll1_80m", "video_pll_out", };
-
-static const char * const imx8mn_pwm2_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
-						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
-						"sys_pll1_80m", "video_pll_out", };
-
-static const char * const imx8mn_pwm3_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
-						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
-						"sys_pll1_80m", "video_pll_out", };
-
-static const char * const imx8mn_pwm4_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
-						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
-						"sys_pll1_80m", "video_pll_out", };
-
-static const char * const imx8mn_gpt1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
-						"audio_pll1_out", "clk_ext1", };
-
-static const char * const imx8mn_gpt2_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
-						"audio_pll1_out", "clk_ext1", };
-
-static const char * const imx8mn_gpt3_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
-						"audio_pll1_out", "clk_ext1", };
-
-static const char * const imx8mn_gpt4_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
-						"audio_pll1_out", "clk_ext1", };
-
-static const char * const imx8mn_gpt5_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
-						"audio_pll1_out", "clk_ext1", };
-
-static const char * const imx8mn_gpt6_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
-						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
-						"audio_pll1_out", "clk_ext1", };
-
-static const char * const imx8mn_wdog_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_160m",
-						"m7_alt_pll_out", "sys_pll2_125m", "sys_pll3_out",
-						"sys_pll1_80m", "sys_pll2_166m", };
-
-static const char * const imx8mn_wrclk_sels[] = {"osc_24m", "sys_pll1_40m", "m7_alt_pll_out",
-						 "sys_pll3_out", "sys_pll2_200m", "sys_pll1_266m",
-						 "sys_pll2_500m", "sys_pll1_100m", };
-
-static const char * const imx8mn_dsi_core_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_250m",
-						    "sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
-						    "audio_pll2_out", "video_pll_out", };
-
-static const char * const imx8mn_dsi_phy_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_100m",
-						   "sys_pll1_800m", "sys_pll2_1000m", "clk_ext2",
-						   "audio_pll2_out", "video_pll_out", };
-
-static const char * const imx8mn_dsi_dbi_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_100m",
-						   "sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
-						   "audio_pll2_out", "video_pll_out", };
-
-static const char * const imx8mn_usdhc3_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m",
-						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
-						  "audio_pll2_out", "sys_pll1_100m", };
-
-static const char * const imx8mn_camera_pixel_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_250m",
-							"sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
-							"audio_pll2_out", "video_pll_out", };
-
-static const char * const imx8mn_csi1_phy_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll2_100m",
-						    "sys_pll1_800m", "sys_pll2_1000m", "clk_ext2",
-						    "audio_pll2_out", "video_pll_out", };
-
-static const char * const imx8mn_csi2_phy_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll2_100m",
-						    "sys_pll1_800m", "sys_pll2_1000m", "clk_ext2",
-						    "audio_pll2_out", "video_pll_out", };
-
-static const char * const imx8mn_csi2_esc_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_80m",
-						    "sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
-						    "clk_ext3", "audio_pll2_out", };
-
-static const char * const imx8mn_ecspi3_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
-						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
-						  "sys_pll2_250m", "audio_pll2_out", };
-
-static const char * const imx8mn_pdm_sels[] = {"osc_24m", "sys_pll2_100m", "audio_pll1_out",
-					       "sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
-					       "clk_ext3", "audio_pll2_out", };
-
-static const char * const imx8mn_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", };
-
-static const char * const imx8mn_clko1_sels[] = {"osc_24m", "sys_pll1_800m", "dummy",
-						 "sys_pll1_200m", "audio_pll2_out", "sys_pll2_500m",
-						 "dummy", "sys_pll1_80m", };
-static const char * const imx8mn_clko2_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_400m",
-						 "sys_pll2_166m", "sys_pll3_out", "audio_pll1_out",
-						 "video_pll_out", "osc_32k", };
-
-static const char * const clkout_sels[] = {"audio_pll1_out", "audio_pll2_out", "video_pll_out",
-					   "dummy", "dummy", "gpu_pll_out", "dummy",
-					   "arm_pll_out", "sys_pll1", "sys_pll2", "sys_pll3",
-					   "dummy", "dummy", "osc_24m", "dummy", "osc_32k"};
-
 static struct clk_hw_onecell_data *clk_hw_data;
 static struct clk_hw **hws;
 
@@ -320,7 +21,6 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	void __iomem *base;
 	int ret;
 
 	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
@@ -340,100 +40,93 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_EXT4] = imx_get_clk_hw_by_name(np, "clk_ext4");
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mn-anatop");
-	base = of_iomap(np, 0);
-	of_node_put(np);
-	if (WARN_ON(!base)) {
-		ret = -ENOMEM;
+	if (WARN_ON(!np)) {
+		ret = -ENODEV;
 		goto unregister_hws;
 	}
 
-	hws[IMX8MN_AUDIO_PLL1_REF_SEL] = imx_clk_hw_mux("audio_pll1_ref_sel", base + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	hws[IMX8MN_AUDIO_PLL2_REF_SEL] = imx_clk_hw_mux("audio_pll2_ref_sel", base + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	hws[IMX8MN_VIDEO_PLL_REF_SEL] = imx_clk_hw_mux("video_pll_ref_sel", base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	hws[IMX8MN_DRAM_PLL_REF_SEL] = imx_clk_hw_mux("dram_pll_ref_sel", base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	hws[IMX8MN_GPU_PLL_REF_SEL] = imx_clk_hw_mux("gpu_pll_ref_sel", base + 0x64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	hws[IMX8MN_M7_ALT_PLL_REF_SEL] = imx_clk_hw_mux("m7_alt_pll_ref_sel", base + 0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	hws[IMX8MN_ARM_PLL_REF_SEL] = imx_clk_hw_mux("arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	hws[IMX8MN_SYS_PLL3_REF_SEL] = imx_clk_hw_mux("sys_pll3_ref_sel", base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-
-	hws[IMX8MN_AUDIO_PLL1] = imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_ref_sel", base, &imx_1443x_pll);
-	hws[IMX8MN_AUDIO_PLL2] = imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);
-	hws[IMX8MN_VIDEO_PLL] = imx_clk_hw_pll14xx("video_pll", "video_pll_ref_sel", base + 0x28, &imx_1443x_pll);
-	hws[IMX8MN_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);
-	hws[IMX8MN_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx_1416x_pll);
-	hws[IMX8MN_M7_ALT_PLL] = imx_clk_hw_pll14xx("m7_alt_pll", "m7_alt_pll_ref_sel", base + 0x74, &imx_1416x_pll);
-	hws[IMX8MN_ARM_PLL] = imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", base + 0x84, &imx_1416x_pll);
-	hws[IMX8MN_SYS_PLL1] = imx_clk_hw_fixed("sys_pll1", 800000000);
-	hws[IMX8MN_SYS_PLL2] = imx_clk_hw_fixed("sys_pll2", 1000000000);
-	hws[IMX8MN_SYS_PLL3] = imx_clk_hw_pll14xx("sys_pll3", "sys_pll3_ref_sel", base + 0x114, &imx_1416x_pll);
+	hws[IMX8MN_AUDIO_PLL1_REF_SEL] = imx_get_clk_hw_from_dt(np, "clock-audio-pll1-ref-sel");
+	hws[IMX8MN_AUDIO_PLL2_REF_SEL] = imx_get_clk_hw_from_dt(np, "clock-audio-pll2-ref-sel");
+	hws[IMX8MN_VIDEO_PLL1_REF_SEL] = imx_get_clk_hw_from_dt(np, "clock-video-pll1-ref-sel");
+	hws[IMX8MN_DRAM_PLL_REF_SEL] = imx_get_clk_hw_from_dt(np, "clock-dram-pll-ref-sel");
+	hws[IMX8MN_GPU_PLL_REF_SEL] = imx_get_clk_hw_from_dt(np, "clock-gpu-pll-ref-sel");
+	hws[IMX8MN_VPU_PLL_REF_SEL] = imx_get_clk_hw_from_dt(np, "clock-vpu-pll-ref-sel");
+	hws[IMX8MN_ARM_PLL_REF_SEL] = imx_get_clk_hw_from_dt(np, "clock-arm-pll-ref-sel");
+	hws[IMX8MN_SYS_PLL3_REF_SEL] = imx_get_clk_hw_from_dt(np, "clock-sys-pll3-ref-sel");
+
+	hws[IMX8MN_AUDIO_PLL1] = imx_get_clk_hw_from_dt(np, "clock-audio-pll1");
+	hws[IMX8MN_AUDIO_PLL2] = imx_get_clk_hw_from_dt(np, "clock-audio-pll2");
+	hws[IMX8MN_VIDEO_PLL1] = imx_get_clk_hw_from_dt(np, "clock-video-pll1");
+	hws[IMX8MN_DRAM_PLL] = imx_get_clk_hw_from_dt(np, "clock-dram-pll");
+	hws[IMX8MN_GPU_PLL] = imx_get_clk_hw_from_dt(np, "clock-gpu-pll");
+	hws[IMX8MN_VPU_PLL] = imx_get_clk_hw_from_dt(np, "clock-vpu-pll");
+	hws[IMX8MN_ARM_PLL] = imx_get_clk_hw_from_dt(np, "clock-arm-pll");
+	hws[IMX8MN_SYS_PLL1] = imx_get_clk_hw_from_dt(np, "clock-sys-pll1");
+	hws[IMX8MN_SYS_PLL2] = imx_get_clk_hw_from_dt(np, "clock-sys-pll2");
+	hws[IMX8MN_SYS_PLL3] = imx_get_clk_hw_from_dt(np, "clock-sys-pll3");
 
 	/* PLL bypass out */
-	hws[IMX8MN_AUDIO_PLL1_BYPASS] = imx_clk_hw_mux_flags("audio_pll1_bypass", base, 16, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), CLK_SET_RATE_PARENT);
-	hws[IMX8MN_AUDIO_PLL2_BYPASS] = imx_clk_hw_mux_flags("audio_pll2_bypass", base + 0x14, 16, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_sels), CLK_SET_RATE_PARENT);
-	hws[IMX8MN_VIDEO_PLL_BYPASS] = imx_clk_hw_mux_flags("video_pll_bypass", base + 0x28, 16, 1, video_pll_bypass_sels, ARRAY_SIZE(video_pll_bypass_sels), CLK_SET_RATE_PARENT);
-	hws[IMX8MN_DRAM_PLL_BYPASS] = imx_clk_hw_mux_flags("dram_pll_bypass", base + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK_SET_RATE_PARENT);
-	hws[IMX8MN_GPU_PLL_BYPASS] = imx_clk_hw_mux_flags("gpu_pll_bypass", base + 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
-	hws[IMX8MN_M7_ALT_PLL_BYPASS] = imx_clk_hw_mux_flags("m7_alt_pll_bypass", base + 0x74, 28, 1, m7_alt_pll_bypass_sels, ARRAY_SIZE(m7_alt_pll_bypass_sels), CLK_SET_RATE_PARENT);
-	hws[IMX8MN_ARM_PLL_BYPASS] = imx_clk_hw_mux_flags("arm_pll_bypass", base + 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SET_RATE_PARENT);
-	hws[IMX8MN_SYS_PLL3_BYPASS] = imx_clk_hw_mux_flags("sys_pll3_bypass", base + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), CLK_SET_RATE_PARENT);
+	hws[IMX8MN_AUDIO_PLL1_BYPASS] = imx_get_clk_hw_from_dt(np, "clock-audio-pll1-bypass");
+	hws[IMX8MN_AUDIO_PLL2_BYPASS] = imx_get_clk_hw_from_dt(np, "clock-audio-pll2-bypass");
+	hws[IMX8MN_VIDEO_PLL1_BYPASS] = imx_get_clk_hw_from_dt(np, "clock-video-pll1-bypass");
+	hws[IMX8MN_DRAM_PLL_BYPASS] = imx_get_clk_hw_from_dt(np, "clock-dram-pll-bypass");
+	hws[IMX8MN_GPU_PLL_BYPASS] = imx_get_clk_hw_from_dt(np, "clock-gpu-pll-bypass");
+	hws[IMX8MN_VPU_PLL_BYPASS] = imx_get_clk_hw_from_dt(np, "clock-vpu-pll-bypass");
+	hws[IMX8MN_ARM_PLL_BYPASS] = imx_get_clk_hw_from_dt(np, "clock-arm-pll-bypass");
+	hws[IMX8MN_SYS_PLL3_BYPASS] = imx_get_clk_hw_from_dt(np, "clock-sys-pll3-bypass");
 
 	/* PLL out gate */
-	hws[IMX8MN_AUDIO_PLL1_OUT] = imx_clk_hw_gate("audio_pll1_out", "audio_pll1_bypass", base, 13);
-	hws[IMX8MN_AUDIO_PLL2_OUT] = imx_clk_hw_gate("audio_pll2_out", "audio_pll2_bypass", base + 0x14, 13);
-	hws[IMX8MN_VIDEO_PLL_OUT] = imx_clk_hw_gate("video_pll_out", "video_pll_bypass", base + 0x28, 13);
-	hws[IMX8MN_DRAM_PLL_OUT] = imx_clk_hw_gate("dram_pll_out", "dram_pll_bypass", base + 0x50, 13);
-	hws[IMX8MN_GPU_PLL_OUT] = imx_clk_hw_gate("gpu_pll_out", "gpu_pll_bypass", base + 0x64, 11);
-	hws[IMX8MN_M7_ALT_PLL_OUT] = imx_clk_hw_gate("m7_alt_pll_out", "m7_alt_pll_bypass", base + 0x74, 11);
-	hws[IMX8MN_ARM_PLL_OUT] = imx_clk_hw_gate("arm_pll_out", "arm_pll_bypass", base + 0x84, 11);
-	hws[IMX8MN_SYS_PLL3_OUT] = imx_clk_hw_gate("sys_pll3_out", "sys_pll3_bypass", base + 0x114, 11);
+	hws[IMX8MN_AUDIO_PLL1_OUT] = imx_get_clk_hw_from_dt(np, "clock-audio-pll1-out");
+	hws[IMX8MN_AUDIO_PLL2_OUT] = imx_get_clk_hw_from_dt(np, "clock-audio-pll2-out");
+	hws[IMX8MN_VIDEO_PLL1_OUT] = imx_get_clk_hw_from_dt(np, "clock-video-pll1-out");
+	hws[IMX8MN_DRAM_PLL_OUT] = imx_get_clk_hw_from_dt(np, "clock-dram-pll-out");
+	hws[IMX8MN_GPU_PLL_OUT] = imx_get_clk_hw_from_dt(np, "clock-gpu-pll-out");
+	hws[IMX8MN_VPU_PLL_OUT] = imx_get_clk_hw_from_dt(np, "clock-vpu-pll-out");
+	hws[IMX8MN_ARM_PLL_OUT] = imx_get_clk_hw_from_dt(np, "clock-arm-pll-out");
+	hws[IMX8MN_SYS_PLL3_OUT] = imx_get_clk_hw_from_dt(np, "clock-sys-pll3-out");
 
 	/* SYS PLL1 fixed output */
-	hws[IMX8MN_SYS_PLL1_OUT] = imx_clk_hw_gate("sys_pll1_out", "sys_pll1", base + 0x94, 11);
-	hws[IMX8MN_SYS_PLL1_40M] = imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_out", 1, 20);
-	hws[IMX8MN_SYS_PLL1_80M] = imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_out", 1, 10);
-	hws[IMX8MN_SYS_PLL1_100M] = imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_out", 1, 8);
-	hws[IMX8MN_SYS_PLL1_133M] = imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_out", 1, 6);
-	hws[IMX8MN_SYS_PLL1_160M] = imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_out", 1, 5);
-	hws[IMX8MN_SYS_PLL1_200M] = imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_out", 1, 4);
-	hws[IMX8MN_SYS_PLL1_266M] = imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_out", 1, 3);
-	hws[IMX8MN_SYS_PLL1_400M] = imx_clk_hw_fixed_factor("sys_pll1_400m", "sys_pll1_out", 1, 2);
-	hws[IMX8MN_SYS_PLL1_800M] = imx_clk_hw_fixed_factor("sys_pll1_800m", "sys_pll1_out", 1, 1);
+	hws[IMX8MN_SYS_PLL1_OUT] = imx_get_clk_hw_from_dt(np, "clock-sys-pll1-out");
+	hws[IMX8MN_SYS_PLL1_40M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll1-40m");
+	hws[IMX8MN_SYS_PLL1_80M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll1-80m");
+	hws[IMX8MN_SYS_PLL1_100M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll1-100m");
+	hws[IMX8MN_SYS_PLL1_133M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll1-133m");
+	hws[IMX8MN_SYS_PLL1_160M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll1-160m");
+	hws[IMX8MN_SYS_PLL1_200M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll1-200m");
+	hws[IMX8MN_SYS_PLL1_266M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll1-266m");
+	hws[IMX8MN_SYS_PLL1_400M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll1-400m");
+	hws[IMX8MN_SYS_PLL1_800M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll1-800m");
 
 	/* SYS PLL2 fixed output */
-	hws[IMX8MN_SYS_PLL2_OUT] = imx_clk_hw_gate("sys_pll2_out", "sys_pll2", base + 0x104, 11);
-	hws[IMX8MN_SYS_PLL2_50M] = imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_out", 1, 20);
-	hws[IMX8MN_SYS_PLL2_100M] = imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_out", 1, 10);
-	hws[IMX8MN_SYS_PLL2_125M] = imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_out", 1, 8);
-	hws[IMX8MN_SYS_PLL2_166M] = imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_out", 1, 6);
-	hws[IMX8MN_SYS_PLL2_200M] = imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_out", 1, 5);
-	hws[IMX8MN_SYS_PLL2_250M] = imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_out", 1, 4);
-	hws[IMX8MN_SYS_PLL2_333M] = imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_out", 1, 3);
-	hws[IMX8MN_SYS_PLL2_500M] = imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_out", 1, 2);
-	hws[IMX8MN_SYS_PLL2_1000M] = imx_clk_hw_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1);
-
-	hws[IMX8MN_CLK_CLKOUT1_SEL] = imx_clk_hw_mux2("clkout1_sel", base + 0x128, 4, 4, clkout_sels, ARRAY_SIZE(clkout_sels));
-	hws[IMX8MN_CLK_CLKOUT1_DIV] = imx_clk_hw_divider("clkout1_div", "clkout1_sel", base + 0x128, 0, 4);
-	hws[IMX8MN_CLK_CLKOUT1] = imx_clk_hw_gate("clkout1", "clkout1_div", base + 0x128, 8);
-	hws[IMX8MN_CLK_CLKOUT2_SEL] = imx_clk_hw_mux2("clkout2_sel", base + 0x128, 20, 4, clkout_sels, ARRAY_SIZE(clkout_sels));
-	hws[IMX8MN_CLK_CLKOUT2_DIV] = imx_clk_hw_divider("clkout2_div", "clkout2_sel", base + 0x128, 16, 4);
-	hws[IMX8MN_CLK_CLKOUT2] = imx_clk_hw_gate("clkout2", "clkout2_div", base + 0x128, 24);
+	hws[IMX8MN_SYS_PLL2_OUT] = imx_get_clk_hw_from_dt(np, "clock-sys-pll2-out");
+	hws[IMX8MN_SYS_PLL2_50M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll2-50m");
+	hws[IMX8MN_SYS_PLL2_100M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll2-100m");
+	hws[IMX8MN_SYS_PLL2_125M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll2-125m");
+	hws[IMX8MN_SYS_PLL2_166M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll2-166m");
+	hws[IMX8MN_SYS_PLL2_200M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll2-200m");
+	hws[IMX8MN_SYS_PLL2_250M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll2-250m");
+	hws[IMX8MN_SYS_PLL2_333M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll2-333m");
+	hws[IMX8MN_SYS_PLL2_500M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll2-500m");
+	hws[IMX8MN_SYS_PLL2_1000M] = imx_get_clk_hw_from_dt(np, "clock-sys-pll2-1000m");
+
+	hws[IMX8MN_CLK_CLKOUT1_SEL] = imx_get_clk_hw_from_dt(np, "clock-out1-sel");
+	hws[IMX8MN_CLK_CLKOUT1_DIV] = imx_get_clk_hw_from_dt(np, "clock-out1-div");
+	hws[IMX8MN_CLK_CLKOUT1] = imx_get_clk_hw_from_dt(np, "clock-out1");
+	hws[IMX8MN_CLK_CLKOUT2_SEL] = imx_get_clk_hw_from_dt(np, "clock-out2-sel");
+	hws[IMX8MN_CLK_CLKOUT2_DIV] = imx_get_clk_hw_from_dt(np, "clock-out2-div");
+	hws[IMX8MN_CLK_CLKOUT2] = imx_get_clk_hw_from_dt(np, "clock-out2");
+	of_node_put(np);
 
 	np = dev->of_node;
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(IS_ERR(base))) {
-		ret = PTR_ERR(base);
-		goto unregister_hws;
-	}
-
 	/* CORE */
-	hws[IMX8MN_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mn_a53_sels, base + 0x8000);
+	hws[IMX8MN_CLK_A53_DIV] = imx_get_clk_hw_from_dt(np, "clock-arm-a53-div");
 	hws[IMX8MN_CLK_A53_SRC] = hws[IMX8MN_CLK_A53_DIV];
 	hws[IMX8MN_CLK_A53_CG] = hws[IMX8MN_CLK_A53_DIV];
 
-	hws[IMX8MN_CLK_M7_CORE] = imx8m_clk_hw_composite_core("arm_m7_core", imx8mn_m7_sels, base + 0x8080);
+	hws[IMX8MN_CLK_M7_CORE] = imx_get_clk_hw_from_dt(np, "clock-arm-m7-core");
 
-	hws[IMX8MN_CLK_GPU_CORE] = imx8m_clk_hw_composite_core("gpu_core", imx8mn_gpu_core_sels, base + 0x8180);
-	hws[IMX8MN_CLK_GPU_SHADER] = imx8m_clk_hw_composite_core("gpu_shader", imx8mn_gpu_shader_sels, base + 0x8200);
+	hws[IMX8MN_CLK_GPU_CORE] = imx_get_clk_hw_from_dt(np, "clock-gpu-core");
+	hws[IMX8MN_CLK_GPU_SHADER] = imx_get_clk_hw_from_dt(np, "clock-gpu-shader");
 
 	hws[IMX8MN_CLK_GPU_CORE_SRC] = hws[IMX8MN_CLK_GPU_CORE];
 	hws[IMX8MN_CLK_GPU_CORE_CG] = hws[IMX8MN_CLK_GPU_CORE];
@@ -443,156 +136,141 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_GPU_SHADER_DIV] = hws[IMX8MN_CLK_GPU_SHADER];
 
 	/* CORE SEL */
-	hws[IMX8MN_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", base + 0x9880, 24, 1, imx8mn_a53_core_sels, ARRAY_SIZE(imx8mn_a53_core_sels));
+	hws[IMX8MN_CLK_A53_CORE] = imx_get_clk_hw_from_dt(np, "clock-arm-a53-core");
 
 	/* BUS */
-	hws[IMX8MN_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi", imx8mn_main_axi_sels, base + 0x8800);
-	hws[IMX8MN_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mn_enet_axi_sels, base + 0x8880);
-	hws[IMX8MN_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_bus("nand_usdhc_bus", imx8mn_nand_usdhc_sels, base + 0x8900);
-	hws[IMX8MN_CLK_DISP_AXI] = imx8m_clk_hw_composite_bus("disp_axi", imx8mn_disp_axi_sels, base + 0x8a00);
-	hws[IMX8MN_CLK_DISP_APB] = imx8m_clk_hw_composite_bus("disp_apb", imx8mn_disp_apb_sels, base + 0x8a80);
-	hws[IMX8MN_CLK_USB_BUS] = imx8m_clk_hw_composite_bus("usb_bus", imx8mn_usb_bus_sels, base + 0x8b80);
-	hws[IMX8MN_CLK_GPU_AXI] = imx8m_clk_hw_composite_bus("gpu_axi", imx8mn_gpu_axi_sels, base + 0x8c00);
-	hws[IMX8MN_CLK_GPU_AHB] = imx8m_clk_hw_composite_bus("gpu_ahb", imx8mn_gpu_ahb_sels, base + 0x8c80);
-	hws[IMX8MN_CLK_NOC] = imx8m_clk_hw_composite_bus_critical("noc", imx8mn_noc_sels, base + 0x8d00);
-
-	hws[IMX8MN_CLK_AHB] = imx8m_clk_hw_composite_bus_critical("ahb", imx8mn_ahb_sels, base + 0x9000);
-	hws[IMX8MN_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mn_audio_ahb_sels, base + 0x9100);
-	hws[IMX8MN_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb", base + 0x9080, 0, 1);
-	hws[IMX8MN_CLK_IPG_AUDIO_ROOT] = imx_clk_hw_divider2("ipg_audio_root", "audio_ahb", base + 0x9180, 0, 1);
-	hws[IMX8MN_CLK_DRAM_CORE] = imx_clk_hw_mux2_flags("dram_core_clk", base + 0x9800, 24, 1, imx8mn_dram_core_sels, ARRAY_SIZE(imx8mn_dram_core_sels), CLK_IS_CRITICAL);
+	hws[IMX8MN_CLK_MAIN_AXI] = imx_get_clk_hw_from_dt(np, "clock-main-axi");
+	hws[IMX8MN_CLK_ENET_AXI] = imx_get_clk_hw_from_dt(np, "clock-enet-axi");
+	hws[IMX8MN_CLK_NAND_USDHC_BUS] = imx_get_clk_hw_from_dt(np, "clock-nand-usdhc-bus");
+	hws[IMX8MN_CLK_DISP_AXI] = imx_get_clk_hw_from_dt(np, "clock-disp-axi");
+	hws[IMX8MN_CLK_DISP_APB] = imx_get_clk_hw_from_dt(np, "clock-disp-apb");
+	hws[IMX8MN_CLK_USB_BUS] = imx_get_clk_hw_from_dt(np, "clock-usb-bus");
+	hws[IMX8MN_CLK_GPU_AXI] = imx_get_clk_hw_from_dt(np, "clock-gpu-axi");
+	hws[IMX8MN_CLK_GPU_AHB] = imx_get_clk_hw_from_dt(np, "clock-gpu-ahb");
+	hws[IMX8MN_CLK_NOC] = imx_get_clk_hw_from_dt(np, "clock-noc");
+
+	hws[IMX8MN_CLK_AHB] = imx_get_clk_hw_from_dt(np, "clock-ahb");
+	hws[IMX8MN_CLK_AUDIO_AHB] = imx_get_clk_hw_from_dt(np, "clock-audio-ahb");
+	hws[IMX8MN_CLK_IPG_ROOT] = imx_get_clk_hw_from_dt(np, "clock-ipg-root");
+	hws[IMX8MN_CLK_IPG_AUDIO_ROOT] = imx_get_clk_hw_from_dt(np, "clock-ipg-audio-root");
+	hws[IMX8MN_CLK_DRAM_CORE] = imx_get_clk_hw_from_dt(np, "clock-dram-core");
 
 	/*
 	 * DRAM clocks are manipulated from TF-A outside clock framework.
 	 * The fw_managed helper sets GET_RATE_NOCACHE and clears SET_PARENT_GATE
 	 * as div value should always be read from hardware
 	 */
-	hws[IMX8MN_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mn_dram_alt_sels, base + 0xa000);
-	hws[IMX8MN_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mn_dram_apb_sels, base + 0xa080);
-
-	hws[IMX8MN_CLK_DISP_PIXEL] = imx8m_clk_hw_composite("disp_pixel", imx8mn_disp_pixel_sels, base + 0xa500);
-	hws[IMX8MN_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mn_sai2_sels, base + 0xa600);
-	hws[IMX8MN_CLK_SAI3] = imx8m_clk_hw_composite("sai3", imx8mn_sai3_sels, base + 0xa680);
-	hws[IMX8MN_CLK_SAI5] = imx8m_clk_hw_composite("sai5", imx8mn_sai5_sels, base + 0xa780);
-	hws[IMX8MN_CLK_SAI6] = imx8m_clk_hw_composite("sai6", imx8mn_sai6_sels, base + 0xa800);
-	hws[IMX8MN_CLK_SPDIF1] = imx8m_clk_hw_composite("spdif1", imx8mn_spdif1_sels, base + 0xa880);
-	hws[IMX8MN_CLK_ENET_REF] = imx8m_clk_hw_composite("enet_ref", imx8mn_enet_ref_sels, base + 0xa980);
-	hws[IMX8MN_CLK_ENET_TIMER] = imx8m_clk_hw_composite("enet_timer", imx8mn_enet_timer_sels, base + 0xaa00);
-	hws[IMX8MN_CLK_ENET_PHY_REF] = imx8m_clk_hw_composite("enet_phy", imx8mn_enet_phy_sels, base + 0xaa80);
-	hws[IMX8MN_CLK_NAND] = imx8m_clk_hw_composite("nand", imx8mn_nand_sels, base + 0xab00);
-	hws[IMX8MN_CLK_QSPI] = imx8m_clk_hw_composite("qspi", imx8mn_qspi_sels, base + 0xab80);
-	hws[IMX8MN_CLK_USDHC1] = imx8m_clk_hw_composite("usdhc1", imx8mn_usdhc1_sels, base + 0xac00);
-	hws[IMX8MN_CLK_USDHC2] = imx8m_clk_hw_composite("usdhc2", imx8mn_usdhc2_sels, base + 0xac80);
-	hws[IMX8MN_CLK_I2C1] = imx8m_clk_hw_composite("i2c1", imx8mn_i2c1_sels, base + 0xad00);
-	hws[IMX8MN_CLK_I2C2] = imx8m_clk_hw_composite("i2c2", imx8mn_i2c2_sels, base + 0xad80);
-	hws[IMX8MN_CLK_I2C3] = imx8m_clk_hw_composite("i2c3", imx8mn_i2c3_sels, base + 0xae00);
-	hws[IMX8MN_CLK_I2C4] = imx8m_clk_hw_composite("i2c4", imx8mn_i2c4_sels, base + 0xae80);
-	hws[IMX8MN_CLK_UART1] = imx8m_clk_hw_composite("uart1", imx8mn_uart1_sels, base + 0xaf00);
-	hws[IMX8MN_CLK_UART2] = imx8m_clk_hw_composite("uart2", imx8mn_uart2_sels, base + 0xaf80);
-	hws[IMX8MN_CLK_UART3] = imx8m_clk_hw_composite("uart3", imx8mn_uart3_sels, base + 0xb000);
-	hws[IMX8MN_CLK_UART4] = imx8m_clk_hw_composite("uart4", imx8mn_uart4_sels, base + 0xb080);
-	hws[IMX8MN_CLK_USB_CORE_REF] = imx8m_clk_hw_composite("usb_core_ref", imx8mn_usb_core_sels, base + 0xb100);
-	hws[IMX8MN_CLK_USB_PHY_REF] = imx8m_clk_hw_composite("usb_phy_ref", imx8mn_usb_phy_sels, base + 0xb180);
-	hws[IMX8MN_CLK_GIC] = imx8m_clk_hw_composite_critical("gic", imx8mn_gic_sels, base + 0xb200);
-	hws[IMX8MN_CLK_ECSPI1] = imx8m_clk_hw_composite("ecspi1", imx8mn_ecspi1_sels, base + 0xb280);
-	hws[IMX8MN_CLK_ECSPI2] = imx8m_clk_hw_composite("ecspi2", imx8mn_ecspi2_sels, base + 0xb300);
-	hws[IMX8MN_CLK_PWM1] = imx8m_clk_hw_composite("pwm1", imx8mn_pwm1_sels, base + 0xb380);
-	hws[IMX8MN_CLK_PWM2] = imx8m_clk_hw_composite("pwm2", imx8mn_pwm2_sels, base + 0xb400);
-	hws[IMX8MN_CLK_PWM3] = imx8m_clk_hw_composite("pwm3", imx8mn_pwm3_sels, base + 0xb480);
-	hws[IMX8MN_CLK_PWM4] = imx8m_clk_hw_composite("pwm4", imx8mn_pwm4_sels, base + 0xb500);
-	hws[IMX8MN_CLK_GPT1] = imx8m_clk_hw_composite("gpt1", imx8mn_gpt1_sels, base + 0xb580);
-	hws[IMX8MN_CLK_GPT2] = imx8m_clk_hw_composite("gpt2", imx8mn_gpt2_sels, base + 0xb600);
-	hws[IMX8MN_CLK_GPT3] = imx8m_clk_hw_composite("gpt3", imx8mn_gpt3_sels, base + 0xb680);
-	hws[IMX8MN_CLK_GPT4] = imx8m_clk_hw_composite("gpt4", imx8mn_gpt4_sels, base + 0xb700);
-	hws[IMX8MN_CLK_GPT5] = imx8m_clk_hw_composite("gpt5", imx8mn_gpt5_sels, base + 0xb780);
-	hws[IMX8MN_CLK_GPT6] = imx8m_clk_hw_composite("gpt6", imx8mn_gpt6_sels, base + 0xb800);
-	hws[IMX8MN_CLK_WDOG] = imx8m_clk_hw_composite("wdog", imx8mn_wdog_sels, base + 0xb900);
-	hws[IMX8MN_CLK_WRCLK] = imx8m_clk_hw_composite("wrclk", imx8mn_wrclk_sels, base + 0xb980);
-	hws[IMX8MN_CLK_CLKO1] = imx8m_clk_hw_composite("clko1", imx8mn_clko1_sels, base + 0xba00);
-	hws[IMX8MN_CLK_CLKO2] = imx8m_clk_hw_composite("clko2", imx8mn_clko2_sels, base + 0xba80);
-	hws[IMX8MN_CLK_DSI_CORE] = imx8m_clk_hw_composite("dsi_core", imx8mn_dsi_core_sels, base + 0xbb00);
-	hws[IMX8MN_CLK_DSI_PHY_REF] = imx8m_clk_hw_composite("dsi_phy_ref", imx8mn_dsi_phy_sels, base + 0xbb80);
-	hws[IMX8MN_CLK_DSI_DBI] = imx8m_clk_hw_composite("dsi_dbi", imx8mn_dsi_dbi_sels, base + 0xbc00);
-	hws[IMX8MN_CLK_USDHC3] = imx8m_clk_hw_composite("usdhc3", imx8mn_usdhc3_sels, base + 0xbc80);
-	hws[IMX8MN_CLK_CAMERA_PIXEL] = imx8m_clk_hw_composite("camera_pixel", imx8mn_camera_pixel_sels, base + 0xbd00);
-	hws[IMX8MN_CLK_CSI1_PHY_REF] = imx8m_clk_hw_composite("csi1_phy_ref", imx8mn_csi1_phy_sels, base + 0xbd80);
-	hws[IMX8MN_CLK_CSI2_PHY_REF] = imx8m_clk_hw_composite("csi2_phy_ref", imx8mn_csi2_phy_sels, base + 0xbf00);
-	hws[IMX8MN_CLK_CSI2_ESC] = imx8m_clk_hw_composite("csi2_esc", imx8mn_csi2_esc_sels, base + 0xbf80);
-	hws[IMX8MN_CLK_ECSPI3] = imx8m_clk_hw_composite("ecspi3", imx8mn_ecspi3_sels, base + 0xc180);
-	hws[IMX8MN_CLK_PDM] = imx8m_clk_hw_composite("pdm", imx8mn_pdm_sels, base + 0xc200);
-	hws[IMX8MN_CLK_SAI7] = imx8m_clk_hw_composite("sai7", imx8mn_sai7_sels, base + 0xc300);
-
-	hws[IMX8MN_CLK_ECSPI1_ROOT] = imx_clk_hw_gate4("ecspi1_root_clk", "ecspi1", base + 0x4070, 0);
-	hws[IMX8MN_CLK_ECSPI2_ROOT] = imx_clk_hw_gate4("ecspi2_root_clk", "ecspi2", base + 0x4080, 0);
-	hws[IMX8MN_CLK_ECSPI3_ROOT] = imx_clk_hw_gate4("ecspi3_root_clk", "ecspi3", base + 0x4090, 0);
-	hws[IMX8MN_CLK_ENET1_ROOT] = imx_clk_hw_gate4("enet1_root_clk", "enet_axi", base + 0x40a0, 0);
-	hws[IMX8MN_CLK_GPIO1_ROOT] = imx_clk_hw_gate4("gpio1_root_clk", "ipg_root", base + 0x40b0, 0);
-	hws[IMX8MN_CLK_GPIO2_ROOT] = imx_clk_hw_gate4("gpio2_root_clk", "ipg_root", base + 0x40c0, 0);
-	hws[IMX8MN_CLK_GPIO3_ROOT] = imx_clk_hw_gate4("gpio3_root_clk", "ipg_root", base + 0x40d0, 0);
-	hws[IMX8MN_CLK_GPIO4_ROOT] = imx_clk_hw_gate4("gpio4_root_clk", "ipg_root", base + 0x40e0, 0);
-	hws[IMX8MN_CLK_GPIO5_ROOT] = imx_clk_hw_gate4("gpio5_root_clk", "ipg_root", base + 0x40f0, 0);
-	hws[IMX8MN_CLK_GPT1_ROOT] = imx_clk_hw_gate4("gpt1_root_clk", "gpt1", base + 0x4100, 0);
-	hws[IMX8MN_CLK_GPT2_ROOT] = imx_clk_hw_gate4("gpt2_root_clk", "gpt2", base + 0x4110, 0);
-	hws[IMX8MN_CLK_GPT3_ROOT] = imx_clk_hw_gate4("gpt3_root_clk", "gpt3", base + 0x4120, 0);
-	hws[IMX8MN_CLK_GPT4_ROOT] = imx_clk_hw_gate4("gpt4_root_clk", "gpt4", base + 0x4130, 0);
-	hws[IMX8MN_CLK_GPT5_ROOT] = imx_clk_hw_gate4("gpt5_root_clk", "gpt5", base + 0x4140, 0);
-	hws[IMX8MN_CLK_GPT6_ROOT] = imx_clk_hw_gate4("gpt6_root_clk", "gpt6", base + 0x4150, 0);
-	hws[IMX8MN_CLK_I2C1_ROOT] = imx_clk_hw_gate4("i2c1_root_clk", "i2c1", base + 0x4170, 0);
-	hws[IMX8MN_CLK_I2C2_ROOT] = imx_clk_hw_gate4("i2c2_root_clk", "i2c2", base + 0x4180, 0);
-	hws[IMX8MN_CLK_I2C3_ROOT] = imx_clk_hw_gate4("i2c3_root_clk", "i2c3", base + 0x4190, 0);
-	hws[IMX8MN_CLK_I2C4_ROOT] = imx_clk_hw_gate4("i2c4_root_clk", "i2c4", base + 0x41a0, 0);
-	hws[IMX8MN_CLK_MU_ROOT] = imx_clk_hw_gate4("mu_root_clk", "ipg_root", base + 0x4210, 0);
-	hws[IMX8MN_CLK_OCOTP_ROOT] = imx_clk_hw_gate4("ocotp_root_clk", "ipg_root", base + 0x4220, 0);
-	hws[IMX8MN_CLK_PWM1_ROOT] = imx_clk_hw_gate4("pwm1_root_clk", "pwm1", base + 0x4280, 0);
-	hws[IMX8MN_CLK_PWM2_ROOT] = imx_clk_hw_gate4("pwm2_root_clk", "pwm2", base + 0x4290, 0);
-	hws[IMX8MN_CLK_PWM3_ROOT] = imx_clk_hw_gate4("pwm3_root_clk", "pwm3", base + 0x42a0, 0);
-	hws[IMX8MN_CLK_PWM4_ROOT] = imx_clk_hw_gate4("pwm4_root_clk", "pwm4", base + 0x42b0, 0);
-	hws[IMX8MN_CLK_QSPI_ROOT] = imx_clk_hw_gate4("qspi_root_clk", "qspi", base + 0x42f0, 0);
-	hws[IMX8MN_CLK_NAND_ROOT] = imx_clk_hw_gate2_shared2("nand_root_clk", "nand", base + 0x4300, 0, &share_count_nand);
-	hws[IMX8MN_CLK_NAND_USDHC_BUS_RAWNAND_CLK] = imx_clk_hw_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_bus", base + 0x4300, 0, &share_count_nand);
-	hws[IMX8MN_CLK_SAI2_ROOT] = imx_clk_hw_gate2_shared2("sai2_root_clk", "sai2", base + 0x4340, 0, &share_count_sai2);
-	hws[IMX8MN_CLK_SAI2_IPG] = imx_clk_hw_gate2_shared2("sai2_ipg_clk", "ipg_audio_root", base + 0x4340, 0, &share_count_sai2);
-	hws[IMX8MN_CLK_SAI3_ROOT] = imx_clk_hw_gate2_shared2("sai3_root_clk", "sai3", base + 0x4350, 0, &share_count_sai3);
-	hws[IMX8MN_CLK_SAI3_IPG] = imx_clk_hw_gate2_shared2("sai3_ipg_clk", "ipg_audio_root", base + 0x4350, 0, &share_count_sai3);
-	hws[IMX8MN_CLK_SAI5_ROOT] = imx_clk_hw_gate2_shared2("sai5_root_clk", "sai5", base + 0x4370, 0, &share_count_sai5);
-	hws[IMX8MN_CLK_SAI5_IPG] = imx_clk_hw_gate2_shared2("sai5_ipg_clk", "ipg_audio_root", base + 0x4370, 0, &share_count_sai5);
-	hws[IMX8MN_CLK_SAI6_ROOT] = imx_clk_hw_gate2_shared2("sai6_root_clk", "sai6", base + 0x4380, 0, &share_count_sai6);
-	hws[IMX8MN_CLK_SAI6_IPG] = imx_clk_hw_gate2_shared2("sai6_ipg_clk", "ipg_audio_root", base + 0x4380, 0, &share_count_sai6);
-	hws[IMX8MN_CLK_UART1_ROOT] = imx_clk_hw_gate4("uart1_root_clk", "uart1", base + 0x4490, 0);
-	hws[IMX8MN_CLK_UART2_ROOT] = imx_clk_hw_gate4("uart2_root_clk", "uart2", base + 0x44a0, 0);
-	hws[IMX8MN_CLK_UART3_ROOT] = imx_clk_hw_gate4("uart3_root_clk", "uart3", base + 0x44b0, 0);
-	hws[IMX8MN_CLK_UART4_ROOT] = imx_clk_hw_gate4("uart4_root_clk", "uart4", base + 0x44c0, 0);
-	hws[IMX8MN_CLK_USB1_CTRL_ROOT] = imx_clk_hw_gate4("usb1_ctrl_root_clk", "usb_bus", base + 0x44d0, 0);
-	hws[IMX8MN_CLK_GPU_CORE_ROOT] = imx_clk_hw_gate4("gpu_core_root_clk", "gpu_core", base + 0x44f0, 0);
-	hws[IMX8MN_CLK_USDHC1_ROOT] = imx_clk_hw_gate4("usdhc1_root_clk", "usdhc1", base + 0x4510, 0);
-	hws[IMX8MN_CLK_USDHC2_ROOT] = imx_clk_hw_gate4("usdhc2_root_clk", "usdhc2", base + 0x4520, 0);
-	hws[IMX8MN_CLK_WDOG1_ROOT] = imx_clk_hw_gate4("wdog1_root_clk", "wdog", base + 0x4530, 0);
-	hws[IMX8MN_CLK_WDOG2_ROOT] = imx_clk_hw_gate4("wdog2_root_clk", "wdog", base + 0x4540, 0);
-	hws[IMX8MN_CLK_WDOG3_ROOT] = imx_clk_hw_gate4("wdog3_root_clk", "wdog", base + 0x4550, 0);
-	hws[IMX8MN_CLK_GPU_BUS_ROOT] = imx_clk_hw_gate4("gpu_root_clk", "gpu_axi", base + 0x4570, 0);
-	hws[IMX8MN_CLK_ASRC_ROOT] = imx_clk_hw_gate4("asrc_root_clk", "audio_ahb", base + 0x4580, 0);
-	hws[IMX8MN_CLK_PDM_ROOT] = imx_clk_hw_gate2_shared2("pdm_root_clk", "pdm", base + 0x45b0, 0, &share_count_pdm);
-	hws[IMX8MN_CLK_PDM_IPG]  = imx_clk_hw_gate2_shared2("pdm_ipg_clk", "ipg_audio_root", base + 0x45b0, 0, &share_count_pdm);
-	hws[IMX8MN_CLK_DISP_AXI_ROOT]  = imx_clk_hw_gate2_shared2("disp_axi_root_clk", "disp_axi", base + 0x45d0, 0, &share_count_disp);
-	hws[IMX8MN_CLK_DISP_APB_ROOT]  = imx_clk_hw_gate2_shared2("disp_apb_root_clk", "disp_apb", base + 0x45d0, 0, &share_count_disp);
-	hws[IMX8MN_CLK_CAMERA_PIXEL_ROOT] = imx_clk_hw_gate2_shared2("camera_pixel_clk", "camera_pixel", base + 0x45d0, 0, &share_count_disp);
-	hws[IMX8MN_CLK_DISP_PIXEL_ROOT] = imx_clk_hw_gate2_shared2("disp_pixel_clk", "disp_pixel", base + 0x45d0, 0, &share_count_disp);
-	hws[IMX8MN_CLK_USDHC3_ROOT] = imx_clk_hw_gate4("usdhc3_root_clk", "usdhc3", base + 0x45e0, 0);
-	hws[IMX8MN_CLK_TMU_ROOT] = imx_clk_hw_gate4("tmu_root_clk", "ipg_root", base + 0x4620, 0);
-	hws[IMX8MN_CLK_SDMA1_ROOT] = imx_clk_hw_gate4("sdma1_clk", "ipg_root", base + 0x43a0, 0);
-	hws[IMX8MN_CLK_SDMA2_ROOT] = imx_clk_hw_gate4("sdma2_clk", "ipg_audio_root", base + 0x43b0, 0);
-	hws[IMX8MN_CLK_SDMA3_ROOT] = imx_clk_hw_gate4("sdma3_clk", "ipg_audio_root", base + 0x45f0, 0);
-	hws[IMX8MN_CLK_SAI7_ROOT] = imx_clk_hw_gate2_shared2("sai7_root_clk", "sai7", base + 0x4650, 0, &share_count_sai7);
-
-	hws[IMX8MN_CLK_GPT_3M] = imx_clk_hw_fixed_factor("gpt_3m", "osc_24m", 1, 8);
-
-	hws[IMX8MN_CLK_DRAM_ALT_ROOT] = imx_clk_hw_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
-
-	hws[IMX8MN_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
-					   hws[IMX8MN_CLK_A53_CORE]->clk,
-					   hws[IMX8MN_CLK_A53_CORE]->clk,
-					   hws[IMX8MN_ARM_PLL_OUT]->clk,
-					   hws[IMX8MN_CLK_A53_DIV]->clk);
+	hws[IMX8MN_CLK_DRAM_ALT] = imx_get_clk_hw_from_dt(np, "clock-dram-alt");
+	hws[IMX8MN_CLK_DRAM_APB] = imx_get_clk_hw_from_dt(np, "clock-dram-apb");
+
+	hws[IMX8MN_CLK_DISP_PIXEL] = imx_get_clk_hw_from_dt(np, "clock-disp-pixel");
+	hws[IMX8MN_CLK_SAI2] = imx_get_clk_hw_from_dt(np, "clock-sai2");
+	hws[IMX8MN_CLK_SAI3] = imx_get_clk_hw_from_dt(np, "clock-sai3");
+	hws[IMX8MN_CLK_SAI5] = imx_get_clk_hw_from_dt(np, "clock-sai5");
+	hws[IMX8MN_CLK_SAI6] = imx_get_clk_hw_from_dt(np, "clock-sai6");
+	hws[IMX8MN_CLK_SPDIF1] = imx_get_clk_hw_from_dt(np, "clock-spdif1");
+	hws[IMX8MN_CLK_ENET_REF] = imx_get_clk_hw_from_dt(np, "clock-enet-ref");
+	hws[IMX8MN_CLK_ENET_TIMER] = imx_get_clk_hw_from_dt(np, "clock-enet-timer");
+	hws[IMX8MN_CLK_ENET_PHY_REF] = imx_get_clk_hw_from_dt(np, "clock-enet-phy");
+	hws[IMX8MN_CLK_NAND] = imx_get_clk_hw_from_dt(np, "clock-nand");
+	hws[IMX8MN_CLK_QSPI] = imx_get_clk_hw_from_dt(np, "clock-qspi");
+	hws[IMX8MN_CLK_USDHC1] = imx_get_clk_hw_from_dt(np, "clock-usdhc1");
+	hws[IMX8MN_CLK_USDHC2] = imx_get_clk_hw_from_dt(np, "clock-usdhc2");
+	hws[IMX8MN_CLK_I2C1] = imx_get_clk_hw_from_dt(np, "clock-i2c1");
+	hws[IMX8MN_CLK_I2C2] = imx_get_clk_hw_from_dt(np, "clock-i2c2");
+	hws[IMX8MN_CLK_I2C3] = imx_get_clk_hw_from_dt(np, "clock-i2c3");
+	hws[IMX8MN_CLK_I2C4] = imx_get_clk_hw_from_dt(np, "clock-i2c4");
+	hws[IMX8MN_CLK_UART1] = imx_get_clk_hw_from_dt(np, "clock-uart1");
+	hws[IMX8MN_CLK_UART2] = imx_get_clk_hw_from_dt(np, "clock-uart2");
+	hws[IMX8MN_CLK_UART3] = imx_get_clk_hw_from_dt(np, "clock-uart3");
+	hws[IMX8MN_CLK_UART4] = imx_get_clk_hw_from_dt(np, "clock-uart4");
+	hws[IMX8MN_CLK_USB_CORE_REF] = imx_get_clk_hw_from_dt(np, "clock-usb-core-ref");
+	hws[IMX8MN_CLK_USB_PHY_REF] = imx_get_clk_hw_from_dt(np, "clock-usb-phy-ref");
+	hws[IMX8MN_CLK_GIC] = imx_get_clk_hw_from_dt(np, "clock-gic");
+	hws[IMX8MN_CLK_ECSPI1] = imx_get_clk_hw_from_dt(np, "clock-ecspi1");
+	hws[IMX8MN_CLK_ECSPI2] = imx_get_clk_hw_from_dt(np, "clock-ecspi2");
+	hws[IMX8MN_CLK_PWM1] = imx_get_clk_hw_from_dt(np, "clock-pwm1");
+	hws[IMX8MN_CLK_PWM2] = imx_get_clk_hw_from_dt(np, "clock-pwm2");
+	hws[IMX8MN_CLK_PWM3] = imx_get_clk_hw_from_dt(np, "clock-pwm3");
+	hws[IMX8MN_CLK_PWM4] = imx_get_clk_hw_from_dt(np, "clock-pwm4");
+	hws[IMX8MN_CLK_WDOG] = imx_get_clk_hw_from_dt(np, "clock-wdog");
+	hws[IMX8MN_CLK_WRCLK] = imx_get_clk_hw_from_dt(np, "clock-wrclk");
+	hws[IMX8MN_CLK_CLKO1] = imx_get_clk_hw_from_dt(np, "clock-clko1");
+	hws[IMX8MN_CLK_CLKO2] = imx_get_clk_hw_from_dt(np, "clock-clko2");
+	hws[IMX8MN_CLK_DSI_CORE] = imx_get_clk_hw_from_dt(np, "clock-dsi-core");
+	hws[IMX8MN_CLK_DSI_PHY_REF] = imx_get_clk_hw_from_dt(np, "clock-dsi-phy-ref");
+	hws[IMX8MN_CLK_DSI_DBI] = imx_get_clk_hw_from_dt(np, "clock-dsi-dbi");
+	hws[IMX8MN_CLK_USDHC3] = imx_get_clk_hw_from_dt(np, "clock-usdhc3");
+	hws[IMX8MN_CLK_CAMERA_PIXEL] = imx_get_clk_hw_from_dt(np, "clock-camera-pixel");
+	hws[IMX8MN_CLK_CSI1_PHY_REF] = imx_get_clk_hw_from_dt(np, "clock-csi1-phy-ref");
+	hws[IMX8MN_CLK_CSI2_PHY_REF] = imx_get_clk_hw_from_dt(np, "clock-csi2-phy-ref");
+	hws[IMX8MN_CLK_CSI2_ESC] = imx_get_clk_hw_from_dt(np, "clock-csi2-esc");
+	hws[IMX8MN_CLK_ECSPI3] = imx_get_clk_hw_from_dt(np, "clock-ecspi3");
+	hws[IMX8MN_CLK_PDM] = imx_get_clk_hw_from_dt(np, "clock-pdm");
+	hws[IMX8MN_CLK_SAI7] = imx_get_clk_hw_from_dt(np, "clock-sai7");
+
+	hws[IMX8MN_CLK_ECSPI1_ROOT] = imx_get_clk_hw_from_dt(np, "clock-ecspi1-root");
+	hws[IMX8MN_CLK_ECSPI2_ROOT] = imx_get_clk_hw_from_dt(np, "clock-ecspi2-root");
+	hws[IMX8MN_CLK_ECSPI3_ROOT] = imx_get_clk_hw_from_dt(np, "clock-ecspi3-root");
+	hws[IMX8MN_CLK_ENET1_ROOT] = imx_get_clk_hw_from_dt(np, "clock-ecspi3-root");
+	hws[IMX8MN_CLK_GPIO1_ROOT] = imx_get_clk_hw_from_dt(np, "clock-gpio1-root");
+	hws[IMX8MN_CLK_GPIO2_ROOT] = imx_get_clk_hw_from_dt(np, "clock-gpio2-root");
+	hws[IMX8MN_CLK_GPIO3_ROOT] = imx_get_clk_hw_from_dt(np, "clock-gpio3-root");
+	hws[IMX8MN_CLK_GPIO4_ROOT] = imx_get_clk_hw_from_dt(np, "clock-gpio4-root");
+	hws[IMX8MN_CLK_GPIO5_ROOT] = imx_get_clk_hw_from_dt(np, "clock-gpio5-root");
+	hws[IMX8MN_CLK_I2C1_ROOT] = imx_get_clk_hw_from_dt(np, "clock-i2c1-root");
+	hws[IMX8MN_CLK_I2C2_ROOT] = imx_get_clk_hw_from_dt(np, "clock-i2c2-root");
+	hws[IMX8MN_CLK_I2C3_ROOT] = imx_get_clk_hw_from_dt(np, "clock-i2c3-root");
+	hws[IMX8MN_CLK_I2C4_ROOT] = imx_get_clk_hw_from_dt(np, "clock-i2c4-root");
+	hws[IMX8MN_CLK_MU_ROOT] = imx_get_clk_hw_from_dt(np, "clock-mu-root");
+	hws[IMX8MN_CLK_OCOTP_ROOT] = imx_get_clk_hw_from_dt(np, "clock-ocotp-root");
+	hws[IMX8MN_CLK_PWM1_ROOT] = imx_get_clk_hw_from_dt(np, "clock-pwm1-root");
+	hws[IMX8MN_CLK_PWM2_ROOT] = imx_get_clk_hw_from_dt(np, "clock-pwm2-root");
+	hws[IMX8MN_CLK_PWM3_ROOT] = imx_get_clk_hw_from_dt(np, "clock-pwm3-root");
+	hws[IMX8MN_CLK_PWM4_ROOT] = imx_get_clk_hw_from_dt(np, "clock-pwm4-root");
+	hws[IMX8MN_CLK_QSPI_ROOT] = imx_get_clk_hw_from_dt(np, "clock-qspi-root");
+	hws[IMX8MN_CLK_NAND_ROOT] = imx_get_clk_hw_from_dt(np, "clock-nand-root");
+	hws[IMX8MN_CLK_NAND_USDHC_BUS_RAWNAND_CLK] =
+		imx_get_clk_hw_from_dt(np, "clock-nand-ushdc-rawnand");
+	hws[IMX8MN_CLK_SAI2_ROOT] = imx_get_clk_hw_from_dt(np, "clock-sai2-root");
+	hws[IMX8MN_CLK_SAI2_IPG] = imx_get_clk_hw_from_dt(np, "clock-sai2-ipg");
+	hws[IMX8MN_CLK_SAI3_ROOT] = imx_get_clk_hw_from_dt(np, "clock-sai3-root");
+	hws[IMX8MN_CLK_SAI3_IPG] = imx_get_clk_hw_from_dt(np, "clock-sai3-ipg");
+	hws[IMX8MN_CLK_SAI5_ROOT] = imx_get_clk_hw_from_dt(np, "clock-sai5-root");
+	hws[IMX8MN_CLK_SAI5_IPG] = imx_get_clk_hw_from_dt(np, "clock-sai5-ipg");
+	hws[IMX8MN_CLK_SAI6_ROOT] = imx_get_clk_hw_from_dt(np, "clock-sai6-root");
+	hws[IMX8MN_CLK_SAI6_IPG] = imx_get_clk_hw_from_dt(np, "clock-sai6-ipg");
+	hws[IMX8MN_CLK_SNVS_ROOT] = imx_get_clk_hw_from_dt(np, "clock-snvs-root");
+
+	hws[IMX8MN_CLK_UART1_ROOT] = imx_get_clk_hw_from_dt(np, "clock-uart1-root");
+	hws[IMX8MN_CLK_UART2_ROOT] = imx_get_clk_hw_from_dt(np, "clock-uart2-root");
+	hws[IMX8MN_CLK_UART3_ROOT] = imx_get_clk_hw_from_dt(np, "clock-uart3-root");
+	hws[IMX8MN_CLK_UART4_ROOT] = imx_get_clk_hw_from_dt(np, "clock-uart4-root");
+	hws[IMX8MN_CLK_USB1_CTRL_ROOT] = imx_get_clk_hw_from_dt(np, "clock-usb1-ctrl-root");
+	hws[IMX8MN_CLK_GPU_CORE_ROOT] = imx_get_clk_hw_from_dt(np, "clock-gpu-core-root");
+	hws[IMX8MN_CLK_USDHC1_ROOT] = imx_get_clk_hw_from_dt(np, "clock-usdhc1-root");
+	hws[IMX8MN_CLK_USDHC2_ROOT] = imx_get_clk_hw_from_dt(np, "clock-usdhc2-root");
+	hws[IMX8MN_CLK_WDOG1_ROOT] = imx_get_clk_hw_from_dt(np, "clock-wdog1-root");
+	hws[IMX8MN_CLK_WDOG2_ROOT] = imx_get_clk_hw_from_dt(np, "clock-wdog2-root");
+	hws[IMX8MN_CLK_WDOG3_ROOT] = imx_get_clk_hw_from_dt(np, "clock-wdog3-root");
+	hws[IMX8MN_CLK_GPU_BUS_ROOT] = imx_get_clk_hw_from_dt(np, "clock-gpu-root");
+	hws[IMX8MN_CLK_ASRC_ROOT] = imx_get_clk_hw_from_dt(np, "clock-asrc-root");
+	hws[IMX8MN_CLK_PDM_ROOT] = imx_get_clk_hw_from_dt(np, "clock-pdm-root");
+	hws[IMX8MN_CLK_PDM_IPG]  = imx_get_clk_hw_from_dt(np, "clock-pdm-ipg");
+	hws[IMX8MN_CLK_DISP_AXI_ROOT]  = imx_get_clk_hw_from_dt(np, "clock-disp-axi-root");
+	hws[IMX8MN_CLK_DISP_APB_ROOT]  = imx_get_clk_hw_from_dt(np, "clock-disp-apb-root");
+	hws[IMX8MN_CLK_CAMERA_PIXEL_ROOT] = imx_get_clk_hw_from_dt(np, "clock-camera-pixel-root");
+	hws[IMX8MN_CLK_DISP_PIXEL_ROOT] = imx_get_clk_hw_from_dt(np, "clock-disp-pixel-root");
+	hws[IMX8MN_CLK_USDHC3_ROOT] = imx_get_clk_hw_from_dt(np, "clock-usdhc3-root");
+	hws[IMX8MN_CLK_TMU_ROOT] = imx_get_clk_hw_from_dt(np, "clock-tmu-root");
+	hws[IMX8MN_CLK_SDMA1_ROOT] = imx_get_clk_hw_from_dt(np, "clock-sdma1-root");
+	hws[IMX8MN_CLK_SDMA2_ROOT] = imx_get_clk_hw_from_dt(np, "clock-sdma2-root");
+	hws[IMX8MN_CLK_SDMA3_ROOT] = imx_get_clk_hw_from_dt(np, "clock-sdma3-root");
+	hws[IMX8MN_CLK_SAI7_ROOT] = imx_get_clk_hw_from_dt(np, "clock-sai7-root");
+
+	hws[IMX8MN_CLK_DRAM_ALT_ROOT] = imx_get_clk_hw_from_dt(np, "clock-dram-alt-root");
+
+	hws[IMX8MN_CLK_ARM] = imx_get_clk_hw_from_dt(np, "clock-arm");
 
 	imx_check_clk_hws(hws, IMX8MN_CLK_END);
 
-- 
2.32.0

