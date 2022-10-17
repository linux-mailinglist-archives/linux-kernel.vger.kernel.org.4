Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394376004ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 03:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJQBrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 21:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiJQBq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 21:46:59 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62D3349AC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:46:58 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f22so6945392qto.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2EnaIiE9Z7xul2n+Sa99kYSQbHoFfWsvTRWVfAVL2Q=;
        b=dsX86aeKxh09gkeG5WMe/l2UOoMq4A/t9Lkli2AK/fKWDFXUvkXTRdemysv3e+p5ge
         Fw4yh+9puNdLI/3bDYHAWyS3QXdp9kc4KDSjZhuULYsTSvFyhHDv4+Lt9XDusgFoJ/ck
         Mg1XAXDDMSl5+0HkuwjSHim/45DRk3IgR26z5JJp8dIz29/u0xYw8YhtLS1st3Nb3wIM
         wPOhFdVu2zYF+xfy8zW1CqHFJzvkUJmZeCC1WkwgMGS/gTRfPLOsoL7r7sbZfNSsRWuq
         jHIuCryPXTeVCK+QafFggyH+EkIExoAzL7++tzyxh0xgMdsS80SBx6GUhCM3fF7byzRs
         IeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2EnaIiE9Z7xul2n+Sa99kYSQbHoFfWsvTRWVfAVL2Q=;
        b=ayxraPJ71yatP5JjgkY1pvqFoXonFkwQ/IPaL/WVnmrfjty0X6ltEZUpSwXE6fRgHs
         AXwvVK4Vx9uoNRmfLYGPk+EYTo6+sm//+jnOtmQE9Bk14QFKbP4OhusFl0tWfpsw8aan
         G5HCGONf5xJiXeyWtCWaFPZieVR0rugdPRmlSekcDjbG5KmjIcHQeWhioVRKb+sIKtNK
         /LcYFoxqcBR7O7cCJ4yVPP6V/uRHhIS2R2M3tya4xsRr0wQ65NJtdSrJFFw0l9u6dMws
         9uKsIW0IIQB5MplzHeQxc1gV6QgeH/uGoaYZxQpzbAOTwnLHCQOcHEyNHFDnJFN8QYaG
         I6EQ==
X-Gm-Message-State: ACrzQf02gdEemsBYk35ezVzGdfjq/PscbC82Sc5kWVkmKpbQrP7slZF5
        cYQ0sh0Zplby4sDFvD6Gs9YqeQ==
X-Google-Smtp-Source: AMsMyM65vRO8bGI6MDeXVTKwIzU5YHdloWZctOXBWNRW1JpOz+on8cdtmrdhBNoF0DasRk9HABaVJw==
X-Received: by 2002:a05:622a:188a:b0:39c:eb39:e7d0 with SMTP id v10-20020a05622a188a00b0039ceb39e7d0mr1898036qtc.182.1665971218137;
        Sun, 16 Oct 2022 18:46:58 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:bb7d:1aa4:bef8:ec27])
        by smtp.gmail.com with ESMTPSA id 66-20020a370745000000b006cfc1d827cbsm7996502qkh.9.2022.10.16.18.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 18:46:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: qcom: ipq8064-rb3011: Add SoC compatible
Date:   Sun, 16 Oct 2022 21:46:53 -0400
Message-Id: <20221017014653.12970-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017014653.12970-1-krzysztof.kozlowski@linaro.org>
References: <20221017014653.12970-1-krzysztof.kozlowski@linaro.org>
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

Add qcom,ipq8064 compatible fallback for the SoC.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
index 5a65cce2500c..162c9c50e301 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
@@ -5,7 +5,7 @@
 
 / {
 	model = "MikroTik RB3011UiAS-RM";
-	compatible = "mikrotik,rb3011";
+	compatible = "mikrotik,rb3011", "qcom,ipq8064";
 
 	aliases {
 		serial0 = &gsbi7_serial;
-- 
2.34.1

