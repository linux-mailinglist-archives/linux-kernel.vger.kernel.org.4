Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64DD74F1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjGKOUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjGKOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:20:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1485412A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:20:07 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso9305008e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085202; x=1691677202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zd0pHiLE6JiFccsytA2KY34kSaVCJDH+B0AfS4SxX7w=;
        b=X3AsMMwIW8ixJYsIYYiApCkGubDFVXJiqmDb339aGy5wae37TEvGpUdy/RrY0hj2PX
         47AjLJYbMBohDdbFUasrWvP/AHxjhtpp1TRMxiWSRn2wpxFtXo5BokFoM+m4wOQxSLPX
         8We8cTIUGXY6FRpm8CiLM7z9NOzPC3SOCeuiGUmqvMRcml0zqQSa37NzxNn0lEWBRFE6
         jQllWGDXsLFtEHXI1qq3wX4uTYRBslhHynP227y03GDhxn81jNuKspyWDsMXD0mUxFyU
         2MHXnpWAoK+8jRZWEzDHNcWOhaJJevfaCR+j3dLhXEn+GxTriHAL77t9PdZMIVhe2rJS
         V9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085202; x=1691677202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zd0pHiLE6JiFccsytA2KY34kSaVCJDH+B0AfS4SxX7w=;
        b=GQNlCYNcyWcf2ZNyVpQQ2OInAx+I0A4kmkBO9qGJG3BGgQn+sELXcl5PZ+lXhvBTIR
         P/6MwSdqGga0eQYUFJywzRmrzTDi2vkgLdfDIVwwgX5Va+bUFJMJOhcXiNvUPYpfgXpw
         mLNobXsnhqEv6L/8sdVK7rRyRCVAiMaxQugkWqlPv7aU7YnWjGKt/z2/wlKhXMz2BFkQ
         F5S+OceLbNFlz9zlJH+6WhHmjwiqsZq6++ApYo7BN+SL2JNQn7XMpUgCeMKPV4VRwgqA
         ElKToETKesvA6vKI++e6HRZqdSM9rg8LYRD5VyOP6W++LTODvK1ZChjNHpDuORLZSQcf
         39gA==
X-Gm-Message-State: ABy/qLZD2k5kdo0Wmw5JpHoujSyj16rnUhujHaMfl/kEGGSP7B5O8yZH
        W2VTC06FTbx0+EcWMlUh85zI2A==
X-Google-Smtp-Source: APBJJlH3CWGuj8eKXxQfrQR1Iyitul4Rnmz45Tbf2YH59TpieCawjjXXSA27O0nHY/Yj4CUChKOOGg==
X-Received: by 2002:a05:6512:32d0:b0:4f8:6dfd:faa0 with SMTP id f16-20020a05651232d000b004f86dfdfaa0mr12537046lfg.2.1689085202092;
        Tue, 11 Jul 2023 07:20:02 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id f13-20020ac251ad000000b004f37bd02a89sm335827lfk.287.2023.07.11.07.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:20:01 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andreas Farber <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/18] genpd: Create a new subsystem directory to host genpd providers
Date:   Tue, 11 Jul 2023 16:19:56 +0200
Message-Id: <20230711141956.751529-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 3be1bdfe8ecc..38eebcc97aa2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8665,6 +8665,13 @@ F:	Documentation/devicetree/bindings/power/power?domain*
 F:	drivers/base/power/domain*.c
 F:	include/linux/pm_domain.h
 
+GENERIC PM DOMAIN PROVIDERS
+M:	Ulf Hansson <ulf.hansson@linaro.org>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git
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

