Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E857B7008D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241189AbjELNNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241207AbjELNM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:12:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B821491D
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:12:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f42c865534so43311965e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683897124; x=1686489124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tU0B69j9oYl9odVdfBAPIMS59aKUXC4/g/SkHuPw6SM=;
        b=DEa+d+uKQoEMQZGIs4gTTO3/X9AWlIU/3Qsb08OsEOQBhbyjHHtbjWpY/JAwJqya1Y
         4mF+izVr5PGl/ffs2k+N9LVtcSr4qARAKN8GGXsfKBMmVeDgZ7zc+1WXgOzwLvwLy1wR
         VY3jucYZBSMd+uRMN+HXUIhlEtXsDsnvKvN5MgAW2Mr8BrEdGFMcVq1HWcrliq7zgJVD
         84FEvJMjO4QjEMBgisKxSQqAK6qQefxO+kfR3wwjROVch7eBWT8QRN6OiLe/7hjFbxTm
         I90p5aWmr3LC9j7g06WfIqFi1tcRw06pH8QMQnoBEYAELhAeN3Y1YlUFN/dLpatWrfYe
         pEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683897124; x=1686489124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tU0B69j9oYl9odVdfBAPIMS59aKUXC4/g/SkHuPw6SM=;
        b=Ap5+q5Bjs9mMqkVe7Y6XaoMguV5a0VrYLZzA2eWFNMfl95Lgj0GL2tTfRKD2DmG+Q5
         F7xn2cnR7I6eXAyNGrigJ5lVJXiCSyWuM1mrqRaEAMEmFkjsgR8z/BQOg3Ap2kxswu+z
         DlApO4OkpNEfEYAlj+bulnd+a6xd4vFvMzbnZItUVzowo/PZSPVsRSBQIphhoWTdaPrS
         IMZTtUAYimubSNcuCdvAepg5JMoy39XYDNh3qieyIDRVl/bildvESHAoTN4R1iziQlpl
         Q4TdDITD+XPxp8F9FTJJx/Q1Wv5qFcFNY9UVOq6JiQcFZzZpXmJDu5OD+/ypXbydJ37E
         vBzw==
X-Gm-Message-State: AC+VfDzLtOHBUzKZnEFbgP1VtlLR3ztFswVav+LNYhT3aNpAd3tSr2sL
        NBlHzfHXQkA9kn5ue+PmnBRipQ==
X-Google-Smtp-Source: ACHHUZ7W/9YsLoXfyrpzR/TWkwhUIMNI3MoJdC2qky03ik8PdsAnXNDdYPZQPGK2elAOg3IC4k1+4g==
X-Received: by 2002:a05:600c:228e:b0:3f4:2174:b28a with SMTP id 14-20020a05600c228e00b003f42174b28amr16472329wmf.15.1683897124428;
        Fri, 12 May 2023 06:12:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d610a000000b0030647449730sm23461965wrt.74.2023.05.12.06.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:12:04 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 12 May 2023 15:11:41 +0200
Subject: [PATCH v4 10/13] phy: amlogic: phy-meson-g12a-mipi-dphy-analog:
 fix CNTL2_DIF_TX_CTL0 value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-10-2592c29ea263@linaro.org>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1015;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zfbNtn4eYfFGUuzqUqrrZy+ybT8YTEYYfxc76QqCk+c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkXjsVuLo7LVxLSfdfUja2xovTbvm0HNpj1ysIYkBZ
 K/S7KECJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZF47FQAKCRB33NvayMhJ0TVREA
 DOsrTgakHLrmGmB/wyrUhMoEXsbiUZVaeV97gzXwbUe/GUy+SedCos1HUur2UmewFphaZyJe+pL0Xv
 pYIXKuMNXIEQLQM4LH1wUbC8p/bvtECbcdUl8j3T9v50w/8okOh+JH/e8OvCagm18Ptj81p7CjtAt2
 B+podPJKhWvlV32zY9od6Y64uyflWC5bbTtP7iQHo5vTLnkwedbtSfg5aKNcaNb2Ibg8MDP1IHFJLq
 RP6wAGI//oUb3XmJ6kRtVCvV1MtcCwp7kk8F0AjnJ+hj8VpXIGQ8kSyxrlCk7JasfbudOpGlYMiX7+
 BWmvwaPjr3tOmUPAKsV5yzVeqb1ZQwvBJD8NDoemCvCW/4S4VRWvcg4caMDQCedK2/NZowXRP+LUzD
 uTq/oNzOgfgHSMlRMQhLoBhRLs3NAcukf7RbkNejIA4UnGZ967/URvq+tpFnXw4KW04PWsP6dbFIKQ
 h7iQD+FNh7PS2cAICGSV3G9duG0Is/ZsrU78dVxotPqBIQcthVuzB524J0T/fooqK0gYdG3LAloQXB
 q6pURKiBKYM0eglBEDUYiKDuqLVWo6QWuykfhtkAYYtUbJgDddhhe9Yu625L8uZlOGPnDXWRuYkXCg
 E8NbJOPkv/k7P0GWvBJo2joJmh8z4HAIzEau29jrsfXk7M11F/h14v/sDdnw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the same CNTL2_DIF_TX_CTL0 value used by the vendor, it was reported
fixing timings issues.

Fixes: 2a56dc650e54 ("phy: amlogic: Add G12A Analog MIPI D-PHY driver")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c b/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
index c14089fa7db4..cabdddbbabfd 100644
--- a/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
+++ b/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
@@ -70,7 +70,7 @@ static int phy_g12a_mipi_dphy_analog_power_on(struct phy *phy)
 		     HHI_MIPI_CNTL1_BANDGAP);
 
 	regmap_write(priv->regmap, HHI_MIPI_CNTL2,
-		     FIELD_PREP(HHI_MIPI_CNTL2_DIF_TX_CTL0, 0x459) |
+		     FIELD_PREP(HHI_MIPI_CNTL2_DIF_TX_CTL0, 0x45a) |
 		     FIELD_PREP(HHI_MIPI_CNTL2_DIF_TX_CTL1, 0x2680));
 
 	reg = DSI_LANE_CLK;

-- 
2.34.1

