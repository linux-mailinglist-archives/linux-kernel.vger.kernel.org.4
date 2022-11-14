Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9686289A1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbiKNTqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiKNTqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:46:08 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D16A101F7;
        Mon, 14 Nov 2022 11:46:07 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 8so8154323qka.1;
        Mon, 14 Nov 2022 11:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XhAD4avTY7qXt3U7Wn89YfBYSuXqW8/ApdfhtU9dt5s=;
        b=Uledq2Qn3qtRvNeE49ieIznBrR6TrcpPncoE6PmbMamqDn9WPdOFWULGoqyfFs756s
         nU4BBlZNk6oue65zr/m8yX3TdMqwWhcb6amByaWWEe13ieT1gLL3UP1YkdK3j8/Fm/DT
         Zc7s9T/QzttiHU+VnenwSsNjkNnHNMiTyyEY18Xc9GXBEfaCuv1JBDFEzm5oXRT2d2OO
         UQxbQgIaPLpCtUY9kgi390/wnuj4ieCvMVF30mGIFW2t45RU30fLlcn+lzEt6Uthshkk
         V9zoTBm4VbhO4PWciJrm/fhGHNI3MgMHlVxdXIDGKuMhW8U9Z1ZWs9wE9IT138iwpZhA
         1gFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhAD4avTY7qXt3U7Wn89YfBYSuXqW8/ApdfhtU9dt5s=;
        b=rnV6M4oJ+RxMJvdKWklXNF3DL8pea+ToKU5GA18cTvskqItQbQuBeUvAA7+B+OADlm
         hFflq1LGoGYhwRZ+ASBRJEoXOSyrh8qlrhF7Aw7m+VbNMvaGCM2Fd/CfTCNjwYKgfS/G
         aMu7oYSsGbZwokOYi40spaLzbNOl04Lto0JUkjv5RQ2hfgynQjjXvWmYIz7WRNEnu1fl
         qZASRF87FbecjM7ZpGDOH2UMjPCen3A2WxIAoUtXIysk07FKp/GKy1bNEMW5ASdiJBfR
         o4du44yCZLIYo3qxVQT7Xx2WMeuL2TcegelUGRmCpkyzrK9gH8H/HC93gysuJmmvqaHy
         YroQ==
X-Gm-Message-State: ANoB5pnaxS1ESVE7+7o/tiiVlPTdPOFa+UQlrf/kNw06B/wlHixjuXRL
        bW2nPKtmldVJbF1u6rlFTbkO2Kak2Ul20TgjD4fkjkyzWNgkrA==
X-Google-Smtp-Source: AA0mqf4wkumcNjUWme9orqYF1suQuKrEGkBqdEWf4gFblgtjEfIjNpfSv5shwP4JTMpUWtXQhdSM1yhDzvoTQQiv16w=
X-Received: by 2002:a05:620a:1aa3:b0:6ef:1064:bee1 with SMTP id
 bl35-20020a05620a1aa300b006ef1064bee1mr12091065qkb.689.1668455166759; Mon, 14
 Nov 2022 11:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20221114180843.1125308-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB5922DDCE24ED6F6DD44B4B3F86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922DDCE24ED6F6DD44B4B3F86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 14 Nov 2022 19:45:38 +0000
Message-ID: <CA+V-a8tRKxpq4LiDDKd98MW27X7DnMEUw0FoL=8MLXK11tD-ng@mail.gmail.com>
Subject: Re: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM clocks
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

HI Biju,

Thank you for the review.

On Mon, Nov 14, 2022 at 6:42 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: 14 November 2022 18:09
> > To: Geert Uytterhoeven <geert+renesas@glider.be>; Wim Van Sebroeck
> > <wim@linux-watchdog.org>; Guenter Roeck <linux@roeck-us.net>; Philipp Zabel
> > <p.zabel@pengutronix.de>; linux-watchdog@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org; linux-renesas-soc@vger.kernel.org;
> > Prabhakar <prabhakar.csengg@gmail.com>; Biju Das
> > <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> > lad.rj@bp.renesas.com>
> > Subject: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM
> > clocks
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > On RZ/Five SoC it was observed that setting timeout (to say 1 sec) wouldn't
> > reset the system. To fix this we make sure we issue a reset before putting
> > the PM clocks to make sure the registers have been cleared.
> >
> > While at it re-used rzg2l_wdt_stop() in rzg2l_wdt_set_timeout() as we were
> > calling the same functions here.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Note,
> > - This patch has been tested on RZ/G2L, RZ/V2M and RZ/Five.
> > - My initial investigation showed adding the delay after
> > pm_runtime_get_sync()
> >   also fixed this issue.
> > - Do I need add the fixes tag ? what should be the operation PUT-
> > >RESET/RESET->PUT?
>
> It looks like timing issue, None of the previous devices are affected by this.
>
yep.

> >   in case we need the tag is:
> >   Fixes: 4055ee81009e6 ("watchdog: rzg2l_wdt: Add set_timeout callback")
> > ---
> >  drivers/watchdog/rzg2l_wdt.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> > index 00438ceed17a..d1271cc7750f 100644
> > --- a/drivers/watchdog/rzg2l_wdt.c
> > +++ b/drivers/watchdog/rzg2l_wdt.c
> > @@ -115,16 +115,14 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
> > {
> >       struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
> >
> > -     pm_runtime_put(wdev->parent);
> >       reset_control_reset(priv->rstc);
> > +     pm_runtime_put(wdev->parent);
> >
> >       return 0;
> >  }
> >
> >  static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int
> > timeout)  {
> > -     struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
> > -
> >       wdev->timeout = timeout;
> >
> >       /*
> > @@ -132,8 +130,7 @@ static int rzg2l_wdt_set_timeout(struct watchdog_device
> > *wdev, unsigned int time
> >        * register so that it is updated with new timeout values.
> >        */
>
>
> Maybe update the comment above with new code change.
>
    /*
     * If the watchdog is active, reset the module for updating the WDTSET
     * register so that it is updated with new timeout values.
     */

The above existing comment holds good with this code change. If you
prefer something else please let me know I'll update it accordingly.

Cheers,
Prabhakar
