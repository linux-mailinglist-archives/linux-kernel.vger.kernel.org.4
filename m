Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EABD67E1FE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjA0Klp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjA0Klb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:41:31 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D8887353
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:40:59 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t18so4592023wro.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VsoS+HLMRIQitJW5cLuMou8qpfRBnFIRf9XZouh1e9Q=;
        b=LO+sAoyMEwdNEnHWYaJlKEDGIbwLsEP/ebM803ORYTt0D1wWGXQWE1WBxnR1wz694Q
         6I2JzsmrVmtFbXDXHT/9+E3jUbMfVHCF0EsD7aKRHo/s1JKRfrmqHwgD6BYPbdy+VBLf
         4ej96pIguY293PjvbWcAHtpb8e3PjD3ITHtbx7HQZabQvv7zV+eIhtRsKIX2mxsynJzh
         906Itbpo2L3Y3oCZ5mfqUKDSc9dghK3F+bGvejJ6i/XllOhHLnTAuyVkCfFxEgwG5CoU
         XrOiUs02/Q6TEEWVXkFB/e4UgtBOuQD0lKZL4O8gpVQqoO57RoXpGL21ESOyw3UJ5TNQ
         YxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VsoS+HLMRIQitJW5cLuMou8qpfRBnFIRf9XZouh1e9Q=;
        b=6CJSF8gd094yQGnB3Q9voNPDy4EsjjDy+E/98J80Vkqtd19SKYws0bam0KIgO92vYs
         arSO8UogFLajvdnNhzZ5eLd3mBCgBrdWvAdQMCE4RLxAwsvSJt7nhewBnTaYIf0n9cw8
         bm9ZEcnEa16u38sKRNbR7KXD42qGJrXc6TV8pWrylTjePjlxSxuY2yKDC700qjX6VvgY
         Zem68mIDOyNYsb3pEfxTJZg7kDzZFTvjVM0Axy1k7/iQhcEDMeCxvADbt4zAUY2kzncI
         gydYAs0G+uQUvd+GOhKNQW6HM6DjIhrtqziWt6sZvZjeXnGWYcowfAEpkldj9GhWGilf
         Zr0g==
X-Gm-Message-State: AFqh2kqJKF7Ur0OjBWw6SEQ7JDKMTfmDNcOAcq+mdI3gmsnu6qvZIP06
        ssu0zIDgaSSpVEaxcnP0ZTVYoUB6ajyUOQe/
X-Google-Smtp-Source: AMrXdXs0EK70vgBGw/Uczwfmggrv143kEnn1iNXDjOTsUS+fwt3Hl+f67U/4xB5huJ2TL8fz+9txig==
X-Received: by 2002:a05:6000:5c2:b0:2bb:eb3d:8d20 with SMTP id bh2-20020a05600005c200b002bbeb3d8d20mr32723282wrb.43.1674816057617;
        Fri, 27 Jan 2023 02:40:57 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e21-20020a5d5955000000b002b57bae7174sm3613089wri.5.2023.01.27.02.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:40:57 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if provider has sync_state
Date:   Fri, 27 Jan 2023 12:40:53 +0200
Message-Id: <20230127104054.895129-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Currently, there are cases when a domain needs to remain enabled until
the consumer driver probes. Sometimes such consumer drivers may be built
as modules. Since the genpd_power_off_unused is called too early for
such consumer driver modules to get a chance to probe, the domain, since
it is unused, will get disabled. On the other hand, the best time for
an unused domain to be disabled is on the provider's sync_state
callback. So, if the provider has registered a sync_state callback,
assume the unused domains for that provider will be disabled on its
sync_state callback. Also provide a generic sync_state callback which
disables all the domains unused for the provider that registers it.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

This approach has been applied for unused clocks as well.
With this patch merged in, all the providers that have sync_state
callback registered will leave the domains enabled unless the provider's
sync_state callback explicitly disables them. So those providers will
need to add the disabling part to their sync_state callback. On the
other hand, the platforms that have cases where domains need to remain
enabled (even if unused) until the consumer driver probes, will be able,
with this patch in, to run without the pd_ignore_unused kernel argument,
which seems to be the case for most Qualcomm platforms, at this moment.

The v1 is here:
https://lore.kernel.org/all/20230126234013.3638425-1-abel.vesa@linaro.org/

Changes since v1:
 * added a generic sync state callback to be registered by providers in
   order to disable the unused domains on their sync state. Also
   mentioned this in the commit message.

 drivers/base/power/domain.c | 17 ++++++++++++++++-
 include/linux/pm_domain.h   |  3 +++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 84662d338188..c2a5f77c01f3 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1099,7 +1099,8 @@ static int __init genpd_power_off_unused(void)
 	mutex_lock(&gpd_list_lock);
 
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
-		genpd_queue_power_off_work(genpd);
+		if (!dev_has_sync_state(genpd->provider->dev))
+			genpd_queue_power_off_work(genpd);
 
 	mutex_unlock(&gpd_list_lock);
 
@@ -1107,6 +1108,20 @@ static int __init genpd_power_off_unused(void)
 }
 late_initcall(genpd_power_off_unused);
 
+void genpd_power_off_unused_sync_state(struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+
+	mutex_lock(&gpd_list_lock);
+
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
+		if (genpd->provider->dev == dev)
+			genpd_queue_power_off_work(genpd);
+
+	mutex_unlock(&gpd_list_lock);
+}
+EXPORT_SYMBOL_GPL(genpd_power_off_unused_sync_state);
+
 #ifdef CONFIG_PM_SLEEP
 
 /**
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f776fb93eaa0..1fd5aa500c81 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -351,6 +351,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index);
 struct device *genpd_dev_pm_attach_by_name(struct device *dev,
 					   const char *name);
+void genpd_power_off_unused_sync_state(struct device *dev);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
 static inline int of_genpd_add_provider_simple(struct device_node *np,
 					struct generic_pm_domain *genpd)
@@ -419,6 +420,8 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline genpd_power_off_unused_sync_state(struct device *dev) {}
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 #ifdef CONFIG_PM
-- 
2.34.1

