Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B8F74448E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjF3WL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjF3WL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:11:56 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA563C24
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:11:55 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b69a48368fso37892651fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688163111; x=1690755111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is887M0LY3foTKHy3QXuE4U0rfFRSbnNfTDJd8nB704=;
        b=BYqQLQjGrLsKQOwv3KAJ37MJ2f3adtFs03MAjLvRr06QMVaBjmxnt1uw71WICoXTop
         SdegnhkChD+CXntjx460Oy+bLM0LmpihJBTdrGU9cRuAgP15DXyJTRGorFtmnC4jn+R7
         iRdQkeESDa83pKEDVHgTsww14XbWg9FnO4sMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688163111; x=1690755111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Is887M0LY3foTKHy3QXuE4U0rfFRSbnNfTDJd8nB704=;
        b=RQZxJr+6m2l0iDf4JK60vBTcyLJi6+v3zk0AbPBf0bbFIrpDD4Q9pOHOcF8UJ1udiK
         ThinE4bCpQ25YoNs8zoSkdQtEg6H+1CE11yBG66StoY0SSNAq+G0giKuwvZPLe6aVbSq
         QADdm/9dQDt8E/eU3uIiTq1YGVcXgLpytsKC3CNJfDr64oCIe0FHDu06vghe3lRydUkW
         UnaSaZFAWY17ABDhlPJrz58BvG/nDIAku9PUTLe4axVC2tyx6wEhx6UkJLb7LyjQEaEk
         8+dK7eBzjLjuPxtW2d8HHX1HmM2S6JlythhxBbPtlgfewwu77HuzlRWmYiStzetPj3yO
         juZA==
X-Gm-Message-State: ABy/qLalOJL2PRNCAbPUC9L9sTdhPlcxszPrQAAUoKZhmNY4FuRV5vrR
        /PqseyqudGMxayH4zblMwU6AQ6q6pzdh2yrdKm/Z5A==
X-Google-Smtp-Source: APBJJlF07jkw8CncLWfmKdqY78ySYAfD1vvkU1wTrGPY5odd+2TfRLqs0t7wffkro/Fsg9sAEq/CqA==
X-Received: by 2002:a2e:95d9:0:b0:2b5:8153:deb3 with SMTP id y25-20020a2e95d9000000b002b58153deb3mr3228882ljh.4.1688163111134;
        Fri, 30 Jun 2023 15:11:51 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id n14-20020a170906118e00b0098ce63e36e9sm8638008eja.16.2023.06.30.15.11.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 15:11:50 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so1078a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:11:50 -0700 (PDT)
X-Received: by 2002:a50:d544:0:b0:50b:c48c:8a25 with SMTP id
 f4-20020a50d544000000b0050bc48c8a25mr28955edj.6.1688163109691; Fri, 30 Jun
 2023 15:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230630143125.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
 <CABBYNZLtxMGQLFwZTztPo2epV2E9Z4uthFMeozxABW2KXQR1nQ@mail.gmail.com>
In-Reply-To: <CABBYNZLtxMGQLFwZTztPo2epV2E9Z4uthFMeozxABW2KXQR1nQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Jun 2023 15:11:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XvSCzi1hjgcWa_AecsdG7wbe9o29n2M1cWLezqZk6Dig@mail.gmail.com>
Message-ID: <CAD=FV=XvSCzi1hjgcWa_AecsdG7wbe9o29n2M1cWLezqZk6Dig@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 30, 2023 at 2:55=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Douglas,
>
> On Fri, Jun 30, 2023 at 2:40=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > KASAN reports that there's a use-after-free in
> > hci_remove_adv_monitor(). Trawling through the disassembly, you can
> > see that the complaint is from the access in bt_dev_dbg() under the
> > HCI_ADV_MONITOR_EXT_MSFT case. The problem case happens because
> > msft_remove_monitor() can end up freeing the monitor
> > structure. Specifically:
> >   hci_remove_adv_monitor() ->
> >   msft_remove_monitor() ->
> >   msft_remove_monitor_sync() ->
> >   msft_le_cancel_monitor_advertisement_cb() ->
> >   hci_free_adv_monitor()
> >
> > Let's fix the problem by just stashing the relevant data when it's
> > still valid.
> >
> > Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor"=
)
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  net/bluetooth/hci_core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 48917c68358d..dbb2043a9112 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -1972,6 +1972,7 @@ static int hci_remove_adv_monitor(struct hci_dev =
*hdev,
> >                                   struct adv_monitor *monitor)
> >  {
> >         int status =3D 0;
> > +       int handle;
> >
> >         switch (hci_get_adv_monitor_offload_ext(hdev)) {
> >         case HCI_ADV_MONITOR_EXT_NONE: /* also goes here when powered o=
ff */
> > @@ -1980,9 +1981,10 @@ static int hci_remove_adv_monitor(struct hci_dev=
 *hdev,
> >                 goto free_monitor;
> >
> >         case HCI_ADV_MONITOR_EXT_MSFT:
> > +               handle =3D monitor->handle;
> >                 status =3D msft_remove_monitor(hdev, monitor);
> >                 bt_dev_dbg(hdev, "%s remove monitor %d msft status %d",
> > -                          hdev->name, monitor->handle, status);
> > +                          hdev->name, handle, status);
>
> Just move the call to bt_dev_dbg under msft_remove_monitor,

Sure. I wasn't sure how much the order of the printout matters, but if
it doesn't then just putting the print first makes sense. Done in v2.

> also there
> is no reason to print hdev->name since bt_dev_dbg already does that so
> while at it we can probably fix this as well.

I made that a separate patch just to keep it cleaner. I also fixed the
"add" function which has the same issue.

-Doug
