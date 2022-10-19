Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEA1605256
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiJSVz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiJSVzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:55:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C4037FA0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:55:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 10so18576454pli.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aSPJogmlylX7KM1RJ0D1MDbzbxw24/coSip2lgP3l8=;
        b=FfeJSmTDi68H718jGTkL3Qo1tO+F4L+j54/kcb1cwGvPvCRoxWbXgrlkIzP8z1mliR
         GZ3uqYlcUUjHj9i+2kUHXcKMhvofvcwCX0imm1RPyUM1cBAIEklypYsyDLGlghvh/Th5
         ePYBz8C0cLy280KU4RVy6tzul8GnmJ1Y48fYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aSPJogmlylX7KM1RJ0D1MDbzbxw24/coSip2lgP3l8=;
        b=bwIuI7iuN+g1T5lvQfRQBU9iTwD27Y0N35jm+Ge+RQ8LbJxknq8BXGiBXlu7l0mjjD
         HIeXfxzAph6tL9q2WDUrKLWKtyty0ZvmYiiAnSpr+s5JsXDRC4iGe8ijhFr8MqZdRIwV
         ZJw3l5zsZS+fqZln1DVJPwQtwOlYD99b5BRXZqTi9fJDrVB1sKbccwZWmGqS76Un4ik5
         16n+bA5bMYIl9JoftBBablMnUr9dGG2WdY7NPM/+IaOrn7zSpf627L+ywwyXAuwg5v+s
         hPw/agQwuBx69F95EoblNnZz+B3u0wFPXmCeQ9PoAaWRlyDiUAvfeWdXc3cHKoFWL6as
         7cfg==
X-Gm-Message-State: ACrzQf2dh8mLrbv51TIDB1FB3rxw4ykOLbGkVEWeZ412ZYOKlKzJ4eqA
        LRumdVigTP5M1xunsL+QWLXCQw==
X-Google-Smtp-Source: AMsMyM7Iv6iv4kAIoVGRCrEZHEH/ZPVWrqoEmnkjZdmu4WQ95eSFzTazbt4oPRQx024Pge0QJgZ0DA==
X-Received: by 2002:a17:902:9048:b0:17f:93a5:4638 with SMTP id w8-20020a170902904800b0017f93a54638mr10696224plz.108.1666216506540;
        Wed, 19 Oct 2022 14:55:06 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:57b7:1f0e:44d1:f252])
        by smtp.gmail.com with UTF8SMTPSA id s13-20020aa78bcd000000b00543a098a6ffsm11792418pfd.212.2022.10.19.14.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 14:55:06 -0700 (PDT)
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
Subject: [PATCH v2 3/7] mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
Date:   Wed, 19 Oct 2022 14:54:36 -0700
Message-Id: <20221019145246.v2.3.I6a715feab6d01f760455865e968ecf0d85036018@changeid>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221019215440.277643-1-briannorris@chromium.org>
References: <20221019215440.277643-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [[ NOTE: this is completely untested by the author, but included solely
    because, as noted in commit df57d73276b8 ("mmc: sdhci-pci: Fix
    SDHCI_RESET_ALL for CQHCI for Intel GLK-based controllers"), "other
    drivers using CQHCI might benefit from a similar change, if they
    also have CQHCI reset by SDHCI_RESET_ALL." We've now seen the same
    bug on at least MSM, Arasan, and Intel hardware. ]]

SDHCI_RESET_ALL resets will reset the hardware CQE state, but we aren't
tracking that properly in software. When out of sync, we may trigger
various timeouts.

It's not typical to perform resets while CQE is enabled, but this may
occur in some suspend or error recovery scenarios.

Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - Rely on cqhci_deactivate() to handle NULL cqe_private, instead of
   moving around CQE capability flags

 drivers/mmc/host/sdhci-brcmstb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index aff36a933ebe..d479ca39c987 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -55,6 +55,9 @@ static void brcmstb_reset(struct sdhci_host *host, u8 mask)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
 
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
+		cqhci_deactivate(host->mmc);
+
 	sdhci_reset(host, mask);
 
 	/* Reset will clear this, so re-enable it */
-- 
2.38.0.413.g74048e4d9e-goog

