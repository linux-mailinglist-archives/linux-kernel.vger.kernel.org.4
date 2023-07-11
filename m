Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B5874EEA0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjGKMWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjGKMVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:21:47 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64872D41
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:20:27 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so88494261fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077972; x=1691669972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/asgZ03NiEjGsv4yFwqtkX/wMZgRigqk79OQqEY/FpA=;
        b=hCpfqLd/vx3JOsEpmrJXLGzzXybtv+LRYxi+h82MiJ/qjN8JRURSOuDN3mSd8QSGXv
         mGm85+F+w5pTBox1tnm6Qyu3TXgZtgLGS8xw8Rrzzd9K0U4Op132J+eptkFEcTFqX+dJ
         ub3IvrGz8bPuqYRFspKOHujpDwTh7HciqFoRmyLckyezZqb5sVQ4jwQ8G8tdzwkbdtXA
         mH2fGxNfFdD+/jw4LGILvnRWI8tmVkv49YRvrDIm0n4vpygk5PZJSDBUQS31KNLOc90O
         4zs1LFTcjh3lGauXF1nOQvHPXuycCbKYgwam2pL1L2HHxcdm1sjgQx/ESfAdk25xRWjQ
         T9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077972; x=1691669972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/asgZ03NiEjGsv4yFwqtkX/wMZgRigqk79OQqEY/FpA=;
        b=ffGO4HqdpQiVhcfHhdcL9Wxt2lZ+aryIyKv2YZjjWmsdR09otwnGm3B1GxLo1AcwjX
         7Qom8bAQRPURsdsUveohjtSriJezKBnts0lEorPE/uvQB1/lwVt8sHLxAJWq5vNepBPy
         VB6ZrqtzR3D9I27Hj7nCjtM3Wa+BLro2OmhLNS97Qp+wgEKM1ECWeNn3KdLH5wUFQs0/
         qn6+q5w+zfGfvg5geqWWcNf0N4DAiCYbEzZSAxXWq2o8dP9JVz34pNYRS/ttz0NWEXta
         vUNGbtIPupf3U2dSNpTmIk6mxUynT37wiEYGpEQdZfz59aDca4MjD0/8xrIEG87zqr+N
         3p1Q==
X-Gm-Message-State: ABy/qLZ5glL/nlOUQvWTsbNNP19oK1yhYigo/AsZ6+InSWvVJ/GreTEf
        5j1RSPUS01t+puQqJla8G0h9fw==
X-Google-Smtp-Source: APBJJlGydSY5p6okL4PaU6GFDJfbxqkpBMjvgZKcHal05MTStl5cNcj28rvD3wzeEz2DDLdvr8RZag==
X-Received: by 2002:a05:651c:102f:b0:2b5:85a9:7e9b with SMTP id w15-20020a05651c102f00b002b585a97e9bmr14905048ljm.33.1689077972306;
        Tue, 11 Jul 2023 05:19:32 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:49 +0200
Subject: [PATCH 50/53] interconnect: qcom: sm8350: Point display paths to
 the display RSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-50-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=2325;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4cN3u17a4Tjp9KwmLVHyYCuynLOUrKPYJniM89DUm8c=;
 b=TCiw8Gn5E+kROybJ7eM9HDAHOFyDwfav4mFNcXKQuvK0+BeKxlWbuCdcJLWAdcb6awXlEbvSA
 6TqOK3Ni0LHAsoY4ARc1sb+WTzVrou+euI5hOGVp7EXrDzsuyVwnFNu
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _DISP paths are expected to go through the DISP RSC. Point them to the
correct place.

Fixes: d26a56674497 ("interconnect: qcom: Add SM8350 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8350.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index c48f96ff8575..0466ba5d939a 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -1609,7 +1609,7 @@ static struct qcom_icc_bcm bcm_sn14 = {
 static struct qcom_icc_bcm bcm_acv_disp = {
 	.name = "ACV",
 	.keepalive = false,
-	.voter_idx = 0,
+	.voter_idx = 1,
 	.num_nodes = 1,
 	.nodes = { &ebi_disp },
 };
@@ -1617,7 +1617,7 @@ static struct qcom_icc_bcm bcm_acv_disp = {
 static struct qcom_icc_bcm bcm_mc0_disp = {
 	.name = "MC0",
 	.keepalive = false,
-	.voter_idx = 0,
+	.voter_idx = 1,
 	.num_nodes = 1,
 	.nodes = { &ebi_disp },
 };
@@ -1625,7 +1625,7 @@ static struct qcom_icc_bcm bcm_mc0_disp = {
 static struct qcom_icc_bcm bcm_mm0_disp = {
 	.name = "MM0",
 	.keepalive = false,
-	.voter_idx = 0,
+	.voter_idx = 1,
 	.num_nodes = 1,
 	.nodes = { &qns_mem_noc_hf_disp },
 };
@@ -1633,7 +1633,7 @@ static struct qcom_icc_bcm bcm_mm0_disp = {
 static struct qcom_icc_bcm bcm_mm1_disp = {
 	.name = "MM1",
 	.keepalive = false,
-	.voter_idx = 0,
+	.voter_idx = 1,
 	.num_nodes = 2,
 	.nodes = { &qxm_mdp0_disp, &qxm_mdp1_disp },
 };
@@ -1641,7 +1641,7 @@ static struct qcom_icc_bcm bcm_mm1_disp = {
 static struct qcom_icc_bcm bcm_mm4_disp = {
 	.name = "MM4",
 	.keepalive = false,
-	.voter_idx = 0,
+	.voter_idx = 1,
 	.num_nodes = 1,
 	.nodes = { &qns_mem_noc_sf_disp },
 };
@@ -1649,7 +1649,7 @@ static struct qcom_icc_bcm bcm_mm4_disp = {
 static struct qcom_icc_bcm bcm_mm5_disp = {
 	.name = "MM5",
 	.keepalive = false,
-	.voter_idx = 0,
+	.voter_idx = 1,
 	.num_nodes = 1,
 	.nodes = { &qxm_rot_disp },
 };
@@ -1657,7 +1657,7 @@ static struct qcom_icc_bcm bcm_mm5_disp = {
 static struct qcom_icc_bcm bcm_sh0_disp = {
 	.name = "SH0",
 	.keepalive = false,
-	.voter_idx = 0,
+	.voter_idx = 1,
 	.num_nodes = 1,
 	.nodes = { &qns_llcc_disp },
 };

-- 
2.41.0

