Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8354474B2A5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjGGOGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjGGOFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:05:39 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C71D273B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:05:12 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so29278781fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738710; x=1691330710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDGJ4Rdnalj6TqDKeki2lXBkMtKfcEDmiGvYuLXTlyU=;
        b=zJEtOhTvr8IllxLtfLNdI3yUT/E73+PntZtuCWGUUchHKZgSYD+qEtQXCLvwzveqMW
         ZyAOjZTv8zOcIQUh5z4XAYMD6Yym0d0VmIqGe8KkeF7X4ldg8qbSBKqY4Elp4FcAjBgG
         4s+W28dTDXf7uNACg9wDlnX86NTuRwM9w2KFwAXEVKo1PROcScXrRGxFEkVuia+qAdyi
         mmMqcvMSZfdyPxB7tir7/NRQGpAyBzcvw8E0RqkLloFAcju6EJ8uwHFUzPb8yAGNpz++
         1dpz89dt0adj2uRATINhATo6vgof3bo6Eu0KWrjlMZl3DOG++mmT65hRZrjfSsRzR/xL
         lgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738710; x=1691330710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDGJ4Rdnalj6TqDKeki2lXBkMtKfcEDmiGvYuLXTlyU=;
        b=P9kLom/RTgqwU+eHtBw0n2eNacFOUwzJX+7OeeydXMZsDGfJxX2dC52QNZd1awJw6F
         s3OdtDApWmqZpJWJ+2ZBTvYIJ4P2xe4sSTxMAYvf9ov9S04zF9qF1IfxRLrJC6QSlQ2u
         GB9coOXC8Jbo5yX8YcAe1kWpdfjf7gjwi5lNqVoiZEsWemRKcHZrvrpOloj9LFt+n7I6
         wrmfdfiw9S/e/5RKGejAnIR5iAzAZrz+MNfuVxhQ7NCtOeWo/mBtg7mk5hNaEPAqsvJ/
         9OR0b2yabliEcr6om8AjM72VckjZD5PAMRD5A/5PvnDIm9pZjGhHt3d+hGlCOoS0+6v1
         Xnbg==
X-Gm-Message-State: ABy/qLa6v60Qxc4ayvN7+/ohDM9Do9VqRRRZK2TaFFUrgmHs7FvZ95lQ
        53Rx7qtXedRY+YEB2KQUihV6x0fhKJOtHHWfz+s=
X-Google-Smtp-Source: APBJJlEzYGXiYkpimLJdVvfFtEAfokJSPAH7vL71Isu/R6lRimZa+x/dK5wbVNgi11PgJpFopZ7Rgw==
X-Received: by 2002:a2e:800a:0:b0:2b6:a76b:c39e with SMTP id j10-20020a2e800a000000b002b6a76bc39emr3365228ljg.35.1688738710333;
        Fri, 07 Jul 2023 07:05:10 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:05:09 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 18/18] ARM: ux500: Move power-domain driver to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:34 +0200
Message-Id: <20230707140434.723349-19-ulf.hansson@linaro.org>
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

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                                     | 1 +
 arch/arm/mach-ux500/Makefile                                    | 1 -
 drivers/genpd/Makefile                                          | 1 +
 drivers/genpd/st/Makefile                                       | 2 ++
 .../pm_domains.c => drivers/genpd/st/ste-ux500-pm-domain.c      | 0
 5 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 drivers/genpd/st/Makefile
 rename arch/arm/mach-ux500/pm_domains.c => drivers/genpd/st/ste-ux500-pm-domain.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cf16ffac892..f9820072848d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2419,6 +2419,7 @@ F:	arch/arm/mach-ux500/
 F:	drivers/clk/clk-nomadik.c
 F:	drivers/clocksource/clksrc-dbx500-prcmu.c
 F:	drivers/dma/ste_dma40*
+F:	drivers/genpd/st/ste-ux500-pm-domain.c
 F:	drivers/hwspinlock/u8500_hsem.c
 F:	drivers/i2c/busses/i2c-nomadik.c
 F:	drivers/iio/adc/ab8500-gpadc.c
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 5e903241bded..270e5676fa02 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -6,4 +6,3 @@
 obj-y				:= pm.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o
 obj-$(CONFIG_SMP)		+= platsmp.o
-obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index efd955f586e9..c429485c13f6 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -8,6 +8,7 @@ obj-y					+= qcom/
 obj-y					+= renesas/
 obj-y					+= rockchip/
 obj-y					+= samsung/
+obj-y					+= st/
 obj-y					+= starfive/
 obj-y					+= sunxi/
 obj-y					+= tegra/
diff --git a/drivers/genpd/st/Makefile b/drivers/genpd/st/Makefile
new file mode 100644
index 000000000000..8fa5f9855460
--- /dev/null
+++ b/drivers/genpd/st/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_ARCH_U8500)		+= ste-ux500-pm-domain.o
diff --git a/arch/arm/mach-ux500/pm_domains.c b/drivers/genpd/st/ste-ux500-pm-domain.c
similarity index 100%
rename from arch/arm/mach-ux500/pm_domains.c
rename to drivers/genpd/st/ste-ux500-pm-domain.c
-- 
2.34.1

