Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8B774F1E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjGKOW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjGKOWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:22:05 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF821FF9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:21:46 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so92310641fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085304; x=1691677304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgQ8n9LomBfmN5XVIE9V8yRduLBIY8d9iOgPKJiP4zs=;
        b=xWSdYCQxNymYgnOZZUnd4ZIodCEnApMke9J1PRrQ57R/Uede91putFMbdX7sCvlTLA
         tB5InT2FwiODgUrIDbyxgbpG+79y/l1WOtH1/tcZICN/AFDjS+91RI3D+FxebIfbEyug
         PFj+fDv3wfCJTx5EOWDKo4dS8IfAU14R0NpPCvU/DvF2KnXoYDrVNFYIVvXP4v+Ac/NX
         fVyUe9tb2jGX2Uh70t5vP5JSqDsMPPpwS4Ddyg53/EO4Mb13xwLHxTcSTtvuVgDOLUmK
         UDn6jyP+Fo3H9+RMXSh5TjdK4o+NS0GPwudFtigwXACKukMRy+8HNFkA+aUc+k5RL/uJ
         21pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085304; x=1691677304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgQ8n9LomBfmN5XVIE9V8yRduLBIY8d9iOgPKJiP4zs=;
        b=RoFyPnkhylQjQ4XqACOyUEYUn4pu+p2SJR0/2cHLnb4Jw/YBcKyt1Mfhr3AjBPJLbF
         I0J0fKWG2oG/J0FosPDRat1qtt60qv8I2NBxEiCSl4x19wdnj1IChFPEtyzhc9ADxiXI
         vFM5ylz2VKUuyP9TwonqkxCUdzfBvb50VWDGnhX8Fp6OVTNdpbbnzP8apuJ0nxZBY6eI
         470uMtV3IXYxiW9wTHt19WMz6DuhXYvw0euv1/oaww73sQw/a4wT0BaNHsK88D5BbVJ2
         HkygIkKxJ/eIa3VhP84lrh4EoY7QtJQkj82XMu80KJSxtMkb7A60kmHt/QcuiVYmE/nt
         cK1g==
X-Gm-Message-State: ABy/qLbmRvFjFGQ4OjscA9NH/lNbYZYkHlsVNF4Ft7Ofxs448IY0MeZP
        WCwro8KSZl4Ay7hpd91nIQK+LA==
X-Google-Smtp-Source: APBJJlEKT6/JfPIQWMIzndgYMxtD7h0zb7OcNaPEMavO1QRqMPj2xl4JjFMYoA+YM6XBYufPqZGF0A==
X-Received: by 2002:a2e:3109:0:b0:2b6:de52:357 with SMTP id x9-20020a2e3109000000b002b6de520357mr12200248ljx.40.1689085304038;
        Tue, 11 Jul 2023 07:21:44 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id j11-20020a2e3c0b000000b002b6ee0ff9bbsm463489lja.67.2023.07.11.07.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:21:43 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 10/18] soc: rockchip: Mover power-domain driver to the genpd dir
Date:   Tue, 11 Jul 2023 16:21:41 +0200
Message-Id: <20230711142141.751692-1-ulf.hansson@linaro.org>
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

To simplify with maintenance let's move the rockchip power-domain driver to
the new genpd directory. Going forward, patches are intended to be managed
through a separate git tree, according to MAINTAINERS.

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: <linux-rockchip@lists.infradead.org>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/genpd/Makefile                                          | 1 +
 drivers/genpd/rockchip/Makefile                                 | 2 ++
 .../{soc/rockchip/pm_domains.c => genpd/rockchip/pm-domains.c}  | 0
 drivers/soc/rockchip/Makefile                                   | 1 -
 4 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 drivers/genpd/rockchip/Makefile
 rename drivers/{soc/rockchip/pm_domains.c => genpd/rockchip/pm-domains.c} (100%)

diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index 286598ce7620..c178421e0cbc 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -6,3 +6,4 @@ obj-y					+= bcm/
 obj-y					+= mediatek/
 obj-y					+= qcom/
 obj-y					+= renesas/
+obj-y					+= rockchip/
diff --git a/drivers/genpd/rockchip/Makefile b/drivers/genpd/rockchip/Makefile
new file mode 100644
index 000000000000..8fb9d88a3492
--- /dev/null
+++ b/drivers/genpd/rockchip/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_ROCKCHIP_PM_DOMAINS)	+= pm-domains.o
diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/genpd/rockchip/pm-domains.c
similarity index 100%
rename from drivers/soc/rockchip/pm_domains.c
rename to drivers/genpd/rockchip/pm-domains.c
diff --git a/drivers/soc/rockchip/Makefile b/drivers/soc/rockchip/Makefile
index 05f31a4e743c..23d414433c8c 100644
--- a/drivers/soc/rockchip/Makefile
+++ b/drivers/soc/rockchip/Makefile
@@ -4,5 +4,4 @@
 #
 obj-$(CONFIG_ROCKCHIP_GRF) += grf.o
 obj-$(CONFIG_ROCKCHIP_IODOMAIN) += io-domain.o
-obj-$(CONFIG_ROCKCHIP_PM_DOMAINS) += pm_domains.o
 obj-$(CONFIG_ROCKCHIP_DTPM) += dtpm.o
-- 
2.34.1

