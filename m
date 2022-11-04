Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1C0619B0D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiKDPKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiKDPKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:10:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4655D2DC7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:10:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h14so4745579pjv.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJiR0l3zu+rrq4gW27oklnD3llG/ltOJZ/tWeSlC10g=;
        b=OTgqCSoh2YvcJ32IjPiJ0Ohi+r0dVtEVpUxV9onQ/bsloNUG/1fzVCl2FAJt5yl7qJ
         W/0Du7QGSCJBiSfasBiW4yFO/DMawCRe25wi+GO8bE1bG3swgxEpFSmIOcLIYv8DXXxN
         ed0NTMn8ZdF1vQQ7kC8s6L6lnRndpnCbqLchKzRkZdsKcVSY3zhVDupCJwz4WXzUU55a
         jDsANgzibYXCccM5Iyz0ib6sk4xwNPP3OThOrQQ+d7NOTzHnKscUiLK/k+CekOc8Irsw
         lsryTP5tYyWQelh17JwZ81rNWOZ6/xi81gmmsgP6tGfcXYe6lmtwpRj83cwf7c5m5Z/D
         LRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJiR0l3zu+rrq4gW27oklnD3llG/ltOJZ/tWeSlC10g=;
        b=gaxCizGeU8Chb/Lhse1Rm6wJtbUxxI2YyzkEwUzQuy/6KEygtaeJezyI88ZRJ+R1Nz
         o1TwoOQlBeMRxfqUQbRi/dm/FurUnyw8vAC75R0W1CXN0FwV74SMHUO6N83gtHjceAyN
         QEu3ryBDN8VPactneZsbtKJbKa0cowRq2RIVlIklyfBfqar6O2d0y8Ye0MFDsmpNX7mq
         AFCchtyWRUu31UXlJr4NQWCBNnm6Drm0MDF1QHtAwvOjxJ3pBh7S/BekAf/TfXhpAGX+
         TwsiOb33J455z/zuzTPcdsPaWx11Q51WhFXCrc2koeRbqHewjfGr5autw+fLCHZMcIQZ
         r6ZA==
X-Gm-Message-State: ACrzQf2U0v/3ZMoh0l7rG5BF7aznX7uBoXBjMQi49k3m2GiY7iJhJZe5
        LZzuWpjqrhEaQF8YwdUJ0bAshksEbDcyhyvT3PpaZw==
X-Google-Smtp-Source: AMsMyM7v/lhbKfY6yPId/WwdeSdcU4FwAHXJyhkf3ncszzUFaEhoZwMtxrOIFVwjKlF86Dbv3p3O9MX0Pp2IDIXlrqo=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr36815479plb.148.1667574606756; Fri, 04
 Nov 2022 08:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-3-victor.shih@genesyslogic.com.tw> <e9c15b05-6515-cc40-d842-4bdaca96b0c8@wanadoo.fr>
In-Reply-To: <e9c15b05-6515-cc40-d842-4bdaca96b0c8@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Nov 2022 16:09:30 +0100
Message-ID: <CAPDyKFrabiXO_9dKMPL0PXfyMfznoMcdLaHmKMr4Esu3b=7fvA@mail.gmail.com>
Subject: Re: [PATCH V5 02/26] mmc: core: Prepare to support SD UHS-II cards
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Victor Shih <victorshihgli@gmail.com>, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 13:16, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 19/10/2022 =C3=A0 13:06, Victor Shih a =C3=A9crit :
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Updates in V4:
> >   - Re-based, updated a comment and removed white-space.
> >   - Moved MMC_VQMMC2_VOLTAGE_180 into a later patch in the series.
> >
> > Update in previous version:
> > The SD UHS-II interface was introduced to the SD spec v4.00 several yea=
rs
> > ago. The interface is fundamentally different from an electrical and a
> > protocol point of view, comparing to the legacy SD interface.
> >
> > However, the legacy SD protocol is supported through a specific transpo=
rt
> > layer (SD-TRAN) defined in the UHS-II addendum of the spec. This allows=
 the
> > SD card to be managed in a very similar way as a legacy SD card, hence =
a
> > lot of code can be re-used to support these new types of cards through =
the
> > mmc subsystem.
> >
> > Moreover, an SD card that supports the UHS-II interface shall also be
> > backwards compatible with the legacy SD interface, which allows a UHS-I=
I
> > card to be inserted into a legacy slot. As a matter of fact, this is
> > already supported by mmc subsystem as of today.
> >
> > To prepare to add support for UHS-II, this change puts the basic founda=
tion
> > in the mmc core in place, allowing it to be more easily reviewed before
> > subsequent changes implements the actual support.
> >
> > Basically, the approach here adds a new UHS-II bus_ops type and adds a
> > separate initialization path for the UHS-II card. The intent is to avoi=
d us
> > from sprinkling the legacy initialization path, but also to simplify
> > implementation of the UHS-II specific bits.
> >
> > At this point, there is only one new host ops added to manage the vario=
us
> > ios settings needed for UHS-II. Additional host ops that are needed, ar=
e
> > being added from subsequent changes.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
>
> []
>
> > +static int sd_uhs2_attach(struct mmc_host *host)
> > +{
> > +     int err;
> > +
> > +     err =3D sd_uhs2_power_up(host);
> > +     if (err)
> > +             goto err;
> > +
> > +     err =3D sd_uhs2_phy_init(host);
> > +     if (err)
> > +             goto err;
> > +
> > +     err =3D sd_uhs2_init_card(host);
> > +     if (err)
> > +             goto err;
> > +
> > +     mmc_attach_bus(host, &sd_uhs2_ops);
> > +
> > +     mmc_release_host(host);
> > +
> > +     err =3D mmc_add_card(host->card);
> > +     if (err)
> > +             goto remove_card;
> > +
> > +     mmc_claim_host(host);
> > +     return 0;
> > +
> > +remove_card:
> > +     mmc_remove_card(host->card);
>
> Hi,
>
> If we arrive here, mmc_add_card() has failed.
> is it correct to call mmc_remove_card() in such a case?

Yes. There are some additional checks in mmc_add_card() to help to
manage this too.

Although, there are certainly some cleanups that can be made to
simplify the code in the mmc core around this, but that's a different
story.

>
> > +     host->card =3D NULL;
> > +     mmc_claim_host(host);
> > +     mmc_detach_bus(host);
> > +err:
> > +     sd_uhs2_power_off(host);
>
> If sd_uhs2_power_up() fails, we arrive here.
> Is its correct to call sd_uhs2_power_off() in such a case, or should we
> return directly if sd_uhs2_power_up() fails?

That's an option that could make the code a bit clearer. I have no
strong opinion around this.

Although, if changing this, we need to make sure sd_uhs2_power_up()
restores things correctly after a failure, but it doesn't do that in
the current version of the patch.

Kind regards
Uffe
