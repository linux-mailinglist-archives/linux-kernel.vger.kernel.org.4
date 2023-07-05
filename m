Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80E9748723
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjGEPAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjGEPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:00:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C099619B3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:59:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98934f000a5so790022366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569186; x=1691161186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHXjpogIHzpcwoVSrVrgGvL8fGQQLUb9SkktXSFG/ek=;
        b=M/KR4eK+B++BFOo+bylXOH+HPcZjilmonE9ssLyC7XVDDf24x6f5RtobAs22GELi29
         XrPQMkIj22MLr6ni4zJduzDAdIwA205RM/OPsgwB0VrdpU6YYtUMXvNIikT0QpmKXPnf
         wIXj12NMLQLkKapiJWvH6giy5hYJblOJQMaCNUgkBkcc6jehid0wlibG7RG75dHJOecC
         bNvOtXi+eQbgzc126gH+z6Gmtf0vmCBrpmOOORfObDOUixdIlVmnPA1rqCsqklkA8UYW
         2EleFWNQAatlUHlSQNZHHqg3CVkr2nM+ICjvIb0u5Yx1koMnQkn7RE+502eLe9ANpEfs
         sMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569186; x=1691161186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHXjpogIHzpcwoVSrVrgGvL8fGQQLUb9SkktXSFG/ek=;
        b=CdpsgVUCe6spUN2MmITh5A/JmXpLJcAlqcKYZll95hah0GFqu7uYCzTbDNA+ZSgyRn
         pFm0Q2o+TcbEvI9Og8Y6fY+Fv6Jxl7dvQg7+EXwFNRsFhC7gMNeN079qBVEe1TK2qyYF
         2oa3T7YiVmmhRFXJtoms2/pxAsOyn3JSopKeBrRt8+rsEgtNBRUygY5pA4nj1kjMmA1p
         kgxDLdZfDsDOvBHc/MEor7EMS76Ev5isqFNgH26y0OY4awwXhqZLKap1yJdkanKITM2S
         sVWAZmuZsi6CrfPijzcEEUFC9slj1KpxIuKSf/E9XluwA8nPgGzMYaLqBtL3oXbxTwwh
         vz4A==
X-Gm-Message-State: ABy/qLZmA0Kgw4elxIaFiicqf7iGFzhj177upSQiwECj0U+jFa9aHf9w
        8T8wjI+JtP7ORgkfQbaQvzEZ2g==
X-Google-Smtp-Source: APBJJlF3sByEtXi4pOjthmEOeN2Qp8nr/Grc3C8LVVeWAIqanI/eg/nwt8pbwL9LC0On+yPn8LLonQ==
X-Received: by 2002:a17:906:4a54:b0:992:6e93:ce38 with SMTP id a20-20020a1709064a5400b009926e93ce38mr11404492ejv.41.1688569185742;
        Wed, 05 Jul 2023 07:59:45 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id rn20-20020a170906d93400b00993004239a4sm6775263ejb.215.2023.07.05.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:59:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: exynos: add missing space before {
Date:   Wed,  5 Jul 2023 16:59:42 +0200
Message-Id: <20230705145942.293527-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
index d3c5cdeff47f..a986749dd49f 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
@@ -313,7 +313,7 @@ wakeup-interrupt-controller {
 			};
 		};
 
-		pinctrl_aud: pinctrl@19c60000{
+		pinctrl_aud: pinctrl@19c60000 {
 			compatible = "samsung,exynosautov9-pinctrl";
 			reg = <0x19c60000 0x1000>;
 		};
-- 
2.34.1

