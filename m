Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7493D6B8CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCNILv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCNILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:11:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1634B984D1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:09:35 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x13so11149194edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKPYbv1iLnGB+8/bk3IbTuS+zV9TKOLzePRCaV4OSl4=;
        b=s2MAYD+rDEsD5eHGwdFliTXA2P5OhUVSh7dZsFvk/A+Xb3zMyLdhU0KVu4hpJiUcGU
         YOp1rjxYBx8XVafAvONnWirpE7OxxHYepLnoxX3zlMrUtBi/KeTL9PSs1dlegHw7RS5F
         0Tw6yLnk2r3fApUsglYvGjz+9qCNvVgJE1p43Tlbt5u+AIk9n/AQPm5e/Tr+jV9JVtpX
         tG/noMQzzYMN6qxxxCzIU2h5OO9KjmkndjgRyOeYXD/RygOXefjBY9hShW26/CBpV8gd
         llNLe9/TcsZJewWVshZfisCC4xvc5TQPAJeI7nt2rVHCCFF8OCtkT5D36g5uTFQz/qQ1
         G/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKPYbv1iLnGB+8/bk3IbTuS+zV9TKOLzePRCaV4OSl4=;
        b=DsfVwXTLXWn3seQN0zzFjqPpqnAAo4sFl2ZdoVlbwcw/4K5o480YcktHVY8T18gVT4
         /dAcrhRwMRmicCOg6K6rvKaoXWiqUXeBHcUADTUmDO/xwXpYip83dZvi518EcN9QuhFM
         o2M+bur5zSWHLwnfOSeGsa3euDOtkKMUMI/uffcvmTEQalVfsiewxhqWeRrrUR8gixrF
         bDG1hctpLhD6/QtdjDlTbKknZ0CvOndyb4KgUKMv6beJYku6h7v89pWzSKVDzEPfWEPw
         +p2zN9vLSRPJTFgGRrajn5mYdhDF+jYR9leFLr5PaAi1hY6lots7RJLv4YjvQLxKrorY
         yCfA==
X-Gm-Message-State: AO0yUKVMXJD3Lw7WEy/Cbfx5TTwP+ruF0uRNF8NZ49OvwZKt3JwEGjhT
        ua9L6gySt5dKTLjFqUAc0KLMTg==
X-Google-Smtp-Source: AK7set9tAQ/UTUyIwBWmhzJ1kVfZkwoA544DRKLIMoO2W/GSjP1BpoPI2ti7TXz6iek3ynAsbFYBeA==
X-Received: by 2002:aa7:df1a:0:b0:4fc:7201:6e4 with SMTP id c26-20020aa7df1a000000b004fc720106e4mr6335498edy.20.1678781368005;
        Tue, 14 Mar 2023 01:09:28 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6932:5570:6254:9edd])
        by smtp.gmail.com with ESMTPSA id co2-20020a0564020c0200b004fce9ff4830sm584872edb.88.2023.03.14.01.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:09:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 09/13] arm64: dts: qcom: sm6115: add compatible fallback to mailbox
Date:   Tue, 14 Mar 2023 09:09:13 +0100
Message-Id: <20230314080917.68246-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
References: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM6115 mailbox is compatible with MSM8994.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index fbd67d2c8d78..2feaf9c831fe 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -2038,7 +2038,8 @@ watchdog@f017000 {
 		};
 
 		apcs_glb: mailbox@f111000 {
-			compatible = "qcom,sm6115-apcs-hmss-global";
+			compatible = "qcom,sm6115-apcs-hmss-global",
+				     "qcom,msm8994-apcs-kpss-global";
 			reg = <0x0 0x0f111000 0x0 0x1000>;
 
 			#mbox-cells = <1>;
-- 
2.34.1

