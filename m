Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7BA7073B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjEQVOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjEQVOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:14:34 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3216F7A98
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac836f4447so12947751fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358070; x=1686950070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WB7o5JzliPqClTUxbFBIzOZ1VAPC2kTl85qPjyuvehw=;
        b=dla0xxAgw14sSQpkBy1XDqebun4ISYqPPRp1iSXhSPWTef6ck6itwp2Y98QnVkReZF
         GpvDIb4WuYYs7hm67HcHOgnCjKz6JtEsEmNq/QaYbzQ3ycn6vWCFCqSstIKDC6EFU6Tr
         dwNaL/ODPSlEq7vqgsAU7A6ZHwsqct8PwX2hdab8jmJupW6xJOmVKXTTV4fYI4LCcO6I
         Dg95G16BYEvbL+/WjGlddz3pqr5vOohpGHjaYrZDjxVhHV8vwdP2zDzBJytkkbSgKtiH
         iAyYVgBL0cqVwFEEgdKPmUoSGdXwLGzuE1jNwlHOJqQXQsZqTKSXToFuMCieKA3/CJoc
         Rzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358070; x=1686950070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WB7o5JzliPqClTUxbFBIzOZ1VAPC2kTl85qPjyuvehw=;
        b=H3DOIlldN31UWa4m2vhAz+hxx9xo2aAo1aeGOmvWDuKqM6hKTpV9g9FgiFk4pUWN1g
         qrakKEkC/Tx81cjrA2rmJG2C+bCI0y+JvxnUSbhGQK2Cyx4XP4XsETeUT2rNFRBOsdBa
         xo0OHyF6Ro6tJBFljb8gf8UJASP1N9xWd3GNxEz2YjFdQCMYSazZbjI2/yhoB/Uyt8bs
         zHtSSyhv/tX76p0xrc0w5nxvnXm12kNYkZq8aofFHEeTPN9Nm2x09pnsZK0HqsGmWFlt
         kEgP0Vjv/8bTjohDr0YShVm23RujPDLZdkED9hmVlUM3piiNFphdu2X9ZfIsr38UjF3G
         fVmg==
X-Gm-Message-State: AC+VfDyUzlWJrgQ6jYmNn5F4MccnGZpIcQ7o+8hdTgubf3+8mvHvlu3D
        ePBK9pCoTndFVNTRtFXbpezX5A==
X-Google-Smtp-Source: ACHHUZ4lOGnG43GrE7vnXDxP7lMKs4LnDRJldBcGumsVA2ZKj+4w3XNxxEJFQhMyvbtkAnx7pcuoqw==
X-Received: by 2002:a2e:b172:0:b0:2a8:c01a:71b6 with SMTP id a18-20020a2eb172000000b002a8c01a71b6mr9519546ljm.3.1684358070367;
        Wed, 17 May 2023 14:14:30 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8345000000b002ac88e29049sm4781142ljh.43.2023.05.17.14.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:14:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 23:14:16 +0200
Subject: [PATCH v3 03/17] media: venus: Introduce VPU version distinction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v3-3-6092ae43b58f@linaro.org>
References: <20230228-topic-venus-v3-0-6092ae43b58f@linaro.org>
In-Reply-To: <20230228-topic-venus-v3-0-6092ae43b58f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358064; l=2053;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fQWU9RHiaT/ZJ+YZvKDL3yk/Cmmu65hET4UaVHeDybg=;
 b=MSj/MTkdOBsAAjOd9xHOkLdhXg9K+8D9c9MSPTarCVdqji1cP3OQmoxQKYt78/xr3r/5WoKtn
 pbacGU+XiN4BUX2kagT66UT3scWB2nnycC4DnBAaGppaU9ABdFkffzw
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

The Video Processing Unit hardware version is the differentiator, based
on which the video driver should decide which code paths to take.

Up until now, we've relied on HFI versions instead, but that was just
a happy accident between recent SoCs. Add a field in the res struct
and add correlated definitions that will be used to account for the
aforementioned differences.

Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
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

