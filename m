Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1748F6E3BAE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 21:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjDPTsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 15:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDPTsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 15:48:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3128E3AA7;
        Sun, 16 Apr 2023 12:47:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p8so23526234plk.9;
        Sun, 16 Apr 2023 12:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681674474; x=1684266474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxfOnlh1gWPz4ECc5+gyXwuy61sNCNvLdcJJf29rWhA=;
        b=A5N7ttd+GYkilmlvtj+KtFUZGLlXeWa2/lQC4BLJPMTdvqPpppJSz2wwXpvbGUnqkH
         BcLUfkVue72PzL+gWUSgIPi+aZzmXVe3HLVRlZJWpJm1+du8k/4SQ1uMg/F0V1VXp2eI
         wbP/ovn3eQssgVTaM4CvwGBMme04YX/bLsvbYH7txalwmDCIPAY8LUvKDRMTnMaMQj00
         jBax7l6/0Vij4TqDSwRJnoYKsETwT00mr27xtm3M5PBXJdhaDli+Sd5o35866ICOWba5
         Jz2mTWatkoNYK2rOvXqY5QIMfcWnzePy0J82H1+MshVziEnNW1RKeJGZnOSgm9mUdCMS
         seGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681674474; x=1684266474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxfOnlh1gWPz4ECc5+gyXwuy61sNCNvLdcJJf29rWhA=;
        b=DOqngfy0JVSTSUuR0WtYh6qsP1vfh0j32Z9ApoPOUdXra092AIuv6u6B/85QlUnyjk
         idYWE49gnSUw4UjBgoMDg5nPIao50P4NsCkFbyL2GS3jJ0H6KHRqveSZvZ5g1nCLWrPU
         GgiqheFQzU2U6jOF8D/HTR7VOjaOlx6NaBtvf19GU0/eh8LfNy27Zw/D6RYbXl47e2uQ
         0dIfoiF+pK/8dyoqy7TiFnQkS4Uy2L9EZWAp1pug9Z2KrY3l2DGCCIzvsrEIG141kuMj
         aW9QGKq/dQPbfks9Ov730L6PB4QHcQNS7oWQ+zDyLATPnt3kB9h0xHKMY5QyHzcqHCnZ
         DTMw==
X-Gm-Message-State: AAQBX9fgJdYBmY0uLzgfkSRHAwvCj9XPH5Gxbqpv8qKsUBlj6OguLTZY
        POrNrEGG0vxhQ9nYo/hzbDBXaYSoNEgOzS4/Qus=
X-Google-Smtp-Source: AKy350YNW0o4BxR7h0HrV31DgHcaDX8VRrafFkGAVtSacy2Ns4UtFBDAxhmCLeiKBHTvKRzzP8g83A==
X-Received: by 2002:a17:902:da8d:b0:1a6:5274:c1b0 with SMTP id j13-20020a170902da8d00b001a65274c1b0mr12262127plx.60.1681674473708;
        Sun, 16 Apr 2023 12:47:53 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.201])
        by smtp.gmail.com with ESMTPSA id jd9-20020a170903260900b001a69b28f5c5sm4490375plb.222.2023.04.16.12.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 12:47:53 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] clk: gate: Add DT binding
Date:   Mon, 17 Apr 2023 03:46:22 +0800
Message-Id: <20230416194624.1258860-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416194624.1258860-1-mmyangfl@gmail.com>
References: <20230416194624.1258860-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding for gate clock as "gate-clock".

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/clk-gate.c | 81 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 64283807600b..a70df4a2a9a7 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -12,8 +12,11 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/err.h>
+#include <linux/platform_device.h>
 #include <linux/string.h>
 
+#include "clk-of.h"
+
 /**
  * DOC: basic gatable clock which can gate and ungate it's ouput
  *
@@ -257,3 +260,81 @@ struct clk_hw *__devm_clk_hw_register_gate(struct device *dev,
 	return hw;
 }
 EXPORT_SYMBOL_GPL(__devm_clk_hw_register_gate);
+
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_clk_flag of_clk_gate_flags[] = {
+	{ "set-to-disable", CLK_GATE_SET_TO_DISABLE },
+	{ "hiword-mask", CLK_GATE_HIWORD_MASK },
+	{ "big-endian", CLK_GATE_BIG_ENDIAN },
+	{ }
+};
+
+static int of_clk_gate_setup(struct device_node *np)
+{
+	struct of_clk_ctrl *ctrl = np->parent->data;
+	const char *name;
+	void __iomem *reg;
+	u32 bit_idx;
+
+	const char *property;
+	struct clk_hw *hw;
+	int ret;
+
+	reg = of_clk_get_reg(np);
+	if (!reg)
+		return -ENOMEM;
+	name = of_clk_get_name(np);
+	if (!name)
+		return -EINVAL;
+
+	property = "bits";
+	if (of_property_read_u32(np, property, &bit_idx))
+		goto err_property;
+
+	hw = __clk_hw_register_gate(NULL, np, name,
+				    of_clk_get_parent_name(np, 0),
+				    NULL, NULL, of_clk_get_flags(np, NULL),
+				    reg, bit_idx,
+				    of_clk_get_flags(np, of_clk_gate_flags),
+				    &ctrl->lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+	if (ret)
+		goto err_register;
+
+	np->data = hw;
+	return 0;
+
+err_register:
+	clk_hw_unregister(hw);
+	return ret;
+
+err_property:
+	pr_err("%s: clock %s missing required property \"%s\"\n",
+	       __func__, name, property);
+	return -EINVAL;
+}
+
+static void __init of_clk_gate_init(struct device_node *np)
+{
+	of_clk_gate_setup(np);
+}
+CLK_OF_DECLARE(of_clk_gate, "gate-clock", of_clk_gate_init);
+
+static const struct of_device_id of_clk_gate_ids[] = {
+	{ .compatible = "gate-clock", .data = of_clk_gate_setup },
+	{ }
+};
+
+static struct platform_driver of_clk_gate_driver = {
+	.driver = {
+		.name = "clk_gate",
+		.of_match_table = of_clk_gate_ids,
+	},
+	.probe = of_clk_probe,
+	.remove = of_clk_remove,
+};
+builtin_platform_driver(of_clk_gate_driver);
+#endif
-- 
2.39.2

