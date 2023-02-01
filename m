Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B064686E21
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjBAShW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjBAShQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:37:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75207FA21
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 10:36:43 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v13so18617939eda.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 10:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6IkYBzHRtP78kfNNlfDDoZLESVj7tG9rKk+4Qd2VXM=;
        b=KegFK2U/B4RmndOABI9a19JnrGK7nSS6Tc9XCPCEzK8Weeo6nle5akFanIEPCZ8L5/
         /g4mdwbHw2jhToCgyOHDPnUjvDaW5Zx6V2bFsFUTROxs4tbg2JfbKU+0TjBbYnP951oI
         gik1lD+Is6F7bj2z6ze2lrhxXFxwbkwM9HBLqD/K/P0JU/q8JymFN5U5nSFgBU5EC2Ry
         P9sLjDnX7Tva+/iUhTbt0l2lLCMe0deR95raWSS0SmrGSv0UGv7na9xPjfBgH6xcFcte
         admvL6QDxMqH5hnfUxH+dRRvxuSnANwoYK+U66ldI/mgsxvgpN8geON5p4qIs6dQHh+2
         zpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6IkYBzHRtP78kfNNlfDDoZLESVj7tG9rKk+4Qd2VXM=;
        b=x2hGFezUbA0hXHArZaEu2hsx0Q5Ubhd8zfDbyHv/2X+65zukLw34qISPrPqPd9IYAT
         IfG06+iwA+RszrnBN9X2nNqZoHRs7v4Gl7EYSFAVvUV5zFLjOv5umSswCnSgGUzTuB5Q
         nAJbFhwZrJ6YPjgHePz08dEcdJuEZTwQFFRIMBgtrRVkzCWjc63SV6P9NbEsJPsfljjH
         W6d9NGpH1hModtC/KCdnWTXUxTXiWhlBzRnuh28nDrtnAXkihU/azpzn7eqNC/jcdH5G
         2B+OgSVGRYy03XbjU9zlJvdp9so31ZyHW42Av42QAZ6V0eC/0PA6AU5Mzk5X6gGwbazG
         9gIw==
X-Gm-Message-State: AO0yUKWaiipiFP02/2KEMJRk7bZErYXoToGCFgx0GuL+e8yJ6bwUc8tn
        gGGjfuDJLF6mqZDW9Y+5rogwng==
X-Google-Smtp-Source: AK7set/OSp3bTSpScRiuoz93pZ+OMFRFsPgu7NtaeIA7jnL3rY6kaW+n5yFBntYk4y4jdQ04uyNTTg==
X-Received: by 2002:aa7:d417:0:b0:4a0:dadc:c0c2 with SMTP id z23-20020aa7d417000000b004a0dadcc0c2mr3444923edq.27.1675276594967;
        Wed, 01 Feb 2023 10:36:34 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id t13-20020a50d70d000000b00458b41d9460sm10297508edi.92.2023.02.01.10.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:36:34 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/10] clk: qcom: branch: Move CBCR bits definitions to the header file
Date:   Wed,  1 Feb 2023 19:36:19 +0100
Message-Id: <20230201183626.351211-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201183626.351211-1-konrad.dybcio@linaro.org>
References: <20230201183626.351211-1-konrad.dybcio@linaro.org>
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

Move the definitions of CBCR bits to the branch header file.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v4 -> v5:

- New patch

 drivers/clk/qcom/clk-branch.c | 5 -----
 drivers/clk/qcom/clk-branch.h | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index f869fc6aaed6..f2b577b07b7e 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -39,11 +39,6 @@ static bool clk_branch_check_halt(const struct clk_branch *br, bool enabling)
 	return !!val == !enabling;
 }
 
-#define BRANCH_CLK_OFF			BIT(31)
-#define BRANCH_NOC_FSM_STATUS_SHIFT	28
-#define BRANCH_NOC_FSM_STATUS_MASK	0x7
-#define BRANCH_NOC_FSM_STATUS_ON	(0x2 << BRANCH_NOC_FSM_STATUS_SHIFT)
-
 static bool clk_branch2_check_halt(const struct clk_branch *br, bool enabling)
 {
 	u32 val;
diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index fa90e150853b..cff9ed6653b8 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -38,6 +38,10 @@ struct clk_branch {
 };
 
 /* Branch clock common bits for HLOS-owned clocks */
+#define BRANCH_CLK_OFF			BIT(31)
+#define BRANCH_NOC_FSM_STATUS_SHIFT	28
+#define BRANCH_NOC_FSM_STATUS_MASK	0x7
+#define BRANCH_NOC_FSM_STATUS_ON	(0x2 << BRANCH_NOC_FSM_STATUS_SHIFT)
 #define CBCR_FORCE_MEM_CORE_ON		BIT(14)
 #define CBCR_FORCE_MEM_PERIPH_ON	BIT(13)
 #define CBCR_FORCE_MEM_PERIPH_OFF	BIT(12)
-- 
2.39.1

