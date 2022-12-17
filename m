Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D094964FB83
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLQSJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiLQSJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:09:03 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49AE13F1B;
        Sat, 17 Dec 2022 10:09:02 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id i25so2857921ila.8;
        Sat, 17 Dec 2022 10:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaOXfyrRK1GvvMxSl/L9IDQJHqE1dyqe1DAr6Oxagug=;
        b=hEajjzC1KfeCTFM9jwZ/wkxgEEsTo56Cmb0HjJq2tAbyL4UrwaaI8OXYEzAmFSXM/m
         Eu00Vyn4U5KHPjF8zfwE4wz+XSFaEl5te2WtTkRxSbtkGeJ8L9ITtGcZdbth0r8fA95X
         BjBnR36kedNXXW1suwWOClMosFLtRpRj0Tvv6OsglfN1zDiiPiAoPMWZNxQVzxzPMIe6
         7zs3frnuUOoEP0Pef3ejhzFOvR0onWVQIk+2cSDWqNYLC4IEDcPHSKAF4hZfNK1DMQKi
         RmeFkysP1ZpSuObN6xy5AITif8bN6f7ppZMC1tnKhapqf2tJBPyJa0XFxcYuG1Xnm37P
         HjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaOXfyrRK1GvvMxSl/L9IDQJHqE1dyqe1DAr6Oxagug=;
        b=c8v8a3WpYp79aG6AoiPO+L6tx1kCuK9bdMMLkfutO+stMSr2pFP9du4wP3vRhI+ViO
         MuOBr0K9HH/WZmnpjiojGXOA0LKGSEXHiJs+JcRgvLQe4fAgRCcYAdoL5gl+vA2pjYKC
         6BUe0pM0BSF0BNAQkSQssQZsmZJbpHPFfv5Ywyfv0L51p4JnrkxbNuZM0JuKYnTXQ403
         /BAB/Iv+obmdce4ArLhLXPxJ9h/czyqRlHRXkpttiTOaDBecOxmC/7e0SC9PROllCtHo
         GCCaqmd47duLL10Je/1kUnUVxI/lpL2xYAhcVL34Yl6RVuCXR8Xys64Qc0Kca0Hpd5x3
         z4Dg==
X-Gm-Message-State: ANoB5pk9T6ggpgjCrdu7JY/5RzCJeE5LyR0Tgahr4Ps+4CZSQip29I2C
        drEIPMPJ/MclfBK22r2tbLw=
X-Google-Smtp-Source: AA0mqf41cNtnsG1L5o0PIOt8qpeGcJNybnnp1MbzQn/F3WKP5fT85C+inXMg1ySV2wTgYSSUxmu+Zw==
X-Received: by 2002:a92:cc4f:0:b0:304:c91b:4a5d with SMTP id t15-20020a92cc4f000000b00304c91b4a5dmr11949100ilq.9.1671300541957;
        Sat, 17 Dec 2022 10:09:01 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:9aea:d320:bc96:560d:6b27])
        by smtp.gmail.com with ESMTPSA id u26-20020a02cbda000000b003728cd8bc7csm1763398jaq.38.2022.12.17.10.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 10:09:01 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: imx8mp: Fix power-domain typo
Date:   Sat, 17 Dec 2022 12:08:49 -0600
Message-Id: <20221217180849.775718-2-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221217180849.775718-1-aford173@gmail.com>
References: <20221217180849.775718-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dt_binding_check detects an issue with the pgc_hsiomix power
domain:
  pgc: 'power-domains@17' does not match any of the regexes

This is because 'power-domains' should be 'power-domain'

Fixes: 2ae42e0c0b67 ("arm64: dts: imx8mp: add HSIO power-domains")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 7a8ca56e48b6..19609ef0560a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -591,7 +591,7 @@ pgc_mipi_phy2: power-domain@16 {
 						reg = <IMX8MP_POWER_DOMAIN_MIPI_PHY2>;
 					};
 
-					pgc_hsiomix: power-domains@17 {
+					pgc_hsiomix: power-domain@17 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MP_POWER_DOMAIN_HSIOMIX>;
 						clocks = <&clk IMX8MP_CLK_HSIO_AXI>,
-- 
2.34.1

