Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2A86A5BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjB1PYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjB1PYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:24:40 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F5924100
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:38 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i28so971042lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677597877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rc6RN3xd6zhAOa0UniFbQ5+ZDyipjjg8if7hSJwNayQ=;
        b=VUwBjh2ERF8LYTz+KF9QEFEOZzDW4X95x4kirUH5CoxXjYou/BYrh+qs+0dkDl1+LZ
         ri4Sb6uofUt+ZcXScmzAImUBg21KWjSlcP+19N3XS4CMn7ekBWROgoxPW+u4WrKDnCAd
         UgZi/MNSDGUJUJTaNuXTpjgvQh/HAKAjw+T1XE/2gQGlGR1cN7+cBpzro2bolDhivDth
         nMv+3HUeWc+iv8Dfc2AkKBE/6PyXiQPPli3DxPlFkap5HIu8QYQggH0dpcfyBtNv4vxG
         20PmCzCuXw+fUNBnjhFctW9ehUEdDzdfOTTatauE1WL2LOea3poz7Jsr9ic5l9OgFD7x
         FMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677597877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rc6RN3xd6zhAOa0UniFbQ5+ZDyipjjg8if7hSJwNayQ=;
        b=miYBl/YNkQrOYQIW2cHR38VrTIKEiIpbcx+LjuoJWBkOHOkvDwxGu5McQPNGWaO6ha
         vSEDAr8nJ9iRAvze8Bgab/0X3q3yxvBOz1en/JzGYrN3uVACrf66o6Azr9C6igzA+wQB
         m62W/oj8p0IyS+oOUUF6px96ov/l9mMbzLiWFb2IiOUl7zpk3WzK71N6aXfw7dVpzjws
         j1VIZoRHyP8y+JaeNTVht1l8dkfjz+SzUXtHXuQxb/Nf/UzBcuenqxUy1xEP14kpwnCb
         GAO2FUorg+go5xAHoUC+Kbdnz45rrF5Xr/NrEHU7q/bFVagnPb7JWmGsqm0D0B9KO75d
         oEdg==
X-Gm-Message-State: AO0yUKXLO0ODcKNpy7acul1C2Qj9JpjcFWOeyWsQkPYWCtUlVass8CHq
        wfEL9Y4PuNJb1x/+F2qosLPyHA==
X-Google-Smtp-Source: AK7set/94+7THEHG/Uoy/IIGa7hBayT2hRAQTaPQxuruESoN15XU0e29HiCzJl+bYW+hIALrsNPohQ==
X-Received: by 2002:ac2:5ecc:0:b0:4dd:b479:1ca1 with SMTP id d12-20020ac25ecc000000b004ddb4791ca1mr742982lfq.3.1677597876978;
        Tue, 28 Feb 2023 07:24:36 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id h17-20020ac250d1000000b004db3aa3c542sm1363688lfm.47.2023.02.28.07.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:24:36 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 16:24:26 +0100
Subject: [PATCH 02/18] media: venus: Introduce VPU version distinction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v1-2-58c2c88384e9@linaro.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
In-Reply-To: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677597872; l=2018;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=8+CFl9UOfZsXychZVCS3rhjkRarB22qAKqY/ChcPXRU=;
 b=/uwB4DFOETcB67/k2z90ex27AHGQnuTnuzVYnJjmQb4G1VKhbXJoyIL3r8ugZdXoBuqgEAOWZlVG
 ZxaI8QmcCNjHc58ohhSRUoD+IZgchgbpqvB+42Xmp/618gcsL2u3
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 32551c2602a9..4b785205c5b1 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -48,6 +48,14 @@ struct bw_tbl {
 	u32 peak_10bit;
 };
 
+enum vpu_version {
+	VPU_VERSION_AR50, /* VPU4 */
+	VPU_VERSION_AR50_LITE, /* VPU4.4 */
+	VPU_VERSION_IRIS1, /* VPU5 */
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
@@ -473,6 +482,12 @@ struct venus_inst {
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
2.39.2

