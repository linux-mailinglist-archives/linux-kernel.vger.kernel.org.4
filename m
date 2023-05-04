Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A836F66AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjEDICs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjEDIB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:01:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A2D4219
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:01:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4efec123b28so181110e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187306; x=1685779306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWMwiYoEjocS38Czi4DBdZu7qtny70oMkcbZd0u1Q7A=;
        b=Ulrq4+bRHU42xZ5xWNyBgbPoQtU9Jr7O1eLonanrs0bAeTTcaT3ZcduwdqxBU6pCmh
         r+GZPzQxqLVLgV+tlA05Yq7g1t72HeYB3zlVJXVMsZmEXDtMYgQPON0bDXUg+fgitHYH
         n0m6pwMQ1ULiMGXiHFM+OHWS3xAGPO52sIwDuk+wKseXt3pCkQ3bYxSIc3/BNN1F6TWV
         pWLz+RdzKs6bUbvt/L4j7zyIxmfLnQudDIvQXkJgxXHcUTurPqUYNCcRsT1zsuDzrYyJ
         EZsPB6jCfruYWV1TAQ//OJUk8trbQyOkSUSPY2IAwM9duRY9GsFP6i+9wq+qfjJ9lvU8
         UZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187306; x=1685779306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWMwiYoEjocS38Czi4DBdZu7qtny70oMkcbZd0u1Q7A=;
        b=ktCTzDOfR0yYf6XnXycvauYlLaCeknciC3nrUmTZ1qtwNIwkQvMsaYoc9Cdytz50Dv
         +/LX32C6QO07Bld/mpKszMfy+W2Tjt8dz0NdBxtbpHIDd62eBm/iLfaTI5yFWBBVpr//
         uWpUd2sd1UNuJajkusX4E+7B/+9GforAZLG/vOQU0wV2rZ/dBKCP0DJhIh5lb91LXWii
         AOspehR4EbONjRdzWQSQQHRGnn9rJvarWus9eJlPqpHEToM+B9h4OhMHYmfUjKT5T5ct
         Sdhm58amKR1hKFgtdTt+eouSmFd4DRwa9YSm41ZVjrJD0KgcKOUQcGCAbYPYEmnPy7MH
         X1Gg==
X-Gm-Message-State: AC+VfDzKccY28VjVAcoKzitidBib3bfMtok3adxIM2UBOrdH2/5Ky7Fu
        9o61cZAHKmU9dLxnz682fGQwVwdnEzTRusiLmHo=
X-Google-Smtp-Source: ACHHUZ51783nMZCbYi7BiWPyUdDB7S9A+1nMYD01cPyM1zmmgpx/RDMOaROcZNXnTzsk4h1aNeEtdw==
X-Received: by 2002:ac2:4186:0:b0:4ea:5902:5af1 with SMTP id z6-20020ac24186000000b004ea59025af1mr1903379lfh.52.1683187306627;
        Thu, 04 May 2023 01:01:46 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004edc512515fsm917165lfi.47.2023.05.04.01.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:01:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 04 May 2023 10:01:09 +0200
Subject: [PATCH v2 13/18] media: venus: firmware: Correct IS_V6() checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v2-13-d95d14949c79@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683187284; l=2319;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6xrIXn1LM019O5ggn7yfRmQJ+yV2jlf4XGTfINFwf1M=;
 b=V0SoVnzgNLdbrnRmf+7uzFU8FSG3h5A82T8szAjDOwZtTkDZWL3SnCOsHqqpe1pdqvxw/VOI4
 IGFUOTtJi1gA0jJqzHp/CBmCB0ydAo07vLNgIrHCPexJtNyVXZcspRA
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

Most of these checks should have checked for TZ presence (or well,
absence), as we shouldn't really be doing things that the black box
does for us on non-CrOS platforms.

The IS_V6() check in venus_shutdown_no_tz() should have checked
whether the core version is IRIS2_1 (so, SC7280). Fix that.

Fixes: afeae6ef0780 ("media: venus: firmware: enable no tz fw loading for sc7280")
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/firmware.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index a4cd919e1dbe..be59f2017155 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -29,7 +29,11 @@ static void venus_reset_cpu(struct venus_core *core)
 	u32 fw_size = core->fw.mapped_mem_size;
 	void __iomem *wrapper_base;
 
-	if (IS_V6(core))
+	/*
+	 * When there's no Qualcomm TZ (like on Chromebooks), the OS is
+	 * responsible for bringing up the hardware instead.
+	 */
+	if (!core->use_tz)
 		wrapper_base = core->wrapper_tz_base;
 	else
 		wrapper_base = core->wrapper_base;
@@ -41,7 +45,7 @@ static void venus_reset_cpu(struct venus_core *core)
 	writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
 	writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
 
-	if (IS_V6(core)) {
+	if (!core->use_tz) {
 		/* Bring XTSS out of reset */
 		writel(0, wrapper_base + WRAPPER_TZ_XTSS_SW_RESET);
 	} else {
@@ -67,7 +71,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
 	if (resume) {
 		venus_reset_cpu(core);
 	} else {
-		if (IS_V6(core))
+		if (!core->use_tz)
 			writel(WRAPPER_XTSS_SW_RESET_BIT,
 			       core->wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
 		else
@@ -179,7 +183,7 @@ static int venus_shutdown_no_tz(struct venus_core *core)
 	void __iomem *wrapper_base = core->wrapper_base;
 	void __iomem *wrapper_tz_base = core->wrapper_tz_base;
 
-	if (IS_V6(core)) {
+	if (IS_IRIS2_1(core)) {
 		/* Assert the reset to XTSS */
 		reg = readl(wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
 		reg |= WRAPPER_XTSS_SW_RESET_BIT;

-- 
2.40.1

