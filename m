Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5C05EEAD1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiI2BQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiI2BQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:16:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086631138E0;
        Wed, 28 Sep 2022 18:16:04 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b23so91917pfp.9;
        Wed, 28 Sep 2022 18:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F1+FkqfkwmhLCAn3NJHPER+7hJ8fiY2kv2ckZW4kL50=;
        b=nPFXGWzu0dPPBXFHQLhus1nG59TKq06lJtiE/k+1gx0JnzAwLbA5ZyrUNqZIRtut1O
         BQRHZ/v6M48oWSs5zoV43CwygfbdG3SaWP58dOlOTaNgGzU4gKQVld3GWu5RU5PMenry
         X7GOPLcCxUzwkY2jRHgSjZZsCAuK3sCUsffbXir+us8+HsAF40yqqKCF9qMKOjXOWGdm
         WtYC6da+eAo46nbc5WwQUBrj5IF3Qe8YF7ig3gR7sYYsR6viZ8rg79bxo08G5uQsW/QQ
         bB0Uby4mOlI11XzSUNyV247k9QFo/PdGWu9nCwKOmQ+BERvmuWdt6a/MLpgiN43ziOys
         qvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F1+FkqfkwmhLCAn3NJHPER+7hJ8fiY2kv2ckZW4kL50=;
        b=56HadpCyMGF+qniwK8xZ8mi9aH4e6xcn2CgA2SJ49R0XqJnoOr+48gjv/vpyu/EbkP
         GQtCPk9wLOGvemcUMaT8oGzwtZ8CdaPzTjUgcKZCaTtp3rA9Q/9aBqKY3nZI5WDNuYeR
         06jPfr20LA+PW+w7Rlvei4iPKjzR2wYISNSIBqw/oVhenH5C9I+wa5r4BoLkCCMI/ZVc
         NPJnqOYRhgkLJRzn8vRre6IVWE2nNH+vb2raDih8EAMibQVCIgJOl+52bU0jiF8ataxk
         noScbY+3bQPTfzH7yictv45+PSN2X5Fg65GQuBNiEoDHLmPfPfHGcYcTmYw+rgCQA/t2
         EX/g==
X-Gm-Message-State: ACrzQf24cLRSLxFpoEGlIZa3Pucq1cc9GTPZoYwzxEmqLIEYiYjkQ3az
        I9WQ++6hZw0aKKS/hsDnvy4=
X-Google-Smtp-Source: AMsMyM5JPA+5q3wy9oMlFnpsgGaUSHQrsazaUXbFoWfvqOvAQv+3m85/9snz/Wp5nsecy3cR9zM3ag==
X-Received: by 2002:a05:6a02:318:b0:43c:e24a:961c with SMTP id bn24-20020a056a02031800b0043ce24a961cmr559038pgb.589.1664414163405;
        Wed, 28 Sep 2022 18:16:03 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:637c:7f23:f348:a9e6])
        by smtp.gmail.com with ESMTPSA id y16-20020aa78f30000000b00540a3252191sm4737655pfr.28.2022.09.28.18.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 18:16:02 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Krzysztof Opasiak <k.opasiak@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: msm8916-samsung-a2015: fix polarity of "enable" line of NFC chip
Date:   Wed, 28 Sep 2022 18:15:56 -0700
Message-Id: <20220929011557.4165216-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220929011557.4165216-1-dmitry.torokhov@gmail.com>
References: <20220929011557.4165216-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
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

According to s3fwrn5 driver code the "enable" GPIO line is driven "high"
when chip is not in use (mode is S3FWRN5_MODE_COLD), and is driven "low"
when chip is in use.

s3fwrn5_phy_power_ctrl():

	...
	gpio_set_value(phy->gpio_en, 1);
	...
	if (mode != S3FWRN5_MODE_COLD) {
		msleep(S3FWRN5_EN_WAIT_TIME);
		gpio_set_value(phy->gpio_en, 0);
		msleep(S3FWRN5_EN_WAIT_TIME);
	}

Therefore the line described by "en-gpios" property should be annotated
as "active low".

The wakeup gpio appears to have correct polarity (active high).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 3255bd3fcb55..5f7cec347a4f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -144,7 +144,7 @@ nfc@27 {
 			interrupt-parent = <&msmgpio>;
 			interrupts = <21 IRQ_TYPE_EDGE_RISING>;
 
-			en-gpios = <&msmgpio 20 GPIO_ACTIVE_HIGH>;
+			en-gpios = <&msmgpio 20 GPIO_ACTIVE_LOW>;
 			wake-gpios = <&msmgpio 49 GPIO_ACTIVE_HIGH>;
 
 			clocks = <&rpmcc RPM_SMD_BB_CLK2_PIN>;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

