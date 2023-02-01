Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1B4686E1A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjBAShO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjBAShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:37:11 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8AD80163
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 10:36:38 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id q19so8710158edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 10:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=El1AVRsQ6D1MqifIni9EpinXyr4efhm++D3OufFjYP4=;
        b=ly6dETHjzRa3Mg4uA8RGluvZ0Z6g7wigR0NdtxHggKWXXPpvGYo8ET89DUdbzgnXTt
         XJ5+rXU9PSoBxNn5gBh4pmHNCs1rikeKa2FkI5qU8yNHp3h7zhrPz7vAwivbC3oZk/4q
         MkqfjcI/0U0PYwu92ruOi3LPYr5oiEwMLPSSUko5SRwMufwcE1g0FxFp4TzohVGr6EcB
         mRmfbTk1enXM86qoiMMsVrRkP8c/cQGy82MIsh70FwxsoJCJlmPuKFQVIYGoOa+kbp7D
         zGaIFdQ80TOG13TxNLv1RtlQt4jKUwEAJ0lQtHRZXQPjm8xt8fFk8QswlnsSLP/baxCa
         IrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=El1AVRsQ6D1MqifIni9EpinXyr4efhm++D3OufFjYP4=;
        b=z/p2sEviXSATN1t98BCOEJCkUsbCb7gXE4qFFEFlNk7J8TYc99hXPhVIU6ezKf6e1D
         //+09h4ZgaU0phJ/YwlUlJIbY9vq2nQ1sxQaQZKIbnBdpZjXwYagGAhpXrbFnXBJN6Do
         stmQZairKuSZOg0aESm03J+R3CAH3HC6OW+vCR4qae3PrjWhPpeq0ElAkITp0+SxGLLK
         WgQQiznqjMp0z0Rw8p8xXJV7hFJ/+1yP5/dlLyc+1mCh0Tl655Qho16Xjp4SG1MgtZ2m
         gtugUZJNZvasRM34cfbFqkbQT6i9SLB+eFM07xUE+ithsU2FiL6dUt/yoJUBl3RKWttK
         cIqw==
X-Gm-Message-State: AO0yUKUC9dcfnLgU/Nz8OlGIK29WHzo1XvPisihswCxlECUBZr1xHE2b
        XhbRAsSyhjNYODAoblXlh3tPSg==
X-Google-Smtp-Source: AK7set9q3uP3SBemadz+F9KkGslcV4+CfVNGuzTtXrjHXVs+qRfNNKLI9VldjJz5jNUEwmD725D2kA==
X-Received: by 2002:aa7:ca42:0:b0:492:8207:f2ba with SMTP id j2-20020aa7ca42000000b004928207f2bamr7319238edt.1.1675276593387;
        Wed, 01 Feb 2023 10:36:33 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id t13-20020a50d70d000000b00458b41d9460sm10297508edi.92.2023.02.01.10.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:36:33 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/10] clk: qcom: branch: Add helper functions for setting SLEEP/WAKE bits
Date:   Wed,  1 Feb 2023 19:36:18 +0100
Message-Id: <20230201183626.351211-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201183626.351211-1-konrad.dybcio@linaro.org>
References: <20230201183626.351211-1-konrad.dybcio@linaro.org>
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

HLOS-controlled branch clocks on non-ancient Qualcomm platforms
feature SLEEP and WAKE fields which can be written to to configure
how long the clock hardware should wait internally before being
(un)gated. Some very sensitive clocks need to have these values
programmed to prevent putting the hardware in a not-exactly-good
state. Add definitions of these fields and introduce helpers for
setting them inside clock drivers.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v4 -> v5:

- Introduce helpers that shift the value for you

 drivers/clk/qcom/clk-branch.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index 55b3a2c3afed..fa90e150853b 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -41,6 +41,8 @@ struct clk_branch {
 #define CBCR_FORCE_MEM_CORE_ON		BIT(14)
 #define CBCR_FORCE_MEM_PERIPH_ON	BIT(13)
 #define CBCR_FORCE_MEM_PERIPH_OFF	BIT(12)
+#define CBCR_WAKEUP			GENMASK(11, 8)
+#define CBCR_SLEEP			GENMASK(7, 4)
 
 static inline void qcom_branch_set_force_mem_core(struct regmap *regmap,
 						  struct clk_branch clk, bool on)
@@ -63,6 +65,18 @@ static inline void qcom_branch_set_force_periph_off(struct regmap *regmap,
 			   on ? CBCR_FORCE_MEM_PERIPH_OFF : 0);
 }
 
+static inline void qcom_branch_set_wakeup(struct regmap *regmap, struct clk_branch clk, u32 val)
+{
+	regmap_update_bits(regmap, clk.halt_reg, CBCR_WAKEUP,
+			   FIELD_PREP(CBCR_WAKEUP, val));
+}
+
+static inline void qcom_branch_set_sleep(struct regmap *regmap, struct clk_branch clk, u32 val)
+{
+	regmap_update_bits(regmap, clk.halt_reg, CBCR_SLEEP,
+			   FIELD_PREP(CBCR_SLEEP, val));
+}
+
 extern const struct clk_ops clk_branch_ops;
 extern const struct clk_ops clk_branch2_ops;
 extern const struct clk_ops clk_branch_simple_ops;
-- 
2.39.1

