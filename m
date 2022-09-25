Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346135E9606
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 22:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiIYUrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 16:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiIYUrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 16:47:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ABA2C102;
        Sun, 25 Sep 2022 13:47:17 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i26so7939380lfp.11;
        Sun, 25 Sep 2022 13:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8JnTaUxBxl2Y6bYQxSkch1AceV7B8+lC6pectLFxi9s=;
        b=IJS99FPsmGvq4RupH7e6tIHqXe/PJQySVzUYUV3HvNwzfqRoJwQkhNUyzizt4qQxOV
         79U+wrFFT2tjt5MSAkjpz3nkKS9reu5CLmNiPCQkiLTzK7x8zzqyj1QIGSnnCvV+85AH
         RG1wNLY/s5UEK9ZWCONZC+PjRfFd79parLyoYH/+c4Mu1zHUEfI/PyP4GweSMqFqYKwn
         x622+QnMc+TTNNmjIeCAx0yuu0XwwO9woYjUL4LqcQE6LsbfDHH3CoHTXPUjc4OaYDV6
         HcZM109r8m/UPOVyiUhjEcWFkdFizitEW2zNpR8kh1ZLarp7bBmyOtDxUjjZbEve93lP
         tYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8JnTaUxBxl2Y6bYQxSkch1AceV7B8+lC6pectLFxi9s=;
        b=4Xfu8NqmK9NsatPV/IVUErEKuS4CuwGwdtjeXiS3jwVV77N9NshuJYxPpapncspO+S
         m8jTl7vcYLIGlZ+eKGSlxEMROUV4NpogDJgS4weCYnLPUb+kIi4KLRL1A5gtT/Om22KV
         UwzsAZY1Tgc8lz3glfNTXOYeDxfgCmniOYrf/NIunOuN5tb3gDqVZIHeKl67AdVzkq8I
         zWgIGVuiq7KoVQwY3cNDkONZkWSdbXHVjwNzOgO58iE4gacihvGNiCxT5QOMWiEY+IMY
         AMyHxYRKR2QRZsBQkh30Rp1uzikTK77HWpngVWtrZSbSQq0owGbJsml4JNWxI0c8USzB
         AYxQ==
X-Gm-Message-State: ACrzQf3jwn1gzFw06EwvCZ0GO8bzUancGyF6guB9CseXLjWobpj+hXrY
        XUVrQnlnDBHKVZ/xyEGFDwdG8ipwBue4PQ==
X-Google-Smtp-Source: AMsMyM6RGKV5dfpjB0YCgFsGbUlYVdOe/IiQeKY4pCKtnnC4CO+tk4bNBZU6mm64LQUsrqY8pLSZiQ==
X-Received: by 2002:a05:6512:281b:b0:499:f773:fecb with SMTP id cf27-20020a056512281b00b00499f773fecbmr7163323lfb.10.1664138835645;
        Sun, 25 Sep 2022 13:47:15 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id c24-20020a196558000000b0049472efaf7asm2297667lfj.244.2022.09.25.13.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 13:47:14 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] ARM: dts: qcom: pm8226: Add node for the GPIOs
Date:   Sun, 25 Sep 2022 23:44:13 +0300
Message-Id: <20220925204416.715687-2-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220925204416.715687-1-matti.lehtimaki@gmail.com>
References: <20220925204416.715687-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8226 provides 8 GPIOs. Add a node to support them.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
(no changes since v2)

Changes in v2:
  - Rename pm8226 gpio node
---
 arch/arm/boot/dts/qcom-pm8226.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
index 9b7d9d04ded6..0c10fa16a0f3 100644
--- a/arch/arm/boot/dts/qcom-pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
@@ -90,6 +90,16 @@ pm8226_mpps: mpps@a000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pm8226_gpios: gpio@c000 {
+			compatible = "qcom,pm8226-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pm8226_gpios 0 0 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 
 	pm8226_1: pm8226@1 {
-- 
2.34.1

