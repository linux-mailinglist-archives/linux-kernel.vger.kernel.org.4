Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4265474F1BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjGKOUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjGKOUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:20:38 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0226110F1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:20:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b708e49059so89924031fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085217; x=1691677217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmcufVla96gj7QBJok4aNFrwvp3Z+1MnOpTkxYvPgM0=;
        b=AiyVL1P+nFlMzdXz54/ydk5itbcOeOvCUs/nZ6yXjVDQ9ADROy8QVgjiKBI/4ZoLj2
         otv4M4yyqZ/ePDpTR9Xxbq0FRFvkOubznLlJP9nAiz2fwZCJ6YItZYovJzu6tJ0dO7R8
         JJhf8Cw55EqF7f1cPAFaUzJD9oeczpsLPbvYbJ/WexFm+p1hxua9pKJvVu4Ei4P4GvAz
         Y9ExbgAyMrUM6DAl+oOt7lnV1YszZkZP2z3ApUF8m3w0RdjBgZkc/k1q2UbamYRnbYUd
         G8gH86kv2NS/2NSLRD5dhKjOQOw4dRbCKVi26G6O1ynEy2BtN96ARTQdX2m5PQ7ppj+S
         MPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085217; x=1691677217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmcufVla96gj7QBJok4aNFrwvp3Z+1MnOpTkxYvPgM0=;
        b=I/g0mfCAnj7pYB1yHTNJQKpbFXUYDV0NZvy35qsioyiA7S1tc8rvLmuNqbihsXHcOt
         BmYzP8PO3JKIqi3NpvyE6aPvLNaIEtHboSS0ITww7lJ/dlxfVVhoUhQ0dZep4G5vjH6q
         BJlAB5japwR1vlxZOcdglYCTAMl4qM8OcDdcSJn/2g1GwOKqT/ESS0NPPzAf4RRG35aF
         LMpdEPtn0l4SjAzbevNmcNVCgva/Klc1R3/3ji2JUKrUymITxMS1kxZqyB9S76ZshhzG
         M3agm9wTHQ+ijnvsR85vKdg6r8qqgT6kyHN5VvzyuNayaad5EkOxA+1yr3P747NlEn72
         iA9g==
X-Gm-Message-State: ABy/qLatRSya5Y5tHIJttrHj0TMkfzG5+ohEUCXvm+nfygvvsbFYOydl
        C95VSZq1u5kxYXCrwXqGY8haXQ==
X-Google-Smtp-Source: APBJJlELlXzsP+JtZBpVTcOFtfxcqaydUXrEFc8Vn+nHWRGhQPaqD8CkyIhFl1SlVeN41gB6zgLtig==
X-Received: by 2002:a2e:b0e4:0:b0:2b6:dd78:2a8e with SMTP id h4-20020a2eb0e4000000b002b6dd782a8emr12445939ljl.50.1689085217077;
        Tue, 11 Jul 2023 07:20:17 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p2-20020a2ea402000000b002b6daa3fa2csm466233ljn.69.2023.07.11.07.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:20:16 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-actions@lists.infradead.org
Subject: [PATCH v2 02/18] soc: actions: Move power-domain driver to the genpd dir
Date:   Tue, 11 Jul 2023 16:20:13 +0200
Message-Id: <20230711142013.751550-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <v2/0003-soc-amlogic-Move-power-domain-drivers-to-the-genpd-d.patch>
References: <v2/0003-soc-amlogic-Move-power-domain-drivers-to-the-genpd-d.patch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

To simplify with maintenance let's move the action power-domain driver to
the new genpd directory. Going forward, patches are intended to be managed
through a separate git tree, according to MAINTAINERS.

Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: <linux-actions@lists.infradead.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/genpd/Makefile                   | 1 +
 drivers/genpd/actions/Makefile           | 2 ++
 drivers/{soc => genpd}/actions/owl-sps.c | 0
 drivers/soc/actions/Makefile             | 1 -
 4 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 drivers/genpd/actions/Makefile
 rename drivers/{soc => genpd}/actions/owl-sps.c (100%)

diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index a4e40e534e6a..a2d5b2095915 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -1 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-y					+= actions/
diff --git a/drivers/genpd/actions/Makefile b/drivers/genpd/actions/Makefile
new file mode 100644
index 000000000000..e78c420a2454
--- /dev/null
+++ b/drivers/genpd/actions/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0+
+obj-$(CONFIG_OWL_PM_DOMAINS)		+= owl-sps.o
diff --git a/drivers/soc/actions/owl-sps.c b/drivers/genpd/actions/owl-sps.c
similarity index 100%
rename from drivers/soc/actions/owl-sps.c
rename to drivers/genpd/actions/owl-sps.c
diff --git a/drivers/soc/actions/Makefile b/drivers/soc/actions/Makefile
index 4db9e7b050e5..4ac88fec2050 100644
--- a/drivers/soc/actions/Makefile
+++ b/drivers/soc/actions/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-$(CONFIG_OWL_PM_DOMAINS_HELPER) += owl-sps-helper.o
-obj-$(CONFIG_OWL_PM_DOMAINS) += owl-sps.o
-- 
2.34.1

