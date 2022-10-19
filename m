Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCADD604F68
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiJSSQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJSSQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:16:36 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776221799AC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:16:35 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id p7so18500480vsr.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GfqaWFlWX03qJjtXLatVr0AX1rxrTcKQJrK9OFei/b4=;
        b=DaMK+okJkhTqXO0tCHUo2PGaEoIoLwmvBLK++ag/DlJYkkcWzc5QW1vlV7mIE4YGyl
         4Si9nq3pHOrzFQPyQOlEIEuyeftKo9fg/wwopYyXUoMoJ38lBaJIadjxMobcVwUhLoW4
         tZ/R7LG1MoOWWGCv899vlYQsGbcV/11Q3LUfFCYUvm6oM3pbusgKbV5BkID3GLx/ypQm
         eHpX2XNY6WBI1kwbEx+kVNYW6FxYTkpuURAwOi7Cl4X3KvGYTDm7hmuDS9pewX8BOpTR
         t9t3I4M0tzovvViRCzsFSsLBicmjyNN2BgUkxRP5e2+o10FAd4UnburFpltk4RQlU9J6
         WqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfqaWFlWX03qJjtXLatVr0AX1rxrTcKQJrK9OFei/b4=;
        b=k0cSYcPX3U4sCCg+HuSQ8B9SStAB66/GvTAKD6hRF4nidAs2sKQ2dIQSviDCIsTYGE
         T2MjETukCUVXjmhRuvNP1n7oZ3+Od4PNZJGwyMOV+h+Kv9sPXWFc8DaD+iZBm/ukvDNB
         ZnS2opxgJLjzZ2SFcuTPwYkUp0HMmeHWam9rM1vh11KPSqbCpYEBJ6D4UBn2WxlT6n1w
         dG/D1yjEuauJgWefnICZIOhKEopQ8ZiQ9luHNE8XnvSzY7bbsizP/bcE8/twePOPYilV
         JExd6iNyISqFMJ3QjITjmQwqxQ4AWUZAD8wyE0GuYIrl/jP5RmOFrKHw436fTQjD3Zkp
         CgSA==
X-Gm-Message-State: ACrzQf1DphOF7g7RKdChJrtAMZaLIXp9vFCYlI9BpKvTw7EZ8yuvHEQ3
        lW2zObIlLTsaWWZE9syD1Xa7NJKm1ajH9P1tSnBXRg==
X-Google-Smtp-Source: AMsMyM6zjb9LpkQkKbRcSiTaG9pbmECJJ2b9kgB//3kBqfIGYtIgxYJ2EeGD/OFPsFmQnygUlgV1hfoPe9bQlNC4auA=
X-Received: by 2002:a67:f342:0:b0:38c:8b81:629f with SMTP id
 p2-20020a67f342000000b0038c8b81629fmr4924691vsm.60.1666203394333; Wed, 19 Oct
 2022 11:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221013210017.3751025-1-ptf@google.com> <CAPDyKFoWy883VqnA8Qmk8OvP2FAQKALys41yDab+YQhs29Y63A@mail.gmail.com>
In-Reply-To: <CAPDyKFoWy883VqnA8Qmk8OvP2FAQKALys41yDab+YQhs29Y63A@mail.gmail.com>
From:   Patrick Thompson <ptf@google.com>
Date:   Wed, 19 Oct 2022 14:16:26 -0400
Message-ID: <CAJs+hrHDjX7csdZouuT75y=k=aiSezTkYEDTM2wk-fMpvLfgMQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-pci-core: Disable ES for ASUS BIOS on
 Jasper Lake
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC Development <linux-mmc@vger.kernel.org>,
        Sangwhan Moon <sxm@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Ulf,

Are there any actions that I need to take?

Best,
Patrick

On Fri, Oct 14, 2022 at 10:08 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 13 Oct 2022 at 23:00, Patrick Thompson <ptf@google.com> wrote:
> >
> > Enhanced Strobe (ES) does not work correctly on the ASUS 1100 series of
> > devices. Jasper Lake eMMCs (pci_id 8086:4dc4) are supposed to support
> > ES. There are also two system families under the series, thus this is
> > being scoped to the ASUS BIOS.
> >
> > The failing ES prevents the installer from writing to disk. Falling back
> > to HS400 without ES fixes the issue.
> >
> > Signed-off-by: Patrick Thompson <ptf@google.com>
> >
> > Fixes: 315e3bd7ac19 ("mmc: sdhci-pci: Add support for Intel JSL")
>
> Applied for fixes and by adding a stable tag, thanks!
>
> Kind regards
> Uffe
>
>
> >
> > ---
> >
> > Changes in v3:
> > * Remove redundant MMC_CAP2_HS400 selection
> >
> > Changes in v2:
> > * Only disable ES instead of CQE in its entirety.
> > * Target Jasper Lake (JSL)
> > * Target ASUS BIOS instead of specific system family
> >
> >  drivers/mmc/host/sdhci-pci-core.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > index 169b84761041..34ea1acbb3cc 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -914,6 +914,12 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
> >                 dmi_match(DMI_SYS_VENDOR, "IRBIS"));
> >  }
> >
> > +static bool jsl_broken_hs400es(struct sdhci_pci_slot *slot)
> > +{
> > +       return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_JSL_EMMC &&
> > +                       dmi_match(DMI_BIOS_VENDOR, "ASUSTeK COMPUTER INC.");
> > +}
> > +
> >  static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
> >  {
> >         int ret = byt_emmc_probe_slot(slot);
> > @@ -922,9 +928,11 @@ static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
> >                 slot->host->mmc->caps2 |= MMC_CAP2_CQE;
> >
> >         if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
> > -               slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
> > -               slot->host->mmc_host_ops.hs400_enhanced_strobe =
> > -                                               intel_hs400_enhanced_strobe;
> > +               if (!jsl_broken_hs400es(slot)) {
> > +                       slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
> > +                       slot->host->mmc_host_ops.hs400_enhanced_strobe =
> > +                                                       intel_hs400_enhanced_strobe;
> > +               }
> >                 slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
> >         }
> >
> > --
> > 2.38.0.413.g74048e4d9e-goog
> >
