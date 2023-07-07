Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A5B74B27F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjGGOEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjGGOEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:04:48 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CA01FEF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:04:45 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6a16254a4so29248501fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738683; x=1691330683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrp8wl+UMMsfs1jvuX8kePskLzEjhfOLcdCCjv/24Fs=;
        b=dh/zABAXgmfBtINbeAHubt+OwDStiqoiZtpcpPlQfiN+JMvejHq++/4MJF0NzMa6Ns
         R9gctkOnzCUbXEmytYwpVTz5+X86UHBL/qOqtlItNMI2v1zq4UE8kjZiUaN3Wex5u6u/
         athNyI8ijb8lO9iNp+XvG0k166u+cGDobwtkYcLjsHkguIWgDVgSQiLRNFKyk64VSJss
         0qWTkQxY4mM2eUnbhilyftrsCITH00i1kdq1/yUVl8GM53VzhxyFp9+c2XVqaTFtQD9X
         MRNK8P/zQOZdBBYs5h3hbpNJrKjcr6qhtgOoRcUasfoAduauRphpU7NOFtLyAJZ/ivrj
         bMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738683; x=1691330683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrp8wl+UMMsfs1jvuX8kePskLzEjhfOLcdCCjv/24Fs=;
        b=iM3P/zA8y4lou/6FL2kP2QPek6dlKyVrPPvk8LM+6vhJvO6/9a2+G7ObHZ0mVLIotL
         kA7wc93Rdj0lf46cBAW+QYtxBPiTLcPVTLwJgcZWx9UX9w0BV2SVRjusymA3L9J7A33N
         Saa0POwEPG/fIQxNOOBK5phiz6uLLSUXLHSmPQh5QiPApj3hICvRmBM0pUG1Voh1tspD
         DD08abKb3rWjAX+VFqswFizkI0PLp5mELSW9Mz0o6twPGmCzfqV8V/GWX/T3WLSLmMst
         reXngY7YNboZsE5VRj3lJdAozKnfkke788mEsr8nYVdAhYpxSjlqIQ4Fvq2FSJtsjV5V
         XVuw==
X-Gm-Message-State: ABy/qLYRSFaT1SC6LakArux0nShqSNge/wb+WmIrmLFB42MO7ToERMkw
        SD4NvyLXI/I6MRu1EfbTL7BNyw==
X-Google-Smtp-Source: APBJJlEAadQSl1mZnQ3nQPXS80mjFk4GuAmuVnheGqj1sTrUfPnOZEUKr/HfbJpFDZ3GOAAEpJZk/A==
X-Received: by 2002:a2e:9d59:0:b0:2b6:d5af:1160 with SMTP id y25-20020a2e9d59000000b002b6d5af1160mr3628897ljj.28.1688738683616;
        Fri, 07 Jul 2023 07:04:43 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:04:43 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/18] genpd: Create a new subsystem directory to host genpd providers
Date:   Fri,  7 Jul 2023 16:04:17 +0200
Message-Id: <20230707140434.723349-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707140434.723349-1-ulf.hansson@linaro.org>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
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

There are currently ~60 users of the genpd provider interface, which
implementations are sprinkled across various subsystems. To simplify with
maintenance let's create a new subsystem (drivers/genpd) and start moving
the providers in there.

My intention is also to host a git tree to collect and to get the patches
tested/integrated through the linux-next tree. Ideally this should release
some of the burden on the soc maintainers.

Note that, I will of course require acks/reviews from the current platform
maintainers, hence the MAINTAINERS file needs to be updated accordingly for
each genpd provider that is moved into the new genpd subsystem.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS            | 7 +++++++
 drivers/Makefile       | 1 +
 drivers/genpd/Makefile | 1 +
 3 files changed, 9 insertions(+)
 create mode 100644 drivers/genpd/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 15ce1f07d9f7..588769fab516 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8663,6 +8663,13 @@ F:	Documentation/devicetree/bindings/power/power?domain*
 F:	drivers/base/power/domain*.c
 F:	include/linux/pm_domain.h
 
+GENERIC PM DOMAIN PROVIDERS
+M:	Ulf Hansson <ulf.hansson@linaro.org>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/pm.git
+F:	drivers/genpd/
+
 GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/Makefile b/drivers/Makefile
index 7241d80a7b29..cffac5b8c092 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_DMADEVICES)	+= dma/
 
 # SOC specific infrastructure drivers.
 obj-y				+= soc/
+obj-$(CONFIG_PM_GENERIC_DOMAINS)	+= genpd/
 
 obj-y				+= virtio/
 obj-$(CONFIG_VDPA)		+= vdpa/
diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
new file mode 100644
index 000000000000..a4e40e534e6a
--- /dev/null
+++ b/drivers/genpd/Makefile
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
-- 
2.34.1

