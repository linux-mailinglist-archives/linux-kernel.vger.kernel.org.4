Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0F56672D9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjALNF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjALNF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:05:57 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA84E27
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:05:53 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ss4so37314311ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js79G0ew5SBLWV/rp6ARJpWVK36TQx65bfTfHk7gwPY=;
        b=WdwnFkSJ6TcQXJX0/YPUg2u26LJdKuuvmh6a4VmVSCu93pLHHZCqhBDl7C1Mom7mCc
         L+Rw5jcBJjG+adaV+vlEyQ9oAFCmmXgMNWC0mFzirsmDljWLksDNmPVFAEJ4nIAcKWxf
         l/AlaCkYpRXdMvbtZqNPfhJREPhB3M79ZcCqFEQx85zXwPHNOKAxGscs7tJLK8B9Q6WU
         ZAZBBT3XbLWn6mo70gZaZKx22EgIpGuMbRZEkAqMoS9WC3B6c1OMr8jn6+0ycMil6uqF
         9wcmyiDXs30gAuDSnmgm9/AJWGCYLUY34uD1HqX8IOFIeZjfgtO2eKUkleO27LGwx8ZF
         cG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Js79G0ew5SBLWV/rp6ARJpWVK36TQx65bfTfHk7gwPY=;
        b=e6c3KPvqe68g7wfzv91s421wPtyGc8zggoq//inBkbv6/rU4hQV1d+zMOflTIV1kKN
         wVPF2rKuiCuSJpuvnenzQwZrrTSvbimnv7+uPIsraJ4ElizwcTWSbVNW2plQmoxD9kk8
         /u/hYiBFIda8XGvpIYesrmrJyygWNuTrOfXrPlhLffhpMoozL+/TKTwyJsXgyL+8Bv4J
         LBvCv/GYcXRr3Z6wJQHSe9qRCg2Fvp3U32gBlQnhrUT89pmGN8qr39ZFKnMyIwt3mMPp
         LpFYwiChgBPxVH9oWOJlSRvyWEDQ15G1tSPpBuOOpdjMZwDhYyT9NttJLcXbqmvXbLbq
         orrw==
X-Gm-Message-State: AFqh2kq5xwgxCU3nRQ03Lb8E0WSwGMZEr/Vps+PfcpPl5e/PDsIGxqeZ
        zsq+r/6WJj6EoQ8YmL4VdPIfVA==
X-Google-Smtp-Source: AMrXdXsOc8saCzmD/dXqJ2/l2qrKh7yzarDqaDTYDJKr8FLOUpOP5e9rsoahF5JlLSFJYI/9/P2l4A==
X-Received: by 2002:a17:907:d004:b0:7c0:f213:4485 with SMTP id va4-20020a170907d00400b007c0f2134485mr66310785ejc.73.1673528752001;
        Thu, 12 Jan 2023 05:05:52 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906318b00b0078d3f96d293sm7427668ejy.30.2023.01.12.05.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 05:05:51 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: phy: Add QMP UFS PHY comptible for SM8550
Date:   Thu, 12 Jan 2023 15:05:37 +0200
Message-Id: <20230112130542.1399921-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112130542.1399921-1-abel.vesa@linaro.org>
References: <20230112130542.1399921-1-abel.vesa@linaro.org>
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

Document the QMP UFS PHY compatible for SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 32ed1886fbae..cd4e877415d6 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,sc8280xp-qmp-ufs-phy
+      - qcom,sm8550-qmp-ufs-phy
 
   reg:
     maxItems: 1
-- 
2.34.1

