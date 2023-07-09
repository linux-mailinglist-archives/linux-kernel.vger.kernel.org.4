Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEF174C196
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 10:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGII2N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Jul 2023 04:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGII2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 04:28:11 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDF3199;
        Sun,  9 Jul 2023 01:28:08 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-c49777d6e7aso4391360276.1;
        Sun, 09 Jul 2023 01:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688891288; x=1691483288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IR/Xx8I4EaLDOI3eaFJvDR4bWuvQgvz+EJ9ItYOUerI=;
        b=lmonR4JgrQOw/Qnv6pBXgsbVATkwsavPZX+rg50pWmzNTYkBEgIhMAwAV8l9o9xE9R
         LMwVdgrJcj8JKNnWcC7gRRdgUmDXdkaLHYaBC+W+t0JmQFKJ6o5nkmLDXHVap/tSKGTD
         TIybC2RiwbMwo+bcNjH8iV24rRygoUHz7LepWLuxcypM+dBY+cbgDoQIJRrOOB2ef1DL
         FC0JmUItrkmE0KR3X7woaWN70TQBe61Clr4sWRBtrkb3mCB93BJrd67ddmynOXLoSolL
         +hwSbdALBkwo8+aXdxSDBdg5nXpBLJUrXpdmAyG4nI2XuZKS7/wvEIA/jA0R3M/EncH3
         EJbQ==
X-Gm-Message-State: ABy/qLYp6Iy6+H/guFCViXIhoxAah292qBFTqSDnhDgWEU8Ngb/UlwXt
        UDmdVUVaSX0tVIotR24AeIVoy3ZiZuKVlg==
X-Google-Smtp-Source: APBJJlEnlOX6e/YthCBQECDoyvt4IyEn2Chg+gpS6KNQIGnCmUpWxKc/Zs7DyEcmX29e59Mr5G3pkQ==
X-Received: by 2002:a25:f505:0:b0:ba8:ae3a:dd39 with SMTP id a5-20020a25f505000000b00ba8ae3add39mr9802738ybe.43.1688891287707;
        Sun, 09 Jul 2023 01:28:07 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id t35-20020a25f623000000b00c4e1589475esm2050170ybd.27.2023.07.09.01.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 01:28:07 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-57a6df91b1eso14140877b3.1;
        Sun, 09 Jul 2023 01:28:07 -0700 (PDT)
X-Received: by 2002:a0d:ea87:0:b0:57a:6bf0:2100 with SMTP id
 t129-20020a0dea87000000b0057a6bf02100mr4060867ywe.1.1688891287208; Sun, 09
 Jul 2023 01:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi7fwNWfqj-QQqEfZTUOB4bbKT8QiEUDHoPk0ecuYA7cA@mail.gmail.com>
 <20230626081950.2090627-1-geert@linux-m68k.org> <39abf2c7-24a-f167-91da-ed4c5435d1c4@linux-m68k.org>
 <2f6ffd1c-a756-b7b8-bba4-77c2308f26b9@infradead.org>
In-Reply-To: <2f6ffd1c-a756-b7b8-bba4-77c2308f26b9@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 9 Jul 2023 10:27:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU30BzfzQ=xEDFCd2bXG=VD68sQz-60Ok8GethLsnEH8A@mail.gmail.com>
Message-ID: <CAMuHMdU30BzfzQ=xEDFCd2bXG=VD68sQz-60Ok8GethLsnEH8A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.4 (wireless/airo)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Sun, Jul 9, 2023 at 4:46 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 6/26/23 01:24, Geert Uytterhoeven wrote:
> > On Mon, 26 Jun 2023, Geert Uytterhoeven wrote:
> >> JFYI, when comparing v6.4[1] to v6.4-rc7[3], the summaries are:
> >>  - build errors: +1/-0
> >
> >   + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]:  => 6163:45
>
> I cannot reproduce this build error. (I don't doubt the problem, just having a problem
> making it happen for me.)
> I have tried it with gcc-11.1.0, gcc-11.3.0, and gcc-13.1.0.

Which is similar to kisskb, using sh4-linux-gcc (GCC) 11.3.0...

> I'm surprised that this is the only instance that gcc found/warned about.

Indeed.

>
> I have a patch for this one instance, but there are 40+ instances of
>         readStatusRid()
>         readConfigRid()
>         readSsidRid()
>         readStatsRid()
>         readCapabilityRid()
> that don't check the return status of the function calls.
>
> I suppose that a patch can quieten the compiler error/warning, but given
> the 40+ other problems, it won't make the driver any noticeably better IMO.

Indeed...

> > sh4-gcc11/sh-allmodconfig
> > seen before
> >
> > This is actually a real issue, and it's been here since basically forever.
> >
> > drivers/net/wireless/cisco/airo.c:
> >
> >     static int airo_get_rate(struct net_device *dev,
> >                              struct iw_request_info *info,
> >                              union iwreq_data *wrqu,
> >                              char *extra)
> >     {
> >             struct iw_param *vwrq = &wrqu->bitrate;
> >             struct airo_info *local = dev->ml_priv;
> >             StatusRid status_rid;           /* Card status info */
> >
> >             readStatusRid(local, &status_rid, 1);
> >
> > ==>         vwrq->value = le16_to_cpu(status_rid.currentXmitRate) * 500000;
> >             ...
> >     }
> >
> >     static int readStatusRid(struct airo_info *ai, StatusRid *statr, int lock)
> >     {
> >             return PC4500_readrid(ai, RID_STATUS, statr, sizeof(*statr), lock);
> >     }
> >
> >     static int PC4500_readrid(struct airo_info *ai, u16 rid, void *pBuf, int len, int lock)
> >     {
> >             u16 status;
> >             int rc = SUCCESS;
> >
> >             if (lock) {
> >                     if (down_interruptible(&ai->sem))
> >                             return ERROR;
> >
> > pBuf output buffer contents not initialized.
> >
> >             }
> >             ...
> >     }
> >
> >
> >> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6995e2de6891c724bfeb2db33d7b87775f913ad1/ (all 160 configs)
> >> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/45a3e24f65e90a047bef86f927ebdc4c710edaa1/ (all 160 configs)
>
> I appreciate the synopsis.  Here's a patch.  WDYT?
> ---
> From: Randy Dunlap <rdunlap@infradead.org>
> Subject: [PATCH] wifi: airo: avoid uninitialized warning in airo_get_rate()
>
> Quieten a gcc (11.3.0) build error or warning by checking the function
> call status and returning -EIO if the function call failed.
> This is similar to what several other wireless drivers do for the
> SIOCGIWRATE ioctl call.
>
> drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: lore.kernel.org/r/39abf2c7-24a-f167-91da-ed4c5435d1c4@linux-m68k.org
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> ---
>  drivers/net/wireless/cisco/airo.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff -- a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
> --- a/drivers/net/wireless/cisco/airo.c
> +++ b/drivers/net/wireless/cisco/airo.c
> @@ -6157,8 +6157,11 @@ static int airo_get_rate(struct net_devi
>         struct iw_param *vwrq = &wrqu->bitrate;
>         struct airo_info *local = dev->ml_priv;
>         StatusRid status_rid;           /* Card status info */
> +       int ret;
>
> -       readStatusRid(local, &status_rid, 1);
> +       ret = readStatusRid(local, &status_rid, 1);
> +       if (ret)
> +               return -EIO;

That's about the best we can do without further surgery.
E.g. PC4500_readrid() should return a proper error code instead of
just ERROR/SUCCESS.
The case gcc complains about is when lock = 1 and the call to
down_interruptible() fails, for which -EBUSY would be appropriate.

>
>         vwrq->value = le16_to_cpu(status_rid.currentXmitRate) * 500000;
>         /* If more than one rate, set auto */
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
