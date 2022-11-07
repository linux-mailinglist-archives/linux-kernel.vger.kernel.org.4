Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA5161FF44
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiKGUNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiKGUNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:13:38 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B0319035
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:13:34 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id b185so11673382pfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s87rc+3CLCRrQxp5sxRKisBXBThEk3zvk8uOAZk34uQ=;
        b=JcatK1a3bnx5+S0pZodYk+4x8ISxTRgSUsbH7K83f5H1MTWJrtZ00CC01l5+JNw5wE
         HGZlX7Cl8JWuzC7SFQfEtoWyAXVgsPF7APeV5BhbUe+RJ8oiLKd1uCQbN6btOgc1fMDG
         AyDCiX7VS5ckLdgp8wCICW3p2fzLRE0C0APaol3oH3OQ3GnRSUSJvyxjVc1PWpzu5U7d
         3v+W2EobOxnhxD/Z836nIjKtP6Ua6902lPUXpqDWr1wzrGzhXv+QDfxWRbLc9CuOtY7D
         096KePrvsoQ9QrHSkCtH+awJs7IDlhxTVHUAjrH+NjQDLDjyecM5WAhXIisMDUEu1FTC
         DCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s87rc+3CLCRrQxp5sxRKisBXBThEk3zvk8uOAZk34uQ=;
        b=Ig6o5lboP0uItqMFrA48rTmyBc1hLY0VZh+MxJmlD664h4O3kg2bjrC1cyFBVJuKE1
         8n1KABGnOgzy89TzPSNI93UahdLlj1FLCSRF8QKGmws4wFTNBnIr8TeAMsxOXS5h13Oc
         sXdjU/uejBMlQhmeP/WQ82ROrsHD0l0A8T1WuOUkQiD0MAlZC+9WP2nB0a7vkIUf6M28
         4d7veQ9lW3Y3fBnTms2iXgnDVFdsV3CpzJ85VPt6MSxZl6LLC7VMeHKQ51teqpJ7BzjA
         Gj+KludlR77awhNkJCJ9OdeGlfk3ujj96ng9zzJHIRx4i0VMB94yULPTXQ9UGo/zcFBi
         MMwQ==
X-Gm-Message-State: ACrzQf0Bp/ZHiWXDhYCnIAvtp2+uMvE8Vlyqu2KNXWgPH4CMghP2XOVb
        JuJaHI80HchvUv70BvYTVlmmuoOw/IcS6S6jdfB0uw==
X-Google-Smtp-Source: AMsMyM4R5Cm2QwKto+eIFDpMQNrn42E1pWAAl2yG+IdRhm6k+vQhrKETu+Dj7T4+ziC4G5VJFL56Pp+oRcye4IJBE9k=
X-Received: by 2002:a05:6a00:1823:b0:56b:f348:998f with SMTP id
 y35-20020a056a00182300b0056bf348998fmr52092639pfa.28.1667852013605; Mon, 07
 Nov 2022 12:13:33 -0800 (PST)
MIME-Version: 1.0
References: <20221026194209.3758834-1-briannorris@chromium.org>
In-Reply-To: <20221026194209.3758834-1-briannorris@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Nov 2022 21:12:56 +0100
Message-ID: <CAPDyKFqQDXPPDVHvSXG57n83wdWs1B7+NzahM0ZAd3CPh6+DXQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] mmc: sdhci controllers: Fix SDHCI_RESET_ALL for CQHCI
To:     Brian Norris <briannorris@chromium.org>
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
        Sowjanya Komatineni <skomatineni@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 at 21:42, Brian Norris <briannorris@chromium.org> wrote:
>
> This is a series of identical fixes for several SDHCI host
> drivers. Patch #2 (for sdhci-of-arasan; plus its dependency in patch #1)
> is the only one I've tested, and I wrote it due to a bug described
> there.
>
> I then noticed that several other drivers do the same thing, and that
> commit df57d73276b8 ("mmc: sdhci-pci: Fix SDHCI_RESET_ALL for CQHCI for
> Intel GLK-based controllers") points out the likely-repeated bug. So the
> fix is now factored into a separate sdhci_and_cqhci_reset() helper,
> and it's likely that most/all drivers that support a combo SDHCI/CQHCI
> controller will want to use it.
>
> Thus, I include additional patches (compile-tested only) that apply this
> helper/fix to the other drivers which call cqhci_init() but not
> cqhci_deactivate(). They contain appropriate disclaimers and the
> relevant parties are CC'd. I would suggest only merging them if you get
> some kind of ACK from people familiar with the relevant hardware.
>
> Notably, I do *not* patch drivers/mmc/host/mtk-sd.c although it uses
> CQHCI, because it doesn't seem to be an SDHCI-based controller, and so
> even if it has a similar bug, it's not clear to me how to patch it.
>
> - Brian
>
> Changes in v4:
>  - Improve for-stable cherry-picking notes
>  - Add Adrian's Ack
>  - Also fix sdhci_am654_ops, sdhci_j721e_8bit_ops
>
> Changes in v3:
>  - Refactor to a "SDHCI and CQHCI" helper -- sdhci_and_cqhci_reset()
>
> Changes in v2:
>  - Rely on cqhci_deactivate() to safely handle (ignore)
>    not-yet-initialized CQE support
>
> Brian Norris (7):
>   mmc: cqhci: Provide helper for resetting both SDHCI and CQHCI
>   mmc: sdhci-of-arasan: Fix SDHCI_RESET_ALL for CQHCI
>   mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
>   mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
>   mmc: sdhci-tegra: Fix SDHCI_RESET_ALL for CQHCI
>   mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
>   mmc: sdhci-*: Convert drivers to new sdhci_and_cqhci_reset()
>
>  drivers/mmc/host/sdhci-brcmstb.c   |  3 ++-
>  drivers/mmc/host/sdhci-cqhci.h     | 24 ++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-esdhc-imx.c |  3 ++-
>  drivers/mmc/host/sdhci-msm.c       | 10 ++--------
>  drivers/mmc/host/sdhci-of-arasan.c |  3 ++-
>  drivers/mmc/host/sdhci-pci-core.c  | 11 ++---------
>  drivers/mmc/host/sdhci-pci-gli.c   | 11 ++---------
>  drivers/mmc/host/sdhci-tegra.c     |  3 ++-
>  drivers/mmc/host/sdhci_am654.c     |  7 ++++---
>  9 files changed, 42 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-cqhci.h
>

Patch1 -> patch6, applied for fixes and by adding stable tags. Patch7
applied for next.

Thanks and kind regards
Uffe
