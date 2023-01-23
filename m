Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DC6678775
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjAWUS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjAWUSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:18:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855D134C09
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:18:18 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t5so11968515wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jxbstFZC7Nau7sl6h71PdO0KZ48q5Fasv9ei6JkkHXs=;
        b=ZisB8u8tGC13xbc/eqG5/Tngo//mu6TIUml3Nt6C9cB2evXRVJ+IxQTmnqikUZ0RLt
         GHnmNQP4uDpav1cluREi9AU8LKx3Ee2iZMIkaF9gdTab8EYa+3bK7QYUlD3Z/Xi6Mvsw
         ZH2Wdvn/1vzFXMb1ILg2ewEz0OWaYVlRm6hRlK+ty7lsKtaLVaIDFGEB+jHQ1y3aMcAT
         L8KGw67uf6m6OhudZKprAwsgDuELiHVdnhW/7Fs/wHx5kvCIl7IOzFYWCnlDCMMY/eAG
         n6jYguiG9Vfnv2iHv/lfIl0339o0FeF5BEp1SbkBPQnRyFsZ3V9WarT4fu0lyFWg7MIO
         m4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxbstFZC7Nau7sl6h71PdO0KZ48q5Fasv9ei6JkkHXs=;
        b=pV7dtQyn0L4aPClU1EAuexVfsOfaLFAxs6lNGsY9kySjQMWNaKfoq+NOELpP0uALE2
         aFsoqIWMiRE3iUMqDebAsDQ3mga2bQVnu6btAFQbmBEixULKyxoqIvxAHIf9iUdcZ5RZ
         cUp8J6ds2R/f6p4MkoYk79//wEMl6lZqpztAGuCLt+RniCnWr3hWUiME8ZwXxWhWR73E
         EEzoSo1+6w/YiN9UG8R20GSxu7iTcPEtMKFgu7sUTOj+5dMv6TYrjrDzcvD7rYIIKPDc
         AAFJjg6LYbIHD1z8dx2FU7rqHIkd2736tLnRJmEV1RgKVv5Pg4uVv4s/D7tYXquomXPp
         mz3w==
X-Gm-Message-State: AFqh2koA2Kx7oZX3NE5/hNkVebauLGU7q9H5p2NR9osrQqlNXzw3QkMq
        ET+7MYEpnHZ9ebjh9/7OzKA67k4hP43WvNyf
X-Google-Smtp-Source: AMrXdXu/XUJGntwDH96r4mOdKbs0k66y5pr8I6eTPUEA5aFlrYDfRN1eIYjkqJ04CGyaWMcyAcRdqA==
X-Received: by 2002:adf:f0c8:0:b0:2bf:9656:d1a8 with SMTP id x8-20020adff0c8000000b002bf9656d1a8mr10492830wro.32.1674505097138;
        Mon, 23 Jan 2023 12:18:17 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v1-20020a5d4b01000000b002be53aa2260sm210078wrq.117.2023.01.23.12.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 12:18:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] clk: qcom: cpu-8996: add missing cputype include
Date:   Mon, 23 Jan 2023 21:18:10 +0100
Message-Id: <20230123201812.1230039-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include asm/cputype.h to fix ARMv7 compile test error:

  drivers/clk/qcom/clk-cpu-8996.c: In function ‘qcom_cpu_clk_msm8996_acd_init’:
  drivers/clk/qcom/clk-cpu-8996.c:468:16: error: implicit declaration of function ‘read_cpuid_mpidr’ [-Werror=implicit-function-declaration]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/clk-cpu-8996.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index ee76ef958d31..40c4dabc20a7 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -49,6 +49,7 @@
  * detect voltage droops.
  */
 
+#include <asm/cputype.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-- 
2.34.1

