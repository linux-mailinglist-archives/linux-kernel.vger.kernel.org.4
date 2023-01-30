Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F218768151B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbjA3PdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbjA3PdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:33:10 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A065A3D08F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:33:08 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qw12so16938500ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klMFULevlZRSdq/t6HkLJjoWsUEq+5/M/OvadlOEDJ8=;
        b=TufXggk+98chwa+9EqnSSCJyj3NeVAN/J4oKU6XwYsgHnTNNyMoIDpFKet588OlBv/
         +evgBQr33NkssDSzsH7RIV+gScR538nB2jvVFjdmgrNu2t04Bq/UHxqiCDpmHnwnhhaV
         rA2dqPMQUxzAYChNF4hCjZ/yuvUmP3ChYlIl1I8SHR5X0tciHJxWfZtqaJ6yjn93Qk/q
         YclnhK7OsmRvbHhd5xExjF3EbMozJxbVdZBWcAgqNaBzIvxBAgVaj0O3YFR+ZL0NPYyu
         jWlPLvDW9fYA2JzjW7j2GoOnW+WbLdXBhLn/9je9vi9b6mSi74hyTP6khKC0nT7NpQlQ
         atIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klMFULevlZRSdq/t6HkLJjoWsUEq+5/M/OvadlOEDJ8=;
        b=7yXKS4he5QXAb7bRfpLOcLQUGIO6htu3BTgZEANyYeuwsNLmReZW7aI9zdjCJHc6a6
         AX/hE7Yn1Et9FUXs88hwTdbU9bYX5fCRXcDFZYXDK2Trz+9yD/iKCdKqmd+wZnVqMb4q
         YXMrfpBzBPyBnVdPodRGN4jyXTIuDZVy/X89qnPQnhV3L8kWPtjbgekwZzrbmI2BEH0G
         7f6UYqtXPjUgGjmP8JFk/uSThuUH1uRM6S8u4Oe86lBCP+4f0wjKFIn5dnsxWjaOe2or
         5Za4oOL6+MOciSnQqqHNfZmzdD1wBEbLhj8a8FSCa/2kIhBwxU0UFMso2c/d+UoQFxuM
         qSNg==
X-Gm-Message-State: AO0yUKWMH8ye7FqrJD1UTPRPs2asvcqhoFzQxbqFJog92/RnMAjoxH1B
        HzbiaFGE4sRI5HFFY9BFD/DmXg==
X-Google-Smtp-Source: AK7set/8thb0RPFSzYQ4tFMVEuWkNDGEJkgsXS0/hVDeS6KIu/w/acJ5fN0fMIHFjeuw+1SJ4t76HA==
X-Received: by 2002:a17:906:9bd8:b0:883:ba98:204d with SMTP id de24-20020a1709069bd800b00883ba98204dmr8557395ejc.65.1675092787251;
        Mon, 30 Jan 2023 07:33:07 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id k7-20020a170906054700b00878769f1e6bsm6805773eja.55.2023.01.30.07.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:33:06 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] clk: qcom: branch: Add SLEEP/WAKE fields definitions
Date:   Mon, 30 Jan 2023 16:32:46 +0100
Message-Id: <20230130153252.2310882-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130153252.2310882-1-konrad.dybcio@linaro.org>
References: <20230130153252.2310882-1-konrad.dybcio@linaro.org>
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
state.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v2 -> v3:

- New patch

 drivers/clk/qcom/clk-branch.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index d8fc7b93ef6d..773f760a4590 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -41,6 +41,8 @@ struct clk_branch {
 #define CBCR_FORCE_MEM_CORE_ON		BIT(14)
 #define CBCR_FORCE_MEM_PERIPH_ON	BIT(13)
 #define CBCR_FORCE_MEM_PERIPH_OFF	BIT(12)
+#define CBCR_WAKEUP			GENMASK(11, 8)
+#define CBCR_SLEEP			GENMASK(7, 4)
 
 static inline void qcom_branch_set_force_mem_core(struct regmap *regmap, u32 reg, bool on)
 {
-- 
2.39.1

