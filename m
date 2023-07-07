Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1D774B291
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjGGOFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjGGOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:04:58 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED132108
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:04:53 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b701dee4bfso31449601fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738692; x=1691330692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ewLZ7PsrVNiFdNIbfFquaT6V9xwZk4+lwOcXDJHnfw=;
        b=LnJEhcpAFuO7pDbjxc/tCUP9N9Zz2V0bEFLE2/ucW4oBShV+0u7o1KRGgF17LDQTbb
         sgFkFKP1gQ4V2YsjwM9u+R00tzKGrVzDNmKpbUSXd/A9lKR+GLgtqu7VYXSh5rvPilOM
         nrjml2olouJjpWQmDwNOn1I8RKBKaZSwYl2Zizf+mCRaVmYnP1OjqmkM17FxdYq4DSZ3
         ojeRfm4+YTvMhdknjhdfhpFACf0644lbT889BmVF4pZbyb2vOiqmXcblCsVr9sFRxdqt
         BGPZlp5bOCJNU2zfB7D751GUCagakr/jVcIXjh4ACQXB7NSIhzZ+O+Qf6iGrmmRFaqtG
         nKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738692; x=1691330692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ewLZ7PsrVNiFdNIbfFquaT6V9xwZk4+lwOcXDJHnfw=;
        b=PTFILm2QyRFQtza7PQhkjgteNrl2vAEPYnCAagootxhxDdleyGH1UXXnhwruRP9tqC
         lWsPMGkSXL2URwbbDpQiQTQvvs7EvPA47aiLNAmsFNkeO4SeM7BsT7IcZV0WPR1//7PO
         Uqc++OQjw6gEMxMe4XVDObIZgc+W1jPoTOVyglDsH8ll+kKDSJWoP875feuepKv0/6z3
         2/TmVwn6cuDbbUZ00LQVF2e4C6etYCultdIczlTOr0QjZv6fHeyqOUajoQdsD6MuWk1Q
         tJKI1czXJX5cNY/Zj6i2XrrmUYP199lnr+67cI3PPPYPfR1oObQ2K1XeCguStDNYnHsj
         LAbw==
X-Gm-Message-State: ABy/qLbaRE9NKAvFBRA8lhxa4YJbaIfXwVqbv4HKyI7VRdxoVRRwC8zj
        x0kegCrwKNWJLNLX9au680f1Ww==
X-Google-Smtp-Source: APBJJlE8yrl9/DHLKpG1gXCDtRhglmdeTUefxOCsODcqBZDs1ZGKpyfQog45Q6+FHuTn3i4Na1vMFg==
X-Received: by 2002:a2e:b0ca:0:b0:2b6:e105:6174 with SMTP id g10-20020a2eb0ca000000b002b6e1056174mr4000524ljl.47.1688738691962;
        Fri, 07 Jul 2023 07:04:51 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:04:51 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH 08/18] soc: qcom: Move power-domain drivers to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:24 +0200
Message-Id: <20230707140434.723349-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707140434.723349-1-ulf.hansson@linaro.org>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
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

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: <linux-arm-msm@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                          | 2 +-
 drivers/genpd/Makefile               | 1 +
 drivers/genpd/qcom/Makefile          | 4 ++++
 drivers/{soc => genpd}/qcom/cpr.c    | 0
 drivers/{soc => genpd}/qcom/rpmhpd.c | 0
 drivers/{soc => genpd}/qcom/rpmpd.c  | 0
 drivers/soc/qcom/Makefile            | 3 ---
 7 files changed, 6 insertions(+), 4 deletions(-)
 create mode 100644 drivers/genpd/qcom/Makefile
 rename drivers/{soc => genpd}/qcom/cpr.c (100%)
 rename drivers/{soc => genpd}/qcom/rpmhpd.c (100%)
 rename drivers/{soc => genpd}/qcom/rpmpd.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9fad7f6033f4..753eea641129 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17518,7 +17518,7 @@ L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
-F:	drivers/soc/qcom/cpr.c
+F:	drivers/genpd/qcom/cpr.c
 
 QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
 M:	Ilia Lin <ilia.lin@kernel.org>
diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index 1a0a56925756..dfdea14e2a8a 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -4,3 +4,4 @@ obj-y					+= amlogic/
 obj-y					+= apple/
 obj-y					+= bcm/
 obj-y					+= mediatek/
+obj-y					+= qcom/
diff --git a/drivers/genpd/qcom/Makefile b/drivers/genpd/qcom/Makefile
new file mode 100644
index 000000000000..403dfc5af095
--- /dev/null
+++ b/drivers/genpd/qcom/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_QCOM_CPR)		+= cpr.o
+obj-$(CONFIG_QCOM_RPMPD)	+= rpmpd.o
+obj-$(CONFIG_QCOM_RPMHPD)	+= rpmhpd.o
diff --git a/drivers/soc/qcom/cpr.c b/drivers/genpd/qcom/cpr.c
similarity index 100%
rename from drivers/soc/qcom/cpr.c
rename to drivers/genpd/qcom/cpr.c
diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/genpd/qcom/rpmhpd.c
similarity index 100%
rename from drivers/soc/qcom/rpmhpd.c
rename to drivers/genpd/qcom/rpmhpd.c
diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/genpd/qcom/rpmpd.c
similarity index 100%
rename from drivers/soc/qcom/rpmpd.c
rename to drivers/genpd/qcom/rpmpd.c
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 99114c71092b..f548a7150bb2 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -3,7 +3,6 @@ CFLAGS_rpmh-rsc.o := -I$(src)
 obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
-obj-$(CONFIG_QCOM_CPR)		+= cpr.o
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
@@ -29,8 +28,6 @@ obj-$(CONFIG_QCOM_STATS)	+= qcom_stats.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 obj-$(CONFIG_QCOM_APR) += apr.o
 obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
-obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
-obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
 obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
 qcom_ice-objs			+= ice.o
-- 
2.34.1

