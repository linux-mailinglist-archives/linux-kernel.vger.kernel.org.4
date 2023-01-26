Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63EE67CB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbjAZMrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjAZMrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:47:13 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DD16D347
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:47:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y1so1669368wru.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Hiqiqd1r7bxhHARO+brBurquXICZ+FcTy3sXinUo+w=;
        b=wWKOlLw8rfTnctLsMzyMyFdaHXAUqlNtWLv9hfwRYMCWd+cYvqxskBNosNjTs4S7Nf
         yE5k986ugAPQfFBSf0IKTekJL/+BTsP4170ikXfN0mA/vVhbwlqi2L/qfKgmWd629HEL
         7v07altHpXx2oXep4eA4ZvgBnOeDWUA8tHqulJ0SfZIWdda64L0cSUm6ZYtNaqrcuDHe
         38Epo150BZsuvGB+fpsc84ypijEu+4b6sRoQcLqhzLG6ecl8ofG5LdB8OAdGATLsNBNw
         HdQtoyFAsTHOXJGGG+oJPoeMuvLcbk8CB22OmbUZ4wgE7wEcyq/Wyu5o9s7L/IiPGAVW
         DK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Hiqiqd1r7bxhHARO+brBurquXICZ+FcTy3sXinUo+w=;
        b=hykZ0ieyr6OySKiXpmKO0GWI0Hb7uGRRkrrPIuTcLQRHg0+qiJ4BptwFXrBCJ6jH6g
         uEK7UN1mQJfeAtmNjKAECt5hdIy9yooxkBV4x5j51hhlOCGRLt1z6X200b/tsAg1Fvbe
         W23PZv5Rk5y5GMpbRWOUa1sfZAwJx0vxbptyFpFB2uWzHT4Bh/S5EOGTxSOIv+D6rFzB
         nfrD3zjeDOvI9Zhknw6GjCR4uldC6cJ+v61BOIsJvYOpqKaNPddDIDj2NBcKuiGnipF7
         j3Q5ijdCJeeIpJVVNayJlfR5ayVcAX3Aggwt8Xa73mLDgQhLcy2yGoVdSNDYyrMgW+AD
         mMHQ==
X-Gm-Message-State: AO0yUKWaPEaApezeWpmbXIyPi6afPHheJReZSt+FeODt/aY2m2c5XKMw
        /YkiAwjP543ey76NIJNpsyuWsN+Vnhit6xd+
X-Google-Smtp-Source: AK7set9q53x1okffv7MXEXBGbFJ2Lkvy3vzXs8pafMBOjEDFgac2KcQARMZDAHCW76jagk0jgidPYA==
X-Received: by 2002:a5d:50c5:0:b0:2bf:b54c:6d19 with SMTP id f5-20020a5d50c5000000b002bfb54c6d19mr6804012wrt.10.1674737223931;
        Thu, 26 Jan 2023 04:47:03 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v11-20020adff68b000000b002bfb8f829eesm1198681wrp.71.2023.01.26.04.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 04:47:03 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: [PATCH v2 5/8] phy: qcom-qmp: Add v6 DP register offsets
Date:   Thu, 26 Jan 2023 14:46:48 +0200
Message-Id: <20230126124651.1362533-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126124651.1362533-1-abel.vesa@linaro.org>
References: <20230126124651.1362533-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new SM8550 SoC bumps up the HW version of QMP phy to v6.
Add the new DP specific offsets in the generic qmp header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

This patch did not exist in v1. Since then, the DP support has been
added.

 drivers/phy/qualcomm/phy-qcom-qmp.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 148663ee713a..7ee4b0e07d11 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -134,4 +134,8 @@
 #define QPHY_V4_PCS_MISC_TYPEC_STATUS			0x10
 #define QPHY_V4_PCS_MISC_PLACEHOLDER_STATUS		0x14
 
+/* Only for QMP V6 PHY - DP PHY registers */
+#define QSERDES_V6_DP_PHY_AUX_INTERRUPT_STATUS		0x0e0
+#define QSERDES_V6_DP_PHY_STATUS			0x0e4
+
 #endif
-- 
2.34.1

