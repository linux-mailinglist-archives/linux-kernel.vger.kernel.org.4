Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8027872A4AC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjFIUVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjFIUVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:21:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A10C420F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:20:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f6195d2b3fso2801928e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341983; x=1688933983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CYnae38h+2Ha8DEsswsgC3tiiF77w45gY0ME9hPmK0=;
        b=UL8iugcjutChamWf42do/iCGYnj6h9Iv5uQA5YnjW/QDyKx8uImL9K+I90O7SQKEUa
         NFb/AlN9DpFyq1TVbLnXnt4U9uPPScCkXC/QhUFaKkfJ/50LdZWugB0GJWZ6As8nSW8W
         J6L5MEhAL/Y9zYeTuL0F29DUCocnezsXXppXS1IykNOTuig9Cq+pdEoZvmANK0yEFKNB
         XTHqJmeMr/0SdYfYv7xWsyt/QOAyjrMC0ZdB0QFr/6DgOR+gm+UCJRlYu/W8HoEyo273
         LolbVXzdxgcK4WIK0DzZN4kbeaVWfcKqk9kepY4UL3K4+6ppn9vztHEBn0ScO5C2LpNT
         297g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341983; x=1688933983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CYnae38h+2Ha8DEsswsgC3tiiF77w45gY0ME9hPmK0=;
        b=a5xg7WY6OuD+81Nd3fm0YJNQO4zv3vzh7rOSykylIk6F+wPv/xX/gvDCPSlQBZkUe8
         KU9oYcj3mrsnAXqtqVag47G4ydMf+AFU/yiv5Oh86KKCPyt7bjZE2BaU9Atg9jnnBDRK
         uIwWejuprOd4CmRhxgB2uREk8nD/h6bsLISBmNRa6kTyyH0h0a1qgxJIH5PQ3TpOkQ9n
         x2Smdy9ZGWOp+kiUOp1jWZjOmpN8fa7FzoFAhKNwYLhC3X8jBe19fLQWd9nlD8ibgxwK
         Ct3oF2oVy4Jn8gpQR0bsedNleWTnUfWGadNyAdtKKtNPVtJNcytkr8Jatkm/l05Z27JR
         05hQ==
X-Gm-Message-State: AC+VfDzhJ+cxkm2MA3YRM5wavU10XcIasd7akzF8GjOumO9rvgcKP69K
        FaBVOCiPMId7FloVIgO/wLqNAg==
X-Google-Smtp-Source: ACHHUZ62iioVreWg2FJGvAlwRg7smnlPA+zSUn7GxRnKaOB/iQ4+SY/mpPnUHkTIw6Oz7esc2wqpHA==
X-Received: by 2002:a19:3819:0:b0:4f3:b8db:917f with SMTP id f25-20020a193819000000b004f3b8db917fmr1269864lfa.47.1686341982937;
        Fri, 09 Jun 2023 13:19:42 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:42 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:26 +0200
Subject: [PATCH v2 21/22] interconnect: qcom: icc-rpm: Set correct
 bandwidth through RPM bw req
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-21-e5934b07d813@linaro.org>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341954; l=1189;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=rnjv1FkG2LZNQA5JLVwzFmZbhzL0mGsmc7rQYDLSsUc=;
 b=zhTwx3ylCzTTKzeHxgS5M8QzOryBV1e3M4jWd/NtdOoMhFRhPiBs/kBDomlORHIjXnYRAJFFm
 izzIkf1c7YQDMGQmqCim4qaVSh+CQR1xb1JWlT3M4nsw90QbrU4lMrb
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
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index ac719013077e..1508233632f6 100644
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

