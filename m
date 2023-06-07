Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054A5725FDF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbjFGMrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbjFGMrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:47:02 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53120198B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:47:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f61735676fso6567825e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142019; x=1688734019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTRBYvWL0ZR20mIms3ANVdkUTRjCIM847wuOR+jiVEw=;
        b=UPwKH0tEs+HxkzN7zAPP+oUW7O3Xmnkqu2EdonIlsR674Hizqw1pKo+qRI2Mmh7Yed
         Sv/Uy5UbTUl0vMSbEcGSb4IxCPX6ZSLbvec24un6Ney98zSuBYLDoByxKlOQjWAWbFOf
         /snJha6Vbf8chEMZxOyL/kr1q/0V5dA2O40Ar4lSwdmL9xFzgY2HkLOe+u6g/6qCn3kI
         gR83/yyBTx9YDRCYDR8ifwlBqXwm3c92MF5CxgW2HIs+umZpzOTowepyZ2wx47Dd4m3C
         dIWu2rhEnDdEESg1zmIXaya7FVpf97fmb1tnJBsKiyC5Q+M3mgv4HqzGrOulkazf1kgj
         U5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142019; x=1688734019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTRBYvWL0ZR20mIms3ANVdkUTRjCIM847wuOR+jiVEw=;
        b=Jf9CMhRUTUg/PgDWV1XWBc+KOhLoMUz7KY4sNFMe+f45jInOt6r+bDM8907ZYZGpsd
         /3lrEhx9UlQK+3V4zCjgRLYGL7aHXkMn/Ss1Ulug+ncLE5TxN4iNtfxk+4x3OrPW+yk3
         pWNtB/7BNMiRm6U1guSxEEFLJTWRa3XvhtkvV9icbF8yt3ANwCP9u8JtLtyfU14WIfhb
         RCZZ48ollJnIe+JujcpciLG5s8YYTzKf4BLBqdeTg+2G5qN7Rth0vYw4SKhXExgJcB9s
         GCjiszT8qxvf0X1aHCwozqnImoYDUtI6csu0XabyrBfPiyWJrM7/TvU6ztp0w3t7ZoZt
         aZNA==
X-Gm-Message-State: AC+VfDxAqYPsfeisK++0Qvo8JWSTr2xRoINRzBpGL0YaqEssEAVR3jnw
        3qbl9erUm18fjrcpxtHNpEUvhA==
X-Google-Smtp-Source: ACHHUZ6OeWVc1a0pysopXFADIzRUnuwVtZGnnlXC6I3lDM3M7q6tNmNUt+le2s2yZte65V2isz4k/Q==
X-Received: by 2002:a05:6512:243:b0:4f2:579d:6867 with SMTP id b3-20020a056512024300b004f2579d6867mr1934525lfo.20.1686142019556;
        Wed, 07 Jun 2023 05:46:59 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:46:59 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/16] cpufreq: scmi: Prepare to move OF parsing of domain-id to cpufreq
Date:   Wed,  7 Jun 2023 14:46:16 +0200
Message-Id: <20230607124628.157465-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
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

The OF parsing of the clock domain specifier seems to better belong in the
scmi cpufreq driver, rather than being implemented behind the generic
->device_domain_id() perf protocol ops.

To prepare to remove the ->device_domain_id() ops, let's implement the OF
parsing in the scmi cpufreq driver instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpufreq/scmi-cpufreq.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index f34e6382a4c5..7d05d48c0337 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -70,13 +70,24 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	return 0;
 }
 
+static int scmi_cpu_domain_id(struct device *cpu_dev)
+{
+	struct of_phandle_args clkspec;
+
+	if (of_parse_phandle_with_args(cpu_dev->of_node, "clocks",
+				       "#clock-cells", 0, &clkspec))
+		return -EINVAL;
+
+	return clkspec.args[0];
+}
+
 static int
 scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
 	int cpu, domain, tdomain;
 	struct device *tcpu_dev;
 
-	domain = perf_ops->device_domain_id(cpu_dev);
+	domain = scmi_cpu_domain_id(cpu_dev);
 	if (domain < 0)
 		return domain;
 
@@ -88,7 +99,7 @@ scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 		if (!tcpu_dev)
 			continue;
 
-		tdomain = perf_ops->device_domain_id(tcpu_dev);
+		tdomain = scmi_cpu_domain_id(tcpu_dev);
 		if (tdomain == domain)
 			cpumask_set_cpu(cpu, cpumask);
 	}
@@ -104,7 +115,7 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
 	unsigned long Hz;
 	int ret, domain;
 
-	domain = perf_ops->device_domain_id(cpu_dev);
+	domain = scmi_cpu_domain_id(cpu_dev);
 	if (domain < 0)
 		return domain;
 
@@ -209,7 +220,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->cpu_dev = cpu_dev;
-	priv->domain_id = perf_ops->device_domain_id(cpu_dev);
+	priv->domain_id = scmi_cpu_domain_id(cpu_dev);
 
 	policy->driver_data = priv;
 	policy->freq_table = freq_table;
-- 
2.34.1

