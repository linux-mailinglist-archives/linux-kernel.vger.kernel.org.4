Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A17D6F3054
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 12:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjEAK66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjEAK6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 06:58:53 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286C7E69
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 03:58:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ab032d9266so1163845ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 03:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682938728; x=1685530728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pXnRK2b3RixHzpaps5p4VYQKZZN8MYbqwqZth/e4To=;
        b=hlznR5LySl+UK2ZLlJct3GOXpPUghZFAT5FJ6Tbok0XhGHi5JbMr0jt3firDYM753r
         D0SVsdL6FPZQdukNYjo2zpJvaOjx73opafsEDTf71X+0+ruBIEXNsIFQi4u7iobKHlHk
         kgMPN+iR4a5yWG4Fq3Mrkbyjr84u7SYPJeb3fyGjaeHPla0v4GT/oxRzpx0683EwA8qo
         oe4tuPuuZeE86e45VdTRn7q6KuhOs1KrrAU0c/f3Q0XU3SjqoQQY/+3wBYJKJt3LR7hj
         RAMGbjfqTwXPQ5rpOopSC5eRlopJgs2Q78RDUYsM7dUdr9neDEjcbxm2yebw596gli3y
         srGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682938728; x=1685530728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pXnRK2b3RixHzpaps5p4VYQKZZN8MYbqwqZth/e4To=;
        b=gOWK7cQG7pN7zlKC7WClCkro9GNuPqyvsLlSAW/QHvkJbmwtfBjlvb1g7BCw4+LGNL
         s2AU2u4Nb4xhE4OE1QL7/Iw9BCKaLmeTackM5/lZ6jTLTmjhAtwxiKf3Mp1uBqUtT7WI
         RTZevCeWRAtF0pxYdUbXEUzs+RBXs9nzZGL0OyNBeNYSBWgw1a9EtvLf9dC/7VtuII7T
         ydc+vJLA2KkGU/aEgMwJ0lm0XxEQ9qKyr2m7upHKVdPiNQVepYQOtLnVaY2Z6YkqBMJn
         2izlkKxSceHAWuUOa5cygZ2ODb15SZL/fb72gQrABrbLQ2S/dJzjdts9usdtbBW3YT0X
         mF7g==
X-Gm-Message-State: AC+VfDxRV32QsJTJAkbJWvhVQaXt9jp9viW9VMGZammvN6sRp87YE/In
        ZeIzSlD3NCnmfY+naz0NPRNc6jov6kNzNhByaqo=
X-Google-Smtp-Source: ACHHUZ6OXsWA6+RtZrgvZBclz8f2I3x5h1gpBhK0DFTK8p7UXR1PlKsBxsVW6+ym1p4obsHM0XM/nA==
X-Received: by 2002:a17:902:7790:b0:19c:dbce:dce8 with SMTP id o16-20020a170902779000b0019cdbcedce8mr13652032pll.15.1682938728576;
        Mon, 01 May 2023 03:58:48 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3b:58fa:39f6:37e1:bb9a:a094])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902849800b001a50ae08284sm17569516plo.301.2023.05.01.03.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 03:58:48 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: qcom: qrb4210-rb2: Fix CD gpio for SDHC2
Date:   Mon,  1 May 2023 16:28:31 +0530
Message-Id: <20230501105832.1185477-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230501105832.1185477-1-bhupesh.sharma@linaro.org>
References: <20230501105832.1185477-1-bhupesh.sharma@linaro.org>
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

Card-Detect (CD) gpio for SDHC2 is an active GPIO line. Fix the same.
This allows the uSD card to be properly detected on the board.

Fixes: 8d58a8c0d930 ("arm64: dts: qcom: Add base qrb4210-rb2 board dts")
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 5a5294cc6e45..bff6ba1d689f 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -203,7 +203,7 @@ &sdhc_1 {
 };
 
 &sdhc_2 {
-	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>; /* card detect gpio */
+	cd-gpios = <&tlmm 88 GPIO_ACTIVE_LOW>; /* card detect gpio */
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc2_state_on &sdc2_card_det_n>;
 	pinctrl-1 = <&sdc2_state_off &sdc2_card_det_n>;
-- 
2.38.1

