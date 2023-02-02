Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF3F687EDE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjBBNis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjBBNij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:38:39 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A7F8F278
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:38:34 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso3737429wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 05:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RF2YyGY2PogpnFtO0lOlawE2OSglZRNn+XgKRaj3V+o=;
        b=B493GU/HRGCE8RL1MHvOnSUSqvtSnxbtJL9m8fVcRc/vQZCUyKjIfw+gg1ks9KsInD
         FSkPV/E/cm+OMAHpgokPniOm0vKmEr7gcFwMbqnMaZ4U3Cl9TZaffN1SY7Eh3m8EVXRF
         I/l5W8hHGTnyn9rRUeWeIN+LzEECgQOoAFiQ4jWfJVfYCBjgW+8NerlXiAXVdIGGqEEe
         tAm/XmQAveY/FQLanOeVnQCL3bTMcTcbfKDx44oU0hJJ+fkUIgIpvS3gX18p7yyEEd1S
         CXDBd3yQVL16zyLhWLvoySJcm9qgKERq6GmOZ4RFtAvwvhSbrK2Z8B5IB2Vn7PFXWY75
         XMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RF2YyGY2PogpnFtO0lOlawE2OSglZRNn+XgKRaj3V+o=;
        b=LhFtklP37mYu1qBVxF1LgpopZZGtGfpIqQWo/vHlOjvFazizXX9K/CYh31VRw2QEec
         V+t78eEIHmG0ov8YMGbp+xt71zzHU3V8Mst7ZYqDydLx1+dJ/c1EBvrm+2pEXzMkGgKf
         YCiEkuN2FsNtF478yNZrykXwEcOD97SSUVAdDgjG5OBfytt2InGkYJZeifF9TnpOBXNK
         +M+PRJR8uOpdZCDU2VkXn6n06U0zSMFk65YfBPs5gBGtNQxXKvi7o5UI4FdZBIXegOG0
         7tywqMU+sQKIfQF2MO2PLIqxFnEmGuoZ1wuwnRMxSj3AjTyIuv9lhDwqmYELWZB9cnM0
         hAjQ==
X-Gm-Message-State: AO0yUKUA0nDLYTgFvZs5MmVLqZt4zeIY4urqFIwU8+J4M8/vSRy74qMq
        vtQgVCS2rgwTLK6zpAFK4X76BQ==
X-Google-Smtp-Source: AK7set/3dxyCvIKg/OxhNHZc2h8pfCZ3eo/m5fmRMmCuySaaZQRcSkDBXrbDfs60V1JHNXj6RsCgfA==
X-Received: by 2002:a7b:c38f:0:b0:3dc:d5b:5f6a with SMTP id s15-20020a7bc38f000000b003dc0d5b5f6amr6074422wmj.30.1675345114293;
        Thu, 02 Feb 2023 05:38:34 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c364a00b003daf7721bb3sm4672657wmq.12.2023.02.02.05.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:38:33 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [RFC v3 6/7] arm64: dts: qcom: pm8550b: Add eUSB2 repeater node
Date:   Thu,  2 Feb 2023 15:38:15 +0200
Message-Id: <20230202133816.4026990-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202133816.4026990-1-abel.vesa@linaro.org>
References: <20230202133816.4026990-1-abel.vesa@linaro.org>
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

From: Neil Armstrong <neil.armstrong@linaro.org>

Add nodes for the eUSB2 repeater found on the pm8550b SPMI PMIC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8550b.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8550b.dtsi b/arch/arm64/boot/dts/qcom/pm8550b.dtsi
index 16bcfb64d735..72609f31c890 100644
--- a/arch/arm64/boot/dts/qcom/pm8550b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8550b.dtsi
@@ -55,5 +55,11 @@ pm8550b_gpios: gpio@8800 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pm8550b_eusb2_repeater: phy@fd00 {
+			compatible = "qcom,pm8550b-eusb2-repeater";
+			reg = <0xfd00>;
+			#phy-cells = <0>;
+		};
 	};
 };
-- 
2.34.1

