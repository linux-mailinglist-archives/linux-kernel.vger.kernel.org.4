Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792187073A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjEQVOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEQVOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:14:30 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EDF6E8C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:29 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af0eb50b4aso8192751fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358067; x=1686950067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=708w9bx/Wu04zRxH+k1/smuWapQNc4JobQVr0bsQL/8=;
        b=njSbkiKckHvpb8hxV2jEL9KYhmW8/M9Dc0FacwUqGf+iDgCcPUND+pZCz+NmPPi7gE
         mZ2r+XLte/5R23qH9/yEvoO+Y6L+MNXETRxxo1FwRhWyReb+pDcJp1nmaYI14Q8HdDkb
         IQyuUyC4oXuOxxHtPbS4NASX03PRymCtcg8qxQNpxCIQVS5Fb2kR2DoHfWKjSZ8SQ6Wx
         4s5tTuOvyqb0F6/4ETJRhawi1axjT67op04vw+xJpCNN+8hFgBvDExxQLXQ3kXunFbZl
         iQO1ak07ZJhOGMOQzpM3rFwXpjqP6vskRAa/yxZtAUXubno2TpK7zHDn+HlWcPHcqfhs
         YjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358067; x=1686950067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=708w9bx/Wu04zRxH+k1/smuWapQNc4JobQVr0bsQL/8=;
        b=OMqZzIwAt3P3nNcDxVdu0z/rlUO69pHYV7iacUk2AzjelqR1fIGWQnylpvML4Pjg5r
         WQU6mASZBwDrCVYf3P2nZaQ6tP3KqT6XekY0ZLeKIwUQ133FeCAYLwIMKp0ZpB1V0QNR
         Dn+aEArwqAJ9uYozPNDABN5MG/cw+96yaxjASb4FCl5HtjX9EMQzkkhxSpiW5d+v5arC
         7rR6Ngy7EygWX8NL9Y30JZcPuNC5/58wVv8THvnFGUKsi/nCnq5rXIc24qkxpZei9zOq
         yRz5YKQQ0Ty3c1YCr8qRD/3UFh3C6O0qPPqAHZnZbws8FADhX2MZ5AGURaAfo6iHZJ6u
         ZvIQ==
X-Gm-Message-State: AC+VfDz8f2amHj3D4paZoCoL7AvtReKaIOUwb5DcrLWHK5QcJ8S52+jl
        SsJ8wSpBS3vzAs16IPkf2zaZzg==
X-Google-Smtp-Source: ACHHUZ49UNq5CYUI/Rar5KqRX27VOcT7F9KMudjoLsPkGbSCIAYNUFyaXTJD7elmBmv9HHx1wAaTOw==
X-Received: by 2002:a2e:730e:0:b0:2ac:78d5:fd60 with SMTP id o14-20020a2e730e000000b002ac78d5fd60mr8971440ljc.9.1684358067391;
        Wed, 17 May 2023 14:14:27 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8345000000b002ac88e29049sm4781142ljh.43.2023.05.17.14.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:14:27 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 23:14:14 +0200
Subject: [PATCH v3 01/17] media: venus: hfi_venus: Only consider
 sys_idle_indicator on V1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v3-1-6092ae43b58f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358064; l=2458;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=LQtQ1yE07Bg59BEEMI3NIlj9dkGtgWhznhuEDogV/mw=;
 b=8bZZHS52TCNJujUVtOO26n+dBvbX9Q52dRMUi3DdTuy7raShvuSA/0FuFA/vdkyw+HZM/pYvz
 udKWg8qKprNCe1IBZwGRwGRdXExmnnQ97r6TrzyaT31sVbvPOyKI2Gh
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

As per information from Qualcomm [1], this property is not really
supported beyond msm8916 (HFI V1) and some newer HFI versions really
dislike receiving it, going as far as crashing the device.

Only consider toggling it (via the module option) on HFIV1.
While at it, get rid of the global static variable (which defaulted
to zero) which was never explicitly assigned to for V1.

Note: [1] is a reply to the actual message in question, as lore did not
properly receive some of the emails..

[1] https://lore.kernel.org/lkml/955cd520-3881-0c22-d818-13fe9a47e124@linaro.org/
Fixes: 7ed9e0b3393c ("media: venus: hfi, vdec: v6 Add IS_V6() to existing IS_V4() if locations")
Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 2ad40b3945b0..bff435abd59b 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -131,7 +131,6 @@ struct venus_hfi_device {
 
 static bool venus_pkt_debug;
 int venus_fw_debug = HFI_DEBUG_MSG_ERROR | HFI_DEBUG_MSG_FATAL;
-static bool venus_sys_idle_indicator;
 static bool venus_fw_low_power_mode = true;
 static int venus_hw_rsp_timeout = 1000;
 static bool venus_fw_coverage;
@@ -947,17 +946,12 @@ static int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
 	if (ret)
 		dev_warn(dev, "setting fw debug msg ON failed (%d)\n", ret);
 
-	/*
-	 * Idle indicator is disabled by default on some 4xx firmware versions,
-	 * enable it explicitly in order to make suspend functional by checking
-	 * WFI (wait-for-interrupt) bit.
-	 */
-	if (IS_V4(hdev->core) || IS_V6(hdev->core))
-		venus_sys_idle_indicator = true;
-
-	ret = venus_sys_set_idle_message(hdev, venus_sys_idle_indicator);
-	if (ret)
-		dev_warn(dev, "setting idle response ON failed (%d)\n", ret);
+	/* HFI_PROPERTY_SYS_IDLE_INDICATOR is not supported beyond 8916 (HFI V1) */
+	if (IS_V1(hdev->core)) {
+		ret = venus_sys_set_idle_message(hdev, false);
+		if (ret)
+			dev_warn(dev, "setting idle response ON failed (%d)\n", ret);
+	}
 
 	ret = venus_sys_set_power_control(hdev, venus_fw_low_power_mode);
 	if (ret)

-- 
2.40.1

