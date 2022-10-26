Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97F860E938
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbiJZTm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbiJZTmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:42:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A24CABEB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:42:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so4107812pjh.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8kvE/d8310xZl2YgDA7SStCHTp5iEbyeEE+ffhvPBuQ=;
        b=RSMDkrX2V+zcNpiTdQ1wkxMpY0MkQFoEcr10UQqRUSMpHme9v3lNADkdRSrpPn0qMo
         ytXgpJn02JU+LhXiBVYIKj85cYxlt/zdYcwXEpnSUh3jfgjqTM7jTU8rFpcab/FhqSN+
         WJ99JXJJGfIpl62F+5NGC2M2ztPtpVbHBEp+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kvE/d8310xZl2YgDA7SStCHTp5iEbyeEE+ffhvPBuQ=;
        b=MeQlPpJUJeUpn2dZzB90f0Z777ublFs2ylcGaZCFIMhSSxiPh4MZSjeBC/p3yppDM+
         Rni6U0PzpqAHAoVqy53c4TJBnnSwu3/p6PWiis6++H6G6DNWdlAPtXGqhpKgGTDaTNym
         rL/zfJn6hCeAthBn7vuIXwdc5rZVj+WoJR3Vb/IytHTEe4pHImqekOMwysG4uOzRklUx
         3FRazzdDaMEZa4WvPehOam0J7btE/ibI2i1GUjWRBwRuK7F1KdDqojUnd+RfN9y5hxUM
         APG/RmEOSi91VQ49IjsXjVBGW12edCepZxc90bKhZ4Zb1Pl1QnCeDJ/RE07vRQMcTT37
         Pzzg==
X-Gm-Message-State: ACrzQf32QF82mc8g/y1bK9qHjt1gC+VXfghYymejrpX8FxcGLmzOmfqr
        i+yaP1xy+9xbbsDyDFJINaQ/qQ==
X-Google-Smtp-Source: AMsMyM6hZj9GDeltOVu0pxtCH5Ge/4TwElCv/M6SAFnmN6j13C5wankmCzTWxSILJ+5vGUOoy3PfIg==
X-Received: by 2002:a17:90b:4a04:b0:213:587b:204e with SMTP id kk4-20020a17090b4a0400b00213587b204emr4770856pjb.98.1666813346142;
        Wed, 26 Oct 2022 12:42:26 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:c9e3:74f3:6b2b:135])
        by smtp.gmail.com with UTF8SMTPSA id mn22-20020a17090b189600b0020d24ea4400sm1441113pjb.38.2022.10.26.12.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:42:25 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Al Cooper <alcooperx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 0/7] mmc: sdhci controllers: Fix SDHCI_RESET_ALL for CQHCI
Date:   Wed, 26 Oct 2022 12:42:02 -0700
Message-Id: <20221026194209.3758834-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

Changes in v4:
 - Improve for-stable cherry-picking notes
 - Add Adrian's Ack
 - Also fix sdhci_am654_ops, sdhci_j721e_8bit_ops

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
 drivers/mmc/host/sdhci-cqhci.h     | 24 ++++++++++++++++++++++++
 drivers/mmc/host/sdhci-esdhc-imx.c |  3 ++-
 drivers/mmc/host/sdhci-msm.c       | 10 ++--------
 drivers/mmc/host/sdhci-of-arasan.c |  3 ++-
 drivers/mmc/host/sdhci-pci-core.c  | 11 ++---------
 drivers/mmc/host/sdhci-pci-gli.c   | 11 ++---------
 drivers/mmc/host/sdhci-tegra.c     |  3 ++-
 drivers/mmc/host/sdhci_am654.c     |  7 ++++---
 9 files changed, 42 insertions(+), 33 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-cqhci.h

-- 
2.38.0.135.g90850a2211-goog

