Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B1874B293
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjGGOFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjGGOFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:05:08 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECD3211F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:04:56 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso29520311fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738695; x=1691330695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvYXj99u7TbpJIDZNfoYyEKQkjm1mobuKtYLdIv6z2U=;
        b=TBReKrdhudySexCVMS3JNfwaQvoW9t88zOuzxiGZ8WRIH7Ehmc+c++bCqJF0bOwMny
         +RpWBjAHFqv+/wg7FRV3S8Y/Msm3HXjYnttbiXC0IUfDzAGynjq6Zfq3SLusc+HXzKK1
         QxGHnctrjLQnGTdE97G5T+DOBJlXigw8ogngQ3YnJkK7jXUlTQ19V8pZSrQ9cnr0Luq1
         qyF/yCJv4h5dh+JCv3ruTpljE5aOBCuAJ3vgoIhzAJIcW93s1YNrG9Al+9WFC4aa1uBU
         gPWqa9Erm8g0wXRRbtmYYpn2I63/I3Mf9otwpgy686tS0AiTFp/6sNDFqAHaRCU/Z40L
         +76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738695; x=1691330695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvYXj99u7TbpJIDZNfoYyEKQkjm1mobuKtYLdIv6z2U=;
        b=LEuLepTCYKmetyaijjzbxWekxQ/z0F3crfeHThZzLF18a5/mV4/rxGaoq0e90x2DFx
         bsj6TLm373pJ1D2ZiYDLRKvJUN3SOPqLK5rqXjxWHhtCFbHQz2rVpAHlJxCQDsyO8aB7
         8FU+QhrncxUAL43uR7ErrBoj+iXEOpURT3pRGDeIencu0F2Uz//MUfzKLF62iHUd4Ozl
         3ej8KunmHYNa2M9fe0Lir9SoKISzfNzcEsG+5GNBVbPjhwv6MsTWwdylJ36pI+ayHnW3
         tp925D/QhalUpjYZCFWTx8a4pMMq7Q2N7eXGvknuRXEUOs+xSMKnBD278CIolfBcUDXy
         VYxQ==
X-Gm-Message-State: ABy/qLZ95c18EdlKL/FRxwKL9LZq4fHYLAG+hPHonD+oI7krunQ416TQ
        SQi6+6ek2fHS2ww8XnwveHSI1A==
X-Google-Smtp-Source: APBJJlFZUteWbKYl1aexP46DguwGv5crahAqnytrmTR0O5/HuzUepW8m9GQt2AqtWhVNZYlKuIDy2A==
X-Received: by 2002:a2e:9e58:0:b0:2b6:e12f:267 with SMTP id g24-20020a2e9e58000000b002b6e12f0267mr3598442ljk.5.1688738694744;
        Fri, 07 Jul 2023 07:04:54 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:04:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 10/18] soc: rockchip: Mover power-domain driver to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:26 +0200
Message-Id: <20230707140434.723349-11-ulf.hansson@linaro.org>
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

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: <linux-rockchip@lists.infradead.org>
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

