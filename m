Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FFC7073D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjEQVPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjEQVO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:14:58 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEE18A67
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:46 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af1551b2a3so4223001fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358086; x=1686950086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCbmXotl4JHp6511qJyB6cem0LHm1+AqjQQ+gB6Kt5k=;
        b=UQjG0/WuV5etiyDEFOP94o2jTjOe5xRhvCKVl73vhfDmGmrmoPKZM9TbL7d2MMqSYm
         wESmm+0FW+v1QpAlutjXMT99Eves69zCtLY7SdsXo5dvFZbkhBuFIOjHDRS5ba6sHGV9
         QJw7yG6oT1jZqx0xZmQSMC0t5j8Muy//u36CzJAAHS+APAwxpKHzmwmoGQS94hRi4XUK
         kLmwRzv3wVB9vlGSmQlRQ1bBQ6w486spfmfYe82it95DiK5rwdv5xx0aYx0+IY5fR5ZS
         7sCchTViFV/BCsoIDiTb0tXxxtNBW4J8qxdnpMnAvqnUwGWSUqKzog1izUwYeLLRJSfv
         j+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358086; x=1686950086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCbmXotl4JHp6511qJyB6cem0LHm1+AqjQQ+gB6Kt5k=;
        b=cbfQlYxrCfYlQRum4CH1OV1ECksfGVkLZFgbypEbeIDYYq/R+cEKBBgaF7WC9moveo
         R49LLPzu3mWDONYfhV4BKHfYcB5hNJKjHHiztYfYzWdvdlYjxm2V2YEFENiXQGQdNIlE
         SpKg6efmVRvsn73JwNmbv57636qbsxZIbck8CiN0CQKrWCRWZ/5EZOvuEktpp8RKjeRS
         B7rhdZUvE7G9QxEF+cf+OPoFTow4IlN+d9q7TMOJeiN/xNDbM5MIC0enLBn/5chtYnSC
         j4WBrDkccJO+XyLbEITDDiS32rZBjELTpkdxiFf70m0Er23wdIhzBe1MYhH8m8eohuYy
         DUAg==
X-Gm-Message-State: AC+VfDzGGOEK2mojdKrj1Ccr+51qQgRfqN2X+iBVY6sJQvS9zihgWzxd
        xflM8bKLNisVPDsHevJhtFDcZw==
X-Google-Smtp-Source: ACHHUZ5rOHGPLn5W5f5+X+lyCQPlcGHnJtwKPUMcFBMVTZmagTmp4w3JjhMcYlHN/hzdlNE5TsvQrw==
X-Received: by 2002:a2e:aa94:0:b0:2ad:90bf:a5a9 with SMTP id bj20-20020a2eaa94000000b002ad90bfa5a9mr1298857ljb.1.1684358085936;
        Wed, 17 May 2023 14:14:45 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8345000000b002ac88e29049sm4781142ljh.43.2023.05.17.14.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:14:45 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 23:14:26 +0200
Subject: [PATCH v3 13/17] media: venus: hfi_platform: Check vpu_version
 instead of device compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v3-13-6092ae43b58f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358064; l=1007;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=EUWf2T+I6vhFizSQGtxC124WvawcGCVn6gQZEf/m3uU=;
 b=UpdjgwgmzcU1sXtNPOGiLxsGyZkEb7Yb3IUpfGrtlJyrVgA12baH+lL/rASjTNvM2lvrLsbPS
 gxBq5TpxWgaAioFlLIcq6de3Jo54QZn9Zh1W3oWvMKGdDIkEhzA1UV8
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

This is not a matter of the host SoC, but the VPU chip in Venus. Fix it.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
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

