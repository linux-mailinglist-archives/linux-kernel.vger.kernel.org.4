Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06E75F2196
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 08:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJBGp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 02:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJBGpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 02:45:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FACC2E6B2
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 23:45:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id 13so16564507ejn.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 23:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I6XMIDzmAb5OEYRQrNrBJ64J1RkMPb1xdg1o6LLrqS4=;
        b=kdPlUwALYdNbkW9cx2XLVNwgOxrzhu3xLLiNM5FmcdjmtgSxDjZiXivE9cURSlKI9G
         THB25Gxkx5t8suAAn8LL2pI7YADY+GVOgVmXbiI2zDF9bH2yHej+i0+hvqZxj0Akp/p5
         uh/tBzNaQX2p0eFbQeZw5FnMylVKKnY0W1Xc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I6XMIDzmAb5OEYRQrNrBJ64J1RkMPb1xdg1o6LLrqS4=;
        b=uVEbYBiw3cdRQMJvQNdFCPb1BNFRP+2e6kux27f5WvR0IWHF2fnWD+tswOrqNTq5Ec
         tJTFG1ByZKZQ+0fvy96auDAoS2c5gy2bT4LEQZhZ50Qy8Vdp9VN9/4OMdaTRN6xSlvdv
         iKDZWUgD2bdeZaYP2mzB0kUOUaMplwjGYdweR2PaW7QHddnpbLXPmJPOaUPBNRrNq0Ud
         A1T835/AQcY56RHWXyNfaXsWjcH8JTFKJr0TCQj3TrkffDq3SwOD1TSgX0PO5F7NvGAt
         6QNCf+GaOWobjeW4CjBLnNS98U4oMrGKQX8+M3sDmzcWtnlG+jJsoLGaLUj3yWVoF5PP
         ky8Q==
X-Gm-Message-State: ACrzQf1/svjZ1glrHWL5Je+JoPxJExkrt/1FLonravtyv1i2nXyq2GMy
        iNtSfl2NuLC/XA1FApiYNmAg+w==
X-Google-Smtp-Source: AMsMyM42Y13+9SuPHtB+8bbihrWVsma1thKzuBn20iHav0eL1jLmBw0Y9w2/3o+fg6AJtnqVC042IA==
X-Received: by 2002:a17:907:2c67:b0:77d:740a:e9b1 with SMTP id ib7-20020a1709072c6700b0077d740ae9b1mr11198850ejc.614.1664693146999;
        Sat, 01 Oct 2022 23:45:46 -0700 (PDT)
Received: from panicking.. ([109.52.206.103])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906329a00b0077f5e96129fsm3569894ejw.158.2022.10.01.23.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 23:45:46 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-amarula@amarulasolutions.com
Subject: [RFC PATCH 2/4] phy: rockchip: Add inno_is_valid_phy_mode
Date:   Sun,  2 Oct 2022 08:45:38 +0200
Message-Id: <20221002064540.2500257-3-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221002064540.2500257-1-michael@amarulasolutions.com>
References: <20221002064540.2500257-1-michael@amarulasolutions.com>
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

The function is used to avoid to enable clock on the hardware
if the mode requested is invalid

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 .../phy/rockchip/phy-rockchip-inno-dsidphy.c  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
index 630e01b5c19b..644cf73cfd53 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
@@ -217,6 +217,20 @@ static void phy_update_bits(struct inno_dsidphy *inno,
 	writel(tmp, inno->phy_base + reg);
 }
 
+static int inno_is_valid_phy_mode(struct inno_dsidphy *inno)
+{
+	switch (inno->mode) {
+	case PHY_MODE_MIPI_DPHY:
+		break;
+	case PHY_MODE_LVDS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+};
+
 static unsigned long inno_dsidphy_pll_calc_rate(struct inno_dsidphy *inno,
 						unsigned long rate)
 {
@@ -495,6 +509,11 @@ static void inno_dsidphy_lvds_mode_enable(struct inno_dsidphy *inno)
 static int inno_dsidphy_power_on(struct phy *phy)
 {
 	struct inno_dsidphy *inno = phy_get_drvdata(phy);
+	int ret = 0;
+
+	ret = inno_is_valid_phy_mode(inno);
+	if (ret)
+		return ret;
 
 	clk_prepare_enable(inno->pclk_phy);
 	clk_prepare_enable(inno->ref_clk);
-- 
2.34.1

