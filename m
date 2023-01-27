Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA8367F213
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjA0XKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjA0XKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:10:10 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD357922D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:10:08 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id pv1-20020a17090b3c8100b0022c1ab71110so3668463pjb.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2P1ER320HX4etFwmaIZHCBscK1bRkAWPoSVYCiNg6kQ=;
        b=gqrvWb8WsLzrm21Hpwl8GON09RFdnmTBgfJ72A35lLaoXBJkQrztQCWMI9t1r3CLZQ
         VaMLLBW/fatacpOJFqAkSm50kBF6VoVdA7PVn1rO/7zkyt5G5AzggFHEoA4TxXhOJ5zF
         UrMx+Xqn9C1s5rlODBpE2Z12e0/Ok0pERE9LMp0ldP8hvX9NvKvazqxgasv38WUhoQ3K
         kiQmTGjAiMbNV7uvd7CfOf6GbdEnPQhEaiYLZPorxzVb9dGNHgcQEdVyW8swmzwnzor2
         /F6cWqbACmIb9/1190YXzSaY3dklsGpEnS0RWgj/XuBt2+3uvDHBQ9BHtT6XDj6CcydW
         RkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2P1ER320HX4etFwmaIZHCBscK1bRkAWPoSVYCiNg6kQ=;
        b=Zkxc+IAhUs667jyjZj6DukMPHAETm12HtfW74xBPZxXc941+/FoxAvHHBaf1RlsUzm
         eSxw/VMys8b2Bl0lr3qD3OPbNmeLO1qQ0+nIEY6PkLj8AxoyZQHhM+WDroFOrpqGI53o
         Vh7TfAYKAhul2WBNtNYqkUSe3sb2jcd4IGTyG3GP5VCPrfzI4cMINnhDorSDWkBQ+pNN
         RLp3zRPlsDE8n7+x8mYpVZku1AHJjZKufY2GcD3bpTYy1u63eVWlwBfsRfo2bdzCluzq
         CTSkD3W/7eKjsf6acVi96hYgDW1tyYkzoELhqFkuOO3B7BGxPzUKHALASmrLVVh+Zfxi
         QXZw==
X-Gm-Message-State: AFqh2koI5DGZKZ92dwIdjXaEBWR9I94yU+mawNo6ieRMKqW9c0uP6Ok1
        OgNIK8bLHJvPbN7HzM01G1KUy1/SKw==
X-Google-Smtp-Source: AMrXdXsmWjuJe1THzipm6A2CR5G7B0C7qX3LE61bEO0+QeV0D68M67tj4rVaEeEWec8YUV41JxLsV9wbkMw=
X-Received: from yabinc3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:1274])
 (user=yabinc job=sendgmr) by 2002:a17:90a:4a03:b0:225:f003:cd15 with SMTP id
 e3-20020a17090a4a0300b00225f003cd15mr6361651pjh.34.1674861007697; Fri, 27 Jan
 2023 15:10:07 -0800 (PST)
Date:   Fri, 27 Jan 2023 23:10:01 +0000
In-Reply-To: <417c4e3a-6fa8-5210-dd27-669a5d9e255c@arm.com>
Mime-Version: 1.0
References: <417c4e3a-6fa8-5210-dd27-669a5d9e255c@arm.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127231001.1920947-1-yabinc@google.com>
Subject: [PATCH v2] coresight: tmc: Don't enable TMC when it's not ready.
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

 .../hwtracing/coresight/coresight-tmc-core.c  |  4 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   | 43 +++++++++++++++----
 .../hwtracing/coresight/coresight-tmc-etr.c   | 18 ++++++--
 drivers/hwtracing/coresight/coresight-tmc.h   |  2 +-
 4 files changed, 53 insertions(+), 14 deletions(-)

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
index 867ad8bb9b0c..0811cb44588b 100644
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
2.39.1.456.gfc5497dd1b-goog

