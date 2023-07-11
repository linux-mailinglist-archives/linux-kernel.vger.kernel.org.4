Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FEB74EF0F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjGKMgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjGKMgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:36:04 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED641721
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:35:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbdfda88f4so57795285e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689078886; x=1691670886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qEI9ih7CsEfqqcZVsPdCla2s3zGk1zpIvdrNZp7GUo=;
        b=Q446X4P+7xWTaxlN5MbzUN6wW5rmmDPu9wNZS/3DVYHxaPbSkAESGhsNZplga/OIMq
         U773HB36h26/H9lPo876fzdqKNICmWgatPzSm3FF/bxjMdkm5NMAfjn/pRnOhdwuPTHx
         tEOSTiSq7mvpDdI+wPL3vAIgo2KWj4aehk4whaMVrbp5qKnUJ+qVkCUPU/Kw+LNV/fm9
         9xiO5Bv4/usDUO0yCNlt26rtdH5z7k1yGSJmcL3HrIQTfY20X/u2D8jsPoA1BPlB+TnV
         mJs0cozjAGcb8vNXL2vXOnVsdi5E9bhwZ+Y8ookpD6AbQWOI/BXYOFmkCK1dbbMJCVjU
         iWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689078886; x=1691670886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qEI9ih7CsEfqqcZVsPdCla2s3zGk1zpIvdrNZp7GUo=;
        b=T/YijyvHr3ao2H3sFpv9tzR4WkzbOu+YYA8toPzVfVbiMyJhTts43KTADxQs74wL/x
         tZ+K5QyQpJIEalAdSdOazMSZIIBwrMNJzlsATzvVpn0sxo6sNqDrLjHVhwPyrvBh+LLX
         P2He+3N60c0GcrP5G+guS9ZP9T3Lqj3dXuWWZtbpFBpG58/Xi9wCK1S1HzWqTgFuRK8q
         ysFSkC7KK85kPZ+EHQFVtgy/tN0c2VataQTFDeXXf034HTl4SPVIZB6lsJR24fTBU20j
         ME9idswKCHEtreB/RyUk66ne/0kFtvHtkSOP1A3iF1drLJV+B2D5KNvjcKjF98snzsEB
         KO6Q==
X-Gm-Message-State: ABy/qLaUVxOElJb91gzu5SngoYZMhUwd0JAS8QiXq35ftEN+Uho43z3v
        YHtD8XrnyDGi7nv+8hwtFa9CYi5K5AKW8GRXcJBNAA==
X-Google-Smtp-Source: APBJJlERwY5Ah/kFYLm9KWUQ1ixR3SDh15gYAU7TZOHqrhoESjYXLBqCwASCR5Xt40UjYu3EHMbB/A==
X-Received: by 2002:a2e:9f4d:0:b0:2b6:e151:791e with SMTP id v13-20020a2e9f4d000000b002b6e151791emr13433971ljk.43.1689077973594;
        Tue, 11 Jul 2023 05:19:33 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:33 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:50 +0200
Subject: [PATCH 51/53] interconnect: qcom: sm8450: Point display paths to
 the display RSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-51-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=2103;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GAWOUV4QJe60q6M3sv3YLGxilMGxFFgLlCxXc4BU++I=;
 b=n6mHwI5Knlo8QwAZ9UuQJZ5TSMk5uicF8dPrneNhYlmJUFzK9gguKI0KQoyfgn83kx8zxL6qu
 BLXqqqUvr/lAd5PsnBNC3JILtU6yS5lpYZClOMClAFtFiipSLnQ2MVw
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _DISP paths are expected to go through the DISP RSC. Point them to the
correct place.

Fixes: fafc114a468e ("interconnect: qcom: Add SM8450 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8450.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index 989ae24f2be9..6f42b1d693b4 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1517,21 +1517,21 @@ static struct qcom_icc_bcm bcm_sn7 = {
 static struct qcom_icc_bcm bcm_acv_disp = {
 	.name = "ACV",
 	.enable_mask = 0x1,
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_DISP,
 	.num_nodes = 1,
 	.nodes = { &ebi_disp },
 };
 
 static struct qcom_icc_bcm bcm_mc0_disp = {
 	.name = "MC0",
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_DISP,
 	.num_nodes = 1,
 	.nodes = { &ebi_disp },
 };
 
 static struct qcom_icc_bcm bcm_mm0_disp = {
 	.name = "MM0",
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_DISP,
 	.num_nodes = 1,
 	.nodes = { &qns_mem_noc_hf_disp },
 };
@@ -1539,7 +1539,7 @@ static struct qcom_icc_bcm bcm_mm0_disp = {
 static struct qcom_icc_bcm bcm_mm1_disp = {
 	.name = "MM1",
 	.enable_mask = 0x1,
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_DISP,
 	.num_nodes = 3,
 	.nodes = { &qnm_mdp_disp, &qnm_rot_disp,
 		   &qns_mem_noc_sf_disp },
@@ -1547,7 +1547,7 @@ static struct qcom_icc_bcm bcm_mm1_disp = {
 
 static struct qcom_icc_bcm bcm_sh0_disp = {
 	.name = "SH0",
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_DISP,
 	.num_nodes = 1,
 	.nodes = { &qns_llcc_disp },
 };
@@ -1555,7 +1555,7 @@ static struct qcom_icc_bcm bcm_sh0_disp = {
 static struct qcom_icc_bcm bcm_sh1_disp = {
 	.name = "SH1",
 	.enable_mask = 0x1,
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_DISP,
 	.num_nodes = 1,
 	.nodes = { &qnm_pcie_disp },
 };

-- 
2.41.0

