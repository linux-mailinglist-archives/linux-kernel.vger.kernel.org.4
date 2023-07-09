Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6BC74C44F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGINXu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Jul 2023 09:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGINXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:23:49 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA39CEB;
        Sun,  9 Jul 2023 06:23:47 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-57688a146ecso45035617b3.2;
        Sun, 09 Jul 2023 06:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688909026; x=1691501026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6Evx3NovBpuOuju5abIqsSv5LMrdA5O+fT2IkTpWiU=;
        b=fyS4HPMy/oZ0XR9rwOegZC2nVfXt/jso706id9imV2m/nt3rGkqEG9HYR6p8/i+45s
         y/YRfXr6Ai6GGBaPixcBnDSWB0siqaq0l7IgjKkwGwG5xNuO3y+a3/JeXGNJXxNif/qN
         9QLb+JxEnF0HWDs7MF+4oxP64wC3fKda/N3Z8mP+JUwLdNoYiarP4Ch859UyH2TPbaXE
         FY5tsfr0ohz+bWse955S72SK8w5SSgYzVWWVhFYHqYP1m06Ah4txyn/OemcdV9WoazXH
         rNbOnt80Qi+kT97XkyBmyxMqRTWSbe+nXq1PC0brzi1tZrczhtrOn0pe69NksAb7pC9T
         WguQ==
X-Gm-Message-State: ABy/qLZEJ5OuadPfRjrPGJe+zmDYgPyJzRImO7U28sI63L2b3vb1K7ol
        kV70J8IlINgJ91ZZLQh35CWkym8FBN8IFw==
X-Google-Smtp-Source: APBJJlG653Ncmpdgqo7+pDZfO01xfawzCHn8YXkTKM74FUrEUmdAuFZZUdULBHeFtVHeFMQJb5jVYA==
X-Received: by 2002:a0d:d910:0:b0:56d:308f:1efa with SMTP id b16-20020a0dd910000000b0056d308f1efamr8910681ywe.4.1688909026086;
        Sun, 09 Jul 2023 06:23:46 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id d62-20020a0df441000000b00577409a2958sm2459094ywf.138.2023.07.09.06.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 06:23:45 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-579dfae6855so45281537b3.1;
        Sun, 09 Jul 2023 06:23:45 -0700 (PDT)
X-Received: by 2002:a0d:e403:0:b0:573:2ea0:da73 with SMTP id
 n3-20020a0de403000000b005732ea0da73mr10389742ywe.28.1688909025661; Sun, 09
 Jul 2023 06:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi7fwNWfqj-QQqEfZTUOB4bbKT8QiEUDHoPk0ecuYA7cA@mail.gmail.com>
 <20230626081950.2090627-1-geert@linux-m68k.org> <39abf2c7-24a-f167-91da-ed4c5435d1c4@linux-m68k.org>
 <2f6ffd1c-a756-b7b8-bba4-77c2308f26b9@infradead.org> <CAMuHMdU30BzfzQ=xEDFCd2bXG=VD68sQz-60Ok8GethLsnEH8A@mail.gmail.com>
 <5037d22d-cc63-d8af-70a9-3c793f07fce2@infradead.org>
In-Reply-To: <5037d22d-cc63-d8af-70a9-3c793f07fce2@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 9 Jul 2023 15:23:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX4xVkdViy1Eq7N43uD_iWp3yS6qkiCbp9+frLHsTA_fg@mail.gmail.com>
Message-ID: <CAMuHMdX4xVkdViy1Eq7N43uD_iWp3yS6qkiCbp9+frLHsTA_fg@mail.gmail.com>
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

On Sun, Jul 9, 2023 at 3:12 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 7/9/23 01:27, Geert Uytterhoeven wrote:
> > On Sun, Jul 9, 2023 at 4:46 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >> On 6/26/23 01:24, Geert Uytterhoeven wrote:
> >>> On Mon, 26 Jun 2023, Geert Uytterhoeven wrote:
> >>>> JFYI, when comparing v6.4[1] to v6.4-rc7[3], the summaries are:
> >>>>  - build errors: +1/-0
> >>>
> >>>   + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]:  => 6163:45
> >>
> >> I cannot reproduce this build error. (I don't doubt the problem, just having a problem
> >> making it happen for me.)
> >> I have tried it with gcc-11.1.0, gcc-11.3.0, and gcc-13.1.0.
> >
> > Which is similar to kisskb, using sh4-linux-gcc (GCC) 11.3.0...
> >
> >> I'm surprised that this is the only instance that gcc found/warned about.
> >
> > Indeed.
> >
> >>
> >> I have a patch for this one instance, but there are 40+ instances of
> >>         readStatusRid()
> >>         readConfigRid()
> >>         readSsidRid()
> >>         readStatsRid()
> >>         readCapabilityRid()
> >> that don't check the return status of the function calls.
> >>
> >> I suppose that a patch can quieten the compiler error/warning, but given
> >> the 40+ other problems, it won't make the driver any noticeably better IMO.
> >
> > Indeed...
> >
> >>> sh4-gcc11/sh-allmodconfig
> >>> seen before
> >>>
> >>> This is actually a real issue, and it's been here since basically forever.
> >>>
> >>> drivers/net/wireless/cisco/airo.c:
> >>>
> >>>     static int airo_get_rate(struct net_device *dev,
> >>>                              struct iw_request_info *info,
> >>>                              union iwreq_data *wrqu,
> >>>                              char *extra)
> >>>     {
> >>>             struct iw_param *vwrq = &wrqu->bitrate;
> >>>             struct airo_info *local = dev->ml_priv;
> >>>             StatusRid status_rid;           /* Card status info */
> >>>
> >>>             readStatusRid(local, &status_rid, 1);
> >>>
> >>> ==>         vwrq->value = le16_to_cpu(status_rid.currentXmitRate) * 500000;
> >>>             ...
> >>>     }
> >>>
> >>>     static int readStatusRid(struct airo_info *ai, StatusRid *statr, int lock)
> >>>     {
> >>>             return PC4500_readrid(ai, RID_STATUS, statr, sizeof(*statr), lock);
> >>>     }
> >>>
> >>>     static int PC4500_readrid(struct airo_info *ai, u16 rid, void *pBuf, int len, int lock)
> >>>     {
> >>>             u16 status;
> >>>             int rc = SUCCESS;
> >>>
> >>>             if (lock) {
> >>>                     if (down_interruptible(&ai->sem))
> >>>                             return ERROR;
> >>>
> >>> pBuf output buffer contents not initialized.
> >>>
> >>>             }
> >>>             ...
> >>>     }
> >>>
> >>>
> >>>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6995e2de6891c724bfeb2db33d7b87775f913ad1/ (all 160 configs)
> >>>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/45a3e24f65e90a047bef86f927ebdc4c710edaa1/ (all 160 configs)
> >>
> >> I appreciate the synopsis.  Here's a patch.  WDYT?
> >> ---
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >> Subject: [PATCH] wifi: airo: avoid uninitialized warning in airo_get_rate()
> >>
> >> Quieten a gcc (11.3.0) build error or warning by checking the function
> >> call status and returning -EIO if the function call failed.
> >> This is similar to what several other wireless drivers do for the
> >> SIOCGIWRATE ioctl call.
> >>
> >> drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]
> >>
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Link: lore.kernel.org/r/39abf2c7-24a-f167-91da-ed4c5435d1c4@linux-m68k.org
> >> Cc: Kalle Valo <kvalo@kernel.org>
> >> Cc: linux-wireless@vger.kernel.org
> >> ---
> >>  drivers/net/wireless/cisco/airo.c |    5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff -- a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
> >> --- a/drivers/net/wireless/cisco/airo.c
> >> +++ b/drivers/net/wireless/cisco/airo.c
> >> @@ -6157,8 +6157,11 @@ static int airo_get_rate(struct net_devi
> >>         struct iw_param *vwrq = &wrqu->bitrate;
> >>         struct airo_info *local = dev->ml_priv;
> >>         StatusRid status_rid;           /* Card status info */
> >> +       int ret;
> >>
> >> -       readStatusRid(local, &status_rid, 1);
> >> +       ret = readStatusRid(local, &status_rid, 1);
> >> +       if (ret)
> >> +               return -EIO;
> >
> > That's about the best we can do without further surgery.
> > E.g. PC4500_readrid() should return a proper error code instead of
> > just ERROR/SUCCESS.
> > The case gcc complains about is when lock = 1 and the call to
> > down_interruptible() fails, for which -EBUSY would be appropriate.
>
> Yes, I saw that return value as one of the options.
> I'll change it to that and submit it.

Unfortunately that is not the only possible failure mode.
But it is the one where gcc can _prove_ the output buffer is not initialized ;-)

OMG, PC4500_readrid() can also read from the passed buffer...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
