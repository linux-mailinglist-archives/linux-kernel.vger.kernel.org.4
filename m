Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8E460524D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJSVzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiJSVzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:55:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A61FF272
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:54:58 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o21so16109542ple.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=05Yhwd9QPD5U+FfDA5cFl5dFoWfVBmAtYbeU1FfXhQQ=;
        b=RlE9kMd6/h7DZpQA0UZZUbHxAWdsUbnFk4ak9VTjYUYSh3bvURpBYXFirqHjFvWrMT
         ojyv6vjPWnXelssHEILiKkmUXn/+N4ZiEjL5bO5xVhXm9YYbwSgv27FlqXci758TQ8e+
         9Rj+LydUeesYL8+PHub5wTR26vhTRYfMNZv38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05Yhwd9QPD5U+FfDA5cFl5dFoWfVBmAtYbeU1FfXhQQ=;
        b=6UrEFefZscrDvGmun3sN5VEADrQBAkxVJ2lNuBaEUgeA8QE4jFJNB+yb/FM1oCJ3Iv
         ioVsKPqYkI5QlKiO7W2qOcbW6QBsX3hhdWv5isOjbAIpuGXqvE8z8bjqjUgRzlQUHF5I
         d4wtJzLHvVOCwq7iOtoxbaHI8RQRyiGmLR+8AJxRI5KmKA7SuACz5PsYMlsBbRZ4N4QK
         yFwTH3+aQkQnxxRXypaaPgzk8331ka0Lo3nmCg6YBE5SOPDBTn+zE4fa2cowTopFxkeE
         TAeoUm+peepu0US7xepCdXy5F2ANLtdWz3AZquqRIGqdL4qIVGsavrtqJsOqt0+R+1pH
         kpHg==
X-Gm-Message-State: ACrzQf1BeVVs3KsxYEijUY4cgK/FbS6n2HweHiHRFQpzyxrE2bweiz8L
        9eE+voy3aMjTFJwBYt551HiFjQ==
X-Google-Smtp-Source: AMsMyM4raOXbgvOGGU+muWqEUI30i6PzZGo+EeKJNqFRBBCvQvSSZ71PmbDc1I5gzJpIorA0Ms5Lcw==
X-Received: by 2002:a17:903:48e:b0:17e:ea4a:394e with SMTP id jj14-20020a170903048e00b0017eea4a394emr10258223plb.48.1666216498114;
        Wed, 19 Oct 2022 14:54:58 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:57b7:1f0e:44d1:f252])
        by smtp.gmail.com with UTF8SMTPSA id d7-20020a170902654700b0017c3776634dsm11254233pln.32.2022.10.19.14.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 14:54:57 -0700 (PDT)
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
Subject: [PATCH v2 0/7] mmc: sdhci controllers: Fix SDHCI_RESET_ALL for CQHCI
Date:   Wed, 19 Oct 2022 14:54:33 -0700
Message-Id: <20221019215440.277643-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
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

This is a series of nearly identical fixes for several SDHCI host
drivers. Patch #2 (for sdhci-of-arasan; plus its dependency in patch #1)
is the only one I've tested, and I wrote it due to a bug described
there.

I then noticed that several other drivers do the same thing, and that
commit df57d73276b8 ("mmc: sdhci-pci: Fix SDHCI_RESET_ALL for CQHCI for
Intel GLK-based controllers") points out the likely-repeated bug.

Thus, I include additional patches (compile-tested only) that apply
similar fixes to the other drivers which call cqhci_init() but not
cqhci_deactivate(). They contain appropriate disclaimers and the
relevant parties are CC'd. I would suggest only merging them if you get
some kind of ACK from people familiar with the relevant hardware.

Notably, I do *not* patch drivers/mmc/host/mtk-sd.c although it uses
CQHCI, because it doesn't seem to be an SDHCI-based controller, and so
even if it has a similar bug, it's not clear to me how to patch it.

- Brian

Changes in v2:
 - Rely on cqhci_deactivate() to safely handle (ignore)
   not-yet-initialized CQE support

Brian Norris (7):
  mmc: cqhci: Handle deactivate() when not yet initialized
  mmc: sdhci-of-arasan: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
  mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci-tegra: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci-pci-*: Drop redundant ->cqe_private check

 drivers/mmc/host/cqhci-core.c      | 2 +-
 drivers/mmc/host/sdhci-brcmstb.c   | 3 +++
 drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
 drivers/mmc/host/sdhci-of-arasan.c | 3 +++
 drivers/mmc/host/sdhci-pci-core.c  | 3 +--
 drivers/mmc/host/sdhci-pci-gli.c   | 3 +--
 drivers/mmc/host/sdhci-tegra.c     | 3 +++
 drivers/mmc/host/sdhci_am654.c     | 3 +++
 8 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.38.0.413.g74048e4d9e-goog

