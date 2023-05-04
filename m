Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167756F669F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjEDICb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjEDIBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:01:53 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22AC4207
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:01:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ec9c7c6986so183380e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187300; x=1685779300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLWIf5AJktVcUGdZu7o/1TfCD4Dmn96OdaFzmDBQ/Dg=;
        b=Df4dlbvM8+/gwDtSxIjKjpEqaBK/y7rpL+azsxYVWnzuOrMjoh0Y1FMB8YH+n/oFvH
         b0Gy78TbyzYk2LC1Z8WPG0uilaC8GTcumgrVDL9BtoPF6NDun47JEvQ96OXWs21FtMQ8
         ckWrvgncWcAV2VOcPK7NosS6acZ5nCFSHLB1JjKPcV0QCxDlIc+8h422QmDeTwRj7MJz
         9TuCK3lfNkA2hepVj0oLa1ILq5+h2S2GPSaOMq9zUJa4bBI53bc62W71twV/ycGhMyS/
         eKIvB+K/D0KGBGG6dw4nubBlG+YwI1IubyQt0vd+184diUsJ+cVuNssLy/oMD+bG2P1L
         aZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187300; x=1685779300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLWIf5AJktVcUGdZu7o/1TfCD4Dmn96OdaFzmDBQ/Dg=;
        b=foBcHoWYWaH5/iNo5MrgONGhQKVDirqqOxWtj0hybNepa0r/c23S9UA/8sIFosZYXl
         UKtkBaGZWiNd8snnDC20Iq99EhA9qafqYHi+79gaJ2c4y6p6WvFS8mjO4hsXtbY6Pyg/
         GDDPX8KQ/yyoZxSiFK90gXnMiod3QY3pwhl/qj9f0YrY8bpXGYZ4J0np4kOoZg5RmoLJ
         f1gncuYLJOpEfdJfFiw3b9Rib29USIy4ITirD6Ccb+7K1YPrhE6ijyXXxDMcIf6Wt+jp
         lmQIpXY6utk4SrfgGKG7oownrqBr2s6ZPNQuC0K21wuCKviPh9e10A8Vg+fTGQ3wjKTX
         P6Ig==
X-Gm-Message-State: AC+VfDwsbQOaVGMIPbJhxiGDu+1f6jp/PPGqkFHzdiBgOpFawXOeBcUa
        d+qj2CP9xZbpy8NxLcJkEzNpIQ==
X-Google-Smtp-Source: ACHHUZ6Ik23hnDj0QNZILPmdNF9TUFNthX8A5QSCFTIe4MaH/AB9MPD8spGlukcP2XF8Z0xKxEeYPA==
X-Received: by 2002:a19:7417:0:b0:4eb:c12:df1c with SMTP id v23-20020a197417000000b004eb0c12df1cmr1520892lfe.65.1683187300652;
        Thu, 04 May 2023 01:01:40 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004edc512515fsm917165lfi.47.2023.05.04.01.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:01:40 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 04 May 2023 10:01:05 +0200
Subject: [PATCH v2 09/18] media: venus: hfi_venus: Fix version checks in
 venus_halt_axi()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v2-9-d95d14949c79@linaro.org>
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
In-Reply-To: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683187284; l=1179;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2TN022IG90w1W+WW41ndXOwXiJsz29XNAp4fcB4/bxA=;
 b=zAqIh0c4vPxL8UYZPaH/GKZD5YzmAXx5SKQ26zh3K3OdP7Z2VReAs2NFUcC353sxLq2vDyDf4
 DBb7zZZF9ckCQR+c5lfDna5ojcjDKQUtW+IoUz0Ax6PXQC2riY0nT3F
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

Only IRIS2(_1) should enter the until-now-IS_V6() path and the
condition for skipping part of it should be IS_IRIS2_1 and not the
number of VPP pipes. Fix that.

Fixes: 4b0b6e147dc9 ("media: venus: hfi: Add 6xx AXI halt logic")
Fixes: 78d434ba8659 ("media: venus: hfi: Skip AON register programming for V6 1pipe")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 9b840440a115..ca56b1a8eb71 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -549,10 +549,10 @@ static int venus_halt_axi(struct venus_hfi_device *hdev)
 	u32 mask_val;
 	int ret;
 
-	if (IS_V6(hdev->core)) {
+	if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core)) {
 		writel(0x3, cpu_cs_base + CPU_CS_X2RPMH_V6);
 
-		if (hdev->core->res->num_vpp_pipes == 1)
+		if (IS_IRIS2_1(hdev->core))
 			goto skip_aon_mvp_noc;
 
 		writel(0x1, aon_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);

-- 
2.40.1

