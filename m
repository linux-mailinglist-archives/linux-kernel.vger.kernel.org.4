Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BAB7073D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjEQVP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjEQVPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:15:02 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE627A99
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ad714536cfso13608581fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358087; x=1686950087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDGFzpmpMzEfdx1VC1Hii8Q1Q5+BqfzALqEO/TlStp0=;
        b=RVDZ3hYucDHtriDtggZ7B/vQ1NH6HgaCqdG8RdKUXujWODZJ7mMM41N1No5HaHDh45
         6qnmqn+wibkOhyW6DJ2JUwKKcWwwkFQ00z6hk/AcpYVqDwnIcLBMPmxiUZPfm4o3Vgml
         J0NuUg0XFLPDwSpniYqpT/22Qj04euCFqdwqiiXfsoQIhwo5DXcGTNCsmYsSTZJdbV4e
         8HWneU6OqoaxDRMK7x24HF5OkZfz0totOmbFvMRSziNUEVGgHDZ55rLJRY33Ydiy2zGF
         XVTyfximvcH1+rQiFL9hmN6Tm+yv3OuFF+i1s+0oTzFlsaTL9i0E11bDTeQgK5ZCYfFu
         C8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358087; x=1686950087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDGFzpmpMzEfdx1VC1Hii8Q1Q5+BqfzALqEO/TlStp0=;
        b=aEkI7GMzMXobFcbH+gtjwGgIdI+TL/KLItDJGiOkDeUFwHvzeI0MoK/DlFisb/JMOE
         dzFoCVtxmlRndON07PxaxhX7VHFCxKW24wDG5DhHMXUI1QA5SzOcetaISC8Js7fUs5jC
         uqkwERQFPpHhNNuyPWCg9wtLfhukaxE61FagXA/k5Zvu/WhlIwESNTi5CkJ7EEnUIByi
         zvGm9IbKHNzR+z2qok75pFUeqddyOV5XukucEsra3pax+cvsImVMgXDwut8KCP4VQrTG
         +CPZ9ou0+fFhuOb7EljVTTrP37a2o7eDsGSB57cahl89fPmMGOpxOOPCJGo1RUZuArOw
         GEvQ==
X-Gm-Message-State: AC+VfDxQh1xkqY1ae4BBJZ/28Ts0ZWxsKSibWDwXgIHED6SkSvgFQmC1
        ywVyC8tgGfOoNEcwEe+t8bsStA==
X-Google-Smtp-Source: ACHHUZ6k21x2x6MNJETwjbepZirGO9oOGF82ibWO4x17Az088t+bnqa57caBVPNtXX2C6R2s7DrG3w==
X-Received: by 2002:a2e:8513:0:b0:2af:3f7:53fe with SMTP id j19-20020a2e8513000000b002af03f753femr1564839lji.50.1684358087507;
        Wed, 17 May 2023 14:14:47 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8345000000b002ac88e29049sm4781142ljh.43.2023.05.17.14.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:14:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 23:14:27 +0200
Subject: [PATCH v3 14/17] media: venus: vdec: Sanitize
 vdec_set_work_route() per-VPU-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v3-14-6092ae43b58f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358064; l=867;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=APaBO7FviqfKlqEiE3ehDGGYRc2ypqRE0QzbhTatWLQ=;
 b=MHxc67Qgwqs4bXALR1ab343Uesn0bN5RPPf+MTD3Ca1Bh3j1c0Onb/wdqus87N3lmoUWNgU71
 CU860m4dWsGBVNaPPV8hW/bzYr3xoObI4Jj5jM6x7oaTHZnsy5Ee3Ba
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

Replace the general IS_V6 checks with more specific VPU version checks.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 51a53bf82bd3..b880e290a62f 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -701,7 +701,7 @@ static int vdec_set_work_route(struct venus_inst *inst)
 	u32 ptype = HFI_PROPERTY_PARAM_WORK_ROUTE;
 	struct hfi_video_work_route wr;
 
-	if (!IS_V6(inst->core))
+	if (!(IS_IRIS2(inst->core) || IS_IRIS2_1(inst->core)))
 		return 0;
 
 	wr.video_work_route = inst->core->res->num_vpp_pipes;

-- 
2.40.1

