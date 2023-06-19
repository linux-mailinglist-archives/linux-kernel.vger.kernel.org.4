Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A70B7357FF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjFSNGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjFSNFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:05:46 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A371991
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:05:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f86e6e4038so1373485e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179904; x=1689771904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jK7Krh6d5glAjoREUgnuuxQiDYi3CDuObLr2ly9o6k=;
        b=JdJnXG1esjRebvsgTz220wWxnPolIN5YMw7qghlcrpz84CYCjhgsPO7c18Y5KGNcjn
         4COHZyZCLyU3ellKlg1ai9oEO0WNC74139M9ip7ApZwy8Rbxf2AO6MmH+ct5iuNc8HQp
         KnRu0BSdCSqE+Ii3spxmA/1k7Jr6re6qjdBt/y8nbS6UBcekAr1eq6/M7HJWmvl92pNa
         mwiY2/fMQZvVUWR6E7yCTNHk8salzcOgNeRtE0j5vL0iR3EKrJDte8HU58AQyTxuXntW
         bwTYaxg2Y4mV3TEFCnyQaCMzIty0FHtGpKV4Hu0C+Smt0YEWjLmU1tB6UKhXxruky1oo
         PSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179904; x=1689771904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jK7Krh6d5glAjoREUgnuuxQiDYi3CDuObLr2ly9o6k=;
        b=jmTclWSMETJDtxOzwZkk3PQOsP8mlHH5N2P3k62XoMYyt7DQP903aEdqd3vPWSkcQc
         wWaSjD46irsddiTL/LsRoO6S8jVUOtOLgOQ6OY208+N/zk8NsrGXNtrEJwR2QVvgzZfR
         ktVvKn4FKmTEDwJvvs8uiMeyGzB2Xh/I12Me6TqJIgksgTo+G1vm1ek4eDy82ZDgyS6k
         WtR3JMf4ilte8r5MX31rAzzIlvidjQy9sRXybSuayip9tO+9+YtRjAED6Lmgr+V1Zvi0
         LxiQtl0jpQAWOfC+GegoQDRw9lPYYn4DA3LwiZ/R+ehetWUwOuL4JBS0eqqMM0HbNXk+
         DVgw==
X-Gm-Message-State: AC+VfDzZIigcE/oMDa0bYwwDjRimDu3JAcXjIq6Df5WVHeOPJfgvnqMF
        8yjpK0n908wYDXH8c0w8QiOs2w==
X-Google-Smtp-Source: ACHHUZ7vYdFROpmKy5fPOADNwOLbbQ09AffVbttkUkhRvYPebRd8YLf73QTKvogFq4d6ZsWky1PYOA==
X-Received: by 2002:ac2:5b1d:0:b0:4f8:6ff9:ec55 with SMTP id v29-20020ac25b1d000000b004f86ff9ec55mr1079820lfn.20.1687179904715;
        Mon, 19 Jun 2023 06:05:04 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:05:04 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 15:04:46 +0200
Subject: [PATCH v7 21/22] interconnect: qcom: icc-rpm: Set correct
 bandwidth through RPM bw req
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v7-21-09c78c175546@linaro.org>
References: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=1241;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kbfzjw5doxXBVvXaQEAjOvlD1+VtGE/glxgCqrLn1Ec=;
 b=X1DxbOAE/DOu0jwuCcpkabpqHd9nbZU+7dNvEN3Gz9wKsC6VEH67jTdSyCIZVZFZCWj4aKavV
 o2mAsVcFvb8BkBozfie7QO/3XDmzbTABz+Fm11Vym3vXHBMGECPlzm4
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we're setting the aggregated-on-provider bandwidth on each
node, individually. That is of course incorrect and results in far too
high votes. Use the correct values to ensure we're not wasting power.

Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
Reported-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 928dc27c1d93..5733261d9407 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -354,12 +354,12 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 
 	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
 
-	ret = qcom_icc_rpm_set(src_qn, agg_avg);
+	ret = qcom_icc_rpm_set(src_qn, src_qn->sum_avg);
 	if (ret)
 		return ret;
 
 	if (dst_qn) {
-		ret = qcom_icc_rpm_set(dst_qn, agg_avg);
+		ret = qcom_icc_rpm_set(dst_qn, dst_qn->sum_avg);
 		if (ret)
 			return ret;
 	}

-- 
2.41.0

