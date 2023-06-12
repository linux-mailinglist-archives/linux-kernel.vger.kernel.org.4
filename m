Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3A272CDF9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbjFLSZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbjFLSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:25:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098F8E69
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:25:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f63a2e1c5fso5589626e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686594308; x=1689186308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIodkBRlayT0V/9pD2j/FIbmEOwVzB4ZwEjxODurwXg=;
        b=TvL/4HpKtWb+k6gMVu3rM/mxPnEc/LH21sIRnm6hq4G1BnkASKfttpKtNiNd3icsAS
         rgCnMsA+7Ovknx8I6gjBSwMijDDVDMTtHX/uErv7FvP255E1acNRJPjP0ntoUy2fySNE
         Pj+VgHbkD155XRUUzKo9eMaXLo2InLXH52TR/CsuXxn0E25rqU9mImrojU6ie3miDwNm
         EUv/s9WjEIRxrgErEeL6tmAiZET273qvn6+zzayO+KMMrn5TKI/H3LLogobR2p9c9iUK
         zSLvHJYROp6xRG13qkVHAYh6hVbu2qQpcFovt5WcXnxP9+iWFw9TyezFU7EbUV3DlluU
         j0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594308; x=1689186308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIodkBRlayT0V/9pD2j/FIbmEOwVzB4ZwEjxODurwXg=;
        b=Yyi4aayzYuW9WbVj2qTSp2Xg6TTo8PSFcZAFbruTlh950t1zPky212ysXPq65fJqMY
         /20sbgFE1TEHHeM4quRj2ogtmH3DNXRR4d0SXvY3t9TmF0IPmfWCbPx+j7MsCWNeRuyx
         OPANvF0xP4RW3uXqf75OPXHzDoaTwWRFBEphjDq1flW0dDFYn0hH57KwHD0giLw2klhM
         vVda1mfMssqmmza7BxgLEvcA9dSttwYRohp+xEDsU34N8NHsjp9QdLefXbV/oW5dtQ3s
         pjeA2dHMzI9mf1itvx4SWM6rjEpTT9QZltI/qJbwcv6xBDTLrY4sTsfRXKiLI5i1Kofa
         KblA==
X-Gm-Message-State: AC+VfDy4fPxGHDLkySOhXmOw48LM/6syWvBMq6xgL5vewmtT3RtZtLpt
        SjSx/E5BDdF8tbvOeZ1DsTguKg==
X-Google-Smtp-Source: ACHHUZ53Pz+ObtBABrs7UPv3+u4OZ3CFekkxzEcnKSce6MNbUB7Xv24/ocTXDjWE7ItkC/fpkxAPKg==
X-Received: by 2002:a05:6512:46a:b0:4f4:cd03:cec8 with SMTP id x10-20020a056512046a00b004f4cd03cec8mr5499858lfd.51.1686594308282;
        Mon, 12 Jun 2023 11:25:08 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25938000000b004f64073a252sm1502035lfi.96.2023.06.12.11.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:25:07 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 12 Jun 2023 20:24:39 +0200
Subject: [PATCH v3 22/23] interconnect: qcom: icc-rpm: Set correct
 bandwidth through RPM bw req
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v3-22-5fb7d39b874f@linaro.org>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686594276; l=1241;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9Ldf/1D6mnr+DmG72PIWvhQfT7N7aniAjBwqWygdML0=;
 b=0neN5UyCnSYJ6t+VeLO5GgXbU3AUqIZD2454T+xAoOEeEiGAVAdpNgAN0RwtWuRNKN9szCHIX
 9lbs9imkG0tCHqVb43vFt1CdPrB8oSoriJlVZs0xB6n1AYksNjN2kjY
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
index 8e4eb0b90905..989b8a1de6d1 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -355,12 +355,12 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 
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

