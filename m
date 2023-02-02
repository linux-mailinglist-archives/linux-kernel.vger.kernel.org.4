Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67677688922
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjBBVqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjBBVqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:46:37 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822B72CC78
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:46:36 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id ip10-20020a17090b314a00b002303f0e68b9so2722307pjb.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 13:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sqjPMfmLxZrl/TWFcH17PAhRzTWGvIwQzKrdbPB0S9A=;
        b=CA4CJlGWskzNxH2h8ZMiOPFchibTfurO0Fbgdjihj/R5MzlnFqNXe2yBBFpXwizOUR
         gHbvQGM0bMarxb5XGfljV2xcFznb8l413rxUe/VLu/B8FessIkKqxgb5aJ+gKYWS30CE
         nRnsrJbJcOmAr5hCoHQBskcgIBKCW0wTtd5qkZqJ4ECYFOr+JGi4e+WqTsbK8Cd1CZib
         iuBsLnPekmtvrmNv/q9vxUi3lYqCn+K2rJb53LkUtQ7w5lqeenOhLyV8f8rPpEG92wtf
         Y1qNmEhYLeEni1mOeUvkLH4wRM+XrrMAOqWDgRTkL4Xh3Elu5jzDAvtmn2tNfw8ARKWE
         X8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sqjPMfmLxZrl/TWFcH17PAhRzTWGvIwQzKrdbPB0S9A=;
        b=Erhdx+lQy9S6TbRNLYNN489l5NgxqV2owWAH6VUcN9P2y0c6+HEsEWZ1ebflZq19lH
         VzGZWXhekotKK//QxAHBkR77/3aOKF9k8wpYUQhJky2U72mhvM5EtctGPNi5r2CRCCXq
         ugWLpHHaffRdLwyh9oSKmEXhKQN7Q2ZXd7ZiOLllwvIaVa/wvC6NsUr2MR8+F9P1tUg+
         /tG98VN7xqOy4BiaunVl/ohnqvxnhJtF2f2jjD+wQcnY7rmETbXh3cG7YiQjBZCxQnNP
         I+XOavybMpxaLnClfXUh72rJJZ8STLDdxHAmVlT8ArPSqxZYXEwrXXm5CuitnZFgXD4H
         hD1Q==
X-Gm-Message-State: AO0yUKXRIOAJK1xTP109BoVZq68FMw10jkEdb8Urol6Sel79jMNB4JeC
        bxzQF7IH0Oy47T2d9WC0nfzVwGmjLg==
X-Google-Smtp-Source: AK7set8TKkCOJWn4gfNwVo2vHevcSDPJfG1Garbim9S45xuvfm1uPUtiwByLC9JT5cuiqONGdhwaL4p5C9k=
X-Received: from yabinc3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:1274])
 (user=yabinc job=sendgmr) by 2002:a17:90a:3cc4:b0:230:6d87:390b with SMTP id
 k4-20020a17090a3cc400b002306d87390bmr160510pjd.99.1675374395962; Thu, 02 Feb
 2023 13:46:35 -0800 (PST)
Date:   Thu,  2 Feb 2023 21:46:32 +0000
In-Reply-To: <CALJ9ZPNrF-HhUNskr=_MJ1CrnO+0xzSN8pMpER3FMqf5Pd0idg@mail.gmail.com>
Mime-Version: 1.0
References: <CALJ9ZPNrF-HhUNskr=_MJ1CrnO+0xzSN8pMpER3FMqf5Pd0idg@mail.gmail.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202214633.12584-1-yabinc@google.com>
Subject: [PATCH v3] coresight: tmc: Don't enable TMC when it's not ready.
From:   Yabin Cui <yabinc@google.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>
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

If TMC ETR is enabled without being ready, in later use we may
see AXI bus errors caused by accessing invalid addresses.

Signed-off-by: Yabin Cui <yabinc@google.com>
---
V1 -> V2: Make change to all TMCs instead of just ETR
V2 -> V3: Handle etr enable failure in tmc_read_unprepare_etr

 .../hwtracing/coresight/coresight-tmc-core.c  |  4 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   | 43 +++++++++++++++----
 .../hwtracing/coresight/coresight-tmc-etr.c   | 25 +++++++++--
 drivers/hwtracing/coresight/coresight-tmc.h   |  2 +-
 4 files changed, 59 insertions(+), 15 deletions(-)

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
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 4c4cbd1f7258..2840227e9135 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -16,12 +16,19 @@
 static int tmc_set_etf_buffer(struct coresight_device *csdev,
 			      struct perf_output_handle *handle);
 
-static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
+static int __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 {
+	int rc = 0;
+
 	CS_UNLOCK(drvdata->base);
 
 	/* Wait for TMCSReady bit to be set */
-	tmc_wait_for_tmcready(drvdata);
+	rc = tmc_wait_for_tmcready(drvdata);
+	if (rc) {
+		dev_err(&drvdata->csdev->dev, "fails to enable not ready TMC\n");
+		CS_LOCK(drvdata->base);
+		return rc;
+	}
 
 	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
 	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
@@ -33,6 +40,7 @@ static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 	tmc_enable_hw(drvdata);
 
 	CS_LOCK(drvdata->base);
+	return rc;
 }
 
 static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
@@ -42,8 +50,10 @@ static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 	if (rc)
 		return rc;
 
-	__tmc_etb_enable_hw(drvdata);
-	return 0;
+	rc = __tmc_etb_enable_hw(drvdata);
+	if (rc)
+		coresight_disclaim_device(drvdata->csdev);
+	return rc;
 }
 
 static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
@@ -91,12 +101,19 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 	coresight_disclaim_device(drvdata->csdev);
 }
 
-static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
+static int __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 {
+	int rc = 0;
+
 	CS_UNLOCK(drvdata->base);
 
 	/* Wait for TMCSReady bit to be set */
-	tmc_wait_for_tmcready(drvdata);
+	rc = tmc_wait_for_tmcready(drvdata);
+	if (rc) {
+		dev_err(&drvdata->csdev->dev, "fails to enable not ready TMC\n");
+		CS_LOCK(drvdata->base);
+		return rc;
+	}
 
 	writel_relaxed(TMC_MODE_HARDWARE_FIFO, drvdata->base + TMC_MODE);
 	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI,
@@ -105,6 +122,7 @@ static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 	tmc_enable_hw(drvdata);
 
 	CS_LOCK(drvdata->base);
+	return rc;
 }
 
 static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
@@ -114,8 +132,10 @@ static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 	if (rc)
 		return rc;
 
-	__tmc_etf_enable_hw(drvdata);
-	return 0;
+	rc = __tmc_etf_enable_hw(drvdata);
+	if (rc)
+		coresight_disclaim_device(drvdata->csdev);
+	return rc;
 }
 
 static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
@@ -639,6 +659,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 	char *buf = NULL;
 	enum tmc_mode mode;
 	unsigned long flags;
+	int rc = 0;
 
 	/* config types are set a boot time and never change */
 	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETB &&
@@ -664,7 +685,11 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 		 * can't be NULL.
 		 */
 		memset(drvdata->buf, 0, drvdata->size);
-		__tmc_etb_enable_hw(drvdata);
+		rc = __tmc_etb_enable_hw(drvdata);
+		if (rc) {
+			spin_unlock_irqrestore(&drvdata->spinlock, flags);
+			return rc;
+		}
 	} else {
 		/*
 		 * The ETB/ETF is not tracing and the buffer was just read.
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 867ad8bb9b0c..4952425dd6e4 100644
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
+		dev_err(&drvdata->csdev->dev, "fails to enable not ready TMC\n");
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
@@ -1750,6 +1762,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 {
 	unsigned long flags;
 	struct etr_buf *sysfs_buf = NULL;
+	int rc = 0;
 
 	/* config types are set a boot time and never change */
 	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
@@ -1764,7 +1777,11 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 		 * buffer. Since the tracer is still enabled drvdata::buf can't
 		 * be NULL.
 		 */
-		__tmc_etr_enable_hw(drvdata);
+		rc = __tmc_etr_enable_hw(drvdata);
+		if (rc) {
+			spin_unlock_irqrestore(&drvdata->spinlock, flags);
+			return rc;
+		}
 	} else {
 		/*
 		 * The ETR is not tracing and the buffer was just read.
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
2.39.1.519.gcb327c4b5f-goog

