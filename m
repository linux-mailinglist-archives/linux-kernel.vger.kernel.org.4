Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F49668EACB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjBHJPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjBHJPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:15:11 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B865645BFF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:13:48 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id jg8so9943478ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuUic+i1U7Wq2FP3EF4of24nNHQpKF/wijqQmHWITsc=;
        b=nDFpFjJi+KCbO6IFRe32xwArDhZIPitZ6Y96CW/FKiA5ymoAy+yjpJvOBtX/RwweKI
         FaWjGlDj8jwi8Wm2Bg6GWr8+ohC3KiZnhlxvbLiSDWkCqqOggWAI9kL/OjSPNc2lwInh
         258UyqHnbEFEsrq1hJjVTC6/e8bThS442mGvY8u7jwed66xz3vrVoX9PNGd3DjB/j3oA
         EB7u+ZIIDIR5Hjg421QkT77lCVnv2TXUAoVKgD0TGfSXorqb4XI/W3mg8SaSD2uKCklO
         K7cK/Y3U2+IQduHLnY+GV8q6dZrON1N4hS6VcnM/UTW3P+CxPKR9Q69DdQS3++/1a0cE
         AFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuUic+i1U7Wq2FP3EF4of24nNHQpKF/wijqQmHWITsc=;
        b=J/YdU1FiA1GyPOejcbv9+y3vcccXY16/4C4WOoiohd7zGdCrZYwLHdQzvk3eaWY0xh
         gTRPBRIAlMyZ0Ov7zrARCoks8XvJbvAFgc/iPm6FuINEykwlSHTkhA13kozGIHepQlCD
         VDu3nGrnkB2HvYXOQwvg9nnBmuO4sKOjD0DPg5V6jqiN9oe7aEq7ZAd3XN4wY84tl3Ul
         nFxXUIE+Dw+Zs+CYJrz9xssikCuXIZjMz/6q2HJbD9qdi33+VGO3tVSSQHXSZJh63HLp
         IJc0fNCaM+pfbveDSoq5EI4P9EOY0u5/2r0kCcUG6q+uy4NUBk5HOELHajmmyqdpKZ0V
         RoNw==
X-Gm-Message-State: AO0yUKWRNCxjIBeaw1jHxvFUPGqxxYJSDV8lYEBWYlMzkg9t/eJjcAW8
        LgeV9Sz+KpFzaOHPil/rsoMBTQ==
X-Google-Smtp-Source: AK7set98G9vNhInMtInU3tZjeGD3eVHTPFfFB2IIwKOg8kwNUoKVef+wYxPQ9KycOilQpaUf5cVtqw==
X-Received: by 2002:a17:907:2da6:b0:8ae:f73e:233f with SMTP id gt38-20020a1709072da600b008aef73e233fmr490317ejc.32.1675847626017;
        Wed, 08 Feb 2023 01:13:46 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709064e0200b00887a23bab85sm7987279eju.220.2023.02.08.01.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 01:13:45 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/10] clk: qcom: branch: Add helper functions for setting retain bits
Date:   Wed,  8 Feb 2023 10:13:31 +0100
Message-Id: <20230208091340.124641-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208091340.124641-1-konrad.dybcio@linaro.org>
References: <20230208091340.124641-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most Qualcomm branch clocks come with a pretty usual set of bits that
can enable memory retention by means of not turning off parts of the
memory logic. Add them to the common header file and introduce helper
functions for setting them instead of using magic writes.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-branch.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index 17a58119165e..55b3a2c3afed 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -37,6 +37,32 @@ struct clk_branch {
 	struct clk_regmap clkr;
 };
 
+/* Branch clock common bits for HLOS-owned clocks */
+#define CBCR_FORCE_MEM_CORE_ON		BIT(14)
+#define CBCR_FORCE_MEM_PERIPH_ON	BIT(13)
+#define CBCR_FORCE_MEM_PERIPH_OFF	BIT(12)
+
+static inline void qcom_branch_set_force_mem_core(struct regmap *regmap,
+						  struct clk_branch clk, bool on)
+{
+	regmap_update_bits(regmap, clk.halt_reg, CBCR_FORCE_MEM_CORE_ON,
+			   on ? CBCR_FORCE_MEM_CORE_ON : 0);
+}
+
+static inline void qcom_branch_set_force_periph_on(struct regmap *regmap,
+						   struct clk_branch clk, bool on)
+{
+	regmap_update_bits(regmap, clk.halt_reg, CBCR_FORCE_MEM_PERIPH_ON,
+			   on ? CBCR_FORCE_MEM_PERIPH_ON : 0);
+}
+
+static inline void qcom_branch_set_force_periph_off(struct regmap *regmap,
+						    struct clk_branch clk, bool on)
+{
+	regmap_update_bits(regmap, clk.halt_reg, CBCR_FORCE_MEM_PERIPH_OFF,
+			   on ? CBCR_FORCE_MEM_PERIPH_OFF : 0);
+}
+
 extern const struct clk_ops clk_branch_ops;
 extern const struct clk_ops clk_branch2_ops;
 extern const struct clk_ops clk_branch_simple_ops;
-- 
2.39.1

