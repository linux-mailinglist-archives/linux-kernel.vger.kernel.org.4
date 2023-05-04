Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861F16F66A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjEDICx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjEDICB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:02:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8FEFB
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:01:49 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4edc114c716so178252e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187308; x=1685779308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HycEk6C3Un7NkbfcbNqLuTVGgeLRsCvnGR39vR7pD+U=;
        b=sQEI3Es2dtjywxv6v+eHUS96veU6RZ6X33s0Ynnsgxa43h5DEMZ4IuRdQk02wKvclJ
         tvz947L9i7vESyoayarPuL90QVOho8EIIX0KR1Xvy8ARhS+Qzx28L2+KObA6Fawy00Nq
         xJDygpr/5PoQJpTcSc0HTAWYQAuCPkigHq++QB/lYABi9PYOHXQEdn48/BOBW4XS83kg
         3908FyClnfRNaEjQj2E1E49skzg6hdV9ubgsAb9Mu0/F18zJCQB2P11Gt/QtfwR62dTu
         tm9fCnSIRH9sOHG2nLtHBWlL8nv9dvMbuvLfOJdb1+5aQZ/FUUNKPCjGGf7LY6iKTN3d
         xTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187308; x=1685779308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HycEk6C3Un7NkbfcbNqLuTVGgeLRsCvnGR39vR7pD+U=;
        b=VYf4PscL8/DXGkzDZGvW4Bs785Wbcrtm8dPODSlqzuOKvv8iq7CFv/epW2fBMGJTNS
         rSedaBuVmLWX3kPKzSZQ5Bv1jBG60rQuZuTId5gUGLTtgNB3OTvEk83/kUxIgRlhNtLe
         S895rrWse6iV6JWdXNI99+dFfawbiXBISdXsbPdh5lvbgruvurB8xeH7YWDSJjphvte8
         1RIrk9H3+VwcSH2rHpZxOfNvLB207Y8lrX0Gb4QhdhJxspxe3+Uzgv+BH903o89i4mYv
         tjUiovCG9jeVhVk91WrSsM9cJY6OSiNsqdwXlVFSLycSym36q+XJQ5DmTtmyUMVpp1n6
         wUHQ==
X-Gm-Message-State: AC+VfDxJWKLNIBrm0MmHdyqAGRMBehJNlMzcznmjwfxhUnQgBoOdnzGD
        UhkpRQqz8eVEJv3cEHhF+T6X9w==
X-Google-Smtp-Source: ACHHUZ5eT/yLKuBw7lyPul0yOBAU16GffGoYtPQSCuYctg0rT+nPjTK4uZ1zYU0+e6lf8Mhaw7vJ0g==
X-Received: by 2002:a19:5519:0:b0:4b5:9b8f:cc82 with SMTP id n25-20020a195519000000b004b59b8fcc82mr1643764lfe.0.1683187308135;
        Thu, 04 May 2023 01:01:48 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004edc512515fsm917165lfi.47.2023.05.04.01.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:01:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 04 May 2023 10:01:10 +0200
Subject: [PATCH v2 14/18] media: venus: hfi_platform: Check vpu_version
 instead of device compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v2-14-d95d14949c79@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683187284; l=950;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=q/vSdQIzdh7d45tOHVzWO20BSTczLeC5udvlzu3X2PM=;
 b=2XRbyAXvi8yZVch7RQ9IDxIiFk8izKf5ejhV1HJZ+scF3YCqriEQ0bIj3aMQMnb2R0lu7C+KX
 FNkVJTKF+NlB3iPKzkwdgzEYx/lreDn1whr4WieHhDnVI39tiNpO/nd
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

This is not a matter of the host SoC, but the VPU chip in Venus. Fix it.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_platform.c b/drivers/media/platform/qcom/venus/hfi_platform.c
index f07f554bc5fe..d163d5b0e6b7 100644
--- a/drivers/media/platform/qcom/venus/hfi_platform.c
+++ b/drivers/media/platform/qcom/venus/hfi_platform.c
@@ -80,7 +80,7 @@ hfi_platform_get_codecs(struct venus_core *core, u32 *enc_codecs, u32 *dec_codec
 	if (plat->codecs)
 		plat->codecs(enc_codecs, dec_codecs, count);
 
-	if (of_device_is_compatible(core->dev->of_node, "qcom,sc7280-venus")) {
+	if (IS_IRIS2_1(core)) {
 		*enc_codecs &= ~HFI_VIDEO_CODEC_VP8;
 		*dec_codecs &= ~HFI_VIDEO_CODEC_VP8;
 	}

-- 
2.40.1

