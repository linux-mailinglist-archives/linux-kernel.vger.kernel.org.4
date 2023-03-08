Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EE16B1463
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCHVmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCHVlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:41:35 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A87D291A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:41:09 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id g18so18063448ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vveGd9sf9fGz7xfjIX4ynPRPTvQaFdGwhHtakqOTRYg=;
        b=MDAy6R+jjctd0vx9CWrQXaXsEMkgKA/ZE6LE8uRw86hdQoO9sa3Q/9/chs5qLDJccG
         rNTN/514pGvz9ibGNcPpdTSm1gyKyXCLqS82bHUk5rhi1jQv16Hidf90VLLI678+qNCh
         Vk7/QAFl7cKP6IZWezjF4730IJVbEGaHbwsJFfQsUbF9IYp4ApjG9/PVR+loQyMeCk4H
         LW2yWvgpwDJtw7fuEpK1Hq4cVpft2f/Ss1lkaj39Dx/Ei0C/kevGyefEznjdROje9YLK
         LU1vHYgO4loidMf5EOI/tV1KT28QxAAlMPkTALUPRwHIAvFswlDmSPWVZPMCyBVReHya
         2Okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vveGd9sf9fGz7xfjIX4ynPRPTvQaFdGwhHtakqOTRYg=;
        b=b9Sd+UmjcWSGAkeoqJz1G8ky8II3goYs4/GVYUJlFmZiC4qAXAaNmaS8ijNPQcxKXf
         s7U2ukazPMoMCtyni5mvPnYnBS02oi5Z+kouBVqPP+zaN7YsBR1tQtU/fe/NAqNripDL
         sjf1qWlUfhAJ9YnqW8y6TR59VXIFWFa7HVi8HWKzoAP4NSLcPm98xt27J1zfezYPFyJ3
         6cHwgJF/7NhHoUZdS3Mhm90WtSZH0WiAliNNHQqtTwBzqrwx/5Yg9k2eJDmZhy4YAdef
         d/tKv3VSzI59Aicjl1PpBMdAcDCVaSyh57QWyCTpsCSaJiElaer4k+YXa2WT0dIQtNip
         +1zw==
X-Gm-Message-State: AO0yUKXi3g8tq8mqihpZSEQwZ4bzPMbqSGU10DcGB/p1ibs2XwwIWFlf
        w1uR2xGwtzS9HEPFZibwAtC8g6bh2/Np0OC4nds=
X-Google-Smtp-Source: AK7set8JeXNHn4TnkWOhL+wkhYu2gkjGes9+4TTQV1KtujPgQcUC0f+IFVgsBNsru/W0JaARFY+M4Q==
X-Received: by 2002:a2e:7e10:0:b0:295:9d05:4a56 with SMTP id z16-20020a2e7e10000000b002959d054a56mr4824962ljc.9.1678311637409;
        Wed, 08 Mar 2023 13:40:37 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a6-20020a2e8606000000b00295a2a608e9sm2688844lji.111.2023.03.08.13.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:40:36 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 22:40:15 +0100
Subject: [PATCH v7 9/9] interconnect: qcom: msm8996: Promote to
 core_initcall
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v7-9-815606092fff@linaro.org>
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
In-Reply-To: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678311609; l=1279;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5H1KJ2r/pG170nOV3v3bsq3JNwWcNEZN04iD5DDB2kw=;
 b=mA+CUaUze95pv7UwCHyxJG284m7hyf7mpYPzfRrzl/yoikhuSf999ZWFXM2KiHMv5jr/d5NJq0Lb
 GnYlQwesD62E+SECS98WGgXTUqKbxD8cKwtBkI2a+l3MTLs+7Q4u
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interconnect driver is (or soon will be) vital to many other
devices, as it's not a given that the bootloader will set up enough
bandwidth for us or that the values we come into are reasonable.

Promote the driver to core_initcall to ensure the consumers (i.e.
most "meaningful" parts of the SoC) can probe without deferrals.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/msm8996.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 347fe59ec293..1eb51ed18b0b 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -2109,7 +2109,17 @@ static struct platform_driver qnoc_driver = {
 		.sync_state = icc_sync_state,
 	}
 };
-module_platform_driver(qnoc_driver);
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
 
 MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
 MODULE_DESCRIPTION("Qualcomm MSM8996 NoC driver");

-- 
2.39.2

