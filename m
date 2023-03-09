Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DF46B2926
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjCIPuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjCIPuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:50:06 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0CCF28BB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:50:04 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x3so8748218edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 07:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678377003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgRFCt619WmiOOy/KiaJocmKNsNdPTYaRqkITCznBlQ=;
        b=VclA2Usv5TOQL2tjYEaywOVcbjTRbt5QTlUyua2Pq3vHwT0lIaQM/mNyIOV0TOQI52
         IYZaDZIyxI6bfTtSPdkATbzV/vwSKO9WATOYBvvvdfBxINsdOu+9jhVMxgvRVNPKD0DU
         pBh7wCzQvILtnKTs0D5k9mFn19e2w1H/RLRe+LCuwUq6sN2BP3U82PEETdzvkuDRBatn
         VC+R8O5s2DjeFay6ztM3X3xLToPRkxTWqQ0+XJHTbOR7nzGi/HLb4CO5t5PSCVMdBptW
         FJkBfzgxbwDDqL9/oGrik3qqY2WROaHcBKDMY35wBfluGRt2mtPv+Dsin4sC8lt2iHvQ
         NOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678377003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgRFCt619WmiOOy/KiaJocmKNsNdPTYaRqkITCznBlQ=;
        b=YpJLNevHmOOO0wH5HCORRwBmYYqLK5I6xVcFnxkoigsA1qXjw9b1YP3XB1PTstEGy7
         4LbxqSuPc4PZT2v6ZZtCMMciszyh2pScBKvlRPx/ng0ZAZ2pA2o8lsFuR4gkE1wXv0X2
         CtgcGS1zUI8aK3OqFe6KDlRzEBS8kBQ5WgfiMGV0p1Xh1TEWttBiWmgB4poTv/voKHws
         890/iiwLEkMUdqDR57p9SjdKISEy0TZQIu5HhBGAWG387UJ/ExkfVvu28E26c7l8UbNg
         8Cy7X7umwVQDeNOHCCwhZDi+bHVOM0IwNBBCBk7nuCis/hMkjHQKQh9MfQSPQGm01lpo
         wTrg==
X-Gm-Message-State: AO0yUKUMRxD7TK98wCWf0sSTiHn3nWkM595eF5lyB4Yp0YLsa561OFpr
        UWJd7QtF4s9vwml9mDYBfOB4sA==
X-Google-Smtp-Source: AK7set9OUMyp7/zfcn1xB/Hxk4VIhd+uwK0b4bIxnhLcxo97/DDeed+1+0rKVoHM3A7Jm4MeebJXTg==
X-Received: by 2002:a17:906:d28c:b0:8e5:88ca:ebac with SMTP id ay12-20020a170906d28c00b008e588caebacmr22319782ejb.40.1678377003285;
        Thu, 09 Mar 2023 07:50:03 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id h17-20020a17090634d100b008ee5356801dsm8981683ejb.187.2023.03.09.07.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 07:50:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] pinctrl: qcom: sm8550-lpass-lpi: allow GPIO function
Date:   Thu,  9 Mar 2023 16:49:49 +0100
Message-Id: <20230309154949.658380-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309154949.658380-1-krzysztof.kozlowski@linaro.org>
References: <20230309154949.658380-1-krzysztof.kozlowski@linaro.org>
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

All LPASS pins have basic GPIO function and most of the code is ready
for that.  Add missing glue pieces to allow LPASS pins to work as GPIO,
which is going to be used on MTP8550 and QRD8550 boards.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c
index c2bdd936d27f..db1a46fee9c6 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c
@@ -102,6 +102,13 @@ static const struct pinctrl_pin_desc sm8550_lpi_pins[] = {
 	PINCTRL_PIN(22, "gpio22"),
 };
 
+static const char * const gpio_groups[] = {
+	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7",
+	"gpio8", "gpio9", "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
+	"gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21",
+	"gpio22",
+};
+
 static const char * const dmic1_clk_groups[] = { "gpio6" };
 static const char * const dmic1_data_groups[] = { "gpio7" };
 static const char * const dmic2_clk_groups[] = { "gpio8" };
@@ -168,6 +175,7 @@ static const struct lpi_pingroup sm8550_groups[] = {
 };
 
 static const struct lpi_function sm8550_functions[] = {
+	LPI_FUNCTION(gpio),
 	LPI_FUNCTION(dmic1_clk),
 	LPI_FUNCTION(dmic1_data),
 	LPI_FUNCTION(dmic2_clk),
-- 
2.34.1

