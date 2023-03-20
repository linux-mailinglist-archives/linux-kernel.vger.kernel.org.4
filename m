Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADED6C0B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 08:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCTHMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 03:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjCTHMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:12:37 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362782195E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 00:12:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u5so11457087plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 00:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679296347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liNNhxqvRDMursBLDB2MIwbIPJeovqlNRny383xdhTI=;
        b=BylZS6xZ3b0Zlrl7YQq86fUUU4kXq9w0KrIWam69wNxiznczxs8DlTjfLG6Bq2J7PL
         eYvthylHCplJ5QATwymsNS5gN9CpHggP584ljCnpJbZDJNJdKgorg3rN1IGaOcrgLO/i
         t+w6nYkOqaqzBR5w2R8RxBJ+rfxa7wwAXj9yNUJkLMb0kSulm8gDAi1oK5orWl5R5wtD
         Amcg6EZge1/y/VKIxyCnBlYgezFQWJO6J5EK5RRgggdp7DBItBftvsfSro/SKFUUpe6o
         DpqkBi4RkQC607k7yLGNEyLXqPC8AzwkHPHQvsA+yiLsQMoQF06ukG8lByZcZJPFlncT
         WIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679296347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liNNhxqvRDMursBLDB2MIwbIPJeovqlNRny383xdhTI=;
        b=YWIquvtC+8kPX9jIvNNEWvPOTmOKsFcBl5p0yweZadrIKk1TKYhc6C4U56hoPCwvHY
         IJGqs5mSq8TVifWN+C7vWH0FGAp9OHAJaBZdlXY4q6fqLAo3aAxB4BHle2OmcpL3FKAA
         jJ9cnfw0+utHN5rmBPjyYYhWupscABwkiXcxZVRPdtfNYru//x2Bjm8WJby2RthqPA9j
         r2YR6fEX7JXx/RESxWDR/HTRWURN77aZ6m9Fo7bK4H2yVcI6/MssjD+kvhzGnXeLeOSv
         0zMbdb91YUQMRaU3lWaHyV8Hf1YsY1wt3HX88HFNuaOrbxcv8ghZR3LIiaXc2ucIknP0
         MeDw==
X-Gm-Message-State: AO0yUKUnFzCD/9KaMML6D9bXOlDJd+ogxsBInqY54NnuSJAQH1lDUJIG
        SFkXryi9Y9HEEaPBl27hBJpOLA==
X-Google-Smtp-Source: AK7set/pArwQDd4hLvBichOD4CHjcDNi/TQiRseWtTK/LvIGTt7oXuPoe+urprEkfBgBWclFjev3Wg==
X-Received: by 2002:a05:6a20:ca4e:b0:d3:c6f6:ac8c with SMTP id hg14-20020a056a20ca4e00b000d3c6f6ac8cmr13025826pzb.36.1679296347663;
        Mon, 20 Mar 2023 00:12:27 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:7331:922d:c0be:85c4:f0ae])
        by smtp.gmail.com with ESMTPSA id m3-20020a63fd43000000b004facdf070d6sm5619477pgj.39.2023.03.20.00.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 00:12:27 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, vkoul@kernel.org,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org
Subject: [PATCH 2/2] dmaengine: qcom: bam_dma: Add support for BAM engine v1.7.4
Date:   Mon, 20 Mar 2023 12:42:11 +0530
Message-Id: <20230320071211.3005769-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230320071211.3005769-1-bhupesh.sharma@linaro.org>
References: <20230320071211.3005769-1-bhupesh.sharma@linaro.org>
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

Qualcomm SoCs SM6115 and  QRB2290 support BAM engine version
v1.7.4.

Add the support for the same in driver. Since the reg info of
this version is similar to version v1.7.0, so reuse the same.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 1e47d27e1f81..153d189de7d2 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1228,6 +1228,7 @@ static const struct of_device_id bam_of_match[] = {
 	{ .compatible = "qcom,bam-v1.3.0", .data = &bam_v1_3_reg_info },
 	{ .compatible = "qcom,bam-v1.4.0", .data = &bam_v1_4_reg_info },
 	{ .compatible = "qcom,bam-v1.7.0", .data = &bam_v1_7_reg_info },
+	{ .compatible = "qcom,bam-v1.7.4", .data = &bam_v1_7_reg_info },
 	{}
 };
 
-- 
2.38.1

