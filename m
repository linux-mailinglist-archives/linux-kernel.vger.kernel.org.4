Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCD9671E79
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjARNw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjARNvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:51:52 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E724ED2C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:23:03 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bk15so25684068ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60yxEW22hoAOOhOWGOTH5M2hZiABdMD97947KesUJto=;
        b=gfY6iL0rwH5atzxFw11g+DLW74OMhX2MYgGHfFVXdXWRoIhLjavXDTvM70MkEMFli2
         2K1cyBaSkZF3spWf7BmE+i7CNbG0XzAgMYUTPqLoJdLw6DEdsuaUpdCCun6fYc9ZAVDM
         5Y4IjCcAp/A9t8WQGASm4efMBVkfHj6ug7snNgOMT+dc/1aFCQS/GJrjETCsHBOEpLsk
         fHLDZ5Slo55EofdS2WQjAHvfi1pWgKKHFZAfpGBopjUy+9xMzMXxEmaJdsu+ftaomyMt
         UVV9S9vAwhNIn1K0NvWV3+fNtH8jLR6TbPJ2oZlhFfWfRQKNk1jkMn7O4aovM+RN2Z3Q
         AQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60yxEW22hoAOOhOWGOTH5M2hZiABdMD97947KesUJto=;
        b=wXWPBFTVQcxtM+3t9f7xfJqM08f6w48Bg1C5wGSbijQaixdEkJkv4Y8doJ5XgHycUU
         qX4JCJwbjMp6yzelpiNjnC3oTM6KFlWkviVKx/inShdVw/PMmbrMM0aEYRKmmMxuYQQ2
         zZOMpaIA4u8cBHcpX/PNMbxirUv0Lz+t9wzbD/agO3kjSqJRQBP+BW9+2WHWwipZFSrQ
         xrJpb7dIOVFcxtg+84AwKQqIgydtNdtYsMEMwlLKn0UN4L2mv9rCgpT/Aq0cu2gvDNJM
         4wgWLzvdgAVDUkXIHnM4Rw//72+qVoYbLDaJMP7qGOXh7VZGDxrNLjwigNpaoEIIZSvH
         XqQg==
X-Gm-Message-State: AFqh2koCCrHy/i5SOsyCRAkwt/gio56SJcTGc8rtybWPfDZWOEoTSopP
        P4+D7ZZHcH9MBBXeMTzSehZS1w==
X-Google-Smtp-Source: AMrXdXu9XmiL3q2VIQiZbBOHbxXO0ki9w+4xQCqDxJve3AGmadrWZRhx+jG374RE1UzWUeeRaUQQIA==
X-Received: by 2002:a17:907:1621:b0:870:34c:97df with SMTP id hb33-20020a170907162100b00870034c97dfmr16824173ejc.4.1674048183291;
        Wed, 18 Jan 2023 05:23:03 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b0083f91a32131sm14633831ejh.0.2023.01.18.05.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 05:23:02 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] mailbox: qcom-apcs-ipc: enable APCS clock device for MSM8996
Date:   Wed, 18 Jan 2023 15:22:53 +0200
Message-Id: <20230118132254.2356209-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118132254.2356209-1-dmitry.baryshkov@linaro.org>
References: <20230118132254.2356209-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8996 also has the clock-related part of the APCS mailbox device.
Follow the usual pattern and create a child device to handle these
clocks.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 0e9f9cba8668..bd61dacb44ba 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -42,7 +42,7 @@ static const struct qcom_apcs_ipc_data msm8994_apcs_data = {
 };
 
 static const struct qcom_apcs_ipc_data msm8996_apcs_data = {
-	.offset = 16, .clk_name = NULL
+	.offset = 16, .clk_name = "qcom-apcs-msm8996-clk"
 };
 
 static const struct qcom_apcs_ipc_data apps_shared_apcs_data = {
-- 
2.39.0

