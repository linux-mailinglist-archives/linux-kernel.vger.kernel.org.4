Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B947466357F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbjAIXnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbjAIXnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:43:17 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A75263C9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:43:16 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id b196-20020a621bcd000000b0058a63dc105eso349714pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FJqodOVZ3N83/BqsgJaqpNXe1RkJlGSQQAWmq9op64U=;
        b=T9qbe/GuQxKBRu1v0S/FfY2XTEaEQzUmiO4VhaVhoSt+YjxMec+P2RIRQwmD2ZxObM
         m+o6s+0/2L/UBGkzH46WN0vcByupJvxQJFYvDNgNkzAkr+1l0aAPSDKAJGJga0vyIYmA
         iKFeN8YqnxfvnOsDJoc6AOmKJa9QG/TflLnM4yH29/zmNzw3GJNCoeOjJoEgkRQ4hOsI
         IvogbotG3D2+h4SkOWIVPk+o6KV1EP2QmqJ9slT5MFf9PPQtp98EkjsXEV1kLYcUr3Uu
         1EN9Aqeyy81zW3fChcIKGJsnMQdND5TLryZ3hHzpmD9/8orCqFSxJXVZPq2S1rMgmF4S
         stKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJqodOVZ3N83/BqsgJaqpNXe1RkJlGSQQAWmq9op64U=;
        b=47dEzsBAOBvf2L65GZgMQHjSuyrxMlUqpH1/iGEWyV6iXlsT4KXfut7lkExWU2xGzt
         cytPQ4wIrYIkK7wcVJDCKWyCsV/sjAsaW7z92fkLjYPSEV01h0sFSdz2+e0FSd6Sxj9i
         eNE5qBOW2cIDJQt2pcM5qqcrygiMs0PlQwSxswyma90ozrAwhEZWPu1B7IoltTnZ88Gl
         RHfP4zuymKcuF9DkrK0w0iRgN4pdlGk2s9rLLm7D/iz6Yc2n5MxvNK/jeS/U2/q51YcR
         619AZva3O2AMsIJUBCjEDI9H4yFvbighDLTAGEGdudMCjZAwR+hxsyiqb4BotThJyxaI
         FjdQ==
X-Gm-Message-State: AFqh2kqoaU/uKTQNkngwgYmloJBgEnAoNJGCl2lW1f0yoHyaz34UtUAS
        AxhZ2amoYX4yOhnP9KCftzjCbF8gZA==
X-Google-Smtp-Source: AMrXdXsLWu88orFDYRQBDp4f7C2u/Chbt1axITWfT9KYKOeJ2E9zlZn9urjdaUUZAeDv6tZVY9kgNu5M+6k=
X-Received: from yabinc3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:1274])
 (user=yabinc job=sendgmr) by 2002:a17:902:ef45:b0:189:1318:714 with SMTP id
 e5-20020a170902ef4500b0018913180714mr5048085plx.122.1673307795909; Mon, 09
 Jan 2023 15:43:15 -0800 (PST)
Date:   Mon,  9 Jan 2023 23:43:12 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109234312.2870846-1-yabinc@google.com>
Subject: [PATCH] coresight: tmc-etr: Don't enable ETR when it's not ready
From:   Yabin Cui <yabinc@google.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, it may cause error in AXI bus and result in a kernel panic.

Signed-off-by: Yabin Cui <yabinc@google.com>
---
 .../hwtracing/coresight/coresight-tmc-core.c   |  4 +++-
 .../hwtracing/coresight/coresight-tmc-etr.c    | 18 +++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc.h    |  2 +-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 07abf28ad725..c106d142e632 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -31,7 +31,7 @@ DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
 DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
 DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
 
-void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
+int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
 {
 	struct coresight_device *csdev = drvdata->csdev;
 	struct csdev_access *csa = &csdev->access;
@@ -40,7 +40,9 @@ void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
 	if (coresight_timeout(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
 		dev_err(&csdev->dev,
 			"timeout while waiting for TMC to be Ready\n");
+		return -EBUSY;
 	}
+	return 0;
 }
 
 void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 867ad8bb9b0c..2da99dd41ed6 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -983,15 +983,21 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
 	etr_buf->ops->sync(etr_buf, rrp, rwp);
 }
 
-static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
+static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 {
 	u32 axictl, sts;
 	struct etr_buf *etr_buf = drvdata->etr_buf;
+	int rc = 0;
 
 	CS_UNLOCK(drvdata->base);
 
 	/* Wait for TMCSReady bit to be set */
-	tmc_wait_for_tmcready(drvdata);
+	rc = tmc_wait_for_tmcready(drvdata);
+	if (rc) {
+		dev_err(&drvdata->csdev->dev, "not ready ETR isn't enabled\n");
+		CS_LOCK(drvdata->base);
+		return rc;
+	}
 
 	writel_relaxed(etr_buf->size / 4, drvdata->base + TMC_RSZ);
 	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
@@ -1032,6 +1038,7 @@ static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 	tmc_enable_hw(drvdata);
 
 	CS_LOCK(drvdata->base);
+	return rc;
 }
 
 static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
@@ -1060,7 +1067,12 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 	rc = coresight_claim_device(drvdata->csdev);
 	if (!rc) {
 		drvdata->etr_buf = etr_buf;
-		__tmc_etr_enable_hw(drvdata);
+		rc = __tmc_etr_enable_hw(drvdata);
+		if (rc) {
+			drvdata->etr_buf = NULL;
+			coresight_disclaim_device(drvdata->csdev);
+			tmc_etr_disable_catu(drvdata);
+		}
 	}
 
 	return rc;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 66959557cf39..01c0382a29c0 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -255,7 +255,7 @@ struct tmc_sg_table {
 };
 
 /* Generic functions */
-void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
+int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
 void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
 void tmc_enable_hw(struct tmc_drvdata *drvdata);
 void tmc_disable_hw(struct tmc_drvdata *drvdata);
-- 
2.39.0.314.g84b9a713c41-goog

