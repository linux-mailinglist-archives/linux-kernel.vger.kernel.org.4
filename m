Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C3A73CAD9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjFXMX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjFXMXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:23:52 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD03BF
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:23:51 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b46cfde592so24899371fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687609430; x=1690201430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avKiWxoWYl1UXVnI1jhFRgj1Bd8Ey8Z1YlDdy76fbHw=;
        b=Y/r6vNeazTy5SqQSn7ySKBYS/EBpIMfd7saTZB52qjSq5nZEBXdxO4wWvT8zv6rMrO
         wZyWiR+0Tnfojf1i9AC5wqXMGQOyzw7Am2DdITaQAj/w2MeP2uY+GgDx6+i/bO2nCh7R
         ejJwJggxe/DpvTjOam5ljnvaB1OYct/bTIAqWtACIdNRUFA+gVMPv+meTW6eMeC+0Hod
         y5TgEkdnnF9RCFhINPanmzx6Lvc1A35m0fDUo8nVmyySkRLsLHOVbaWZhuKKlUqnZYnr
         gamLQAzCSH/X6JOQvqrQjebbafRTQY+fxE7qIjoFcqhMzKU5OzKE9C/mJRAcvuk+/pnB
         jUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687609430; x=1690201430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avKiWxoWYl1UXVnI1jhFRgj1Bd8Ey8Z1YlDdy76fbHw=;
        b=AaSaMVjdPyE5kxLonKYmU+/UMLIUv6j7j0f9SekUaOugoapnOSJLhZ0TsUpIsY3QuR
         7zJmWvv5O7hYJmPUHVtyV/jGPExnZffgqO11Mzdf6eG0P1PxfZNFtygpx3t0MsMinyHh
         SoymiHphwDqfUMIErET4Mz4kJH6wRpJQFkvkVT0kZVwYPIX+1TC2caRaodKMZgkfRKx3
         kl7vlUKgcT8Pxe8VCuDxTPvCtf3SVzTWilD60kNI0xiimAbVint33qlXVob1UZOiRH0x
         rWV74eY1ucl7JybEti5P0GHWGVb0vyElKqXdeNSAVUZJysRZmaMOfx1zNA+NE4eMK7eF
         pS8w==
X-Gm-Message-State: AC+VfDxVElgtQ2qiFyPo1GaBWUGxRXq1jlzOK0NdNl077bilo/At4Zu1
        VXT+hzAcImjY35PmI0yLd0DqyQ==
X-Google-Smtp-Source: ACHHUZ7UTAx2/bEt+ZSl5QD0opwRKHGjqzeFROyYfCzAssepJG3s6vylbvwcndvYK/Kdd5NyeYH6kw==
X-Received: by 2002:ac2:4992:0:b0:4f8:453f:58f3 with SMTP id f18-20020ac24992000000b004f8453f58f3mr16346770lfl.40.1687609430036;
        Sat, 24 Jun 2023 05:23:50 -0700 (PDT)
Received: from [192.168.1.101] (abyk197.neoplus.adsl.tpnet.pl. [83.9.30.197])
        by smtp.gmail.com with ESMTPSA id s13-20020a19ad4d000000b004f00189e1dcsm260200lfd.117.2023.06.24.05.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 05:23:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 24 Jun 2023 14:23:47 +0200
Subject: [PATCH v2 3/3] firmware: qcom_scm: Drop useless compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230623-topic-scm_cleanup-v2-3-9db8c583138d@linaro.org>
References: <20230623-topic-scm_cleanup-v2-0-9db8c583138d@linaro.org>
In-Reply-To: <20230623-topic-scm_cleanup-v2-0-9db8c583138d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687609426; l=1502;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2851rppnMfhTFcDTpFWS0mg9wSl32exm/NRmmxF+T/w=;
 b=Qy3D0ksutlS9UBuf6hqlAIbaAbyXSeHcDCXBDPBTZYPkD2ERbRol6/AF6Z8ZTspgmJZHgNBjx
 x6ELhXKung9BQemO4xI9iX3W25RZf4QdqPkxrMs4VF+BTUIB7z+cHss
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

There are three categories of compatibles within the driver:

1. Ones which were introduced without a qcom,scm fallback
2. Ones which were introduced with a qcom,scm fallback
3. Ones which were defined but never used

Keep 1 for backwards compatibility and axe 2 & 3.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/firmware/qcom_scm.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index b8398002205d..b6055b1c18d8 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1478,20 +1478,15 @@ static void qcom_scm_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_scm_dt_match[] = {
+	{ .compatible = "qcom,scm" },
+
+	/* Legacy entries kept for backwards compatibility */
 	{ .compatible = "qcom,scm-apq8064" },
 	{ .compatible = "qcom,scm-apq8084" },
 	{ .compatible = "qcom,scm-ipq4019" },
-	{ .compatible = "qcom,scm-mdm9607" },
-	{ .compatible = "qcom,scm-msm8660" },
-	{ .compatible = "qcom,scm-msm8960" },
-	{ .compatible = "qcom,scm-msm8916" },
 	{ .compatible = "qcom,scm-msm8953" },
 	{ .compatible = "qcom,scm-msm8974" },
-	{ .compatible = "qcom,scm-msm8976" },
-	{ .compatible = "qcom,scm-msm8994" },
 	{ .compatible = "qcom,scm-msm8996" },
-	{ .compatible = "qcom,scm-sm6375" },
-	{ .compatible = "qcom,scm" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_scm_dt_match);

-- 
2.41.0

