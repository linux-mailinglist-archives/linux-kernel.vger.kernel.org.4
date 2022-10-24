Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989FA60B74E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiJXTWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbiJXTVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:21:45 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6916BA275
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:57:07 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y4so9108223plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4wUfJCplte1+G0mWPV9aexgL/jA5N4Dat7pKZr+Tgc=;
        b=EXsYa0C60uNhGdEspNoh3iWFaw7LXl1Qtz/v/6RA3nAXmgVTB45Y0Cs+4b/mZHdegE
         dyRJc/5yn06OQe3TCE8a5/DHQvB2BGRErC6Gf2fMarXGfx6Gq1rWeAymo685l+trGjT1
         JHZZosjGut02uUo1aIgDPN3HbNldejPRGdGO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4wUfJCplte1+G0mWPV9aexgL/jA5N4Dat7pKZr+Tgc=;
        b=4dQ3NB5mDP99VySXxQrNOR3TSnXIdII8W4okd9efvvnWKFj2orSzJhm9rubY4tT15e
         UsISNTdnp2vtgMwbLZy2sGAWlAwudryaU80eAWLsUwEvB3d2C5J54ZVboh0tRea1sPMb
         ifE5i6O9GpgpBaBZjEkTcH2jhCglO7WhtXhSIAQ1msZVhy7et+vzZfucUYwawFWR3xN0
         iIFFm3ZF/ylnGtOXFwLMpmM6LS1t/92OwqGWPIzB67MG68eJBZvPvK3/AfyhX6kujUsw
         z8ayIol6wOxaKRvv70+uMxsQZsrEMa6Qz8jI83/58wNpxVF6v7lQpeC7ThxYCCLHsqxf
         ubXQ==
X-Gm-Message-State: ACrzQf2aABkMVBs/FlIus6cvJcWgB0zhFORRvFeMFCzyOEOCN8J9y5TJ
        ADBjmn1RGxPJ5fmEfdOd3EAplQ==
X-Google-Smtp-Source: AMsMyM7ROYfV1N2CFGcOsy94fO7hR1Gm02MWsKlw8jSqt/5VNmn1MzJI6nKhj5d01/InBR08iMMFnw==
X-Received: by 2002:a17:902:f687:b0:185:4163:3368 with SMTP id l7-20020a170902f68700b0018541633368mr35234456plg.25.1666634169850;
        Mon, 24 Oct 2022 10:56:09 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:808b:e2f6:edcf:ccb0])
        by smtp.gmail.com with UTF8SMTPSA id l20-20020a656814000000b0043be67b6304sm54917pgt.0.2022.10.24.10.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 10:56:09 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Faiz Abbas <faiz_abbas@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 0/7] mmc: sdhci controllers: Fix SDHCI_RESET_ALL for CQHCI
Date:   Mon, 24 Oct 2022 10:54:54 -0700
Message-Id: <20221024175501.2265400-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of identical fixes for several SDHCI host
drivers. Patch #2 (for sdhci-of-arasan; plus its dependency in patch #1)
is the only one I've tested, and I wrote it due to a bug described
there.

I then noticed that several other drivers do the same thing, and that
commit df57d73276b8 ("mmc: sdhci-pci: Fix SDHCI_RESET_ALL for CQHCI for
Intel GLK-based controllers") points out the likely-repeated bug. So the
fix is now factored into a separate sdhci_and_cqhci_reset() helper,
and it's likely that most/all drivers that support a combo SDHCI/CQHCI
controller will want to use it.

Thus, I include additional patches (compile-tested only) that apply this
helper/fix to the other drivers which call cqhci_init() but not
cqhci_deactivate(). They contain appropriate disclaimers and the
relevant parties are CC'd. I would suggest only merging them if you get
some kind of ACK from people familiar with the relevant hardware.

Notably, I do *not* patch drivers/mmc/host/mtk-sd.c although it uses
CQHCI, because it doesn't seem to be an SDHCI-based controller, and so
even if it has a similar bug, it's not clear to me how to patch it.

- Brian

Changes in v3:
 - Refactor to a "SDHCI and CQHCI" helper -- sdhci_and_cqhci_reset()

Changes in v2:
 - Rely on cqhci_deactivate() to safely handle (ignore)
   not-yet-initialized CQE support

Brian Norris (7):
  mmc: cqhci: Provide helper for resetting both SDHCI and CQHCI
  mmc: sdhci-of-arasan: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
  mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci-tegra: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci-*: Convert drivers to new sdhci_and_cqhci_reset()

 drivers/mmc/host/sdhci-brcmstb.c   |  3 ++-
 drivers/mmc/host/sdhci-cqhci.h     | 25 +++++++++++++++++++++++++
 drivers/mmc/host/sdhci-esdhc-imx.c |  3 ++-
 drivers/mmc/host/sdhci-msm.c       | 10 ++--------
 drivers/mmc/host/sdhci-of-arasan.c |  3 ++-
 drivers/mmc/host/sdhci-pci-core.c  | 11 ++---------
 drivers/mmc/host/sdhci-pci-gli.c   | 11 ++---------
 drivers/mmc/host/sdhci-tegra.c     |  3 ++-
 drivers/mmc/host/sdhci_am654.c     |  3 ++-
 9 files changed, 41 insertions(+), 31 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-cqhci.h

-- 
2.38.0.135.g90850a2211-goog

