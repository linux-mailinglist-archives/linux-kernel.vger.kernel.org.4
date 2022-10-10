Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFA25F9DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiJJLqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbiJJLqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:46:31 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10AB58B49
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:46:27 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id x25so2835190qki.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOV1YvXUlTvYzgHn1cgThpCbIIf+By99HPhPsiBhzhQ=;
        b=qyTZ8FtGPPfGVmi4m0eLsb8rLeihrB74SvWHbfqfyU6nDam5VHpCu5kwO4j3OC+NJp
         hlg/bmcVzloQepXij6oZ/k8Sr1z8L0xCy69ledNUqJ1VDCcuEXgNw6FXwj63fc4Rg5KI
         4owQb9WOybxtX57NhvVVd5gQMcp0ZqagD6qCYkPy0enpNnn4knMouv3wlIIAWaPUYt+K
         wpkI/at//oXSGe1G+iXRw+/Fde3YHVAdGBGtGI1q0CarSLOpjoOzSb08s6Z4BejeDobj
         p7V9koRwgT4pQuJTOYHQ+IkjodcX6RxM54cMzp9yw8RlMwligA+D+sxLmXo1xdfWFtV/
         VZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOV1YvXUlTvYzgHn1cgThpCbIIf+By99HPhPsiBhzhQ=;
        b=Pg0GpA1dqkxLQw367CwxuxoRbcvm3EHN/xZCtC+pqJH72oqR19OL4o9W9yj2PS+vEE
         OxfyTNN87P6ovcQK9tri5nwUMQ8puDuYqb0nwsrDsCIydzvwcOEk6rNkpw16iULpTibR
         sVGa8Bh5iGflkTz+sxv4bQTrvLZdnOeuSUmSYtv9vpnmnI5VSnR5I3RywEj9Na0nvhBY
         ut8wBMenVpb4LEqJNWIN8XNNPNnq0t2O7H1cawrD6XQLfI10xHEI72b4tx1T14JYAcXb
         SercuyP17Swm9IaXzg8lTYhxgbKagDKII2sq5djnjlqfXeh8bj1FnEutGGwbRf4r0YJP
         +ERQ==
X-Gm-Message-State: ACrzQf1AFzGgGGC+RYsvZLmxTGU6YE1vm0z2pkHGh5qZW8xFSgl6wFsv
        iVQ8ftCD+YSpPVmkcoizNRqeOw==
X-Google-Smtp-Source: AMsMyM4t6cU8wGQHbC3r2D5yzQ1uKA2Iuo6dI3dg/HtuJYVZCh/SOOwUcna7jQf6H7hmBhQKSY2GFQ==
X-Received: by 2002:a37:9481:0:b0:6e4:e2f6:bfbe with SMTP id w123-20020a379481000000b006e4e2f6bfbemr12135789qkd.289.1665402386527;
        Mon, 10 Oct 2022 04:46:26 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id s12-20020a05622a178c00b003972790deb9sm6698707qtk.84.2022.10.10.04.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 04:46:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vinod Koul <vkoul@kernel.org>, Xilin Wu <wuxilin123@gmail.com>,
        Molly Sophia <mollysophia379@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/6] arm64: dts: qcom: sdm845-cheza: fix AP suspend pin bias
Date:   Mon, 10 Oct 2022 07:44:14 -0400
Message-Id: <20221010114417.29859-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010114417.29859-1-krzysztof.kozlowski@linaro.org>
References: <20221010114417.29859-1-krzysztof.kozlowski@linaro.org>
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

There is no "bias-no-pull" property.  Assume intentions were disabling
bias.

Fixes: 79e7739f7b87 ("arm64: dts: qcom: sdm845-cheza: add initial cheza dt")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Changes since v1:
1. Drop cc-stable.
2. Add tags.

Not tested on hardware.
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index b5eb8f7eca1d..b5f11fbcc300 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -1436,7 +1436,7 @@ ap_suspend_l_assert: ap_suspend_l_assert {
 		config {
 			pins = "gpio126";
 			function = "gpio";
-			bias-no-pull;
+			bias-disable;
 			drive-strength = <2>;
 			output-low;
 		};
@@ -1446,7 +1446,7 @@ ap_suspend_l_deassert: ap_suspend_l_deassert {
 		config {
 			pins = "gpio126";
 			function = "gpio";
-			bias-no-pull;
+			bias-disable;
 			drive-strength = <2>;
 			output-high;
 		};
-- 
2.34.1

