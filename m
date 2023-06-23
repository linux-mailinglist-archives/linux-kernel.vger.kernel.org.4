Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FA773B82D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjFWMvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjFWMvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:51:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06822711
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:50:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3113306a595so681530f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687524648; x=1690116648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xwdEGR95Jdgntol/p/VjgJdE673liewISx2EIhavUY=;
        b=yX7q9+o/UBUOzghFs0vcm3A5Z9kB3O0t9Ntur83ksuBlZQkFMyeznTBCe1tRZaLhCx
         I3tUB6fycvvOybWRedh79t5RIpREsDMpb44v5Zcbq4lCYm+IanFKAP7BvtFCzN8j3gsD
         YMLki2peNiUN9iyHC/SHx/l69aAF+SwKMe1dVivwA6MDZiEpypQJX7bcBIUOttvrg3AM
         lS0nYFnejUHLbkB93kruhypH4K+so+kIHVBEdfNEdlMBwiLKd1tqsB3TIo/2FHmL0o2A
         2WcckOP7sNC1YnrPUUW5bEjdvnz4OVr2cjeE5O5Iyr3Y5ur8v1EM0XDzWIKsFrxLZEE1
         KTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687524648; x=1690116648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xwdEGR95Jdgntol/p/VjgJdE673liewISx2EIhavUY=;
        b=asafxB12ImHQJ1Gx75ZdAoPkB6CsEfD5R/XkpCTUZOby8dAyd+boeQ7y+WA5qXbBdm
         LpXb9TU9sDexsJ/Yga8/VkzOAJSXyVG3Am2ijTCllsGjMyQjn6RzzRAytglF6rAtItqO
         dznGIwuw40GWqLO17kDNiuWjdGV7j/WYaIxHUBFhIePK8WT9sOWDc/6XdDXvv+FNxSP7
         1GgFI/GmmtB0xBHk+2GWnE4AcoeSuYQzw4nlkbTJxOh3U+3rkFkxfMgbGGon0plPd28Q
         5BUhfdej+xce3gic1lDGSM8zyBsju3cXEk7aRgW6/8/h8yBYbP38gRWDEN1/DX9ENL7k
         MsTg==
X-Gm-Message-State: AC+VfDz6YqHZCgqZ2QJ0QqDfKAWKsUPR474T3VfTtSwjtJS5GJMDUvXf
        ZUL2nOmfnMcGLj7oHn3pJe/DlA==
X-Google-Smtp-Source: ACHHUZ5dfj6Qf5CuDNqbS3VfwWfrZV6hcgA44TWBpBYJsvBHo6RBw6mQV12vDvqbK0QRdzW6Lgg+AQ==
X-Received: by 2002:a5d:42d1:0:b0:30f:c1c3:8173 with SMTP id t17-20020a5d42d1000000b0030fc1c38173mr19597811wrr.26.1687524648225;
        Fri, 23 Jun 2023 05:50:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b002fae7408544sm9455350wrs.108.2023.06.23.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 05:50:47 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 23 Jun 2023 14:50:43 +0200
Subject: [PATCH v2 2/4] interconnect: qcom: sm8450: add enable_mask for bcm
 nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-2-709474b151cc@linaro.org>
References: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-0-709474b151cc@linaro.org>
In-Reply-To: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-0-709474b151cc@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2744;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=LaziN8HXwyH279DHBKH1rB581eoiV23jx7/cCXsPqWQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBklZUkdxD0FbTQDU+PbPUpmHf9tTbxlSXuJeEA6/GX
 pnFbbAaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJWVJAAKCRB33NvayMhJ0eY2D/
 9FLDKlj1748uBlkTDxAyFF2/I8h+Vyr5mtbojmOx7jIBu0cnTqZ5dF3hJmfECQCICFxa0vyZIOpbdm
 zK1D+yKmpcDvxWXWvNnYEqkQQfnmMdvXSslDvp9n5+EM7YVTWrkkAItpCfQQYWoYBXeeVtlKsqyDbr
 7v2/tfqa4Kwni8Ku86mujCQypc11H8xouLiTPpA2JDWCqfSRETeJkwtac1a0n9royPYF7OEd6YblG1
 P87eq0Y/LJjKh1HiGC4XkTM/qdW/iNccCgp72jCGWa4ebzq3Ka2W1XkXzCeLOKSoQPgvdgqL8EXLVz
 7F2scoJ74rh5NMqntXUtnXKxz8jYZMsCtv8KUZzFxWMMgzLQnOAEzfCXDdSdpOkWI8zKV0WGLUmVeM
 ageYZOKMnAHfCwVLDhCmzsJXYX9ePP2hbZgDVM1LIRNsfMDTg5oE/FBS0mpNF8eT7XsPKxmL287v1M
 8YpRjcQbIldioAqutxx4ovN5BkFX8e73HuBHvqIOZT7m9quQTOntwi9luoLPwk0XYAgoDNADP2XLar
 hZRME5r1Myu3aI2FuTi8t79khgHYNOYSH6pIzJMcLQ4lHS7psZv01zU/yOVr93DK9aNeHS1s27Ccj3
 Dh41yo5cp9613MjCpDwW0kTqFESixUWMKFWmn4dITnr2IWPuq4cR2ss4qXjg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the proper enable_mask to nodes requiring such value
to be used instead of a bandwidth when voting.

The masks were copied from the downstream implementation at [1].

[1] https://git.codelinaro.org/clo/la/kernel/msm-5.10/-/blob/KERNEL.PLATFORM.1.0.r2-05600-WAIPIOLE.0/drivers/interconnect/qcom/waipio.c

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/interconnect/qcom/sm8450.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index 2d7a8e7b85ec..e64c214b4020 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1337,6 +1337,7 @@ static struct qcom_icc_node qns_mem_noc_sf_disp = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = 0x8,
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };
@@ -1349,6 +1350,7 @@ static struct qcom_icc_bcm bcm_ce0 = {
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
+	.enable_mask = 0x1,
 	.keepalive = true,
 	.num_nodes = 55,
 	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie,
@@ -1383,6 +1385,7 @@ static struct qcom_icc_bcm bcm_cn0 = {
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
+	.enable_mask = 0x1,
 	.num_nodes = 2,
 	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
 };
@@ -1403,6 +1406,7 @@ static struct qcom_icc_bcm bcm_mm0 = {
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
+	.enable_mask = 0x1,
 	.num_nodes = 12,
 	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
 		   &qnm_camnoc_sf, &qnm_mdp,
@@ -1445,6 +1449,7 @@ static struct qcom_icc_bcm bcm_sh0 = {
 
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
+	.enable_mask = 0x1,
 	.num_nodes = 7,
 	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
 		   &qnm_nsp_gemnoc, &qnm_pcie,
@@ -1461,6 +1466,7 @@ static struct qcom_icc_bcm bcm_sn0 = {
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
+	.enable_mask = 0x1,
 	.num_nodes = 4,
 	.nodes = { &qhm_gic, &qxm_pimem,
 		   &xm_gic, &qns_gemnoc_gc },
@@ -1492,6 +1498,7 @@ static struct qcom_icc_bcm bcm_sn7 = {
 
 static struct qcom_icc_bcm bcm_acv_disp = {
 	.name = "ACV",
+	.enable_mask = 0x1,
 	.num_nodes = 1,
 	.nodes = { &ebi_disp },
 };
@@ -1510,6 +1517,7 @@ static struct qcom_icc_bcm bcm_mm0_disp = {
 
 static struct qcom_icc_bcm bcm_mm1_disp = {
 	.name = "MM1",
+	.enable_mask = 0x1,
 	.num_nodes = 3,
 	.nodes = { &qnm_mdp_disp, &qnm_rot_disp,
 		   &qns_mem_noc_sf_disp },
@@ -1523,6 +1531,7 @@ static struct qcom_icc_bcm bcm_sh0_disp = {
 
 static struct qcom_icc_bcm bcm_sh1_disp = {
 	.name = "SH1",
+	.enable_mask = 0x1,
 	.num_nodes = 1,
 	.nodes = { &qnm_pcie_disp },
 };

-- 
2.34.1

