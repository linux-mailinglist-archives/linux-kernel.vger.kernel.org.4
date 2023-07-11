Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D19374EE59
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjGKMUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjGKMUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:20:14 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B61268B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b703caf344so85764901fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077940; x=1691669940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKS2SK0W5nsBINlksNeBQjYUnc/qHbIAD1PYowN4Eok=;
        b=S/X0GGjSJTV+VnLh2tuqcQ5XWvuajVH9p2wY83XhlYPLGsKKo7QULljsbzG88xOClR
         6YFIZyEgQh2NT3hC/2B/n0707tPPoMPVXfESZXDEPOnL6zqeObWTfpaH8KYveX6px+P6
         21TWCr3x4XVqvnhLrvS+mUQ5O8Kabvxr9eqTsZIf8hOmquryWXtxbpDbtwAZr7x1I4gX
         NjqCnE5FawZyNBVRK1SJhi8smkcFSlfkBxAFYGrZFAsch3zO6oy7pABNRAfViwGEO32R
         UkKHPuXMAcF4kEgl9SjC5FIv8ZPj6V0rbkh8G4CyR2F0oiFXzk85qQmOFbDeYXBMmPw9
         x9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077940; x=1691669940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKS2SK0W5nsBINlksNeBQjYUnc/qHbIAD1PYowN4Eok=;
        b=OJH5oW6vH/xmxLdur+6bLWcOi3pxrP9LNUdXOck7r5Zq/YnKpj+TWJCMdzla47v8DC
         CIftczNC0gjyl9793/MmZSz9lTsuINeCAA6rbauCHZOHt39+N64o9E7IuSHarQNDac5m
         wYvWVQt/tEWnfKuvuKnwxm7/lseagboh7UI5olk4hXLTU1RZRgAK6y+wyKrNOby/4Q4X
         e5c7xZ8yp5QKm7+l62IZgtCuXOCRixL9L11pQ/0/GJiMN4zNSDbzHeNheWidKXZKMbuA
         BZcFEUabDJ6WdnO8v6Jm20pbLwAn660Q0v5elIXJT05Y2CV2o9Z+O/uVq0pGz/vq9VUD
         waXA==
X-Gm-Message-State: ABy/qLb1CbCJBMCCTf2Lryf/4L/CCsq6oQyzkzfM4MnSgvZM15TLJwUM
        N0O3pSsGUKh4PwCeJnltIq14/g==
X-Google-Smtp-Source: APBJJlG8IuuLHE9jv8dBtHVEsSeLt6su5vbR50FA9D2D/+Lc9g2U3TgoBse94+pcxbxyD/nh2VjVIg==
X-Received: by 2002:a2e:9206:0:b0:2b6:ba00:f733 with SMTP id k6-20020a2e9206000000b002b6ba00f733mr12471543ljg.18.1689077940157;
        Tue, 11 Jul 2023 05:19:00 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:59 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:24 +0200
Subject: [PATCH 25/53] interconnect: qcom: icc-rpmh: Retire DEFINE_QBCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-25-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=963;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4QbqX9qEiwnykOnp3T41q/aNjoSl3d0wkDdtwzmuC9Q=;
 b=KRB7LLVjGAZUDlQ6RmEwKiP2CeNYEuzZIz/3UkIO9aa7zYQPnhOJzN+j7mjNIJXqSehfercoh
 RO54QxvYyekB6AHJF4LoEHDTgGiagtGPZdFwxdVTK3Z7JOtfdppI723
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

This helper has no users anymore. Kill it with heavy fire.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/bcm-voter.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.h b/drivers/interconnect/qcom/bcm-voter.h
index 30b324fcb2ee..62cdee94b5ba 100644
--- a/drivers/interconnect/qcom/bcm-voter.h
+++ b/drivers/interconnect/qcom/bcm-voter.h
@@ -12,14 +12,6 @@
 
 #include "icc-rpmh.h"
 
-#define DEFINE_QBCM(_name, _bcmname, _keepalive, ...)			       \
-static struct qcom_icc_bcm _name = {					       \
-	.name = _bcmname,						       \
-	.keepalive = _keepalive,					       \
-	.num_nodes = ARRAY_SIZE(((struct qcom_icc_node *[]){ __VA_ARGS__ })),  \
-	.nodes = { __VA_ARGS__ },					       \
-}
-
 void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm);
 int qcom_icc_bcm_voter_commit(struct bcm_voter *voter);
 

-- 
2.41.0

