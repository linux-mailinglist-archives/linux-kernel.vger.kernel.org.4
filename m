Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5E260525B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiJSVzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiJSVzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:55:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53D61FFA2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:55:17 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so1258200pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8XIt+LggyNBDoRO5DPqQzHUIRS3Q64oYXaRetbeVDU=;
        b=ONOmRF0mDJlMUUgoZfpOOcJhHDL43tb1DR59Cn86BKCS9C+k1S/KxZwH6mZiMrJ+kU
         Ottj80CTOFsteLCq01PVaE/3uKcb90AUR5vyhlIznDrj6/+XeVgkPIWwOQsJiu39aLtQ
         4JpFsES+9Qe7QYXOq8gf+kAgwQasVt69wrtgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8XIt+LggyNBDoRO5DPqQzHUIRS3Q64oYXaRetbeVDU=;
        b=c4n+1AqjOoetcJ+kPO1QyTZGm9uwSEDpowLGe/mo+1S+lYoNngQgHjeZkGoWbwO8Q4
         74JNQXRwAmMqWf2vmKN0+A1ims88t9V2GeOp58M4tbcLOlhAjrK4nRMqjjjSAnZa7C7q
         9HkO80Q5YmSG2ybyqEkTjeBufpF/kGn7DVh/2h1+cDR5GmkfRIHyznIXi41tO6jB5b5E
         ZRMBXXu7Zd60LgUYe3h1a/LWj15Fj0nfv1ZI6s/7kbLziM8vMNaDP2hHwEoh658B2n7a
         GTPQ/vPpF+Djpd/t3apLDX2r8RrmT3o9EM/SXl0Mtq7KlLdCqohadQIdWa2Tkzek0N4j
         djvQ==
X-Gm-Message-State: ACrzQf2Zi3nJGNEnogE0tyqbQi6Ex6NJYqYQZxIo8ZlYxEwjp6N9nDCc
        s3Rv9vyAM5Fy2hz9XaUkwZT9Qw==
X-Google-Smtp-Source: AMsMyM6mWW1NA845EmugIF+u48eK7uRHNgk0VuFucq2yhcYYRzx/GflrLlfIxne9eONc9g0FrfwbVQ==
X-Received: by 2002:a17:90b:4d0d:b0:1fb:a86d:e752 with SMTP id mw13-20020a17090b4d0d00b001fba86de752mr12030955pjb.120.1666216517374;
        Wed, 19 Oct 2022 14:55:17 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:57b7:1f0e:44d1:f252])
        by smtp.gmail.com with UTF8SMTPSA id h12-20020a170902680c00b00178bd916c64sm11161877plk.265.2022.10.19.14.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 14:55:16 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Faiz Abbas <faiz_abbas@ti.com>, linux-mmc@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Al Cooper <alcooperx@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 7/7] mmc: sdhci-pci-*: Drop redundant ->cqe_private check
Date:   Wed, 19 Oct 2022 14:54:40 -0700
Message-Id: <20221019145246.v2.7.Ia91f031f5f770af7bd2ff3e28b398f277606d970@changeid>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221019215440.277643-1-briannorris@chromium.org>
References: <20221019215440.277643-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An earlier patch ("mmc: cqhci: Handle deactivate() when not yet
initialized") makes these redundant.

I keep these as a separate patch, since the earlier patch is a
prerequisite to some important bugfixes that need to be backported via
linux-stable.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - New in v2

 drivers/mmc/host/sdhci-pci-core.c | 3 +--
 drivers/mmc/host/sdhci-pci-gli.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 169b84761041..63d62a9228d7 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -236,8 +236,7 @@ static void sdhci_pci_dumpregs(struct mmc_host *mmc)
 
 static void sdhci_cqhci_reset(struct sdhci_host *host, u8 mask)
 {
-	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
-	    host->mmc->cqe_private)
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
 		cqhci_deactivate(host->mmc);
 	sdhci_reset(host, mask);
 }
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 4d509f656188..5a13fe961620 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -924,8 +924,7 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
 
 static void sdhci_gl9763e_reset(struct sdhci_host *host, u8 mask)
 {
-	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
-	    host->mmc->cqe_private)
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
 		cqhci_deactivate(host->mmc);
 	sdhci_reset(host, mask);
 }
-- 
2.38.0.413.g74048e4d9e-goog

