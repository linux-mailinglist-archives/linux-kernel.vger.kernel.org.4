Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0159973874D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjFUOki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjFUOk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:40:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984041735
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:40:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51a2c8e5a2cso8103917a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687358427; x=1689950427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUE1natntFFJxsuWsetQCXUchTahXfnKhHb9xOBxGoI=;
        b=qNLgGH6/U2CxKdty9gB9OsWqbEI66/eB1ycqZqWjUDLPw5Qp7zQZpAebwvhHwycK8e
         zmTYkehL8diU3hTT2idtJjbZNc4XpTUHXziQ+croXRzw+ZBfuY/t7WvTOOd5LyAcrQs7
         5/s3LofdWZEf9wiA9bLxBNR8Oq/ubOb9ql5blfWJyzlK6AO650+QC2cTQerFbgyLDh2W
         xBq+u3m0ErKru6xrL/AayQtWrSMzQUQUhxP8/eBlefpVQDI64L/GlAJhz5F0BiU94jrp
         aEIGxVCMzHO4pHhyZjMB4miUA1jZeFcRyXRZtVZoNQ7iu/q6AYmMOkwJsaDt7vGUtLNv
         lUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687358427; x=1689950427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUE1natntFFJxsuWsetQCXUchTahXfnKhHb9xOBxGoI=;
        b=ctoQxtohjcr6dAUSV3jmJY0z4zgtnsefZ1odoMzVzvNinPTUlaUXFQzD2ADoGXVSM5
         H9SSRx8rLPLAjSLZpSGwWdtuRRsfKIaB7oE1Ejbl3H+pERP8PD4glDhhwXdRXgi118+v
         MBRhJ9m60u8+2sTu0SfY9Es7Ecya6Tcos5pzPI3GdSWSabDf09xMK+jyGK2PQHxOaa2U
         u1nnX7SaNElNC4dtd0RPmovtmYMdM3NJlTS1Tfjefwpvdm/E4D+zaM8PdUjwvpmJz+Bw
         hHW9xUTcFX2V/ZiSrWxD3Dzd/Wh3YZ5pcWALL8NI5xrWQ0WemtPVdoVikELItE55V8vt
         vFPg==
X-Gm-Message-State: AC+VfDwWc1quf1iJ7uBTPtG42jxXcoc4qio2GZ3gRgxS6ooARqJL6g5J
        ETAQkmWoju+oXzV2Zip2308hqg==
X-Google-Smtp-Source: ACHHUZ4HCoMV0tAzMxaR5BKXJ048JX29F/y3Dx69qV2TakWJ7Pc8uAurEkNVP+eicW3QAbAB88GYEA==
X-Received: by 2002:aa7:cf19:0:b0:510:82b4:844d with SMTP id a25-20020aa7cf19000000b0051082b4844dmr11822520edy.2.1687358427133;
        Wed, 21 Jun 2023 07:40:27 -0700 (PDT)
Received: from hackbox.lan ([82.79.124.17])
        by smtp.gmail.com with ESMTPSA id l13-20020a056402344d00b0051879c4f598sm2689505edc.66.2023.06.21.07.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 07:40:26 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Bjorn Andersson <andersson@kernel.org>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [RFC PATCH v5 3/4] PM: domains: Ignore power off request for enabled unused domains
Date:   Wed, 21 Jun 2023 17:40:18 +0300
Message-Id: <20230621144019.3219858-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621144019.3219858-1-abel.vesa@linaro.org>
References: <20230621144019.3219858-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of, safekeep the boot state that is provided on init, then use this
boot state to make decisions whether a power off request should be
ignored or not. In case a domain was left enabled before boot, most
likely such domain is needed and should not be disabled on the 'disable
unused' late initcall, but rather needs to stay powered on until the
consumer driver gets a chance to probe. In order to keep such domain
powered on until the consumer handles it correctly, the domain needs to
be registered by a provider that has a sync_state callback registered
and said provider has state synced.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/base/power/domain.c | 49 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  1 +
 2 files changed, 50 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 51b9d4eaab5e..5967ade160e2 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -654,6 +654,43 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
 	queue_work(pm_wq, &genpd->power_off_work);
 }
 
+/**
+ * genpd_keep_on - Tells if the domain should skip the power 'off' request
+ * @genpd: PM domain to be checked.
+ *
+ * If the domain's current state meets the following conditions:
+ *  - marked for being kept as enabled
+ *  - has a provider with a sync state callback registered
+ *  - the provider hasn't state synced yet
+ * then the power 'off' request should be skipped.
+ *
+ * This function should only be called from genpd_power_off and with
+ * the lock held.
+ */
+static inline bool genpd_keep_on(struct generic_pm_domain *genpd)
+{
+	bool ret = false;
+
+	if (!(genpd->boot_keep_on))
+		return false;
+
+	if (!genpd->has_provider)
+		goto out;
+
+	if (!dev_has_sync_state(genpd->provider->dev))
+		goto out;
+
+	if (dev_is_drv_state_synced(genpd->provider->dev))
+		goto out;
+
+	return true;
+
+out:
+	genpd->boot_keep_on = false;
+
+	return ret;
+}
+
 /**
  * genpd_power_off - Remove power from a given PM domain.
  * @genpd: PM domain to power down.
@@ -682,6 +719,13 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	if (!genpd_status_on(genpd) || genpd->prepared_count > 0)
 		return 0;
 
+	/*
+	 * If the domain is enabled and unused, bail out and ignore
+	 * the 'off' request until the provider has state synced.
+	 */
+	if (genpd_keep_on(genpd))
+		return -EBUSY;
+
 	/*
 	 * Abort power off for the PM domain in the following situations:
 	 * (1) The domain is configured as always on.
@@ -2065,6 +2109,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	atomic_set(&genpd->sd_count, 0);
 	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
 	genpd->device_count = 0;
+	genpd->boot_keep_on = !is_off;
 	genpd->provider = NULL;
 	genpd->has_provider = false;
 	genpd->accounting_time = ktime_get_mono_fast_ns();
@@ -2718,6 +2763,10 @@ static void genpd_dev_pm_sync(struct device *dev)
 	if (IS_ERR(pd))
 		return;
 
+	genpd_lock(pd);
+	pd->boot_keep_on = false;
+	genpd_unlock(pd);
+
 	genpd_queue_power_off_work(pd);
 }
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f776fb93eaa0..3eb32c4b6d4f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -131,6 +131,7 @@ struct generic_pm_domain {
 	const char *name;
 	atomic_t sd_count;	/* Number of subdomains with power "on" */
 	enum gpd_status status;	/* Current state of the domain */
+	bool boot_keep_on;	/* Keep enabled during 'disable unused' late initcall */
 	unsigned int device_count;	/* Number of devices */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
-- 
2.34.1

