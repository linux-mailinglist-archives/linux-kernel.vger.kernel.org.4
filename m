Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383B37345FA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 13:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjFRLpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 07:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjFRLpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 07:45:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB6E10E7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 04:44:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-982a0232bdcso401550466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 04:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687088697; x=1689680697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI7hZPh6Ef7hI7RZcUH78AnG3ZVvJbISEmDlW8t8yX0=;
        b=IKzOcvVISUvvxf4yVIrMpll/ZUR4dXtAdOE+8K1TJ/9LcLibW54Ek7KIAHh8ltOemj
         77DF2R+b3R+GwcBKoVbRKQXS79rqCUrNg1nN5SdTeeThZS+FGWbc00GIH8+saX682i/k
         An9cOtR4HtD69IGPcNLyoXZq4OQgTTS3hD2dEIPuXhwePpLtTkaxHXVPLsUwUr/BR0K1
         Roabn2jqrMbbL5EUrGcEsgyZd5aqDi0k4WVoZyCVFpfyQJ+t+xzVE3F9E35KFuSMZZaW
         pKPdgVMyuG3al38Ho+kNO6gyb0iMfChw7tQHpqLViUeis2pyvOkUPpf+2Go8jDxLzHiD
         c0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687088697; x=1689680697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI7hZPh6Ef7hI7RZcUH78AnG3ZVvJbISEmDlW8t8yX0=;
        b=Ty+PzZV07Y0bU1GmDZTWlxT0SUbesIce/nLk0w2yif1v7HddLSkRiSMQPv3qNW4/W/
         JuJmbwEFX7vTlZ42I5xzl4TmYGpWDpsOtkmLc2p12cfvzx54GanFyz5d6Ni9gAZmGdqQ
         H8Ofk1uP6MyCs+PcQ3bq9aH3GTuqZrPAUnnN0/uai++jb1zAlYeB7sDNgDUeazZhW2jI
         JvNX9O3X32JJon1bB2Vcvjmf3k+uo/nZiHHBY7cUDGTBOmiZp3RGIuUpmJLNVYBWi8fJ
         W+1Nq64bV+g+ZoWRUyXjn0N2YIwd0uaRAWizNCK+p+AEhdjbgYHaAxHbDwYnWhCoh6Mr
         U5Lw==
X-Gm-Message-State: AC+VfDzcV4GenfC2+OdC21s56K3xqFwiLoB32pD1SeoEtzJrjBIkkI7J
        NgkI+oJ/mQATKuXIArgiHL3dmA==
X-Google-Smtp-Source: ACHHUZ76G2KJnKYcfx5b3ujMuXh181TywXBmv3mdldkUI6reL+LmKWCkNnQvmCMZesi0PdcLC2tTig==
X-Received: by 2002:a17:907:60d6:b0:973:ca90:1f18 with SMTP id hv22-20020a17090760d600b00973ca901f18mr7596760ejc.76.1687088696966;
        Sun, 18 Jun 2023 04:44:56 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709060dc400b0096f937b0d3esm13183854eji.3.2023.06.18.04.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 04:44:56 -0700 (PDT)
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
Subject: [PATCH 6/7] arm64: dts: qcom: sm8150-kumano: correct ramoops pmsg-size
Date:   Sun, 18 Jun 2023 13:44:41 +0200
Message-Id: <20230618114442.140185-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
References: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no 'msg-size' property in ramoops, so assume intention was for
'pmsg-size':

  sm8150-sony-xperia-kumano-griffin.dtb: ramoops@ffc00000: Unevaluated properties are not allowed ('msg-size' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
index baafea53770b..ae0ca48b89a5 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
@@ -222,7 +222,7 @@ ramoops@ffc00000 {
 			reg = <0x0 0xffc00000 0x0 0x100000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
+			pmsg-size = <0x20000>;
 			ecc-size = <16>;
 			no-map;
 		};
-- 
2.34.1

