Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995AE6787B3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjAWU03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjAWU0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:26:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81342367DB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:26:17 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d14so8278853wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9bJvI0er9NKNpyW36Ww5MlEqVL1HalCL3An+z6IAwBs=;
        b=kJJvK6idxMBGC+1pmy/3TT8FBROK0VCDlR89DeNLjbGvXBkArBXsbKYsVDPpF85kG3
         6Xyr/slLys+933gTy3O1JiZnHI8vZMmtaoD1h8K94krUipVEKZ7WxjKciQeP+STz1GhQ
         5KDdRd/9lX7yqw5+6esYYIEm5v8pfxk+klTfUdf77tpfTW7Qr/MKf6xXnqUY6lyFJDNj
         gjxsYOHb0V/BIy8R0oBCyncvND/ofWdx52ijlAqQ1s3yQzTGriDLNRQUuwq850FBEB3a
         2wzgpbPE3MfFBUz0fhOaLVVGNfT8MqzUeaPVrqq5FXPv7evJxnILfYTOlxzo8SXGnBNE
         cD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bJvI0er9NKNpyW36Ww5MlEqVL1HalCL3An+z6IAwBs=;
        b=Aj9rMEUtlvohrMpmkyWmjZ9a9nq/yRyg59QReZCU52HRzg++NCXQrims8RsoHEIPZx
         3/RM0oFWlZvBxXilaLOhZHlCAXjANkuMMORTE9B9y65Ycx1zCV8dlFU20ep/s+u8KKv4
         gyJoe1WSkseXdcB+mrVpQjlKRVeRQcmpcWaCY4aaZ4F/zlujz906ZPrLKcEkNvHW89x5
         8QTfmV/y7YrJQtb9AlH52FPVXJx1cnyN1951j7EnmvMYzN0nW+4Hb8LQtIscxJzCYkVH
         5IzyDbHDoGEJYQePpZsYUX6nrJOZf+1g6olZNCcHFZJScM6SCTHWODGrtlSxxs7+EwlJ
         0lHA==
X-Gm-Message-State: AO0yUKUoCSy4NfIVnkb+sQI3aWje0fI7eo63BOIs2naW6McXdk/kL6Rw
        V6Pkg+IeOHzba1tzlPSsA1rrRw==
X-Google-Smtp-Source: AK7set8G62ZPGE3yj/GxRFf06B6qne0PaY4rDmY0nPTNs/5+g71n4+vH1n+t5qHnjsp9Y9c1WKdnCQ==
X-Received: by 2002:a05:6000:5:b0:2bf:ae2f:c6ff with SMTP id h5-20020a056000000500b002bfae2fc6ffmr372304wrx.31.1674505576089;
        Mon, 23 Jan 2023 12:26:16 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y15-20020adfdf0f000000b00236883f2f5csm220301wrl.94.2023.01.23.12.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 12:26:15 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] soc: qcom: restrict L2 accessors to ARM64 build tests
Date:   Mon, 23 Jan 2023 21:26:01 +0100
Message-Id: <20230123202601.1296983-1-krzysztof.kozlowski@linaro.org>
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

The QCOM_KRYO_L2_ACCESSORS can be compile tested only on ARM64 because
it references asm/sysreg.h present only on ARM64.  Mark the dependency
correct, even though as a non-selectable option it does not have real
effect.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 21c4ce2315ba..96b5d0a4ed48 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -80,7 +80,7 @@ config QCOM_DCC
 
 config QCOM_KRYO_L2_ACCESSORS
 	bool
-	depends on ARCH_QCOM && ARM64 || COMPILE_TEST
+	depends on (ARCH_QCOM || COMPILE_TEST) && ARM64
 
 config QCOM_MDT_LOADER
 	tristate
-- 
2.34.1

