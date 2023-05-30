Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99828715FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjE3Mcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjE3McW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:32:22 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257EFE7D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:46 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af20198f20so45020901fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685449858; x=1688041858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCbmXotl4JHp6511qJyB6cem0LHm1+AqjQQ+gB6Kt5k=;
        b=SCYl3pwqYVglWX8Xi1vf6uiEsmGVPsuG8y5duX0ElHDXSNbjgyK40To93hnzuzqt1h
         QlrbquLEwsBRqv/zM2IcLd4ouCkstm6p5oTwH+sEwVxK1c1vFQF8CRBVAgNGeiY7yyo9
         YUKh1eAcS8qF618AYUauKFWz1se69Hro5WClNfF3f+e71/AZPsS/KyJDo2zeG6QRawBp
         TGmyj6dNJYnm4WwFxz7EDT7wb8zafEoP3tjKaq0Yz1hUKQ23Gq30j6V4KOtbOQgY+Xeb
         ocZno5DSYZ7jF+A2UNh2kwcdgSY6eLCbwsiTVlnOGc+wKuvsf1mAsNRTrzDd3dwmqtiM
         +0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449858; x=1688041858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCbmXotl4JHp6511qJyB6cem0LHm1+AqjQQ+gB6Kt5k=;
        b=bypuN2B1fetTHngv3W4sAdGAqx3fQODUzaEIUCauHh6O7u3P6//pb2ThXlP03ds3S/
         UwgIZebpFxEfCQyEmM1R1IJcud3WWWHbatzdcM9ZVVdaYNkXNK3Ee2/qDI+MKMrW9fqq
         kIv25OsUaG2Bq/wbaEi1D5GsHcjuVVgCnVUOrYbttWVHE+3+265CO+/rR1IgMh++4wSR
         nrTw6dDXmqhfEwBOGvmyQGUdYFLG+XvWAwVkWvf6llL/MOa8a9v0SN/WBuoW9kWJ5CE4
         d/wvWx6OYjTN3rtrXLqlWSbzrMCHaAtheyt1ZZusryBXVtPM6GYP4PpghGscWiKjEwOo
         qy3A==
X-Gm-Message-State: AC+VfDzwuETAXYyR3JRNMqYD8iojX6YYS7aDf0NO6TsNP8aPTLD1Ra03
        nl7FpykZob91aSNPSCKdaBgrLQ==
X-Google-Smtp-Source: ACHHUZ5QYGxZY7HU/diHNzd2HbY7SLguWgH6WN/zU7FGqFLt9FIqhJWue63p2k72hbAbG5qsjbEjFQ==
X-Received: by 2002:a2e:98c7:0:b0:2af:23fe:98ef with SMTP id s7-20020a2e98c7000000b002af23fe98efmr657276ljj.50.1685449857841;
        Tue, 30 May 2023 05:30:57 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id u18-20020a2e91d2000000b002a8b8baf542sm2854814ljg.126.2023.05.30.05.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:30:57 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 14:30:47 +0200
Subject: [PATCH v4 13/17] media: venus: hfi_platform: Check vpu_version
 instead of device compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v4-13-feebb2f6e9b8@linaro.org>
References: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
In-Reply-To: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685449837; l=1007;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=EUWf2T+I6vhFizSQGtxC124WvawcGCVn6gQZEf/m3uU=;
 b=yQW+ZmcZHz0nTsrcuohrVTl7N3UqRQ2dZPoS6Vn/18F3I0gbau/J1nJ4vwL7mmALeRZAAbw8X
 mBO38SlEvptC2xIm1JDuMfvGDzU4kZDGulCD008OT+2p3bGD79hL4L8
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

