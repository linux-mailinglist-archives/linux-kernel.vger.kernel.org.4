Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B53269694F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjBNQXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjBNQXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:23:44 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1E12914E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:23:31 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qw12so41482398ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWIjHrmZ+GcxrVYKcQs3CE7ngJu8LR3XWPQYlEPfpOQ=;
        b=bI4hWJG3Q+VuAjT1QxZUerpnbyaPU/zn8vRg/T9FYK0gZGBlA7kNfvu6erBnZwZmNc
         l2tmENYV0Wo0X9Lyd236dUIpAKhwaOSvfeN1Rldc1nR0v42Yx9Cs9WQ36j6/zPTkrQx7
         HgYtLK75EOxP7w0VszpRZ1rda7RFJHQzDW+inoN2JIIOA+Ex9eco8hLcywhdxlhUA+WD
         ZLXkIRTo3R2nXFvI6rqfkA395lKDCjkd5DKM/ALKUJQP/qs6lAcr+doM537dAv8SSm1D
         G+vP6c1wL3D8+WCKjxSOK1f+KjWU3BUH1+6GeJlDzUcqwIdOBFEjXelwKKI67H1zE2c9
         e9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWIjHrmZ+GcxrVYKcQs3CE7ngJu8LR3XWPQYlEPfpOQ=;
        b=MiO3L8f/jhZxMsW6wxmurcO6eVc6vd8wJxFLs/hu0HS3kEkVq9ellAcKko21b0Ua+r
         /kC6api+8xP+uRUr7glyyLMbUM+CYNanUPMxzB1T1guS6MbS8w8B51EYc8VcV1QhrvlR
         5B5dOik1oybt9UmFLXgyjflrHCBJ8NQUPf6R4by5mQmkTpx6idOzXIzZsmF5UTWOr4uL
         oxu3gX6PUip6xZTrB8Amm5GfZayyDymufYY2yvFPxO1yjKKpj343+i3LHABy5HamWACx
         +ZahXAK2gF2gA2P3kxs+DDfb+2tH0ikwcHTHH39fdYkVSi1TV6SD9h832zYnne34D2ne
         nkzA==
X-Gm-Message-State: AO0yUKV796e83LN5N9myBzYpAwTqLs8CECASOQl1nON2pVw/TZDHm667
        z/oVP6hIWo0Oj9omi/IMqY+EVA==
X-Google-Smtp-Source: AK7set9BtFcqAcq5ajOac4T/k51Q+E/d85kqF0LHSGKpmkt8/CMhQvDMeTOHsdPywwvmB2dNiQrI9Q==
X-Received: by 2002:a17:906:abc6:b0:87b:da74:d272 with SMTP id kq6-20020a170906abc600b0087bda74d272mr3252617ejb.45.1676391810354;
        Tue, 14 Feb 2023 08:23:30 -0800 (PST)
Received: from fedora.. (cpezg-94-253-130-165-cbl.xnet.hr. [94.253.130.165])
        by smtp.googlemail.com with ESMTPSA id bp8-20020a170907918800b008806a3c22c5sm1318027ejb.25.2023.02.14.08.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:23:29 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 3/7] ARM: dts: qcom: ipq4019: pass XO and sleep clocks to GCC
Date:   Tue, 14 Feb 2023 17:23:21 +0100
Message-Id: <20230214162325.312057-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214162325.312057-1-robert.marko@sartura.hr>
References: <20230214162325.312057-1-robert.marko@sartura.hr>
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

Directly pass XO and sleep clocks to GCC via phandles.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index a7a43f7bc2b2a..7d3a812e2b13a 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -191,6 +191,8 @@ gcc: clock-controller@1800000 {
 			#power-domain-cells = <1>;
 			#reset-cells = <1>;
 			reg = <0x1800000 0x60000>;
+			clocks = <&xo>, <&sleep_clk>;
+			clock-names = "xo", "sleep_clk";
 		};
 
 		prng: rng@22000 {
-- 
2.39.1

