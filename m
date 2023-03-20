Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504B46C13C2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCTNmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjCTNma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:42:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D82DBDC9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:42:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eh3so46846060edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679319745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjKiN0F5wVydodH1DdUegjCL8bujRKxDngFdNV9Cs2c=;
        b=CDVGNXBPBN3zdUl7FjlFIv2E0h2geCNhMI1PP8HGrSgTs+BJuRsvUQ8kKvW/9nHD6N
         ow11RnoeG6AyipGzzUF/lO2TgVbEawbgTLBNGTuFejZWb9xACrAOTxT0Pc+DyojUHoQj
         z6XSF+lwJMKFBd7D22ZkGy7V0IY7K+0c1K3HQzE2X+WVa7wCm1IXg4yUc2lPx8QODOc3
         mS04vNuhq8CkG3cvPfStcuTLNmf7zvbJHoA98VNoLA4Ehm4wvwJ9NS5qSTVeudyu4MSB
         3XpH2Aq0TssgKopj8KOSAqljUq6V79aGyWyrfVrfP4Q0Gl5ncE9tOmeL9rZtZSNVqcba
         ZPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679319745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjKiN0F5wVydodH1DdUegjCL8bujRKxDngFdNV9Cs2c=;
        b=yxVH7C9dZXqTsTahZyaeuLu943NnwMx/vkiCzjpjiwyrEpjg37AT0j3csy+R5S2pok
         g0fEROZwQz9yqGZqYFHd+LfGm5zqbigcGyGvbWmF24Sk50BRCvwFisQFPw4Fcfjp+LYK
         s0mshy8BNoKwoKMSimP68p4yrfoK/s+Ls2E7pEAWnZAAwBX1Da9W1NYUvSK6g0RRefVx
         ANXu19FCqVEViZlRNtoAZp/YforsmuIfFQ3rT0nP8+WXd2nQphjCIm0I3CYho1LEe+M4
         sG6DjF5oLtclWFDWdyxaSXAUmJ6PSc7vlSVWtVCKlJL8xW+xWZ/ds2SP4VKvkDwB1ZjQ
         XQUA==
X-Gm-Message-State: AO0yUKW1mt2Y9HCKaqCuEABi/DhgF55XHjd9zzCe9GMcQ8B5Pp2RBcdI
        VVA6RcSibxnb+t/Zt9iO1BsXGg==
X-Google-Smtp-Source: AK7set8fdXj5wZW+bwPsLGCClZ5wHbtWt3lGG6NeFx2qa6Ytz64EWWAV2hS1cYoBxEYSKOOASiOrVw==
X-Received: by 2002:a17:906:1e85:b0:931:1567:f84f with SMTP id e5-20020a1709061e8500b009311567f84fmr8266966ejj.4.1679319745664;
        Mon, 20 Mar 2023 06:42:25 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906409700b009334a6ef3e8sm2368602ejj.141.2023.03.20.06.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 06:42:25 -0700 (PDT)
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
Subject: [RFC PATCH v2 1/5] PM: domains: Allow power off queuing from providers
Date:   Mon, 20 Mar 2023 15:42:13 +0200
Message-Id: <20230320134217.1685781-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320134217.1685781-1-abel.vesa@linaro.org>
References: <20230320134217.1685781-1-abel.vesa@linaro.org>
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
index f776fb93eaa0..f9729640f87e 100644
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
 
+void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 						     unsigned int state)
 {
-- 
2.34.1

