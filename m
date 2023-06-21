Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67346738751
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjFUOkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjFUOkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:40:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D8E1739
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:40:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51bdc87feb1so875333a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687358428; x=1689950428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmB7aafZYu+t3l7iCsSmX4rGYeW4d39sw8kiK1MfRbc=;
        b=vbFeL6g/0gsnlVG3qe4dFQ8UgIqumpBG61md5jata02BeIpTUP5kaC99ThhE7dmF4O
         I7Y6Zk5tYifXsAurwx4LMPSIMFpU9Uu6yDlI+EBdE6mOHSG1vQP3bEWFSAODNm5tMAIz
         LsRijdo+V3NVq1ZT/fxLXgfSryujgdNMA1JxE9gWEwTMz1pUqJLzarZBXWf44s239bLm
         TdB9UU5sroVO28ey88uuV0uMfBQwyLW+RskbylYy58Ok9Xk4xzMLpNXO98g5W5m1cRPx
         iD8aORPz8tkdFjxBJk6+5sw+YR+XVIlM9Clkc1SXJc9guWiefmUzSYaphjxgmLinhgdV
         +6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687358428; x=1689950428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmB7aafZYu+t3l7iCsSmX4rGYeW4d39sw8kiK1MfRbc=;
        b=IJa/pIFNkG7mtilM+VPcHMdt8AmQ3L3/LGfJog0LCHrX39Eah597ayNQh7Rmig+3mE
         ifpdjjxMyfl6od36HAlwKQ+x8LW1iS6XkqcmgdxvJdbuzUEnixuBiey1KlvmBXpW4b1Q
         icZfNK8VyPA2Ls3xHc9HmcanN1sPPSmiF4zj903KjVEmIspj9uphHw0tahjBRDMqB1qS
         Apn1+6qx6XstedUYflh4ToW/hMp8dZeuPQd0+bU0zYhrcE4yLUx0mIWzCjDP1USQPCDc
         oaTNnaGokle9ketMo3zTFLpKfUSRrq7HK/CJawJFEApDZytqPsPhaAqa7TUuhyUV6gRx
         /kZw==
X-Gm-Message-State: AC+VfDxlmXXs4c31h92kqfbjCv5A/slkB5gZrN5HHuCdS3jKQNE6rT9F
        bXAt0f/1tkGU+WQVpq/pqkx2nw==
X-Google-Smtp-Source: ACHHUZ4omXHV92p6l7BRCmNWk6b/xm5hYh8nglQVFTzBHSceHAhc/cMnje+b0wXypCUxuAfl56P+9g==
X-Received: by 2002:aa7:c90f:0:b0:51a:50f2:4e7a with SMTP id b15-20020aa7c90f000000b0051a50f24e7amr7153676edt.13.1687358428418;
        Wed, 21 Jun 2023 07:40:28 -0700 (PDT)
Received: from hackbox.lan ([82.79.124.17])
        by smtp.gmail.com with ESMTPSA id l13-20020a056402344d00b0051879c4f598sm2689505edc.66.2023.06.21.07.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 07:40:28 -0700 (PDT)
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
Subject: [RFC PATCH v5 4/4] PM: domains: Add and set generic sync state callback
Date:   Wed, 21 Jun 2023 17:40:19 +0300
Message-Id: <20230621144019.3219858-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621144019.3219858-1-abel.vesa@linaro.org>
References: <20230621144019.3219858-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For every provider that doesn't register a sync_state callback,
register a generic one. This new generic sync_state callback queues up a
power off request.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/base/power/domain.c | 23 +++++++++++++++++++++++
 include/linux/pm_domain.h   |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5967ade160e2..ec16db0599ac 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -654,6 +654,27 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
 	queue_work(pm_wq, &genpd->power_off_work);
 }
 
+/**
+ * pm_genpd_power_off_unused_sync_state - Power off all domains for provider.
+ * @dev: Provider's device.
+ *
+ * Request power off for all unused domains of the provider.
+ * This should be used exclusively as sync state callback for genpd providers.
+ */
+void pm_genpd_power_off_unused_sync_state(struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+
+	mutex_lock(&gpd_list_lock);
+
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
+		if (genpd->provider && genpd->provider->dev == dev)
+			genpd_queue_power_off_work(genpd);
+
+	mutex_unlock(&gpd_list_lock);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_power_off_unused_sync_state);
+
 /**
  * genpd_keep_on - Tells if the domain should skip the power 'off' request
  * @genpd: PM domain to be checked.
@@ -2329,6 +2350,8 @@ static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
 	cp->xlate = xlate;
 	fwnode_dev_initialized(&np->fwnode, true);
 
+	dev_set_drv_sync_state(np->fwnode.dev, pm_genpd_power_off_unused_sync_state);
+
 	mutex_lock(&of_genpd_mutex);
 	list_add(&cp->link, &of_genpd_providers);
 	mutex_unlock(&of_genpd_mutex);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 3eb32c4b6d4f..78164244b89f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -279,6 +279,9 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 	return -EOPNOTSUPP;
 }
 
+static inline void pm_genpd_power_off_unused_sync_state(struct device *dev)
+{ }
+
 static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 						     unsigned int state)
 {
-- 
2.34.1

