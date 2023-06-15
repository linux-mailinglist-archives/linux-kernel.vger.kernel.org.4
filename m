Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76491731872
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344662AbjFOMOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344109AbjFOMOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:14:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C895C1FD4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so10440413e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686831274; x=1689423274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C82NuiRAia/YhjujkCgLkELLEPYOAaW/5fpk8oBGP4=;
        b=nbSrgGPYHGrb5NKSb9GhBpiLuoYPO81y9AWPuhIYDmhylQDSCIhhZVpYdlJpFrO7ZG
         KNEpsDyztKGig5WxaeaoevmrrZktAQtH1FhP4gPPHfMBnJRIyRJOnKl7QsjJAwVwAPdq
         6TfRqOj8XSwylj8ghIN/npIEZG6VrCugss/69cHUCCuwoN3UDpTw84Svasp/8x1Czzby
         OHF7oHwmouARvjVcTzERFZh60OL6MIlm8/ZcM6Qzabi7GWGyLSm6FslEj/usCpjxPPmO
         gohhbaJvKsGtkGqpCb3HbwryUqSmh058EtuWN+/HXJpiLzF1C7x3DTfo7q3y2KjZqlg/
         O8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686831274; x=1689423274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1C82NuiRAia/YhjujkCgLkELLEPYOAaW/5fpk8oBGP4=;
        b=VxJ3VwWITacE1hYSGy4/brdTOhWb7wprY587PUU90iI4f2ODKyD/MzClMVh0nir+r3
         7/wFXuo5xYVOrWIPMta0QERlXwFFd3rD4XJcltvJ2+DDd60ydr0Rj94JtZx5vCFaEjfm
         MV+wAD1RCkq7FFR2q1BOq6NPXKuug+Rjajt0dgpKwoCnXmUVy7VcbnDOgcFkDb+Jf02J
         NKcHqkJj9T33OdHqGM/uIS+M0j6CYXLAoxpn+irOkDAo+a5DcVZ3fdunEP2j9XxoxvJM
         QCXMY+fnAmapFXfxOX6ZE2MQfZ17j44JV7GzUvRNHCAoG09NXpkEzGdxi22b6hvB0Rv8
         OLsw==
X-Gm-Message-State: AC+VfDyn8YDqNSVmhy/Gaowd7GNccWXQQK8O9MT2wlleJHO4QMsCW3KQ
        NgncY0onapltSvnQkosexNcfJA==
X-Google-Smtp-Source: ACHHUZ5t5bTBAwDNCCYhGugAix3n0kHObs1gW6QysxD7oyK5sYxgSrgds18lC0BPxZXC4yE+EbTEPg==
X-Received: by 2002:ac2:5b5d:0:b0:4f4:c6ab:f119 with SMTP id i29-20020ac25b5d000000b004f4c6abf119mr10024535lfp.64.1686831273902;
        Thu, 15 Jun 2023 05:14:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2ad4:65a7:d9f3:a64e])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d4291000000b003047ea78b42sm20918012wrq.43.2023.06.15.05.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:14:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v2 01/23] phy: qualcomm: fix indentation in Makefile
Date:   Thu, 15 Jun 2023 14:13:57 +0200
Message-Id: <20230615121419.175862-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615121419.175862-1-brgl@bgdev.pl>
References: <20230615121419.175862-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Align all entries in Makefile.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/phy/qualcomm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index de3dc9ccf067..5fb33628566b 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -20,4 +20,4 @@ obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
 obj-$(CONFIG_PHY_QCOM_USB_HS_28NM)	+= phy-qcom-usb-hs-28nm.o
 obj-$(CONFIG_PHY_QCOM_USB_SS)		+= phy-qcom-usb-ss.o
 obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2)+= phy-qcom-snps-femto-v2.o
-obj-$(CONFIG_PHY_QCOM_IPQ806X_USB)		+= phy-qcom-ipq806x-usb.o
+obj-$(CONFIG_PHY_QCOM_IPQ806X_USB)	+= phy-qcom-ipq806x-usb.o
-- 
2.39.2

