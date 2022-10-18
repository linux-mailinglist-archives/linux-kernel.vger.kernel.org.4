Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C08B6022F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJRD5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiJRD5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:57:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CDE23155
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:57:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso16126311pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ttn9BtsRvPHZDctoQFYhqchv6f4WZOW0AdvCedAYGAQ=;
        b=AxoTvulQsXHyVthGzQJijYlWVIHRm2hUNQK040FlpeeFvQfV2Fvgv53nLi9MQeFpC5
         W7LFWCpzSLU8uOaqCg3PaGdrVYGk2e45mCqzVkiUVsvgpJJWHBZXv+8xyrtBsCbemUNX
         UpMYHFkZZ11zxyfkIYH+H7UVa8lDBE+rdIoow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ttn9BtsRvPHZDctoQFYhqchv6f4WZOW0AdvCedAYGAQ=;
        b=6d4bD9eA1giUr2Rq5qSpUtftqBnQ6ablktHH0wAyb5/mjA1KZiAT7gzRYuagBhTwj8
         yV5VopmeGxAWFvDA4rjRyZ5cn0yuu4LF0QtKIfAxd5j/Os8d5pOXh3+c7P2bh5Jv1Cu1
         h38Wbv7FMRsL8MkaMJvAkcYxcNX3CNCxu30HDs/oDhDBJN+hnm2r+8dOPqmvgTizzKSm
         qSz0YSAGUiN41IYAqtY3bMrQ6rmXE3tIdhd6Q9k+SVp0dhwnqF3LbEVgG/2vWF97QGqA
         ed3tDzT6N2/FlYpvgupd+nCOXRrvwO3X3rrVEOyPcySPSiHkrpHdvjRgnl7WPAL1f4Ev
         az2w==
X-Gm-Message-State: ACrzQf3a5X6OUlfoE+lSJ2S+OOcf/Qz81lsffSIEpZcD18qlQIyy8F/y
        y9FxLfrXt+LLfypmf2933zvkTA==
X-Google-Smtp-Source: AMsMyM5/MMsR3dKwAlnXsP26b3+7tHkvjjlj4iiVTtsPTtcIH0lwoZsn74D8o17KJH1w3ZfKQ3PUHg==
X-Received: by 2002:a17:902:f549:b0:185:3b98:380f with SMTP id h9-20020a170902f54900b001853b98380fmr1074842plf.36.1666065456717;
        Mon, 17 Oct 2022 20:57:36 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:2ac3:f4e2:e908:c393])
        by smtp.gmail.com with UTF8SMTPSA id d9-20020a170902654900b00182305a787fsm7418748pln.62.2022.10.17.20.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 20:57:36 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/5] mmc: sdhci controllers: Fix SDHCI_RESET_ALL for CQHCI
Date:   Mon, 17 Oct 2022 20:57:19 -0700
Message-Id: <20221018035724.2061127-1-briannorris@chromium.org>
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
drivers. The first patch (for sdhci-of-arasan) is the only one I've
tested, and I wrote it due to a bug described there.

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


Brian Norris (5):
  mmc: sdhci-of-arasan: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
  mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci-tegra: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI

 drivers/mmc/host/sdhci-brcmstb.c   |  7 ++++++-
 drivers/mmc/host/sdhci-esdhc-imx.c |  7 +++++++
 drivers/mmc/host/sdhci-of-arasan.c | 17 +++++++++++------
 drivers/mmc/host/sdhci-tegra.c     |  4 ++++
 drivers/mmc/host/sdhci_am654.c     |  3 +++
 5 files changed, 31 insertions(+), 7 deletions(-)

-- 
2.38.0.413.g74048e4d9e-goog

