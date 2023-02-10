Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67A86921AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjBJPK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjBJPKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:10:24 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0D4B440
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:10:16 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso6495232wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=adIPNQyKxDd1RuPK4zL9OpTeZ2XD9I/+wxj+DVdGgI0=;
        b=ps/i48xY7OTd8AHo0A09urvF94RXGDUUF2uqa3Qb3qPCVs6MBw2zl72LuGRcivC0n5
         Zf60Yr+29BTihaSvM/AVfvJoiIYUCde8S59w7wqg4AI98ueD0otRTQoWa4AvTYvapTc8
         MprdpV4zxU8u8k6mbwGiFH4dZpBI5KwjNZLLEb5yMCea1iIjva9QO7aFCibo5RNilHZ8
         +V+3e2b3qXqlQvAsEzCQ6mmjZ6IBwIV+QtNY1WPKDruiuD/vGMchgDL+rtwcO19ZrY9e
         bDI0000zOtUY9IHvZztVfw8p0HklEmgB0Dnf/kUFF5pgo/s8ap4vuqNRgdrIe3Qjy2Qe
         Wt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adIPNQyKxDd1RuPK4zL9OpTeZ2XD9I/+wxj+DVdGgI0=;
        b=QkLGMFcKthmBCP+6fq7WHzyB5g1SP8d4RmdKbe1OUjW9J2JkSQUbGtZGmsOdWN/ZLZ
         pAbIH97xaAjyJbjtWSvUaoxmBSKTKJNRlFxeQwhOSMNG2v+PNSUAOIdJwGTiD6vDf3P0
         d2ba3EnSCRmDHtjvpzrjXJuNj0QTChck4LFK1EKc86aDbJpaZ8lqmys3VhWx0qeykg6x
         0dE2bFd39tvNel9zL1u3lV5ujRuVdm11f4W9k3H5SFkKncriBr6Y8OnoNFhpYw60l0+L
         XS/yGN11DDSEbaFojhqcmoShC7KmXDFj/nGFPBD2VzsXHkyMkUBiyyyB0DzAYvO1Lh7t
         f3Cw==
X-Gm-Message-State: AO0yUKUDpoFf2dKw3vpNw1FvgVQZv75+gyoFLrkc8xKfm6o9vFTjKSJh
        rzd6i5ncQO8+P3e3zpEwv8bLWA==
X-Google-Smtp-Source: AK7set9fKSGwP/RWViQy85RqPAZSLf97pmWbONz27jW18E4EKt6F9/VhTsH1UFLZlcOFQQo0nPVXRQ==
X-Received: by 2002:a05:600c:4910:b0:3dc:1dc3:7a05 with SMTP id f16-20020a05600c491000b003dc1dc37a05mr13295789wmp.10.1676041815276;
        Fri, 10 Feb 2023 07:10:15 -0800 (PST)
Received: from linaro.org ([2a00:23c5:680a:d01:61c3:70d8:6500:e102])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003db0ee277b2sm8587771wmq.5.2023.02.10.07.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:10:14 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, yabinc@google.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 2/3] coresight: tmc: Update error logging in tmc common functions
Date:   Fri, 10 Feb 2023 15:10:07 +0000
Message-Id: <20230210151008.4587-3-mike.leach@linaro.org>
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

Enhance the error logging in the tmc_wait_for_tmcready() and
tmc_flush_and_stop() to print key tmc  register values on error
conditions to improve hardware debug information.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../hwtracing/coresight/coresight-tmc-core.c  | 37 +++++++++++++++----
 drivers/hwtracing/coresight/coresight-tmc.h   |  2 +-
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index c106d142e632..f048f450843d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -31,25 +31,36 @@ DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
 DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
 DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
 
+#define TMC_WAIT_READY_FMT_STR "timeout while waiting for TMC to be Ready [STS=0x%04x]\n"
+
 int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
 {
 	struct coresight_device *csdev = drvdata->csdev;
 	struct csdev_access *csa = &csdev->access;
+	u32 tmc_sts = 0;
 
 	/* Ensure formatter, unformatter and hardware fifo are empty */
-	if (coresight_timeout(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
-		dev_err(&csdev->dev,
-			"timeout while waiting for TMC to be Ready\n");
+	if (coresight_timeout_retval(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1,
+				     &tmc_sts)) {
+		dev_err(&csdev->dev, TMC_WAIT_READY_FMT_STR, tmc_sts);
 		return -EBUSY;
 	}
 	return 0;
 }
 
-void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
+int tmc_flush_and_stop(struct tmc_drvdata *drvdata)
 {
 	struct coresight_device *csdev = drvdata->csdev;
 	struct csdev_access *csa = &csdev->access;
-	u32 ffcr;
+	u32 ffcr, ffsr, tmc_sts;
+	int rc = 0;
+
+	/* note any MemErr present when stopping TMC */
+	tmc_sts = readl_relaxed(drvdata->base + TMC_STS);
+	if (tmc_sts & TMC_STS_MEMERR)
+		dev_err(&csdev->dev,
+			"MemErr detected before Manual Flush; STS[0x%02x]\n",
+			tmc_sts);
 
 	ffcr = readl_relaxed(drvdata->base + TMC_FFCR);
 	ffcr |= TMC_FFCR_STOP_ON_FLUSH;
@@ -57,12 +68,22 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
 	ffcr |= BIT(TMC_FFCR_FLUSHMAN_BIT);
 	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
 	/* Ensure flush completes */
-	if (coresight_timeout(csa, TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0)) {
+	if (coresight_timeout_retval(csa, TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0,
+				     &ffcr)) {
+		ffsr = readl_relaxed(drvdata->base + TMC_FFSR);
 		dev_err(&csdev->dev,
-		"timeout while waiting for completion of Manual Flush\n");
+			"timeout while waiting for completion of Manual Flush\n");
+		dev_err(&csdev->dev,
+			"regs: FFCR[0x%02x] FFSR[0x%02x] STS[0x%02x]\n",
+			ffcr, ffsr, tmc_sts);
+		rc = -EBUSY;
 	}
 
-	tmc_wait_for_tmcready(drvdata);
+	if (tmc_wait_for_tmcready(drvdata)) {
+		dev_err(&csdev->dev, "TMC ready error after Manual flush\n");
+		rc = -EBUSY;
+	}
+	return rc;
 }
 
 void tmc_enable_hw(struct tmc_drvdata *drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 01c0382a29c0..314f8244787f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -256,7 +256,7 @@ struct tmc_sg_table {
 
 /* Generic functions */
 int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
-void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
+int tmc_flush_and_stop(struct tmc_drvdata *drvdata);
 void tmc_enable_hw(struct tmc_drvdata *drvdata);
 void tmc_disable_hw(struct tmc_drvdata *drvdata);
 u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata);
-- 
2.17.1

