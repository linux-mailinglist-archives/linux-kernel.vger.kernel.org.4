Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4AE73A20B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjFVNlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjFVNlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:41:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3D4199F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:41:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f871c93a5fso6494705e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687441301; x=1690033301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ohz7CdORxun31CtHu9WD9WzGY/WxyhnyXo2NvK1FiX8=;
        b=D8NbKPGXoESsaW1qLXEsMpmRDhOLeeOyYm2YrXcVigXClndnALYYRkMkho4bHLwSlQ
         Lx9p5wuLceh86kCh5OyFBW858lpF2eoaEYt2FKo7MWpEbG4fuwCItqjVDkPlC0Srvfqd
         YW2WAdcYf2zUMUZn9JrNHvzLaFf2Jzb36iJUG5s5lJx2wQHG9/rqbpYUgbAZTTHzDJV8
         e32xsWNBo7JDbdY+ozabGuFcJvclSbV5t9VDj7eDxjZ4BPJEsFdyo3hr6h1uc3lTnYWJ
         M7J5Av1KZB8a3FT4wN9bl01K0Y7dywDsCA3Jey0F4Y/D7qZiBFXEUmZcD8kJXeg0yaK5
         Qaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441301; x=1690033301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ohz7CdORxun31CtHu9WD9WzGY/WxyhnyXo2NvK1FiX8=;
        b=YNZnHa9uDKjBgQ4+AJEmLFXcN/keO0VVWblmhv/+3UzYby2Y1w3XhnUndxZM+2G29V
         dh7LwsSiqM7tnqZAFOFYzGyjomj6UBhJBYcLgy5EhidqgsHko0bauuC2WTiY87AHyjYg
         2UhHvd4Vv5IxC7ZK7cR3dlsoD/GP/H9n+H+awQokZwsocgFSVyPWuwjlYRd4ousKGdQC
         xsAfWpsFqCRqjUBI8D6T+zQyiu4pS/7tOBcyhjvTD+FWdZFRDldGwqcBBllJ8y2BNUmX
         UhPvQxqyQdxH67JobsxdVF4WtzVzMM3Tng05s8SeVBCso9RQDghTU5ZrmPou2v8M+6C+
         4E8Q==
X-Gm-Message-State: AC+VfDxCgll+nJnnaxC12FGWasK3qaIVxLgjF2a2YxP6q7hA1SV+gkLm
        Nfi9CrhQuMGn4Lk74UffZnJwHA==
X-Google-Smtp-Source: ACHHUZ6sJ01sHdgtaaOUyjH3Wh1mnuXXVE5uwvjGV73E9/+BuQA3ozkyF+592DjVfyBF4NCcR2eIcw==
X-Received: by 2002:ac2:4e97:0:b0:4f9:615f:14e0 with SMTP id o23-20020ac24e97000000b004f9615f14e0mr1694028lfr.49.1687441301030;
        Thu, 22 Jun 2023 06:41:41 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id x8-20020ac24888000000b004eff32d6a21sm1108648lfc.121.2023.06.22.06.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:41:40 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.4-rc8
Date:   Thu, 22 Jun 2023 15:41:39 +0200
Message-Id: <20230622134139.78695-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.4-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.4-rc6

for you to fetch changes up to 413db499730248431c1005b392e8ed82c4fa19bf:

  mmc: usdhi60rol0: fix deferred probing (2023-06-19 13:32:39 +0200)

----------------------------------------------------------------
MMC host:
 - Fix support for deferred probing for several host drivers
 - litex_mmc: Use async probe as it's common for all mmc hosts
 - meson-gx: Fix bug when scheduling while atomic
 - mmci_stm32: Fix max busy timeout calculation
 - sdhci-msm: Disable broken 64-bit DMA on MSM8916

----------------------------------------------------------------
Christophe Kerello (1):
      mmc: mmci: stm32: fix max busy timeout calculation

Jisheng Zhang (1):
      mmc: litex_mmc: set PROBE_PREFER_ASYNCHRONOUS

Martin Hundebøll (1):
      mmc: meson-gx: remove redundant mmc_request_done() call from irq context

Sergey Shtylyov (12):
      mmc: bcm2835: fix deferred probing
      mmc: meson-gx: fix deferred probing
      mmc: mtk-sd: fix deferred probing
      mmc: mvsdio: fix deferred probing
      mmc: omap: fix deferred probing
      mmc: omap_hsmmc: fix deferred probing
      mmc: owl: fix deferred probing
      mmc: sdhci-acpi: fix deferred probing
      mmc: sdhci-spear: fix deferred probing
      mmc: sh_mmcif: fix deferred probing
      mmc: sunxi: fix deferred probing
      mmc: usdhi60rol0: fix deferred probing

Stephan Gerhold (1):
      mmc: sdhci-msm: Disable broken 64-bit DMA on MSM8916

 drivers/mmc/host/bcm2835.c      |  4 ++--
 drivers/mmc/host/litex_mmc.c    |  1 +
 drivers/mmc/host/meson-gx-mmc.c | 14 ++++----------
 drivers/mmc/host/mmci.c         |  3 ++-
 drivers/mmc/host/mtk-sd.c       |  2 +-
 drivers/mmc/host/mvsdio.c       |  2 +-
 drivers/mmc/host/omap.c         |  2 +-
 drivers/mmc/host/omap_hsmmc.c   |  6 ++++--
 drivers/mmc/host/owl-mmc.c      |  2 +-
 drivers/mmc/host/sdhci-acpi.c   |  2 +-
 drivers/mmc/host/sdhci-msm.c    |  3 +++
 drivers/mmc/host/sdhci-spear.c  |  4 ++--
 drivers/mmc/host/sh_mmcif.c     |  2 +-
 drivers/mmc/host/sunxi-mmc.c    |  4 ++--
 drivers/mmc/host/usdhi6rol0.c   |  6 ++++--
 15 files changed, 30 insertions(+), 27 deletions(-)
