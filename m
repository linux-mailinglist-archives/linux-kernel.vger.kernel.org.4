Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6206C5F5100
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJEIiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJEIiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:38:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E615072FDC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 01:38:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f11so22190719wrm.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EeAiRegJpB0iE5xwNj8sJLpx3MJbnRtOGu7e95kFXvI=;
        b=AMyMDquDAGH4PLFHdv82M1yeUIpUEh7Pw3mVXe81db3GeQKFHmKDaovL/L/wnL+jSU
         k1TU1NwEMmzrkDyDk5IJqgNxDDQzQJGYtKPLa3dqP83Hj6h0Z4lmeNqWjSnd2+wY5hxl
         /yRWoUzpGULLorPTOnLrRxe0FwpSE0E9GgvqGgzAERlu/VwnY4biHVKx2Gp0jfFCUtq4
         U1yRZRv2ooce6vBNyZkVS1Jn81+7XEM19x4mvgXv6y54jp4lmJIDqwcb1G6brTZvQa9I
         6GjWWz0TYC0ADz6L61JCFAfUkgeVgqAzl2x6I9RROcvgAfjU+5+V3MesIySeJ+PbEO8B
         JlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EeAiRegJpB0iE5xwNj8sJLpx3MJbnRtOGu7e95kFXvI=;
        b=ucwPEf1EKxJ3H3+JIPj8MQjz5NMvRHTyVHPiedySk0uHVXb4wgGt3BGe3pN29dqJ38
         TsqmXXeoXY49ZZtC2pBlmLjAbIDT9bDHMFHstAD4JSi3WdAizTjVFHula8EOlx/MXbR1
         bvgA0icHz3ZmVdVh5Mryv0u4QwTQjyfE4aR+sUu9f6QMQfvY4NVQsD/ylswYzi2DxyoX
         nD9vZCl0MAbtcnn49VUNXdGBPxNsgML+anJxOcuthMVGUYIzxk7LY4ChOPI8XuLfPx+o
         8YluqvUCC7LTAablRULvuxdX+IapwC1IF7Tp8ZZQweZtM3TvQYnO5HhLHVolP/P/Re74
         XB/Q==
X-Gm-Message-State: ACrzQf1VYbs8eA+3QAgLtbp4XYpyLdzDHmMLRZMHRohEfmGK5ZhxTP+D
        dltq1bRJoO0aNzlYqeoAziUliQ==
X-Google-Smtp-Source: AMsMyM5ocPfLtUnWEnDkVlnPSjEZYeLkAp3Fm9mx+gat6KnREHhBZ4rWurWwGgu7VcFvjREmKsr3XQ==
X-Received: by 2002:adf:e60d:0:b0:22c:d483:5ee1 with SMTP id p13-20020adfe60d000000b0022cd4835ee1mr18175649wrm.641.1664959079391;
        Wed, 05 Oct 2022 01:37:59 -0700 (PDT)
Received: from localhost.localdomain (hst-221-6.medicom.bg. [84.238.221.6])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b003b47e75b401sm1318171wmo.37.2022.10.05.01.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 01:37:58 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 3/3] venus: firmware: Correct assertion of reset bit on remote processor
Date:   Wed,  5 Oct 2022 11:37:30 +0300
Message-Id: <20221005083730.963322-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005083730.963322-1-stanimir.varbanov@linaro.org>
References: <20221005083730.963322-1-stanimir.varbanov@linaro.org>
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

Currently we use read/write_relaxed in combination with mb() to assert
reset. This looks wrong because mb() after write_relaxed() will not
order correctly load-update-store sequence. Correct this by use
readl/writel which include memory barriers.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/firmware.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 71e43611d1cf..142d4c74017c 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -181,17 +181,15 @@ static int venus_shutdown_no_tz(struct venus_core *core)
 
 	if (IS_V6(core)) {
 		/* Assert the reset to XTSS */
-		reg = readl_relaxed(wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
+		reg = readl(wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
 		reg |= WRAPPER_XTSS_SW_RESET_BIT;
-		writel_relaxed(reg, wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
+		writel(reg, wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
 	} else {
 		/* Assert the reset to ARM9 */
-		reg = readl_relaxed(wrapper_base + WRAPPER_A9SS_SW_RESET);
+		reg = readl(wrapper_base + WRAPPER_A9SS_SW_RESET);
 		reg |= WRAPPER_A9SS_SW_RESET_BIT;
-		writel_relaxed(reg, wrapper_base + WRAPPER_A9SS_SW_RESET);
+		writel(reg, wrapper_base + WRAPPER_A9SS_SW_RESET);
 	}
-	/* Make sure reset is asserted before the mapping is removed */
-	mb();
 
 	iommu = core->fw.iommu_domain;
 
-- 
2.25.1

