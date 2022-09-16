Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE045BB1C8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIPR65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIPR6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:58:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12130A6ADE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:58:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dv25so51124376ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Zd/o9M8DI6uCrxhdOmsIDeIBqPxRjAyKBLA8DBswRu4=;
        b=m90z0oUISdCEVrhjQ9uxUANR3NM+rrTnamL16T2Nn3vpLe8WXEL5NAp9AqZl3J8vn3
         O1bpIw1FDkyRbTfK3j31cJfLWEUs8sjFb6PpwBZNdO8ZdCnnCBOMYLvGkwaiS+jSe0yh
         LITIPcmoQS+/LNf6Lmk5/rkBj/Av0e9+yhuhi6wIOH04IRjfPAZnrBkEo5esTJ+nFUq8
         CoG5N3mYBX7CpdlAG3aRZKeoyPvu3UUiNwtWBc68j19ZR8uAOMN5UuxUiVXtvvgdqp9d
         ju1FyVwDb+4eFmf7i+v3y4zmgTNKp6u/69gro38QCm3jEeL2rpi11snDAX9wOz2FlVSK
         sD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Zd/o9M8DI6uCrxhdOmsIDeIBqPxRjAyKBLA8DBswRu4=;
        b=AhoMS7NxQ7BxFj7c6vDnG9Vr2IKNvC+9VwKg330isZ9zr5cHAMRXYFu+HeNvw96BBw
         dTQXeV76Ysg8gImXAY0c5KISB/nwHXKiJSWIJzqnd0FmOjXoqjTrk8WJsg2BZCmxSfpV
         BvUsEFk7Zdvd7ejgzqwY0dkhYksjxZxPqA8tB6JwmyuRQ7p97I9EPZ95JF/O8NIsbwHa
         sQguSvfGJ+f3QP8fBkQ0nJWmN7oM0v3J2Rgdd3V0h0y/3paCkhhpE+Vyv7VS5+ob75Z1
         AKdC+2/RcJbGiA395z6g56SLWZUrBx0JhYVLTUo4gcCvPj5Jm/AVBmSR5U3HCIQGzR7p
         710w==
X-Gm-Message-State: ACrzQf3tscvLKRcwCOud+PWWZebJq/jxELiFkvM4eIfHYIIgbwdCAYDT
        7uW1ObFjYuBgnfK//O3Lshfa6Cv7JHrwMQDWGkiWPA==
X-Google-Smtp-Source: AMsMyM69Euu4DOD30Wd1AHTVKT487yinq2VcXobq8TR0kzMsZGA+ymFgkuKfAvxrsz9WGg22sPg7VqALnRIfWZ//76g=
X-Received: by 2002:a17:907:3f26:b0:77c:2508:3c08 with SMTP id
 hq38-20020a1709073f2600b0077c25083c08mr4403073ejc.532.1663351131443; Fri, 16
 Sep 2022 10:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220912212847.1337868-1-ptf@google.com> <925b6e37-051f-927c-350a-cd767d88d72b@intel.com>
In-Reply-To: <925b6e37-051f-927c-350a-cd767d88d72b@intel.com>
From:   Patrick Thompson <ptf@google.com>
Date:   Fri, 16 Sep 2022 13:58:40 -0400
Message-ID: <CAJs+hrEiMP1hxZ06rnHWeUbvsau5C3D3aScSTmU4tEwvQ8Zm5w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-core: Disable cqe for ASUS 1100FK family devices
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linux MMC development <linux-mmc@vger.kernel.org>,
        Sangwhan Moon <sxm@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

I made a mistake while testing this patch, please do not merge it as
it does not fix any issues. We will send out a v2 patch shortly.

Thanks,
Patrick


On Tue, Sep 13, 2022 at 2:34 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 13/09/22 00:28, Patrick Thompson wrote:
> > From: ptf <ptf@google.com>
> >
> > The CQE implementation for the eMMC in the ASUS 1100FK family of devices
> > is broken. This causes installations to fail and thus we are disabling
> > CQE for this family of devices.
> >
> > Signed-off-by: Patrick Thompson <ptf@google.com>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> > ---
> >
> > Hello,
> >
> > I was hoping to get some advice on adapting this patch to target the
> > eMMC directly instead of a family of laptops. One idea is to use the
> > PCI-id of the controller (in this case [8086:4dc4]). Would that make
> > sense? Is there someone with more knowledge on the subject that could
> > confirm that the [8086:4dc4] device doesn't have a working CQE?
>
> In these cases the issue is suspected to be BIOS. Best solution is to
> disable CQE.
>
> >
> > Thank you,
> > Patrick
> >
> >
> >  drivers/mmc/host/sdhci-pci-core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > index 622b7de96c7f..3ba0250559e7 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -890,7 +890,8 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
> >  {
> >       return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
> >              (dmi_match(DMI_BIOS_VENDOR, "LENOVO") ||
> > -             dmi_match(DMI_SYS_VENDOR, "IRBIS"));
> > +             dmi_match(DMI_SYS_VENDOR, "IRBIS") ||
> > +             dmi_match(DMI_PRODUCT_FAMILY, "ASUS BR1100FKA"));
> >  }
> >
> >  static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
>
