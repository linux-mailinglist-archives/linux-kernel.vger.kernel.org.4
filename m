Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE9B64B533
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiLMM3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiLMM3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:29:20 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F2C1F2CE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:29:19 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f3so10317993pgc.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE+N1Gt7gGhT7n4RSqzdZOvLJC2LaUfbxIBsv2ZH22E=;
        b=c0vjS0nWa0vtcHTHwwgvDJUpfJLA8wLcA+h4xzxkUaFFMu7alJOjtQOFHBtfipU2ro
         lcC50Ke9qOuIC7bXqZsGxdNFgRJiAvn7SJwAHDoZHFB0+9ob5y5MWPnjXME2MPWBqtUe
         br0mKI+1reVRTjp6rBFCa04joQZBwKYtnnEa0P0+kALh6PtsDVSigsTr8yzjhG00FMoX
         5ICrfB9iLhfZdqDs25kzK2gnSz7VK4+jfMhSc99zZ0US/08IKupYykB5YN3ED03vsJWK
         xSzWQTKXZN8DTt2FjXPWttv6E+waW+bIsajy0SFBAUJzg+H+5f+hAV7ap5l9bIGX7xxu
         etqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PE+N1Gt7gGhT7n4RSqzdZOvLJC2LaUfbxIBsv2ZH22E=;
        b=G6q0cruL4K49PWuoSPFxm+FMc9o4qfCaIDi4thF56loLiBlwcqZx4J2GfldUU2yd8F
         Oxf237p2pNhf2EDT6aHD87Pu1R6xpJ/QmO/S8RU3U8aw5znWU8joLBEnn+GXODzzUwdp
         FpT42OuQa+caoLYcr9s3cJd35hXhi2lHFHLzluvorvCWIx5SP555I60cO+xQ/Ykjlpng
         wshay1ZecHhwubY0mL/eG9pSvDXPxfGFFydF0+7uL1bwt7+cA2rP1C19+7xIiCEoUwE+
         gpMw6otFEeaVH5b4JlXy13LBCyIz3TRcocS+76Wp0UH78aWVYgJb90jJ20WYW25Ofk7L
         OnYg==
X-Gm-Message-State: ANoB5pkNqQ7Qr2HiB6hHOvE2h3i41bVmbah9QKTMr2rVWyrA/nARRItp
        aKzWxNF+z+0k6v+cq3ovRcx1Tw==
X-Google-Smtp-Source: AA0mqf42wIJlaGrjyscSyxfrsCX6wYLLGGWN2fZBuQgon8p4dxNSQ3PcWR2HLv9MPBgwK7o5KQZ2og==
X-Received: by 2002:a62:e21a:0:b0:576:d2cc:1ad2 with SMTP id a26-20020a62e21a000000b00576d2cc1ad2mr20161699pfi.6.1670934559070;
        Tue, 13 Dec 2022 04:29:19 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c60:4bad:5c3:ab51:3d81:6264])
        by smtp.gmail.com with ESMTPSA id y10-20020aa793ca000000b0057555d35f79sm7602468pff.101.2022.12.13.04.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 04:29:18 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     vkoul@kernel.org, linux-phy@lists.infradead.org
Cc:     shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        konrad.dybcio@somainline.org
Subject: [PATCH 3/3] phy: qcom-qmp-usb: Add Qualcomm SM6115 / SM4250 USB3 PHY support
Date:   Tue, 13 Dec 2022 17:58:43 +0530
Message-Id: <20221213122843.454845-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221213122843.454845-1-bhupesh.sharma@linaro.org>
References: <20221213122843.454845-1-bhupesh.sharma@linaro.org>
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

Enable SM6115 / SM4250 USB3 PHY support by adding the
qmp_phy_cfg data. Since this PHY is the same as the
one used on QCM2290, reuse the QCM2290 qmp_phy_cfg data
already available.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 7a847ffe46daf..8ede8a6ab5e02 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2622,6 +2622,9 @@ static const struct of_device_id qmp_usb_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sdx65-qmp-usb3-uni-phy",
 		.data = &sdx65_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sm6115-qmp-usb3-phy",
+		.data = &qcm2290_usb3phy_cfg,
 	}, {
 		.compatible = "qcom,sm8150-qmp-usb3-phy",
 		.data = &sm8150_usb3phy_cfg,
-- 
2.38.1

