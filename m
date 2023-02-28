Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A7E6A5BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjB1PZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjB1PZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:25:24 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878D730E8D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:56 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f41so13646774lfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677597895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mv+5dN06QajiFNtKq3cylP0qYElk+b0EFltGbtCWW5s=;
        b=KLqV2kBPxpqQedLLP2jyVH3dv78B+IiH2UApRHAUkV6hehtDudrXUtxm8t7KBLwV/S
         JrT4Ua/HFFKaXd4XObOSCVdRFZTO1uRpw9yHezvZomea882YUXrYb6FytSllzRIVCGRH
         2ieI6yRUz/4xVuD9yyQ65jQ1yTO40+KBj7mQsh0MMWEI8zWW7fPy1Ec+MbZ3HpGY1Jmu
         n67+NSUzlPoRvkyozoDJSPfA3mxTIdxDB2RCxT5y9NkIEhgP4CHI0NGRRzYe/wer8wgV
         Qv8xFXApmHJ1BUARK91jPZJnmnAkJa9OCOEiAOKZJUR8UWYK6Pax2/HQrzvkleBYiU1g
         KTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677597895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv+5dN06QajiFNtKq3cylP0qYElk+b0EFltGbtCWW5s=;
        b=BRpG6UUg6wvT0JsLWqzVXqKIL1E6SS3kT2W8UjjmxGukNVFHGrt7gxi0C4ifv67y1u
         k6kIkfmf7mbStwYengRnlCzpXkktZClp22bv9nUfttu7Wi1h1H6N53O1QpRZ7Xh1QIfv
         pTADGgSLEXuqw5sWdpH4BibwSV0o/gmV2O4FMVC18EL130wcykOObUF/zM5BffDDBi6I
         hmh7teG4dK2PwiqP+11EBIhXDWBJEri+S1Btu2WX1nc4+/wGPx9UncEAFPuotaDQGfM/
         YpiiioS6d/Jm2bR1gP8B9Cl/gbhwW7s6dTtwoOwclZMrWUV3/cwWP1VqC1c6U+kgazfG
         nWBQ==
X-Gm-Message-State: AO0yUKUJzJqa09etyB33JR6JOsrGQ5GOtcjxXLxt5nYuxBornymm8X3A
        8vxrNrQBteP9kwqdbxKM0bLCUQ==
X-Google-Smtp-Source: AK7set8V7zZSECX4B4EzCidKb2bc4mpAjprKUNmvbZsREWvIVZfvcp54SeRwDyRFYNl1B7n7ElgSnQ==
X-Received: by 2002:ac2:59c5:0:b0:4b5:6042:d136 with SMTP id x5-20020ac259c5000000b004b56042d136mr918294lfn.22.1677597894820;
        Tue, 28 Feb 2023 07:24:54 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id h17-20020ac250d1000000b004db3aa3c542sm1363688lfm.47.2023.02.28.07.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:24:54 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 16:24:37 +0100
Subject: [PATCH 13/18] media: venus: hfi_platform: Check vpu_version
 instead of device compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v1-13-58c2c88384e9@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677597872; l=890;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3bmF96yM+QeLlPRbGOz/QxxJqjmwlG7of1Yk2fGr9GA=;
 b=jpgQaZLqM13yEMK+h/OFBgzPaEzZbooIJVn7HfPIUyzKP41ZQlz6Xd2WOp+5KcfwsiUhV7XhBk+H
 1O/uvXECBU7gwqicK5TcpgMawKJblW3ZeTIB+4G7OajEe+qtLvM+
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

This is not a matter of the host SoC, but the VPU chip in Venus. Fix it.

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
2.39.2

