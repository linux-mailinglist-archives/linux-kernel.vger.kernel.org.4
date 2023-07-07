Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB1074B287
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjGGOFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjGGOEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:04:50 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3671FEA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:04:48 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so30068271fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738687; x=1691330687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sXML62c+yFPRbDSYafRH6BnTPPBo1FmIeRXiEVvoz4=;
        b=g98aymrYA8zDV231rNQrnKVclgn0H4N2GuKBHsDELfkIsb0QnjTG+ctQIIUKnsWp4j
         KmOS6OWL/v9qyQ4XJd6FfjVwDiWnrqc2pKx7o5isTpnv0fAnu1u9EMhCx1rKcOai/T+A
         NidHb/FTvnfSgxVZkDobhZULe2O2ZFb9+zsDrGAWHovltbC/H05f3+0PZIjGEZX8JjI4
         NpJOBLsouVPK1cC0stSkPj8pngbmsepUrwZF9KqXyd+tvMfPo/mXiH9KrglvOu8U0KT7
         riRdun6q9E1utBztnSJHShXUjHwCMwxUVms9fnYEAWlaQh7GqRbESAqE8ssFQiHxIuBK
         ldNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738687; x=1691330687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sXML62c+yFPRbDSYafRH6BnTPPBo1FmIeRXiEVvoz4=;
        b=FeIFXiji+qzYJ9QsOQpq1DTja02d8RPckh1ut1gT0i5sR7LahGhdPTh2gvNmlGU66o
         O5bI7wrNXqXliprjzFcPHhPozEp9YPd8PVGkPBAvY1Ilwo1kmSBoO2JIZOlmG9KA2plV
         0BM0V8L5ycvkg9CIaNYF6NXi3c5nMbuyvAOHdZ3/JZxfZ3xqkz0UdTVUOjRw4hMDpdt3
         ezDNMY0D/rZg+24fAXa8UVbP1MVD/RAa1ddf7I3UsxXad30yLkJ9Dm3ESITjy2VuJEsg
         vGFJDs4U/lxPgZxGmp85iPwJwfHDf3pycRR9byGD9PIeWDRnck/cT1M8YfWWAGzURTbM
         HUhQ==
X-Gm-Message-State: ABy/qLZI7XDDbAqu8ci+4H3pNkpYM7dKQfLsIBjnMNPJEx7hsXd3TnLz
        GfnKJdorlX9oqqWmdeNJqrkCOQ==
X-Google-Smtp-Source: APBJJlFJRHcHjPxKIKBEsHDjPcXRyoiBK2mBftJUZjn4Ch6s3fn8Za1if7mpBpiPudhx2Cm45tyKyA==
X-Received: by 2002:a2e:a0d7:0:b0:2b6:e536:a2a3 with SMTP id f23-20020a2ea0d7000000b002b6e536a2a3mr4569253ljm.19.1688738687256;
        Fri, 07 Jul 2023 07:04:47 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:04:46 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev
Subject: [PATCH 04/18] soc: apple: Move power-domain driver to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:20 +0200
Message-Id: <20230707140434.723349-5-ulf.hansson@linaro.org>
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

Cc: Hector Martin <marcan@marcan.st>
Cc: Sven Peter <sven@svenpeter.dev>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: <asahi@lists.linux.dev>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                                     | 1 +
 drivers/genpd/Makefile                                          | 1 +
 drivers/genpd/apple/Makefile                                    | 2 ++
 .../apple/apple-pmgr-pwrstate.c => genpd/apple/pmgr-pwrstate.c} | 0
 drivers/soc/apple/Makefile                                      | 2 --
 5 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 drivers/genpd/apple/Makefile
 rename drivers/{soc/apple/apple-pmgr-pwrstate.c => genpd/apple/pmgr-pwrstate.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b8c9ae2375d..98a6847c8c3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1904,6 +1904,7 @@ F:	drivers/bluetooth/hci_bcm4377.c
 F:	drivers/clk/clk-apple-nco.c
 F:	drivers/cpufreq/apple-soc-cpufreq.c
 F:	drivers/dma/apple-admac.c
+F:	drivers/genpd/apple/
 F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c
 F:	drivers/iommu/apple-dart.c
diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index cdba3b9f0c75..91d4a3808981 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y					+= actions/
 obj-y					+= amlogic/
+obj-y					+= apple/
diff --git a/drivers/genpd/apple/Makefile b/drivers/genpd/apple/Makefile
new file mode 100644
index 000000000000..53665af630be
--- /dev/null
+++ b/drivers/genpd/apple/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_APPLE_PMGR_PWRSTATE)	+= pmgr-pwrstate.o
diff --git a/drivers/soc/apple/apple-pmgr-pwrstate.c b/drivers/genpd/apple/pmgr-pwrstate.c
similarity index 100%
rename from drivers/soc/apple/apple-pmgr-pwrstate.c
rename to drivers/genpd/apple/pmgr-pwrstate.c
diff --git a/drivers/soc/apple/Makefile b/drivers/soc/apple/Makefile
index 20feee6f3943..302ec8184535 100644
--- a/drivers/soc/apple/Makefile
+++ b/drivers/soc/apple/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_APPLE_PMGR_PWRSTATE)	+= apple-pmgr-pwrstate.o
-
 obj-$(CONFIG_APPLE_MAILBOX) += apple-mailbox.o
 apple-mailbox-y = mailbox.o
 
-- 
2.34.1

