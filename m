Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F906921AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjBJPKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjBJPKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:10:24 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070123EC5D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:10:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so6503313wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y30ATMpLL1p4sSwUhQyjHL/c3brIpR/bscArWLHO7lI=;
        b=GGmHtQVXt/y7Gf70PAxFkbRl2K3rbN4eQbpOp9jBgJIVukppqlJ4dIqqyjbLHzcC90
         49LbKn/X4chqRjUB5AU7itVq2yGdaBZ9EPK5ibJbrwFPBbw9b+jq2MrxKpOLX2iNU5l2
         CzPchIYQXKdAaN0+ukZU4doAloHwNmXJPlDyXpM/itGD/uWX/v7j4ar/hCFuhjbaGvTS
         SNRt4Mrkat2plsvjmEstWqmvO3mg1qF7NNKFBCFw9WuqpLoJEcFPgiNHA90/s2wHV/A3
         G7X3yebzB5o87am0AOxRi9yzv1pbzQFBIIneoQNvo8HKT36bdbN6KmmkG+eRiMhwHX4L
         1bmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y30ATMpLL1p4sSwUhQyjHL/c3brIpR/bscArWLHO7lI=;
        b=gA3rYq5a6aq7uiMVZFZmGypHL/2jx2n//DSnGJe6uvONM4mqwxmbHhrF+ujs0tHKw4
         LfyuV/I2KdGLlGXGaWCc8aL61zJ6sEJtFI0ZnaiYQPDU1b06sTpAXgpluSnzFUUJfQiB
         ReQqUiT+JLA6eBatZD8RdAA5emEQ5x1KyzuC+J+A17rD3jbjWNPKAhjzWStnfW5FRgs8
         A64wD5Ogr4/uPm90Jmv2oZR2X+QOKChEE8wuOFvvhUVVkHgSrBlXahp98gOTrc0txpxY
         2un72MBFOaSJ+HXHIy8ngiU4V5p8knvRkDILSFDb1WdshbqzB8G+K1cyMZUhYpp1qR+g
         cP7A==
X-Gm-Message-State: AO0yUKXXt4U5VuyNyj1EaBTIT/1aMod0ynHPM0Ob9QksVIro7+kEg+RI
        xHpWOfJsG9GvOlFtvupak7V8og==
X-Google-Smtp-Source: AK7set8eCMDn9dJoiFXBhY9Qctg7aCPwRdmw5nKICGViJS8cWrEchk5Wh2a2gkwdmFoIs0Z/wSoYkg==
X-Received: by 2002:a05:600c:9a2:b0:3dc:576c:ab07 with SMTP id w34-20020a05600c09a200b003dc576cab07mr13027845wmp.14.1676041816571;
        Fri, 10 Feb 2023 07:10:16 -0800 (PST)
Received: from linaro.org ([2a00:23c5:680a:d01:61c3:70d8:6500:e102])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003db0ee277b2sm8587771wmq.5.2023.02.10.07.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:10:15 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, yabinc@google.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 3/3] coresight: etf: etr: Update logging around flush_and_stop() errors
Date:   Fri, 10 Feb 2023 15:10:08 +0000
Message-Id: <20230210151008.4587-4-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230210151008.4587-1-mike.leach@linaro.org>
References: <20230210151008.4587-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Insert additional context around tmc_flush_and_stop() errors.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 12 +++++++++---
 drivers/hwtracing/coresight/coresight-tmc-etr.c |  8 ++++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 0ab1f73c2d06..c8a4d4eff64f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -84,7 +84,9 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
-	tmc_flush_and_stop(drvdata);
+	if (tmc_flush_and_stop(drvdata))
+		dev_err(&drvdata->csdev->dev,
+			"Flush and stop error disabling ETB\n");
 	/*
 	 * When operating in sysFS mode the content of the buffer needs to be
 	 * read before the TMC is disabled.
@@ -146,7 +148,9 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 
 	CS_UNLOCK(drvdata->base);
 
-	tmc_flush_and_stop(drvdata);
+	if (tmc_flush_and_stop(drvdata))
+		dev_err(&drvdata->csdev->dev,
+			"Flush and stop error disabling ETF\n");
 	tmc_disable_hw(drvdata);
 	coresight_disclaim_device_unlocked(csdev);
 	CS_LOCK(drvdata->base);
@@ -492,7 +496,9 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 
 	CS_UNLOCK(drvdata->base);
 
-	tmc_flush_and_stop(drvdata);
+	if (tmc_flush_and_stop(drvdata))
+		dev_err(&drvdata->csdev->dev,
+			"Flush and stop error updating perf buffer\n");
 
 	read_ptr = tmc_read_rrp(drvdata);
 	write_ptr = tmc_read_rwp(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 918d461fcf4a..ceae6a093612 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1145,7 +1145,9 @@ static void __tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
-	tmc_flush_and_stop(drvdata);
+	if (tmc_flush_and_stop(drvdata))
+		dev_err(&drvdata->csdev->dev,
+			"Flush and stop error disabling ETR\n");
 	/*
 	 * When operating in sysFS mode the content of the buffer needs to be
 	 * read before the TMC is disabled.
@@ -1548,7 +1550,9 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 
 	CS_UNLOCK(drvdata->base);
 
-	tmc_flush_and_stop(drvdata);
+	if (tmc_flush_and_stop(drvdata))
+		dev_err(&csdev->dev,
+			"Flush and Stop error updating perf buffer\n");
 	tmc_sync_etr_buf(drvdata);
 
 	CS_LOCK(drvdata->base);
-- 
2.17.1

