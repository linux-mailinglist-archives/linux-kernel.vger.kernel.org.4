Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC8B62BA8C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiKPLAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiKPK7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:59:20 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2453A42996
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:47:49 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j15so29265703wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1Tc2RVUxyY/wPgm/kZo/scwJJwqK1LQAAoSgxEFsQQ=;
        b=TugSr+/lSFhtvLU4DEgeUvhD9VO/pYDpQ9Ln9qc09Uq5x7F6tjqQyujNhxnOUG0pr1
         QyoUXtRe46H2Lfg9KoX1UvW3wv3aMkZHaCBUgICdDECMNpmJbWZ6b3gjFNOrvN1tQKYE
         s6Vppsl9tga0X2ULd9h7SHVGFRRTRAJtDXelQVc3TuXqhQHt499HMV/KyVf16RHw2mzr
         vbdBMIC1Msb6e6EPVeeW6uq7KHJVkdze0J4CTndUWTr4UAgztPA2ciCBV6iNJRrK31qk
         7jVS6wHOMekMCbUir4Qk+exCpzLD22oGAdAaIRvUlHUr6Agw5x0VS5efIQnQHvJcjov4
         gZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1Tc2RVUxyY/wPgm/kZo/scwJJwqK1LQAAoSgxEFsQQ=;
        b=RTxj692Z/vg3LmyLQhJgmq1Jm3ldz8NrNvE13hJ3sC7rH3/rQKlRQQrZ6WGFjOs1Zs
         MXMUHoqqNCDRSXxxa6EuudRcwIxoVJR3Kjv9zgf1e/aHGMKSvUOwCAjQZ47WdbeDZcSV
         RgG4BAXpedVz3EKWnE5K/hAtP0Wek1jXmPQ4zhskFOvTcOYc0X44dfdcQqTPYk8G8fI6
         H3Oldn7ZFQoTRj1CbEVG1uakvLyDE6MD5mfb8GvKtPRxcpD+OA2lEGyfEARwtLom4mci
         gZvwtL4qNBeGYqCMEUDl/Nu59V+H3QnsExQA2juI0JHOEpZJNnQDVFxuMN2mIAm92smM
         65gA==
X-Gm-Message-State: ANoB5pmcwolvnqF4FgXGlkPgBttD1KYdoYFG+1DPscs86NOcxqLGQGLl
        pux17U/BQXXDOpo7EZCqml3Wdw==
X-Google-Smtp-Source: AA0mqf4FoEk+dNIahXYw8o4NPh8WPEnrSdSxaX8yD9XOLE1b0DUkQD+a8Uf72Rhpwec1HuThqd2RjQ==
X-Received: by 2002:a5d:6e55:0:b0:23a:239b:7e73 with SMTP id j21-20020a5d6e55000000b0023a239b7e73mr13326846wrz.233.1668595667673;
        Wed, 16 Nov 2022 02:47:47 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id b3-20020adff903000000b002366fb99cdasm14674206wrr.50.2022.11.16.02.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:47:47 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 6/9] dt-bindings: clock: qcom,rpmh: Add CXO PAD clock IDs
Date:   Wed, 16 Nov 2022 12:47:13 +0200
Message-Id: <20221116104716.2583320-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116104716.2583320-1-abel.vesa@linaro.org>
References: <20221116104716.2583320-1-abel.vesa@linaro.org>
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

The SM8550 has a new fixed divider as child clock of CXO
called CXO_PAD, so add IDs for it.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 include/dt-bindings/clock/qcom,rpmh.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,rpmh.h b/include/dt-bindings/clock/qcom,rpmh.h
index 0a7d1be0d124..f3e0288420ce 100644
--- a/include/dt-bindings/clock/qcom,rpmh.h
+++ b/include/dt-bindings/clock/qcom,rpmh.h
@@ -33,5 +33,7 @@
 #define RPMH_HWKM_CLK				24
 #define RPMH_QLINK_CLK				25
 #define RPMH_QLINK_CLK_A			26
+#define RPMH_CXO_PAD_CLK			27
+#define RPMH_CXO_PAD_CLK_A			28
 
 #endif
-- 
2.34.1

