Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4D69A95C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBQKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjBQKrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:47:03 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4A0644E0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:47 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id f22so557370lja.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odDokNhSe0XiR1J+qvgMZCsSwTEjlZob9GhOBF9OHvc=;
        b=D3K1+FTh9n03cNh00K7Ql0DlhbCiO3snRPzAQCYRUG/kv1+Of7CSMSAoNV9rbY5paP
         W8hvgn6W/Sx9JTN+Sk6WsfKqW9pGze1ppmWc5Vm6T6FeJ5HqtIZYxQE9oCSVtrU3pHaO
         fKawFEuoaf52WGrh27Axphw2tsY/FqQw1COM/V1OkpOjUs+v6Z+RQbjOlU77Aksh69AQ
         uCpNVZoWEbLRKnDFD//1Y9upK775vvik1CwIJzld+ydbJgnr7PFNmJ8r5kZR5k/qWJjZ
         RirViQ0GcfsuksJaQ2bYZkGkAUSspKsIepsQswI0tq74LifTEUjU0cYZ21n9LPxW2QwU
         bxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odDokNhSe0XiR1J+qvgMZCsSwTEjlZob9GhOBF9OHvc=;
        b=M1CBaAcIhZt0WqjmeDtiiHIzWFnFhJkwLp0M2S0dNQpkwgMFcCaavoDCqxBLVtYz44
         WMVafcHrcfXdFANWrOHbiKbNZmt3bA57Eq/wrB1asGa9MkMAfb2OGhnx0eSAoAEHTXhG
         Yt6W/s47cguepP7BdCtCWU23tvboj5/B+EiUI/ws6IPGRWaVPRlusUjV7Fxi2dMofCwT
         bnv62xWCN1yPSi06kyEoNxVD3Tcyl4tiM7jk8zA0Ql7GaDW0YNSmdQ30T2vsF+9GcYW8
         MZiffHZkb9eZaGhcpRW+/CK2ONr51hWGS8TqtGdrFabQoav0LewExS2Nqt/G14WH0K7r
         WIsw==
X-Gm-Message-State: AO0yUKXAL8KJEtW3ktGULcxB5Fr1C8jA7I31C6/l/eSUJbpbP5aoP7ML
        LyoWf411Em+oE3zYl96nNpJ3gg==
X-Google-Smtp-Source: AK7set8YPXVOhX95P8BHybZ0yF7DQ14DmrU2Ma3cK5WTeI2AqchRxe+rXSXSklTjMpm5wimfKxP5iw==
X-Received: by 2002:a05:651c:cb:b0:288:7a51:3882 with SMTP id 11-20020a05651c00cb00b002887a513882mr2620028ljr.10.1676630805803;
        Fri, 17 Feb 2023 02:46:45 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id c13-20020a05651221ad00b004b53eb60e3csm645940lft.256.2023.02.17.02.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:46:45 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 17 Feb 2023 11:46:31 +0100
Subject: [PATCH v5 10/10] interconnect: qcom: msm8996: Promote to
 core_initcall
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-icc-fixes-v5-v5-10-c9a550f9fdb9@linaro.org>
References: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
In-Reply-To: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676630791; l=1279;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=v+92vgE4LxpyLLy9TkKCUJhLtzjJRiMz2HkYa5ye5Ko=;
 b=ye4+EU5XrLH1YeGrsjD9r0V6qhdwvc1GMXE2fvuG0bZEIWXL6uWLEUYNCxBlRl9MS9g/djo7ZGI9
 ccQmDLJEAYFbDFBz7+l3TTxtL/qOuMeqSDMG4MhgNym1eq7GwA6E
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
index 45eb8675fb11..0e0395328dc7 100644
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
2.39.1

