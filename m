Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59D46F66AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEDIC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjEDICF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:02:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0091540C9
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:01:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f13a72ff53so185555e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187309; x=1685779309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gmh3QMl0vM3P+SsAKhPqtUWQqJrL9cfiujmVg23UbYw=;
        b=tXlmsu808ieo/MGeji0bU10a8QIdPqAsymprNBulh1El7cx84cOhNh+M/wUBcO8KnT
         tgJi8KDmLNuq5m49YoWoaW7TzrFb1XrmdLXYkIys4YBQWz45rI1KpdTambR8kZpjcWeh
         f0LuZ3ieNhWDp9tBPMBHHNFoqwg6nSKbAqEFa9dp2Z4cfKUwCxGYfwn33hkPrWEzBub8
         TrkuzuBBsPS/+jm66s0VRJwa0G9zcZbhuzCbMzOgD+OcQviMFUOZdASoofLt4wrs9lty
         6zRMU6frGxt7cx/a4d6ISe/FZJDy4dhDE30a95yX35gM3wwN9lsRP54Y1Ry2rkTnrVnK
         /v3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187309; x=1685779309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gmh3QMl0vM3P+SsAKhPqtUWQqJrL9cfiujmVg23UbYw=;
        b=Gg5yKI0gOdYPNQ4C3yaWTIpnOJ64DFxTE1+G9ho2DHNJsoWcLf/7cCAH1qY1lkqFpT
         /m4w/WNAkU7Kz+mR6a0UG5NCD7MUtny5WyJsW031BrcF70tbtDD5v7AW/sU95+xkaFod
         V54EznHeRGhoj9xGA3WMJg+WI0v8P3Paja77WCIOcU8F1yjrrEkiOzpYQB7FyYpQnNz8
         4KiOp+fEO9K9blTpIaT+lXavuElI3jxM7H7c+pgaA94wFm/C8ZwZs5lpPK7p0PAjOz+l
         6r14s2QljpoVr0ND3ZWOQChhdMH7VtZi/QFPd9zj4nfOSKGNKGb7qLODpRZB6QDZ+s4q
         QQFw==
X-Gm-Message-State: AC+VfDycbuTYzgP8w1ckZ2N8y8HuhyPIgYxyDMA38U7aBxZctVoT0Gvh
        esM2f4guayYFmGjIL/7wRwplsA==
X-Google-Smtp-Source: ACHHUZ5oRM5V+EZh6kIq/2iypM6QV6wWqlFyeOuwbRRdSSu7IrQSyRLY9R82pvILzPj64vExzyLYsQ==
X-Received: by 2002:ac2:599c:0:b0:4ef:f630:5c1e with SMTP id w28-20020ac2599c000000b004eff6305c1emr1417050lfn.51.1683187309645;
        Thu, 04 May 2023 01:01:49 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004edc512515fsm917165lfi.47.2023.05.04.01.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:01:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 04 May 2023 10:01:11 +0200
Subject: [PATCH v2 15/18] media: venus: vdec: Fix version check in
 vdec_set_work_route()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v2-15-d95d14949c79@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683187284; l=949;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=V/UGltlLWzlzUZNyrcqVl2X6sG5k2nSoHaxfv6KAids=;
 b=WtOwVMLsPygfuOE/M19QhQt6sE2ZYkfB4FjsG/HcddOYKMC+fTHbC05xXxHT4EpQlkl7qsff0
 mjhayIDddOHAfsOiuUNXMgf4oIyAFjkAM36KmNnSsRI+iWP23l3jHIc
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

This is not so much V6-dependent as it's IRIS(1|2|2_1). Fix it.

Fixes: 6483a8cbea54 ("media: venus: vdec: set work route to fw")
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 51a53bf82bd3..33e3f7208b1a 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -701,7 +701,7 @@ static int vdec_set_work_route(struct venus_inst *inst)
 	u32 ptype = HFI_PROPERTY_PARAM_WORK_ROUTE;
 	struct hfi_video_work_route wr;
 
-	if (!IS_V6(inst->core))
+	if (!(IS_IRIS1(inst->core) || IS_IRIS2(inst->core) || IS_IRIS2_1(inst->core)))
 		return 0;
 
 	wr.video_work_route = inst->core->res->num_vpp_pipes;

-- 
2.40.1

