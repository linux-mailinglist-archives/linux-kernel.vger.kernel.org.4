Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7C45B61CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 21:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiILTkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 15:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiILTkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:40:40 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C98474EF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 12:40:39 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so13353382pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=reN5wXnTuCLuDR5wNe7lt3rMw3sDp5Q+m6oxec1H4aw=;
        b=u5z/DuJdUpoI7Umw7soQw8TEWGOLi4554arXzKxejigplqHvL52rV6NeeEm1Y6q/qf
         9eR+wU+u3R+6fv1CYpF9nvOXKtW/vpOsv/zONSZCIyUlyH6SuneWJfBp2GEiGi4wWOEy
         yhNT6PXSmggbCDmWrsEKICRLAh6+qzu4xeVd7LtySAgghcXvqQbnubqHnkSh7xaqF081
         QWLGDDrJbMj96g/FMzlPgKetfubG/xyfXxWxaMZGUvp2kCYKFEUhor06iawK/Lp1t5Ts
         tCGyyaljcvrGLMZFkcf7Jo+p5PpkZw5hiMC1Fr2At3Hu+RbtEhrnE+4zcW7RB4ZSb9Cn
         B+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=reN5wXnTuCLuDR5wNe7lt3rMw3sDp5Q+m6oxec1H4aw=;
        b=oCASY9L38An+CpinXr0xy7+Isl9wch7nUW/g+o190jpzSlFCwOdYTyZ3yIE/DJfEFP
         uuVhkUzAcsvijxELJNIveRkBewDi5OCyMH0+xO5eH57mXmuQabu/Vnw6IJ3w55JSGxEB
         oDhZl3U8wbDKEmsCz+ciUj16+QHl/bEfKQWGmXrxHSCxQAXQcfCRrl+Rivn9LdEkcYOa
         eYRAPj7ZMTY2TPXQb/ebJ3KPKZkF53IgN+JhjzG4WIVSDdGMX1UV6JQB6V+YYKA2bXhe
         ajp8HMi/LQeYOFCDZ0lHIA5g/4+VxnF2nmhyR8bXrOKPL7bo2CAyZKlJmhGJ/lIJ41ug
         qiYg==
X-Gm-Message-State: ACgBeo2cfw9IWb6ovoSSAnntkyBHn+RHt5u19R8jesy0cNDB46Le5lay
        r1oQpfRo6dvmevWVS/Jhh15ewfBVnGhDkQ==
X-Google-Smtp-Source: AA6agR4Tdr5zJtzIUmmf8yiuX910IgZMhxBKKfK9LZzZLlliGnAAuB8NPee/ijCNolN+ifeWZ81XEw==
X-Received: by 2002:a17:902:db0a:b0:178:2636:b6de with SMTP id m10-20020a170902db0a00b001782636b6demr10521516plx.58.1663011638725;
        Mon, 12 Sep 2022 12:40:38 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001709b9d292esm6486362plg.268.2022.09.12.12.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 12:40:38 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, rafael@kernel.org,
        dmitry.baryshkov@linaro.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v2 1/2] thermal: Introduce CONFIG_QCOM_THERMAL in Makefile and qcom/Kconfig
Date:   Tue, 13 Sep 2022 01:10:27 +0530
Message-Id: <20220912194028.3584378-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce CONFIG_QCOM_THERMAL to allow better control
over selection of various Qualcomm Thermal drivers
available inside qcom/ directory.

This is a preparatory change to allow new drivers to
be added inside qcom/ directory in a more structured
fashion later-on.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
- v1 can be viewed here: https://www.spinics.net/lists/kernel/msg4510793.html
- Fixed review comments from Dmitry received in v1.

 drivers/thermal/Makefile     |  2 +-
 drivers/thermal/qcom/Kconfig | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index def8e1a0399c..2506c6c8ca83 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
 obj-y				+= intel/
 obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
 obj-y				+= st/
-obj-$(CONFIG_QCOM_TSENS)	+= qcom/
+obj-y				+= qcom/
 obj-y				+= tegra/
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
 obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index 2c7f3f9a26eb..ccfd090273c1 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -1,8 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config QCOM_THERMAL
+	tristate "Thermal drivers on Qualcomm Snapdragon series of SoCs"
+	help
+	  Support for thermal drivers on Qualcomm Snapdragon series of SoCs.
+	  There are several thermal sensors available on the Qualcomm Socs
+	  which can be used for thermal mitigation purposes.
+
 config QCOM_TSENS
 	tristate "Qualcomm TSENS Temperature Alarm"
 	depends on NVMEM_QCOM_QFPROM
 	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_THERMAL
 	help
 	  This enables the thermal sysfs driver for the TSENS device. It shows
 	  up in Sysfs as a thermal zone with multiple trip points. Disabling the
@@ -15,6 +24,7 @@ config QCOM_SPMI_ADC_TM5
 	depends on OF && SPMI && IIO
 	select REGMAP_SPMI
 	select QCOM_VADC_COMMON
+	select QCOM_THERMAL
 	help
 	  This enables the thermal driver for the ADC thermal monitoring
 	  device. It shows up as a thermal zone with multiple trip points.
@@ -25,6 +35,7 @@ config QCOM_SPMI_TEMP_ALARM
 	tristate "Qualcomm SPMI PMIC Temperature Alarm"
 	depends on OF && SPMI && IIO
 	select REGMAP_SPMI
+	select QCOM_THERMAL
 	help
 	  This enables a thermal sysfs driver for Qualcomm plug-and-play (QPNP)
 	  PMIC devices. It shows up in sysfs as a thermal sensor with multiple
@@ -35,6 +46,7 @@ config QCOM_SPMI_TEMP_ALARM
 config QCOM_LMH
 	tristate "Qualcomm Limits Management Hardware"
 	depends on ARCH_QCOM && QCOM_SCM
+	select QCOM_THERMAL
 	help
 	  This enables initialization of Qualcomm limits management
 	  hardware(LMh). LMh allows for hardware-enforced mitigation for cpus based on
-- 
2.37.1

