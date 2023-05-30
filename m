Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497A9715FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjE3McD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjE3Mbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:31:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277CA10A
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:12 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso4616556e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685449849; x=1688041849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyFXYw29tyYHnh7jUZGsXGdVkCfkSlUBmlV0J/bqh7E=;
        b=l29c14kS+E/k9kDpvUSsaoSoMSoOGaa7uEtNOCc+pvtVMZilXyTwYxL5NTdY6zWZGD
         a3++h1FVa8I4pmXyD5vJ/F70mJDQod7U1OafHsF3nDYxXUDEyQ4fTGUVhcsmc4VDti+p
         kHi14Enek42nmcHLBjqtIB//pkcSBxOq6mxj+Z9z+xi+UxpPucYbZ7NndkqKhkuCvWUr
         60u1xBd81TW/eaugYEDzz7Hb1lIWXCgaoSGzufyP0B9Bkol8NRq6hGzaWNCuHIo5u3p4
         ct1QRaR6STzNw/IU2XwUghEQ/FWOI0rxrS1GGqNSGwpwLXnpcdTc8tkDenE5kk1KsMKx
         xZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449849; x=1688041849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyFXYw29tyYHnh7jUZGsXGdVkCfkSlUBmlV0J/bqh7E=;
        b=MC3UkYspxTlIa7RmDhVCa9Y3Ca/Md2Cs8VOIuGi8oAeCBHTnXqV0cZK0wfyjX8g1iJ
         dj8+yZncElIf6lqNkJ2UzWqL42oJ5NAD0YJb0AOr0P09uAKjD74PIayG0kcz7QhckR2e
         /tecrTArRx5OZaWBX+wRCglpmfju4RPzpKmZe4HVDUeiEoXO59AaOu4n8A5NBNmyrrXp
         a6yABaaBZRiD+CLt2yxGxJ0Y6l4zTBLLI10THHwhaaet1YxLr2Ejh5+MwSyKL+h4f3Wr
         HbQhb/vTm0il6Jvy+nDX8upINxM+OBRzwprtOC7s6cn/xclhwaiJi31bcMQrifd/OQRD
         rdfg==
X-Gm-Message-State: AC+VfDzk7gApOMxEXaTwPGLex/2jYxGq5nuk+cq0fXsn/WDRqnAZWNcA
        6JbDei5q5R2FTncwPtwvl5iYHQ==
X-Google-Smtp-Source: ACHHUZ5H96w3r5Nr2GfN0aIY1qXkTny4w+kmfV2bIoO0UXxr+zVKEk9g699+0IR+//wfrCJPNLY7Qw==
X-Received: by 2002:a2e:740e:0:b0:2ae:df5a:9637 with SMTP id p14-20020a2e740e000000b002aedf5a9637mr674229ljc.21.1685449848871;
        Tue, 30 May 2023 05:30:48 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id u18-20020a2e91d2000000b002a8b8baf542sm2854814ljg.126.2023.05.30.05.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:30:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 14:30:41 +0200
Subject: [PATCH v4 07/17] media: venus: core: Assign registers based on VPU
 version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v4-7-feebb2f6e9b8@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685449837; l=911;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jLkMwNqqG57kt4LLfCZOGle80CsutpLNKoM94v0Cd64=;
 b=ZadOsG66UgcLTo3X0cHb8UNZN5x0jCBfFaACQBzQpgsBcyGqvCeZtjHcxSxETIaI+Lhv5p3CH
 vQu9zy0kwbxBgxO1KQD0iLji/JjndvQ/N3nj87i+3d3AMHD4I1T6NlN
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

The current assumption of IS_V6 is overgeneralized. Adjust the logic
to take the VPU hardware version into account.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 01671dd23888..69c77b2137cc 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -246,7 +246,7 @@ static int venus_enumerate_codecs(struct venus_core *core, u32 type)
 
 static void venus_assign_register_offsets(struct venus_core *core)
 {
-	if (IS_V6(core)) {
+	if (IS_IRIS2(core) || IS_IRIS2_1(core)) {
 		core->vbif_base = core->base + VBIF_BASE;
 		core->cpu_base = core->base + CPU_BASE_V6;
 		core->cpu_cs_base = core->base + CPU_CS_BASE_V6;

-- 
2.40.1

