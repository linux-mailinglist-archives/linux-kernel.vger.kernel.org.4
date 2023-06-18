Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DCA7345F5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 13:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjFRLpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 07:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjFRLo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 07:44:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E237BE77
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 04:44:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9883123260fso83654066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687088693; x=1689680693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSL47gn1L1/6NYCgMBALhWT3v+BPAsJvm/qvmecO3gg=;
        b=QhC1QYjJNQsPuuiB8j4j956d80LOgk7C0p7Sr3KjTnDiAftCdaKBcVYOHxzuCP0fSO
         0wbZnJVQBAeKUppqrDCZCiwdogs5c47a8zkJ3OqQ4AbfLE88Ovl9FhePpy13QhmthCDd
         RCNNvGO72opz/clsxizJTuv03ayUmM+No6H8ZhHp3dX1lVOx1x7v3sk4CVEWrn0sA/tx
         xv8r4qXE5KXYqo8sfc77Jq1cgo49Qq3FB4GpuQFc9yMITKkhEk13BlLypUA/CkoehGUB
         +E92OBsPyCMmGS+C20mL4V2qhiHZ4SMqiPwBQ9rq3YdEVfN0VpLe6I4TTDBUInxyk/rS
         W86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687088693; x=1689680693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSL47gn1L1/6NYCgMBALhWT3v+BPAsJvm/qvmecO3gg=;
        b=i+PwiXuNKgKHiOgA+0kWdUWVE8oTYw7kZgf5yKgz4B8RquPmUYjEEKLXDvIALfKewo
         lgH5/RGMSn2pn5LrvegS5995dWHfi0G90YSdC/zVEWbTB+tcTHZ7lQmaTzZYALx4NEIH
         rdRiHjBNrYFH8wEQ64c3/E/BuVW8/N+cKBBfqIpFn9DkMuUPzYlT4Hf2uaNKZwhlTNvk
         IHvYu1gFfQ7Wg/rievcJoi2MUEc4MiPZ79Y9xCLmEOH9Gm/lX1W5Po6PWeBN5I7PStc2
         DgJRtoJt3HX4P0DmSWCNrlrSBm4KVab+ZnQC39cGVTDdSCAjIeGe8X7+CLvfMgvIH25G
         59Yw==
X-Gm-Message-State: AC+VfDxg75da1oCGGTHLJ+/yBvffmRkh+dWPCxpPrS/ARhazMmt4UjqH
        nVF4IfHA9yhWstKRJ6cn2M92eA==
X-Google-Smtp-Source: ACHHUZ6WKKXMpAExOdY4Zmhg6hUi7ZqfeA6VLYdFNA1+NxUIUoJNrgqOA+AKMQqEYWhRjpi01mc5kw==
X-Received: by 2002:a17:907:3fa1:b0:94f:6218:191f with SMTP id hr33-20020a1709073fa100b0094f6218191fmr5996848ejc.52.1687088693349;
        Sun, 18 Jun 2023 04:44:53 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709060dc400b0096f937b0d3esm13183854eji.3.2023.06.18.04.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 04:44:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/7] arm64: dts: qcom: sm6125-sprout: correct ramoops pmsg-size
Date:   Sun, 18 Jun 2023 13:44:39 +0200
Message-Id: <20230618114442.140185-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
References: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no 'msg-size' property in ramoops, so assume intention was for
'pmsg-size':

  sm6125-xiaomi-laurel-sprout.dtb: ramoops@ffc00000: Unevaluated properties are not allowed ('msg-size' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
index a7f4aeae9c1a..7c58d1299a60 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
@@ -52,7 +52,7 @@ pstore_mem: ramoops@ffc00000 {
 			reg = <0x0 0xffc40000 0x0 0xc0000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
+			pmsg-size = <0x20000>;
 		};
 
 		cmdline_mem: memory@ffd00000 {
-- 
2.34.1

