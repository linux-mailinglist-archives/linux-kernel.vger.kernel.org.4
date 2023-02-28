Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB506A5BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjB1P0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjB1PZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:25:36 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A679311F4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:25:00 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g17so13713552lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677597896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGxFL4MVhFGQlNfkdvC0F8xmFUE9FZn8c53afBHcPpw=;
        b=Sz1rSd05Z20rHlYSzZ38KwCwlmpPalfs6vDSUJvu85qVs0S3SdHjRnZTdSvG2k0KW9
         XJiuKbJRFxyntrgCrBpPkLDmlrR1GlLORpr0gDIr0DxN8R6vBjWHze6YtZ3DxKgj+L0A
         vwHZDgAb6jSHDCGNvUz4Mv+5VTcnkA57Jx11qRoHYV9ybOMr51AXn5EsAE7WuX1qkV/x
         eQDo7wNcXM8g0YWjjVqlJRWEj3gBvjrAot+pIcZl1Y8fCOYT8iuvNXOMZ+nJ5xmxi3a4
         Hfg7gVf4BhT5e+Ggam3o4e7QhRmW3ag52g5DENCEIQ6fdJMuIHE2XKQq7HzanKzx1+yc
         THDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677597896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGxFL4MVhFGQlNfkdvC0F8xmFUE9FZn8c53afBHcPpw=;
        b=YV9CqRrJNdb5uF3RO2OsJ4kWvQV6TiEpQJXUfgeWGlwcHl5gPnC9hRW+H1QFQ3aXyM
         BpyNtkVfRv0wtDDJbkbXLgGtuHeoeI8Oq0ilp4r385ddEnmLNTx07/J5TD44q8emP3U+
         AlLAybF2V8MwHrbKMfXTpFvnmnRzqLUOcx3RJcfJoWI953uqSghK0w+QKOJ5BHWmEsix
         +N5YmgHNGZyYOan5q3Wh+xJpN+Bb4ew0tIBDAlnCDna2ubJk/lsFSAH4zCHUlBx5ppI4
         mg8wy8L+dyhre3yC7RMjDrSkQUt+rqdTkykHr8Bpq8qyLjJzaCzGOj8Hu+BU3d2qdPky
         7xCA==
X-Gm-Message-State: AO0yUKXHe55Y7e0Y+Tkx8UpEEyYEB2rKbcDEq+zxiBLPng0NGyu971dW
        1K/9bAxOMIGzo4Gm6Rk0kvi0cA==
X-Google-Smtp-Source: AK7set9ExYDRDA5/DRFbFN76ugSfsnisPOu/hE32eU9BnT6XpxnnIIUTVCIuGZwPNA6O4iUVGLcbdg==
X-Received: by 2002:a05:6512:15c:b0:4dd:a633:2ae4 with SMTP id m28-20020a056512015c00b004dda6332ae4mr747452lfo.39.1677597896457;
        Tue, 28 Feb 2023 07:24:56 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id h17-20020ac250d1000000b004db3aa3c542sm1363688lfm.47.2023.02.28.07.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:24:56 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 16:24:38 +0100
Subject: [PATCH 14/18] media: venus: vdec: Fix version check in
 vdec_set_work_route()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v1-14-58c2c88384e9@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677597872; l=889;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=NR98BB9al4sSkxNIa6+yGGigc06GdfYg0LINSGvViP4=;
 b=bq1okqrJvNNOMyG7tqrD1u4NAbhi5TdjqmEpSiH61gAAHn93cFWepoEQeNmUOWEqDPCUA+8apBAS
 o9+CJ0S9Bkl1stfo1KlchiZ070Wsl3ZZ0Mwgq0ubcaCkZLBqbpCN
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

This is not so much V6-dependent as it's IRIS(1|2|2_1). Fix it.

Fixes: 6483a8cbea54 ("media: venus: vdec: set work route to fw")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 4ceaba37e2e5..f55d6cce163c 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -688,7 +688,7 @@ static int vdec_set_work_route(struct venus_inst *inst)
 	u32 ptype = HFI_PROPERTY_PARAM_WORK_ROUTE;
 	struct hfi_video_work_route wr;
 
-	if (!IS_V6(inst->core))
+	if (!(IS_IRIS1(inst->core) || IS_IRIS2(inst->core) || IS_IRIS2_1(inst->core)))
 		return 0;
 
 	wr.video_work_route = inst->core->res->num_vpp_pipes;

-- 
2.39.2

