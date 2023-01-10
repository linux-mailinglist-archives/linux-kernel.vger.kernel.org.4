Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8639866419D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjAJNXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbjAJNWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:22:34 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B332718E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:22:26 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bp15so18357330lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCaSD33g+a3bin8joEEWKLvk9yQ9RU+f7chaK9VTAPI=;
        b=RIY4n+ANhRf2uGDnIHSWQB7bCTaDUpIaH5ggYbAwSZ+jJT8AvbiGGYUxdBMtPBQBVj
         ePYr1qadtHQ4zUmcxdnnaEGcaocSqKNLKSaPupuK2giRctafAdazNh2SCynELLNPcqvr
         C7jQs2D8l3+HwVINoMbigltgHotdtmDj4/5fv9d/bTxbfcH3rX6EXHMQmC9zC4letM5v
         Hg+34z9YKK1u6zU0DY28ubW9YjfVIFE0pjLiUWRBX7W3PV7Jah0lUn3uHLH658FP+SEf
         qSfeDz1W0sk0QiXlKG7qH2jTEjUjA+vCeywMqD5+TCmTE5ZL+mofJDUAhDHdjqKAO3Fg
         8jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCaSD33g+a3bin8joEEWKLvk9yQ9RU+f7chaK9VTAPI=;
        b=yfOlf+YYhS9ZwwH1N2jXhbdpcK3LPtrgqXatMfFBtAIquN9gw/tHUl4vBjP1W9uVVG
         Dv9OYzoWPcKcZYkCl/4IgZZc8q4iqPrTJOlr6LMN2pAWYRRb1qY30g/4dK3LjSQr9epU
         Bod52OwGxzCTFRyKvPeIfr6iNCaR8mQhDtR37qqyfxCJzxJG/kGmU1O+Sl+P1+OzDOU4
         2JbSjz8n4BAwW5zO0j1mJRR0HQGwCXwGBKRlMvjUbS/CjVZ9aJqE7+LDZjOB2pH+X0+h
         icb/8CYlm1NqF6QBH/VtH0wsl5kZDwkHbHw1Kv8FUn2uMUDnuCC0osOQBJMGbK3aKq+J
         jq0Q==
X-Gm-Message-State: AFqh2kpnk5LJp7HWxeLjyjDjcgUesDQ68+dM/Nkq8DdmNVA7HvuXfMpL
        bovZwORj3JxycuWZUKEz007lqg==
X-Google-Smtp-Source: AMrXdXsI+wTZ+Y884JwfHmMfUGVOnRGkt36fRMetj8KZMjS5xls4XmSvdmG80yY1+uICmaiF/wRkGQ==
X-Received: by 2002:a05:6512:3f9c:b0:4a4:68b8:9c1b with SMTP id x28-20020a0565123f9c00b004a468b89c1bmr22811410lfa.3.1673356945321;
        Tue, 10 Jan 2023 05:22:25 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id w4-20020a19c504000000b004b5812207dbsm2183000lfe.201.2023.01.10.05.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:22:24 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] interconnect: qcom: rpm: Don't use clk_get_optional for bus clocks anymore
Date:   Tue, 10 Jan 2023 14:22:02 +0100
Message-Id: <20230110132202.956619-11-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110132202.956619-1-konrad.dybcio@linaro.org>
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
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

Commit dd42ec8ea5b9 ("interconnect: qcom: rpm: Use _optional func for provider clocks")
relaxed the requirements around probing bus clocks. This was a decent
solution for making sure MSM8996 would still boot with old DTs, but
now that there's a proper fix in place that both old and new DTs
will be happy about, revert back to the safer variant of the
function.

Fixes: dd42ec8ea5b9 ("interconnect: qcom: rpm: Use _optional func for provider clocks")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 804ba75bcd79..f6cb330ab0f9 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -529,7 +529,7 @@ int qnoc_probe(struct platform_device *pdev)
 	}
 
 regmap_done:
-	ret = devm_clk_bulk_get_optional(dev, qp->num_bus_clks, qp->bus_clks);
+	ret = devm_clk_bulk_get(dev, qp->num_bus_clks, qp->bus_clks);
 	if (ret)
 		return ret;
 
-- 
2.39.0

