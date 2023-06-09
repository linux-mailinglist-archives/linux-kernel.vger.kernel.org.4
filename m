Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C836E72A486
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjFIUUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjFIUTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:19:50 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15EA3C3D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:19:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f62d93f38aso2809331e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341972; x=1688933972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxwAlvsxTG2NJKirdi7L920nJWliszLcfh8qb5HaEiU=;
        b=Pu1eMhlvtx2syAfk6O/Kew64LxKcAeWFOSBhLgK+EkjXBWO9dDhA2hUvZR94D4GyVc
         zNyAXWqtcjDID4K8OmwgtVsL1WSrZKwB0ZS0+rFkt/cHJL+HdUgFMJUDbFYhqNOu8aUC
         jwPX5/3tDo9n2xndATcljDJYnzQwtUNY5kVJdGVjH6sh1L9C33ymuNtp1so7mxmATK2q
         7hcOWJ5i0j+6E1JKAVqUtUIh1o3fcV9bKHkVqI0911138jIF5ZP9pm87T+kJY9wcskfH
         GiQFzGGwAZ4rGNbp4AXWHM+ToE5VMYdHVoGLSREPvBzF/ey1f9Mzzwso8SeN7CEuxjTT
         Xtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341972; x=1688933972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxwAlvsxTG2NJKirdi7L920nJWliszLcfh8qb5HaEiU=;
        b=CSNkp/4QA0PbVh+caP+jjp4auC0drjAjDqJ6IUuI8Ndg+tqf/LVXdhvEz8Be4xOCyE
         6/KI7IHhmsScR8adgPPNYS9X/X2EVoGMsH9cx4BOjt43YMfkPWl6uiymcqnQvuQFvb+R
         +fsVSLP2Qw5/fbiIfozRIOTiReg93/czTrkYOyjfciU8yWCa+sLywQ6f4KIjxWc3dsdk
         rtMMcaZka3tFsokqxpPTDzz8T3C3OwInlWrH3gO+arzrsUjq2hnvv1kq6b7u2RrZhikX
         qAvyKdWc5WRPOU4r7UavOgsaDBUai0EJQQa6fGY7R0ZhddFaVQNF5XznNf2bMYxiB8sn
         dNJg==
X-Gm-Message-State: AC+VfDwLv7vT0MfRJdy+IwjVNlBBFh0I6A46qmO/nwrGpDxED2wiO5Nt
        9nSqWv0XYhBLyMvkTWCkJDnQgw==
X-Google-Smtp-Source: ACHHUZ4/Mlbad/Bz5Ye4ghUR+Ks8t1P3RipWOIYwo+g0JIb9jCoqD7/4hsUVpAYSxmcGvVndfscrew==
X-Received: by 2002:ac2:5bca:0:b0:4ec:8853:136 with SMTP id u10-20020ac25bca000000b004ec88530136mr1760276lfn.12.1686341971890;
        Fri, 09 Jun 2023 13:19:31 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:18 +0200
Subject: [PATCH v2 13/22] interconnect: qcom: qcs404: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-13-e5934b07d813@linaro.org>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341953; l=1291;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=NibH4RmX92w9jFbYbYmeVzyLtbX9fV3dfXE9S9JnGAI=;
 b=TCpechMBmNATG7KGeUW31PLFuqm3NZxW7uiHDhtr0yC1lY68iIT1yDQ3b2mP4m5p+HjRj8PFP
 4THtWoa3TEfBvWcVHk9/g8MjWvcFHHyCbJQFsbMvcjEKwPK6x9asXqQ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign the necessary definitions to migrate to the new bus clock
handling mechanism.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qcs404.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 938283ddd0e3..9deb4d81104e 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -984,6 +984,7 @@ static struct qcom_icc_node * const qcs404_bimc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs404_bimc = {
+	.bus_clk_desc = &bimc_clk,
 	.nodes = qcs404_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_bimc_nodes),
 };
@@ -1038,6 +1039,7 @@ static struct qcom_icc_node * const qcs404_pcnoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs404_pcnoc = {
+	.bus_clk_desc = &bus_0_clk,
 	.nodes = qcs404_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_pcnoc_nodes),
 };
@@ -1066,6 +1068,7 @@ static struct qcom_icc_node * const qcs404_snoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs404_snoc = {
+	.bus_clk_desc = &bus_1_clk,
 	.nodes = qcs404_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_snoc_nodes),
 };

-- 
2.41.0

