Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356686F66A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjEDICp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjEDIB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:01:56 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14194493
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:01:46 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8baeac4d1so2020101fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187305; x=1685779305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaTET6I6Chlike4b1aelQ66mWsgrpXX+pZVYbCKm7nw=;
        b=YUgFU5sMXvCPA0Ws9/d+bhPa1YbJkUH0i8oeUrxAlICS2e6hha231etQK99tXZ7C6y
         1wQOufMin6XZWyJ4SmIeqXz9CEYqi/B4oBNrX+t4D4rK7zHSBDa/TAc2mAX2PkcRt6CG
         NBYBvYL0c8dJOHT+WW2qdYP+HopoexNr/801YMuOqESa+r6YIAwaeq/NWn0e3MgGIhbT
         vpYKjwoZmg8JaSZ2zREkFT3vhsMRRRuK82ApY+RTZh+uWxVpvMP38HaqY9u39eLEDfnx
         mxSKkxpzn7y7HCtV0Ea+HHayugaTyi1mmr4ARrv3PMKlsDD2NMlUTDqyJwvNVqbmhOGM
         Ne3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187305; x=1685779305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaTET6I6Chlike4b1aelQ66mWsgrpXX+pZVYbCKm7nw=;
        b=fKUorotmsatiEDVe3Sq+9OYEonHAqPJ0xEo53VMyCa9eTzgwp1Pk7ACPcM5mvor/2Z
         1MPEy1557KsaC+I2lFCvvHgUogks+ZPCjoBv/4daDtEMQBbgPiAQLY5s4pPb9BJd1mle
         /87Wgu19x4NHxDn5TNKzCMIM1/Ta8oHwi4tYb1Muh6xdIAcfyB+glD1ZYvGJf6W3L/uQ
         P6+kIRzAJYYdTKQLW/okGcY9Tu+SIG55fRIaO7akKTrGlBZVQyA4vbuBBkG0DuiEwBxZ
         DeCiRbaN6Qek1eD2Ig9KUvwxIM80UkHy+Zl2JLysXyW1X9YunmfyeSicPHIXTrTYxcwh
         Thog==
X-Gm-Message-State: AC+VfDyYjsq76L2GtRp8+YVqDMMW9DgvD2MskR2DYPhuq2hWPt5m5a/W
        Gb3I4oiaFNromK58d7eloYUqLw==
X-Google-Smtp-Source: ACHHUZ50XmpCPgmWw0NN363CZF8Fbn3moQBl4zNyY9vkMb9MSB3Uxn+XAignsD/uR7rsAj/Wwr7geQ==
X-Received: by 2002:a05:651c:1204:b0:295:b0cd:517 with SMTP id i4-20020a05651c120400b00295b0cd0517mr681510lja.35.1683187305068;
        Thu, 04 May 2023 01:01:45 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004edc512515fsm917165lfi.47.2023.05.04.01.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:01:44 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 04 May 2023 10:01:08 +0200
Subject: [PATCH v2 12/18] media: venus: hfi_venus: Fix version check in
 venus_cpu_idle_and_pc_ready()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v2-12-d95d14949c79@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683187284; l=1021;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=8zfWzMcpL3GpjtgMJa9NGDyn8/IKM9ZLPIj9iHUztqo=;
 b=oFPFCaIJsqshA/+ulg13SPuJfH68My4z6Enu3TNb8ypHKqyJhbkqVR7VRJa7c+3w1rySeeTQn
 TYp4Kfb69uWC8eOaxksAA9M9XnAzNY+Mewc+9UayiCSweTSuwLlyJ2R
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

IS_V6() should have instead checked for specific VPU versions. Fix it.

Fixes: e396e75fc254 ("media: venus: hfi: Read WRAPPER_TZ_CPU_STATUS_V6 on 6xx")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 82aa7deeafa1..d6df99a921bb 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1557,7 +1557,7 @@ static bool venus_cpu_idle_and_pc_ready(struct venus_hfi_device *hdev)
 	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	u32 ctrl_status, cpu_status;
 
-	if (IS_V6(hdev->core))
+	if (IS_AR50_LITE(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
 		cpu_status = readl(wrapper_tz_base + WRAPPER_TZ_CPU_STATUS_V6);
 	else
 		cpu_status = readl(wrapper_base + WRAPPER_CPU_STATUS);

-- 
2.40.1

