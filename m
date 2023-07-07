Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB1F74B283
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjGGOE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjGGOEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:04:48 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC86A2105
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:04:46 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so30067561fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738685; x=1691330685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPh7xpb+blxJOGL61tBABmnFabAnXMzH94T37+TZKIU=;
        b=OYtqzWJ1PJ7FCuYSNQ+dAygCRK8lPvqtxdpNPu1QU3Rw192tE+zN3da777aLp+ruXx
         n3LTfqvg//u0BGWzeJgmfuadvspgJZf+2d+zzfmMEIMG+Bebbq2hSvg19s3ec6XRP4XT
         IV7jV5XVxnEf061w1053kPlgp5KbCwsPSCF9msjIYNJqxW61Ic2EpbNXVcExplOwEXBV
         GvdRlehmIDZZDLhSSBEFX/wYxLKTyOKxrh6S59XSVVUZJt8oRrrJga4W/HBkU3IELXlb
         obIhftvh/9H0o5Ny9Ksl5PO8i0lGhJlP7npaBa7JSV3uOIYe9aVfS6CB5+BCIBHKj55O
         wngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738685; x=1691330685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPh7xpb+blxJOGL61tBABmnFabAnXMzH94T37+TZKIU=;
        b=FZR8hIwGU121B+ZgbTcfJP9bbnJma+2vELmc3jDKzEUXTblj4Wld7KelvkfO7x2ixZ
         n1E5TPdLBU7rtJnLurSsaEPUxAYT97xPsaMKa2xz4z8soX8CnWkBzQnH3KO1OjHdwace
         H82Oet2Fw+PCeUaU51Uq9TB2F6jdvg+Y2JlU6t3f8H+pucYlameBBnIcpdu5nN8yZvnD
         6Ni7vC9uch90aBEOdb5kIjnJngEdp2xi7rbgg7aB+0t1igR+GELtn2xpsKk8BC64953i
         fE98XvfcUR4OC6zubJI8snlQg37B1ZhbOpG7upcCZtEQ6ru9RkBXbHKXWZZIHfBfPYcz
         +oNQ==
X-Gm-Message-State: ABy/qLZBI8w6RdqD2xdSDa5wZVNBgMWG9nZerYvxavjbykPegJPqaCJc
        lTrabaC9qZ2cAsnZcbAfmBPM1w==
X-Google-Smtp-Source: APBJJlE0OVlckxhKJTRERTMlLjuSyKJAjas/JvbXx/qdJGpg6nQ4zMBGxkEoII0Gpm9P3dNltK7VnA==
X-Received: by 2002:a2e:b045:0:b0:2b6:e618:b597 with SMTP id d5-20020a2eb045000000b002b6e618b597mr4795078ljl.28.1688738684950;
        Fri, 07 Jul 2023 07:04:44 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:04:44 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-actions@lists.infradead.org
Subject: [PATCH 02/18] soc: actions: Move power-domain driver to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:18 +0200
Message-Id: <20230707140434.723349-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707140434.723349-1-ulf.hansson@linaro.org>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
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

Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: <linux-actions@lists.infradead.org>
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

