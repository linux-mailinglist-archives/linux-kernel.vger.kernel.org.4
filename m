Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291605B56AC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiILIvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiILIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:51:13 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA8112621
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:51:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fv3so7351887pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PwVnNN2JhAtCKR0gIBdzx98+e1DHY5UcBcw9xoLU858=;
        b=hEPAwSbzAOvqn2YXh0qAh/0aJJa7o1LlnmZ/o4T/+xTW977a/r+pwV0o6gfG/WUVnO
         5uYE3hAeusjghsHJxjes6XuMg8vKZo4g/e+sOpvl4dGTuVDf/VRN0u3Q0bYNOxbFy/yB
         X9QOqrLObLXc6yia8LhbuvXVKzJ9yhaGg0RqRHzLDCBCHzp2qurxa22sZg5s5FC401KM
         08huE8kjCplyJr2BYhFvk+FTSBlatJx7SCJYJPYfDL8UwYl9smdAYr8Tkx+3Ufh2dXUA
         tn/Fn2TpuA0vNMJRJUapZCP6B+PlxPwYiveSAq0Wby12p39gUyy23VcGDRsivav4UpFF
         A8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PwVnNN2JhAtCKR0gIBdzx98+e1DHY5UcBcw9xoLU858=;
        b=Q55EVbjqcxlPkXM6tEaS3dWIT7SDWlr+dDuZQCRuAMbCSQh3oktHExG9n5aFw1+KwO
         OiKQvQ7kG9nbJjBceFBwQz3MNsSu0STG1NR/RfG7WuDbdXoM1rcIpv6tFxxQk2ojiTe+
         sLwC1qhhB4wPnUTP4ypkA7bPZNvZqHeZGNLxndqRAnxiCj1Lew4QVf1o8FsYTlxH4pSh
         SnnA63h7M60skM83qCtRwe3lqpE3V0i3tiW86Y4sv00c9FAoIWHo1ua7FIYIvK7nwXS9
         RV7kr5QgfPPN1rvTM4SYHPgOHLLY2T5U5s+7OCvHundO/4PZQKEGy5GikIqJCfB8xGrX
         jvuA==
X-Gm-Message-State: ACgBeo262rWgrPJMRqKLCGY1uZVmGpQv0w//jN1UBCe3SjSY9mA2got+
        7BUxrKTor6MPG4IADOJsNVTUgfyWuWTncQ==
X-Google-Smtp-Source: AA6agR5WEYx+186Y7fKIpxYQSlC6qTkziOsd9iGGngx5HBUgwEAvMV3qqBmF3IUcE4OZOv2uQLVJ0A==
X-Received: by 2002:a17:90b:3845:b0:202:c44a:8b87 with SMTP id nl5-20020a17090b384500b00202c44a8b87mr6496320pjb.115.1662972671189;
        Mon, 12 Sep 2022 01:51:11 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f54d00b00172897952a0sm5326699plf.283.2022.09.12.01.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 01:51:10 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh@kernel.org, andersson@kernel.org,
        rafael@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com
Subject: [PATCH 2/4] thermal: qcom: Add Kconfig entry & compilation support for qmi cooling driver
Date:   Mon, 12 Sep 2022 14:20:47 +0530
Message-Id: <20220912085049.3517140-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220912085049.3517140-1-bhupesh.sharma@linaro.org>
References: <20220912085049.3517140-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kconfig entry & compilation support for Qualcomm qmi cooling driver.

Cc: daniel.lezcano@linaro.org
Cc: rafael@kernel.org
Cc: andersson@kernel.org
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/thermal/qcom/Kconfig              |  4 ++++
 drivers/thermal/qcom/Makefile             |  2 ++
 drivers/thermal/qcom/qmi_cooling/Kconfig  | 14 ++++++++++++++
 drivers/thermal/qcom/qmi_cooling/Makefile |  3 +++
 4 files changed, 23 insertions(+)
 create mode 100644 drivers/thermal/qcom/qmi_cooling/Kconfig
 create mode 100644 drivers/thermal/qcom/qmi_cooling/Makefile

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index ccfd090273c1..d383b2cf4c7f 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -53,3 +53,7 @@ config QCOM_LMH
 	  input from temperature and current sensors.  On many newer Qualcomm SoCs
 	  LMh is configured in the firmware and this feature need not be enabled.
 	  However, on certain SoCs like sdm845 LMh has to be configured from kernel.
+
+menu "Qualcomm QMI cooling drivers"
+source "drivers/thermal/qcom/qmi_cooling/Kconfig"
+endmenu
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 0fa2512042e7..61114129827a 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_QCOM_QMI_COOLING)	+= qmi_cooling/
+
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
 
 qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
diff --git a/drivers/thermal/qcom/qmi_cooling/Kconfig b/drivers/thermal/qcom/qmi_cooling/Kconfig
new file mode 100644
index 000000000000..96488181cd5f
--- /dev/null
+++ b/drivers/thermal/qcom/qmi_cooling/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config QCOM_QMI_COOLING
+	tristate "Qualcomm QMI cooling drivers"
+	depends on QCOM_RPROC_COMMON
+	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_QMI_HELPERS
+	help
+	   This enables the remote subsystem cooling devices. These cooling
+	   devices will be used by Qualcomm chipset to place various remote
+	   subsystem mitigations like remote processor passive mitigation,
+	   remote subsystem voltage restriction at low temperatures etc.
+	   The QMI cooling device will interface with remote subsystem
+	   using Qualcomm remoteproc interface.
diff --git a/drivers/thermal/qcom/qmi_cooling/Makefile b/drivers/thermal/qcom/qmi_cooling/Makefile
new file mode 100644
index 000000000000..ea6cb3c8adb0
--- /dev/null
+++ b/drivers/thermal/qcom/qmi_cooling/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_QCOM_QMI_COOLING)	+= qcom_cooling.o
+qcom_cooling-y			+= qcom_tmd_services.o qcom_qmi_cooling.o
-- 
2.37.1

