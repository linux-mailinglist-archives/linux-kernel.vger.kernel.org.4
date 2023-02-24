Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D40B6A1A05
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBXKWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBXKWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:22:43 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB4B1CF46;
        Fri, 24 Feb 2023 02:22:42 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id c18so440308qte.5;
        Fri, 24 Feb 2023 02:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ArdJ82Ti4o0RpCTc3la0LvQj32FhuvjhyjGEJAFaRo=;
        b=dC+nfr7TtVnR4AooU8jYBSOyZWFE53uaJTrXRf5ZXHxMwrkYb4cFtOFFOLVfq+yuaf
         OCWXKw+rE9CPImvyXqhS1lHmHVFuzDbh7Yho2IjAwkZvRxQQHXpTje8n7N/cikNyyEx0
         s7MgUWDsxzLWKqMbSFfyedo7TKCmnOdeNQLFv/LLv4P18NaLFYruLreA/4PLeBwIFkR5
         VCPGLjMT7UkAwXXpf/mw3F4vcnnAImVXxUW5TLc55VFmnPiUNCBZpeQZwRrptQZMFdN2
         L31ydk5THOP0hdu2l1zdkZLp4UxVS2TVrrBZpoMNJGDaLGHVx4sM0q7lxdNEY2tqwlXd
         +cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ArdJ82Ti4o0RpCTc3la0LvQj32FhuvjhyjGEJAFaRo=;
        b=bIbZvEjNdncOBtmR2z6EP/z6S53cGy7MmzwhI421v0qX+iNfqANdswZ0C1JVMpycb9
         Oszsjmdw+32AjZcALTCTvLLmXru3AK1L+ln1pufbFnprqeF1wd+kziz3U1yT5K3LxTCI
         TBZ7yZtijBcNcIh20KLxdA0pxksQFzOzU38UahbEHLy1pn1rzJj79S1+7UE5it3odeLN
         SNP0Hn5CEgxYoee2xtxom4fh/JyLYFXDYYkuPBa88L47vXEJ8hj0SMvSJS7JwEI3kc+X
         MoVvs8unP4IjArww+JLbfhEzzUmiWqYhNdShtUyR7UOUUKAreSkLDnMEldC4oorS3mdW
         NZ4g==
X-Gm-Message-State: AO0yUKVyKysLexonkdvxxDcN3nP5PrCP/rvVuaIT5dcxhs32r+4zGVqR
        OF4FD/pMksH6XM0lMwjWu98N8odyM80B40SIK1U=
X-Google-Smtp-Source: AK7set+lNXXxsCgvZ4t+iXZH2vNnwUUFCHa+MJV8RpOpu6jfJWo34rHQetYrPNWTBHzkKFezpLRWlPO/VD3cWQvBCKo=
X-Received: by 2002:ac8:604e:0:b0:3bd:6c0:933d with SMTP id
 k14-20020ac8604e000000b003bd06c0933dmr2758827qtm.10.1677234161233; Fri, 24
 Feb 2023 02:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-2-victor.shih@genesyslogic.com.tw> <1dc8942d-b7c7-144b-f5a1-a3f614f159ff@intel.com>
In-Reply-To: <1dc8942d-b7c7-144b-f5a1-a3f614f159ff@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 24 Feb 2023 18:22:29 +0800
Message-ID: <CAK00qKC0h1x=oXFcXPGe0hFCnTG2vsgrSWttVYro9P1D_7=LWg@mail.gmail.com>
Subject: Re: [PATCH V6 01/24] mmc: core: Cleanup printing of speed mode at
 card insertion
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adrian

On Fri, Jan 6, 2023 at 5:22 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 13/12/22 11:00, Victor Shih wrote:
> > The current print of the bus speed mode in mmc_add_card() has grown over
> > the years and is now difficult to parse. Let's clean up the code and also
> > take the opportunity to properly announce "DDR" for eMMCs as
> > "high speed DDR", which is according to the eMMC spec.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/core/bus.c | 35 ++++++++++++++++++++---------------
> >  1 file changed, 20 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> > index 36679f4e9acc..bbbbdbca5366 100644
> > --- a/drivers/mmc/core/bus.c
> > +++ b/drivers/mmc/core/bus.c
> > @@ -299,6 +299,7 @@ int mmc_add_card(struct mmc_card *card)
> >  {
> >       int ret;
> >       const char *type;
> > +     const char *speed_mode = "";
> >       const char *uhs_bus_speed_mode = "";
> >       static const char *const uhs_speeds[] = {
> >               [UHS_SDR12_BUS_SPEED] = "SDR12 ",
> > @@ -337,25 +338,29 @@ int mmc_add_card(struct mmc_card *card)
> >               break;
> >       }
> >
> > +     if (mmc_card_hs(card))
> > +             speed_mode = "high speed ";
> > +     else if (mmc_card_uhs(card))
> > +             speed_mode = "ultra high speed ";
> > +     else if (mmc_card_ddr52(card))
> > +             speed_mode = "high speed DDR ";
> > +     else if (mmc_card_hs200(card))
> > +             speed_mode = "HS200 ";
> > +     else if (mmc_card_hs400es(card))
> > +             speed_mode = "HS400 Enhanced strobe ";
> > +     else if (mmc_card_hs400(card))
> > +             speed_mode = "HS400 ";
> > +
> >       if (mmc_card_uhs(card) &&
> >               (card->sd_bus_speed < ARRAY_SIZE(uhs_speeds)))
> >               uhs_bus_speed_mode = uhs_speeds[card->sd_bus_speed];
> >
> > -     if (mmc_host_is_spi(card->host)) {
> > -             pr_info("%s: new %s%s%s card on SPI\n",
> > -                     mmc_hostname(card->host),
> > -                     mmc_card_hs(card) ? "high speed " : "",
> > -                     mmc_card_ddr52(card) ? "DDR " : "",
> > -                     type);
> > -     } else {
> > -             pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
> > -                     mmc_hostname(card->host),
> > -                     mmc_card_uhs(card) ? "ultra high speed " :
> > -                     (mmc_card_hs(card) ? "high speed " : ""),
> > -                     mmc_card_hs400(card) ? "HS400 " :
> > -                     (mmc_card_hs200(card) ? "HS200 " : ""),
> > -                     mmc_card_hs400es(card) ? "Enhanced strobe " : "",
> > -                     mmc_card_ddr52(card) ? "DDR " : "",
> > +     if (mmc_host_is_spi(card->host))
> > +             pr_info("%s: new %s%s card on SPI\n",
> > +                     mmc_hostname(card->host), speed_mode, type);
> > +     else {
>
> This bracket wasn't in V5.  Brackets should be on both
> branches of the if-clause or neither.
>

I will update it in V7 version.

> > +             pr_info("%s: new %s%s%s card at address %04x\n",
> > +                     mmc_hostname(card->host), speed_mode,
> >                       uhs_bus_speed_mode, type, card->rca);
> >       }
> >
>

Thanks, Victor Shih
