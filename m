Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C6A6CAEF0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjC0Tiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjC0Tim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:38:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD202D4D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:38:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b20so40811798edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679945918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3FY60jRaqB/nKnC/ZVyGb5zqQ4bk2PkIiKSObmnrIQ=;
        b=lD3UCQsabNKCxuw+k0jMYVQykNzKE6YSURXkPe/4rGzFb32aL1aoerSdBMjZTnpKTP
         PpWSsXoxtkEpx4dLH2U1CVhqaDKoWzpvC1TwrKDy+L4SqN4EOywjXnaBC2OZsDTv1e22
         sxywrgWntliUknEhF3xNZ7JpQhVRpkWtKODlv3/8c0ZFziUJ0lk14dp3gNMnq5w2LQxC
         dsiynBXQuB6Q6mpMt17PeUmaXYWzF3/ID8ScsXbNqwQEvYd3WEjSW+0DY4AFT1sYHcOL
         NnSr3tdPxirCPC5i90vCVYSlQPQG4Rrng1ys+9/rifVwQQ5ZbVjMt8vrToU+VmPNcBtX
         GSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679945918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3FY60jRaqB/nKnC/ZVyGb5zqQ4bk2PkIiKSObmnrIQ=;
        b=40pus94nKVjCXBXzEufmfn4KpZhNTJ/rMQNO1V8kVYN6aJ/ZKl6roWI00nNhWkGm1m
         VOMh4p6H6hafGBeIWRhCrtUboECdQePdF3XuFdv7HO7k9v5etGCYWcDcU4Ft5jygcXKV
         tBFyvzywdTb5Bo2FznisHf90pN7AWQMb7r7Y7l0n4Fr8Lex9HjP0hq4BjMHvQMFTRH61
         dJqFuiGIlzoByKWCMt5Uj5s68EKZdo6IdwgGwBiydCi0tQ0LQulYXNydFIW02rY9Um7h
         h4ajAE1KUTMfeWt3rnZZjr519Ki47HzUiw4OSOIaynM7Y+O5O0nPTneK8yLmH3i958d/
         iRmQ==
X-Gm-Message-State: AAQBX9d55Rg71IHaKjgldL1Zw9KSkSzEo8/2PftwmQ1nz8KhMH/cM108
        U+g3hgS44MsG9iEibZ1ZFktZPA==
X-Google-Smtp-Source: AKy350YSvT3xVHjl1UJksa71FJRcStTLZfE1yVgC7y3c2td7z3w2N40AV4VOuwkl/+jDfmgfSLXudg==
X-Received: by 2002:a17:906:8398:b0:8f6:88b7:73a7 with SMTP id p24-20020a170906839800b008f688b773a7mr12275694ejx.7.1679945918715;
        Mon, 27 Mar 2023 12:38:38 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id kb1-20020a1709070f8100b00933c4a25735sm11701254ejc.100.2023.03.27.12.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:38:38 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 1/4] PM: domains: Allow power off queuing from providers
Date:   Mon, 27 Mar 2023 22:38:26 +0300
Message-Id: <20230327193829.3756640-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327193829.3756640-1-abel.vesa@linaro.org>
References: <20230327193829.3756640-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, the providers might choose to refuse powering off some
domains until all of the consumers have had a chance to probe, that is,
until sync state callback has been called. Such providers might choose
to disable such domains on their own, from the sync state callback. So,
in order to do that, they need a way to queue up a power off request.
Since the generic genpd already has such API, make that available to
those providers.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 18 ++++++++++--------
 include/linux/pm_domain.h   |  4 ++++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 32084e38b73d..209b8152e948 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -643,16 +643,18 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 }
 
 /**
- * genpd_queue_power_off_work - Queue up the execution of genpd_power_off().
+ * pm_genpd_queue_power_off - Queue up the execution of genpd_power_off().
  * @genpd: PM domain to power off.
  *
  * Queue up the execution of genpd_power_off() unless it's already been done
- * before.
+ * before. The sole purpose of this being exported is to allow the providers
+ * to disable the unused domains from their sync_state callback.
  */
-static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
+void pm_genpd_queue_power_off(struct generic_pm_domain *genpd)
 {
 	queue_work(pm_wq, &genpd->power_off_work);
 }
+EXPORT_SYMBOL_GPL(pm_genpd_queue_power_off);
 
 /**
  * genpd_power_off - Remove power from a given PM domain.
@@ -1096,7 +1098,7 @@ static int __init genpd_power_off_unused(void)
 	mutex_lock(&gpd_list_lock);
 
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
-		genpd_queue_power_off_work(genpd);
+		pm_genpd_queue_power_off(genpd);
 
 	mutex_unlock(&gpd_list_lock);
 
@@ -1431,7 +1433,7 @@ static void genpd_complete(struct device *dev)
 
 	genpd->prepared_count--;
 	if (!genpd->prepared_count)
-		genpd_queue_power_off_work(genpd);
+		pm_genpd_queue_power_off(genpd);
 
 	genpd_unlock(genpd);
 }
@@ -2703,7 +2705,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 	}
 
 	/* Check if PM domain can be powered off after removing this device. */
-	genpd_queue_power_off_work(pd);
+	pm_genpd_queue_power_off(pd);
 
 	/* Unregister the device if it was created by genpd. */
 	if (dev->bus == &genpd_bus_type)
@@ -2718,7 +2720,7 @@ static void genpd_dev_pm_sync(struct device *dev)
 	if (IS_ERR(pd))
 		return;
 
-	genpd_queue_power_off_work(pd);
+	pm_genpd_queue_power_off(pd);
 }
 
 static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
@@ -2879,7 +2881,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	}
 
 	pm_runtime_enable(virt_dev);
-	genpd_queue_power_off_work(dev_to_genpd(virt_dev));
+	pm_genpd_queue_power_off(dev_to_genpd(virt_dev));
 
 	return virt_dev;
 }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f776fb93eaa0..b7991bf98e1c 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -231,6 +231,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov, bool is_off);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
+void pm_genpd_queue_power_off(struct generic_pm_domain *genpd);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_genpd_remove_notifier(struct device *dev);
@@ -278,6 +279,9 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 	return -EOPNOTSUPP;
 }
 
+static inline void pm_genpd_queue_power_off(struct generic_pm_domain *genpd)
+{ }
+
 static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 						     unsigned int state)
 {
-- 
2.34.1

