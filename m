Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3106BB47E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjCONXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjCONXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:23:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E43658E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:23:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w9so4703774edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678886616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLRj53L/DjbMBhi79PBbCLq4uHXoSyceNvFogThLTB0=;
        b=O83NQyj//J7bmfedXnmbIqeW8+JZ+xkH6PdT0B1LHXQwigwDA4kKO9qois1oqflooO
         2qN3SbCw7sMLxHiCBH7UUzaSlQI4tGkIPl7tWzRhqwe4cPeQHepWNoSWdv1JkeiUSAqn
         6SzVrAsKaY8+/+6upW+K0/kX1dagOxqA+52IjhgReVcifbfVHPco3q1/sknGmtHVlrny
         zCmslTLInyjOgsClAVV/udywSh2Gcem+dLJEEkkoouFM6o1cNve15fCMg3e293FtrHTG
         hgnBZQ8zlkCCYlgZaw+6j17I9qlldEHXyzFQlTMNuVVtaAODnnJm+KQvCRdBVtEzX7Il
         8rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678886616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLRj53L/DjbMBhi79PBbCLq4uHXoSyceNvFogThLTB0=;
        b=Uh3er56HEWPEbNwdtvXtDnziBIXVbPDzZkoCvwKV+vtgTcr+Bnfru4gj3K4EjpHjhh
         cj33gxXlul3QmYqwEMaq8PGtfWbquwddIkraoqaVK+MMyPHnjzwBnJA4t40VsNfW7kS7
         PHSEGhiGndY6dk8i10l24j2jvQCJK6znBQGlpv2QhrVHWuPK0bEtSRD+QyWmuUGZDMAe
         zMmIp6oM+hIndrEHMUAEnbYlJIEHgi/ZJzmB020ZudsI+2RKAF5UHOgx90CenSblIP+b
         4XwtUAdHEr/nsOQ/PR1xBNKxvOWWvLPARsKaiUQGDHodxd89XlvN603u1a3p+TwLldUj
         ibuw==
X-Gm-Message-State: AO0yUKXymtdbF1f+R8BgIdoQZXPdBcdTr3oK2XFzK7tsDZ/thtcGVs1L
        +2d/+6Ru5sJbVBGZEe0RX9ovvA==
X-Google-Smtp-Source: AK7set9pBrz1LS8rrkjEkjlBWW/QTLUzc6ajPIuUyelYl6UYlSSo60YiGfHokLYhvw8Y59YDahM3DQ==
X-Received: by 2002:a17:906:c2c3:b0:870:b950:18d4 with SMTP id ch3-20020a170906c2c300b00870b95018d4mr5975836ejb.5.1678886615800;
        Wed, 15 Mar 2023 06:23:35 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id pj18-20020a170906d79200b008b133f9b33dsm2497365ejb.169.2023.03.15.06.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:23:35 -0700 (PDT)
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
Subject: [RFC PATCH 1/5] PM: domains: Allow power off queuing from providers
Date:   Wed, 15 Mar 2023 15:23:26 +0200
Message-Id: <20230315132330.450877-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315132330.450877-1-abel.vesa@linaro.org>
References: <20230315132330.450877-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, the providers might choose to refuse powering off some
domains until all of the consumer have had a chance to probe, that is,
until sync state callback has been called. Such providers might choose
to disable such domains on their on, from the sync state callback. So,
in order to do that, they need a way to queue up a power off request.
Since the generic genpd already has such API, make that available to
those providers.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/base/power/domain.c | 3 ++-
 include/linux/pm_domain.h   | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 32084e38b73d..97d4e2f2da91 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -649,10 +649,11 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
  * Queue up the execution of genpd_power_off() unless it's already been done
  * before.
  */
-static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
+void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
 {
 	queue_work(pm_wq, &genpd->power_off_work);
 }
+EXPORT_SYMBOL_GPL(genpd_queue_power_off_work);
 
 /**
  * genpd_power_off - Remove power from a given PM domain.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f776fb93eaa0..c9c0b4916e25 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -231,6 +231,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov, bool is_off);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
+void genpd_queue_power_off_work(struct generic_pm_domain *genpd);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_genpd_remove_notifier(struct device *dev);
@@ -278,6 +279,11 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 	return -EOPNOTSUPP;
 }
 
+void genpd_queue_power_off_work(struct generic_pm_domain *genpd);
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 						     unsigned int state)
 {
-- 
2.34.1

