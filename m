Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8806A5BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjB1PZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjB1PYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:24:53 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949FF30E8C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:47 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id k14so13675216lfj.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677597887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfXCDnSGYPCMSV9KjGFpz0bE/u8I9Ovc8VZm+qsFkfI=;
        b=Q6oE6tw9A5p6GgBxquD0kIGwuwm6O4I/lh0LBv3v+d24PbHvCqA1EpI4+VmTDZyh/w
         WySG95QOp5/siDHdL+d0YJGVBDR++d52SmB+gITzSpvCyPyZdEopn1Ku8h35PsUd9OFW
         RxlLUJsw+WoLePiODBj+L5NXJ/KoJcgbNpFqtXyfve+NhTj/3JChLMKF76dXCkp+9+0c
         srl1OyYSjsXAZ+9Q5bCGujYKhdZbFGEWa/k8EC+vT5po6urdYMualTO21dnjExEzLK1e
         NVMaKm55nqziA+Gs0Bur4EfcBnjODJ/Ezzd6gOPLmKyrPdq9k80iVyVdIvrw98VzrmB+
         U8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677597887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfXCDnSGYPCMSV9KjGFpz0bE/u8I9Ovc8VZm+qsFkfI=;
        b=Zf6Iy9f8qD6tlvjHq8cag8DmFnsTFLWiyfX3Z9zwvIbbCyRYBmzZ6t3Qdx72Ip8eys
         jeLh7KIBwg8hX8EwwV6O4L985BikstqpuBjpJFPHFM9qfsOMiGmyQYWuZ0Xbi7jUM1+t
         CAq4xWeKP/nuU9jtoJ5Mt++uZelf7TzBjlKN5Ldufc+L9RnaXJ0GUh1hqXlddAwWprFg
         ysK5f0cl7fa15pAOfcZdEeIlZxacf2rMRm/yvcPWB7ATFj0mt/LouXpK1IjfwDS35P2f
         J7aZN75q3v+MJk4WTCCIxeKpGWgJxArpMTDpnRjP7oJ48p8MYXuXFLrPU8i4j7tB3Iex
         if5Q==
X-Gm-Message-State: AO0yUKVBkIkEt4q+HGAJyCEGjmrfxRrhspUu+dudCU8uMYCQPS4UK9Xe
        tKivFIhLnHV3sNXWLbNnxPfUKQ==
X-Google-Smtp-Source: AK7set/RWrkF30CJYtmVxOARcAfI8MHJoux1IqIAE9xsQO1Ls7jT4+jOPVXNQHaN613N+SuC/shyeg==
X-Received: by 2002:ac2:52af:0:b0:4da:f436:d423 with SMTP id r15-20020ac252af000000b004daf436d423mr752939lfm.21.1677597887017;
        Tue, 28 Feb 2023 07:24:47 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id h17-20020ac250d1000000b004db3aa3c542sm1363688lfm.47.2023.02.28.07.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:24:46 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 16:24:32 +0100
Subject: [PATCH 08/18] media: venus: hfi_venus: Fix version checks in
 venus_halt_axi()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v1-8-58c2c88384e9@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677597872; l=1179;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vcJCyKKGC7W2leXuwnA0vfyXrDyJXcgxDMnLgbkLNUQ=;
 b=s9z0ihnhSdd53PCcE7vAgn1D8+UghQlKIAvON5ygD8Wwgjm4G2pXiVypjRpWXierXW9LevxoYJJi
 XBCfNQAxCUGjXBX/3Agz/jqF8gVvKtcrGF+/CoWqjcK2UE+cIKBr
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 4d785e53aa0b..0d137e070407 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -550,10 +550,10 @@ static int venus_halt_axi(struct venus_hfi_device *hdev)
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
2.39.2

