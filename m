Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10F45F1E3B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 19:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJARLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 13:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJARLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 13:11:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC8B5A3E1
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 10:11:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bk15so11188441wrb.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YHOQ8ywlbK0fpRlF8bymKRRxYbAe1JYFFKpNvoXmLTc=;
        b=PQYX1b3WPfpe0x2Fmbp2rME42Xu5jQKv6PUU6e/28nzTG072cA+2b+CrAKYB/kSUYc
         MelmLmb/pQco1l5kSxx7OLn1QcyeDQQmBuY24NXePgq25OO9j/iAD0K05hU/ctnJSrJ9
         vPEUOEEMNU5poui0za/ihUstAYbUNYGDxabqAWKhVKKUUslr0GuYwyPv7eKxg3QZnfI9
         gamj1GfvuXEsePfHhx6K8ns5zTdtaoTvovBHPXPsh2YOrDYtqkMcMkv54kCYYiL1TJi9
         wAqWtXCdjum9wQu9qv9cxRsFDEzWh4yICOxQGMNnZI+deWlQ/eRfckwtNyvyK76brV+W
         O6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YHOQ8ywlbK0fpRlF8bymKRRxYbAe1JYFFKpNvoXmLTc=;
        b=77Ng42xo0IwhxRuwh4b6Ont6MSpjkpScIJBL0XZQb9sYFKt4JZh5yjZBaebK3LagVb
         tLavtbAU0WTwNAvRJpLqPolYd0ZCiLuszhANIirMyX+9kwuv3mpAKFy2utk3AnSSwqju
         JCe0SJUvenhR+Yn2zJbgz9ZsPWO71pzR6/35XuMWU5VV5T9F8HkxgumvT+m35wZS3s0e
         03QtmnpHOi/0iCJaHhtCXLhfOrRsvR9vBQG5RoNAz71CPDKE62rxijVioUrAYLHgYA5S
         jsO1ecmebGtgPEzVGgHyKW23ivf+/y25NTTP/VNV0a6sHGGUgDkzdHUsWZshY4sqmRHg
         hxlw==
X-Gm-Message-State: ACrzQf2+2aDhbEWuIljB8nL/OdtKyncieR2e89FnS90tKshUHAHDpVn+
        RJZXLVRrI3uXj4WxsBhrm21UzHo9BngCWg==
X-Google-Smtp-Source: AMsMyM4Rgu7zhGQsIpV1EOpQQ3WcvL47Dq2sP16tSAWhcfuj52TzHaGFdXlgR6FATnwHIGLb636zAQ==
X-Received: by 2002:a05:6000:2a7:b0:22a:f98f:b75f with SMTP id l7-20020a05600002a700b0022af98fb75fmr9443666wry.373.1664644262969;
        Sat, 01 Oct 2022 10:11:02 -0700 (PDT)
Received: from radium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id h40-20020a05600c49a800b003b49ab8ff53sm5817641wmp.8.2022.10.01.10.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 10:11:02 -0700 (PDT)
From:   Fabien Parent <fabien.parent@linaro.org>
To:     ilia.lin@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fabien Parent <fabien.parent@linaro.org>
Subject: [PATCH 2/3] cpufreq: qcom: pass pvs_name size along with its buffer
Date:   Sat,  1 Oct 2022 19:10:26 +0200
Message-Id: <20221001171027.2101923-2-fabien.parent@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221001171027.2101923-1-fabien.parent@linaro.org>
References: <20221001171027.2101923-1-fabien.parent@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_version handler takes a pvs_name buffer and can override it with
the speed, pvs, and pvs version values. The function does not take as
argument the buffer size and is currently being determined by calling
`sizeof("speedXX-pvsXX-vXX")`. This is not great because it duplicates
the string in several locations which makes it error-prone if we need to
modify the string someday. Also since the buffer and its size are tied
together, it makes sense that they should both be passed together to the
get_version as parameters.

This commit makes sure that the PVS name template string is only
defined once, and that the pvs_name buffer is passed with its size.

Signed-off-by: Fabien Parent <fabien.parent@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3bd38acde4b9..64ce077a4848 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -30,6 +30,7 @@
 #include <linux/soc/qcom/smem.h>
 
 #define MSM_ID_SMEM	137
+#define PVS_NAME_TEMPLATE "speedXX-pvsXX-vXX"
 
 enum _msm_id {
 	MSM8996V3 = 0xF6ul,
@@ -50,6 +51,7 @@ struct qcom_cpufreq_match_data {
 	int (*get_version)(struct device *cpu_dev,
 			   struct nvmem_cell *speedbin_nvmem,
 			   char **pvs_name,
+			   size_t pvs_name_size,
 			   struct qcom_cpufreq_drv *drv);
 	const char **genpd_names;
 };
@@ -172,6 +174,7 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
 static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 					  struct nvmem_cell *speedbin_nvmem,
 					  char **pvs_name,
+					  size_t pvs_name_size,
 					  struct qcom_cpufreq_drv *drv)
 {
 	size_t len;
@@ -208,6 +211,7 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 					   struct nvmem_cell *speedbin_nvmem,
 					   char **pvs_name,
+					   size_t pvs_name_size,
 					   struct qcom_cpufreq_drv *drv)
 {
 	int speed = 0, pvs = 0, pvs_ver = 0;
@@ -235,7 +239,7 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 		goto len_error;
 	}
 
-	snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
+	snprintf(*pvs_name, pvs_name_size, "speed%d-pvs%d-v%d",
 		 speed, pvs, pvs_ver);
 
 	drv->versions = (1 << speed);
@@ -265,7 +269,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
 	struct device *cpu_dev;
-	char *pvs_name = "speedXX-pvsXX-vXX";
+	char *pvs_name = PVS_NAME_TEMPLATE;
 	unsigned cpu;
 	const struct of_device_id *match;
 	int ret;
@@ -306,8 +310,8 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 			goto free_drv;
 		}
 
-		ret = drv->data->get_version(cpu_dev,
-							speedbin_nvmem, &pvs_name, drv);
+		ret = drv->data->get_version(cpu_dev, speedbin_nvmem, &pvs_name,
+					     sizeof(PVS_NAME_TEMPLATE), drv);
 		if (ret) {
 			nvmem_cell_put(speedbin_nvmem);
 			goto free_drv;
-- 
2.37.2

