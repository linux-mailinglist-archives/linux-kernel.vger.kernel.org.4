Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218BD6F6692
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjEDIB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjEDIBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:01:38 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AD740C2
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:01:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2a8b082d6feso1982521fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187292; x=1685779292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzxlUp4GevQo4zepiewLcHPe74bB2xBOAHPwd2eLqVk=;
        b=WSR6igftGzl/n19F+ivPAwwjgS3NkuZOc0nOXB79LVGDUnvoLSnGzoAFvyL+GiK8yT
         bHUjsRKYbkyos6N1khLh2385eoKbTQkXz8sIVOAdjc64AnUyaAagPBZvnjhlZXRdhO5o
         us8bEIlvvFJTYHPq3XUOAv0FbFsggaElghw4O/AjLagT3Ns6e4ciGm9NSp091ombSTnt
         Pn8BXrVi1dG4BQylgQw7RedOcSQuZhiMDaMR17pT1TuDC2evWcdbMel4nnULgG8vjhqR
         Vxk2WCkN8L++KB8RqldXIg3Tf4PWmiYu+NvmwYQI52TH7PEkWuQz3ziONVoLnYWx1Xsj
         +6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187292; x=1685779292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzxlUp4GevQo4zepiewLcHPe74bB2xBOAHPwd2eLqVk=;
        b=SHSsn3r+UvXIqaVKYFr2ohKB2WIzDoTZnh8IdAdhCFM4X/28dPxYyGPzWWz/uNFfe0
         O/809EwuhyfuLRh0+ZbkI75LRfhqO+HO1FKb8em/XHKFdfpHEGhDcd8G/B7wOBpGsAx1
         jtOPKS01zeF+1xZtkrVbMByI9exWJyFj7oMFbVwQ6L2JtCmrcPKYg4PNCVfrN+49ClkX
         F3RShOgOE/v4k+QjBXCDmF4RG1SaY9p0hM7M2AN+a0nKkT7yMVVD+qQG8LS59BZy2h9I
         IOTqw215rJ4mUbXJlITqyk+a1ZTky8F2NVgC1j2+QxhptIj8AXj/XPROaV7Sre7jM70a
         Begw==
X-Gm-Message-State: AC+VfDz2qtUeFg+Vxmvflt16BjKvhJboAea7xaBaJCx1ExfNfhEEhjg/
        aWDUVC4dX7t2lsLHYyi3bDlMgQ==
X-Google-Smtp-Source: ACHHUZ4ckv52wOwgtQLC+dHGPcaSmZPAvrQ3dT8+o9kSVCyvPl9JapLOsXVHo6Zw0GaVPlStbmb7ag==
X-Received: by 2002:ac2:5237:0:b0:4ef:d573:c8a7 with SMTP id i23-20020ac25237000000b004efd573c8a7mr1613683lfl.32.1683187291973;
        Thu, 04 May 2023 01:01:31 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004edc512515fsm917165lfi.47.2023.05.04.01.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:01:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 04 May 2023 10:01:00 +0200
Subject: [PATCH v2 04/18] media: venus: Introduce VPU version distinction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v2-4-d95d14949c79@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683187284; l=1983;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=HzABoJBacsfN8IA/HbPbvHnBAN4Alo5yV3JV9j0U0iY=;
 b=To1WkTJnLXLSw48ogxPQ3YmXryfFfCKO+6KFtrPSzA1dHUlfBUkToGVGYWYr3k2ukttZB02Xr
 uGbPA5Ykh1iDKVnYx3VRe/HTccaQkmQUyQhwXfQV32XRNScUzchS/kB
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

The Video Processing Unit hardware version is the differentiator,
based on which we should decide which code paths to take in hw
init. Up until now, we've relied on HFI versions, but that was
just a happy accident between recent SoCs. Add a field in the
res struct and add correlated definitions that will be used to
account for the aforementioned differences.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 4f81669986ba..62c310b7dee6 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -48,6 +48,14 @@ struct bw_tbl {
 	u32 peak_10bit;
 };
 
+enum vpu_version {
+	VPU_VERSION_AR50,
+	VPU_VERSION_AR50_LITE,
+	VPU_VERSION_IRIS1,
+	VPU_VERSION_IRIS2,
+	VPU_VERSION_IRIS2_1,
+};
+
 struct venus_resources {
 	u64 dma_mask;
 	const struct freq_tbl *freq_tbl;
@@ -71,6 +79,7 @@ struct venus_resources {
 	const char * const resets[VIDC_RESETS_NUM_MAX];
 	unsigned int resets_num;
 	enum hfi_version hfi_version;
+	enum vpu_version vpu_version;
 	u8 num_vpp_pipes;
 	u32 max_load;
 	unsigned int vmem_id;
@@ -481,6 +490,12 @@ struct venus_inst {
 #define IS_V4(core)	((core)->res->hfi_version == HFI_VERSION_4XX)
 #define IS_V6(core)	((core)->res->hfi_version == HFI_VERSION_6XX)
 
+#define IS_AR50(core)		((core)->res->vpu_version == VPU_VERSION_AR50)
+#define IS_AR50_LITE(core)	((core)->res->vpu_version == VPU_VERSION_AR50_LITE)
+#define IS_IRIS1(core)		((core)->res->vpu_version == VPU_VERSION_IRIS1)
+#define IS_IRIS2(core)		((core)->res->vpu_version == VPU_VERSION_IRIS2)
+#define IS_IRIS2_1(core)	((core)->res->vpu_version == VPU_VERSION_IRIS2_1)
+
 #define ctrl_to_inst(ctrl)	\
 	container_of((ctrl)->handler, struct venus_inst, ctrl_handler)
 

-- 
2.40.1

