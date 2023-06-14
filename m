Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C911D730714
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbjFNSHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241688AbjFNSFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:05:15 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ADA2683
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:05:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f649db9b25so9040907e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686765905; x=1689357905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jK7Krh6d5glAjoREUgnuuxQiDYi3CDuObLr2ly9o6k=;
        b=OwIo8UKwEUo7vVB7txLULtay3a4jAcrT3MWK1c0iP3ThbEN+IkQFegbRMvtdp2SGuX
         AKlDiOz+EpNzqor1YyEoSPmAuj1xCvgS8VRe1U6SF+YO8yVfiqYBTH1LcnUkuYg6j3aT
         QU4Tqk+2qXErCsH8Ofbm817Sze7cbMGQsBqhlYFHUuWUif/AS3/zoQBHjlJpicHhrh1t
         CuazJ3hxtfkqcYQ4DFLvmAuo31qV4HVx8Fr0hwN//bycN7YzLPwsjmMNuhYTQqcFHpvz
         DNP5mAztMtI2VJQKXaKXSumZU9QRsItbuLJvAh7JNNiaQ2UqYNoi6v8aaJjAv+HvkfYb
         xoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765905; x=1689357905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jK7Krh6d5glAjoREUgnuuxQiDYi3CDuObLr2ly9o6k=;
        b=iidGcjDlXxYlpNvNOIwOMsF5qj3am/ca1qA2N/4CjYP9tbdf8o5IEyS5jtu6MyXm4k
         Bd6AQjPKubQBcvPvo2Stx4SaGeaa1kYll2scTxCplziy7lkGr4NGzBadiL6mKHeB/AHn
         MFUsikLG0uTj5u7jqxMKqqGulGNyvYOmig5RHLBJ5mHL6PHqHe/pPR9TASULcLRKL2Fb
         iydkAs2qLdd7xhuE8H0bSGVheZ1cQaheuQtvJ12THY22C++TRzeBypLdOhehDXJEPdT1
         g1oCOBjRlc1RAcZmkrEFYGGCP5T1rbTDdiEeuiqHW6KmJZd4k3hPDqqKxMoN47L50OWQ
         jsjw==
X-Gm-Message-State: AC+VfDx66WAmTXH8Cg2fV1cR+cdoGRaa6tjlKzU8Oy6Ee0ZPRCrAn80x
        tHVCqCFQOpM1dbTU7F9vCdfZ/Q==
X-Google-Smtp-Source: ACHHUZ79SFUlXngqD6+wdEGvXFP7Gt9ySja/c0ks4vmeRgBojOREk6Du7K2W+aIyDkce9mJ+87gJcQ==
X-Received: by 2002:a19:ab02:0:b0:4f5:1418:e230 with SMTP id u2-20020a19ab02000000b004f51418e230mr8526746lfe.52.1686765905514;
        Wed, 14 Jun 2023 11:05:05 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id l18-20020a19c212000000b004eff1f7f206sm2224053lfc.9.2023.06.14.11.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:05:05 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 20:04:40 +0200
Subject: [PATCH v6 21/22] interconnect: qcom: icc-rpm: Set correct
 bandwidth through RPM bw req
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v6-21-263283111e66@linaro.org>
References: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686765873; l=1241;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kbfzjw5doxXBVvXaQEAjOvlD1+VtGE/glxgCqrLn1Ec=;
 b=W1bC3r65t6nqniIfPxVvYWPx6IUPsJ8nB6cXGnLHWP9BPmWYGhSkPSt3L9gHWS2stPilvmxQS
 Jat4lkIfYasDBkekfuBzrvMHkRqqu12tS9rd9LNQmUF9RBWHUT1SU1U
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

