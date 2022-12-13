Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89BB64B49F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbiLML5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiLML4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:56:48 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774391EAEF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:56:36 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id y4so3021298ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk5rrHzgobJdv8TvBstVTWS9sXEGYG6jA51TSd6vSnI=;
        b=HSFc84LGJ4NIaljk8RtC0qIjeOqQy98Pw/DgT2WF/Man1MF/WUzt8jj+qYw4PztKvA
         IGXemB5HxSEYDUnW5Hk+v+aKpHKoLLdH6xWZCiEHydxC0OEbYfAQHUxeZMwUgDkh2Ujl
         W8nLznXXVlpMNhoHARHxXU9lAW/qB+QLkcuJPvKd7TseTg7MjT/1Qa4zl8oASn04Yya3
         Caj9iQ+O3PL+79+NXSbR88vUDnWJGNrNqJr2zA8SXlrqzALjcufLrbjql0ONac/hEQSy
         xJ69/bjBtU+p5Fd7YAUBbMM+zJaaA6I2kmqLd9ztaZS+cSR9iGGx9kdTHXX2B2x4CYhI
         vjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk5rrHzgobJdv8TvBstVTWS9sXEGYG6jA51TSd6vSnI=;
        b=BZoU82HLS6GkNhjmN/GnzFx3Uu82YkYLwDm7KEJjZ+6XgYi2egDosLWqDbIeFkRoca
         h0nJ2W+i+h/qLndh1QccoM1MPvzuxHZyQsQYQtpNvvLrsBiGwfqJWfcLSeqqgueUXEqC
         nVGFTpNchmiOVgn5heVzQ0E1rEk47btCX9+d7ZpQfKGi0luewO4lZOnYxFazAt1usIUI
         cUSqdlIgYlkKj41SlVFN4tZIPgnH4dJ559KPueqNRyG6UzGs2IElel5+p7tW3vmcIZ8o
         7NWH8dtESIyBBO961qKWHlVnIY0SZVKOGI60v7CItutoo8Xcr2Drj7mWVjX+lxit/JN5
         UL7Q==
X-Gm-Message-State: ANoB5pnmY80aYEKGQK4Ih2Qvui1A2icX3Ww/i/3iV4Dhfhetw/ifENee
        5vtu/OWnl/TqJts19qxyv/jVpw==
X-Google-Smtp-Source: AA0mqf52dwG5wKeAoLqyWAZh0ngIe5mlmNXplbW5iLKAZYBQgWwCRvwNqDJugsZdzj2kTpUF3j5CEQ==
X-Received: by 2002:a2e:9a87:0:b0:279:e300:8f91 with SMTP id p7-20020a2e9a87000000b00279e3008f91mr6723409lji.43.1670932594795;
        Tue, 13 Dec 2022 03:56:34 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id 8-20020a2eb948000000b0026daf4fc0f7sm234573ljs.92.2022.12.13.03.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 03:56:34 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: qcom: sdm845: Add fallback CCI compatible
Date:   Tue, 13 Dec 2022 12:56:27 +0100
Message-Id: <20221213115628.105149-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213115628.105149-1-konrad.dybcio@linaro.org>
References: <20221213115628.105149-1-konrad.dybcio@linaro.org>
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

Add a fallback CCI compatible, as required by bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9eecf1b4ebf9..154f5054a200 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4386,7 +4386,7 @@ port@3 {
 		};
 
 		cci: cci@ac4a000 {
-			compatible = "qcom,sdm845-cci";
+			compatible = "qcom,sdm845-cci", "qcom,msm8996-cci";
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-- 
2.39.0

