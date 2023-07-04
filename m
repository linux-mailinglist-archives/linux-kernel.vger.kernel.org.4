Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A435747715
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjGDQmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjGDQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:42:18 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D961725;
        Tue,  4 Jul 2023 09:42:15 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6a675743dso89876401fa.2;
        Tue, 04 Jul 2023 09:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688488933; x=1691080933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JYO2M7vRZa1/xxbWLBVMXjKnA4nuseIujdVy5vF91g=;
        b=pghI0t5YBwzJ3AdI9JYwld77J9hsXvrdpqlHWa4dWVonfYfm44QXaNRh+YfZCxbrFx
         Ui4/SBBIR4TO5sFJUPj3JbCZppLZyUMBCi0DdDu115H+uY8HDVryj908wbmSpSLzIx/p
         uvOEvszbow4ocbt6fR5PjQ2onKt2IM19GMm7sG2Ya1GJaRmiQj+0beuoD2tQgL2wndNw
         Q9Fy3h3h46COYjJpslEjsmvTyplzvPzDIGjZFbUJjKKclFcsb0x9HgEp65kKS/N8kRxd
         CyWoP8nWIajomXQXYfjcRBC/OyS0ybqFydicmyk4ushObSVnKJ0G8qHtcdZTCI6QPPX/
         649g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688488933; x=1691080933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JYO2M7vRZa1/xxbWLBVMXjKnA4nuseIujdVy5vF91g=;
        b=fqmYt4mXyeYEBiO9S9CaMVLW9L+EnVgIePHdaixsJfDTRT2wbCNARdgsMDX7OttF+D
         D+h6BsByIuxA3IlnzGV2ITEv7FX67AvURlTdEqzE836sJIHMZMcb4keMW/DXvq9xAWwJ
         qy5uzFmLdqYOKkzjMZUX/6RaZsIYiJDDYd1iCuLSCYO9ns4gD7kgLVfT8tjllXd46SpO
         sEB1UebSS4vglhswz2seZX4ajQCRRCMjbPTw8xNXOGRE7bj/Cv+sPlK5xtlEB2EA9d6N
         0Vs+omX/vJAhMb0c1zmf0RXIkhnYDCHLKAh053xXEn3zL9gPe0Es5nZLajdZCui1ipz1
         Y2DA==
X-Gm-Message-State: ABy/qLbODHOw2DTdFnMIzwJ3axvXVY6wseK4SoHWTVtKQIslRSwM6G0L
        srfkziT5W4DMTA+rZk8YQKg=
X-Google-Smtp-Source: APBJJlGsWqDe80udi5tHeC5ZuJvG13BJTy0Ip/B55ZgMSwqho6eBYiMId5M6RQdizGvi5IeOKGLzoA==
X-Received: by 2002:a2e:9105:0:b0:2b6:af60:6342 with SMTP id m5-20020a2e9105000000b002b6af606342mr10121385ljg.40.1688488933622;
        Tue, 04 Jul 2023 09:42:13 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.169.176])
        by smtp.googlemail.com with ESMTPSA id u15-20020a2e2e0f000000b002b6eb5db863sm1181920lju.43.2023.07.04.09.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:42:13 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        map220v <map220v300@gmail.com>,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH 4/7] clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src
Date:   Tue,  4 Jul 2023 18:31:57 +0200
Message-ID: <20230704163848.169853-6-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704163848.169853-2-davidwronek@gmail.com>
References: <20230704163848.169853-2-davidwronek@gmail.com>
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

From: map220v <map220v300@gmail.com>

Add the PARENT_ENABLE flag to prevent the clock from getting stuck at
boot.

Fixes: 17269568f726 ("clk: qcom: Add Global Clock controller (GCC) driver for SC7180")
Signed-off-by: map220v <map220v300@gmail.com>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 drivers/clk/qcom/gcc-sc7180.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index cef3c77564cf..49f36e1df4fa 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -651,6 +651,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_5,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
-- 
2.41.0

