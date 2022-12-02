Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D08A6409A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiLBP5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiLBP5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:57:45 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B798BF598
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:57:43 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id d6so8002707lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 07:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v7Do1zGZeJXfk/btC7g+b550Atcgh8+jKqzDtcXOK/E=;
        b=I2uoBpetXygYV2BOAzzNs3znsM9iyVjecCI7TMryTjj9yycblQftOFDQEw5+15+t0Y
         hlexP1IG49F3V/T0PXewL4KQ2DpUFmtw8AXrfuSEpv/K98fcjb2pye6tpdaD/3jE7/3+
         qHspF8CAdMvreGlEnMalhG9EzyV5/pgQyVgZbxLTm4L/Giql0JwlXKzT0LTh11DnL+Ii
         q2Su1htcs8ox4I3f2nuG7/Hy5W7tyzaGqmVuOAk6LM5Bn38zqgQ+QEfQ/mvDkVuWj/v4
         YFgolMAlZOHH00dQ+RJZyU198tpPXcBUG8KKxFtyHXILs2PY5CRYWD8IdydNYUSOPGmI
         C5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7Do1zGZeJXfk/btC7g+b550Atcgh8+jKqzDtcXOK/E=;
        b=dbZsBsWg8N/nVuzug/9cD9UBAu3YzFNKXkapwaXao27/OvJ+dO1LDj/khwFlYENojK
         QI4fv6PuSvyMRPWLSqdSbnHMkdMxtyRP8Kg55VZnKnN++yHBF+f7P9BvP6voMn27ijWU
         YKfRUaXhnXi1H9JTeEQolIg0h1/OwEWbQx/aP/KHWTb3BDuXcnBzWDrBL7WJXfc9KhWk
         N6MXOXG7rY5k6Yz242OQkL734XOKWqZZD5UnrNmj3AU/SeU4ycLNteJoVNsFdHLbP7fM
         S87Ag+1ZcqmFb4mWNgmQUTTyirZt36WobnHI1OwrBUwxGZNjVYFoeoPWa8hMv+iDlWJm
         kOqA==
X-Gm-Message-State: ANoB5pkh4450i6ozjjQJUY+o8dmJTbUkB8aD5LSjiQ+28HaLwlIasYT5
        6f11+2lWfaohXaK1eny8pCtX0ygdiZk1dzHmKu4=
X-Google-Smtp-Source: AA0mqf6bzFc67lteDluoeYPumSDHPT1u2Ff3NsMyEbeCNcymqTNokJU6p8C0hYnJ9JwNnxbcipD5AA==
X-Received: by 2002:ac2:5195:0:b0:4b5:362d:b6ae with SMTP id u21-20020ac25195000000b004b5362db6aemr4000777lfi.528.1669996662112;
        Fri, 02 Dec 2022 07:57:42 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b25-20020ac25e99000000b004b4e6dab30esm1049133lfq.222.2022.12.02.07.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 07:57:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v3 1/3] arm64: dts: qcom: sdm845-db845c: fix audio codec interrupt pin name
Date:   Fri,  2 Dec 2022 16:57:36 +0100
Message-Id: <20221202155738.383301-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pin config entry should have a string, not number, for the GPIO used
as WCD9340 audio codec interrupt.

Reported-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Doug Anderson <dianders@chromium.org>

Changes since v2:
1. New patch.
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 3e7ceb0861eb..f324c0af665b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -979,7 +979,7 @@ sdc2_card_det_n: sd-card-det-n {
 	};
 
 	wcd_intr_default: wcd_intr_default {
-		pins = <54>;
+		pins = "gpio54";
 		function = "gpio";
 
 		input-enable;
-- 
2.34.1

