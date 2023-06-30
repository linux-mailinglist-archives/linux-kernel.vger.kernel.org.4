Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017C57444DE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjF3Wb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjF3WbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:31:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C9C4239
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:31:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9922d6f003cso287756366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688164268; x=1690756268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpUt64TUG9f/DRzzzxuqwiJUEfTRlaFEKr7xn8qUIWY=;
        b=O0efaCThDHNVytH88XvP6eK7uY/nnz7dm+BTWxdSpgQGtVbt5Pxz5SbhzAZPwV5pqY
         zVvp6Fc+tJjYOE+PxnMmniQVRsPZ6g1g+hLPQTHOlT5ujwHZ7DZLf7LgM61hFJByAWea
         FQmB/VOimdjYChbV7HW41R9vznM4q+8d1TiqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688164268; x=1690756268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpUt64TUG9f/DRzzzxuqwiJUEfTRlaFEKr7xn8qUIWY=;
        b=P2Ub9tpuWVKQTvVDhTm0nsvoZDi7p5+oTsDNNUR/uophU4FNlTbN0t20wMY8deSyUT
         yt46a677KEzB8S/DBBrdJGQuiEfeAHNWiA2/y93nXxaGtBy8WQlASsilqSDHTc7JhTV2
         C8H4I7zxbL8yqvHu7UoYKl3UtQF0dl6XZP3hJmgr+FS9ONdBkE6PfZjgjOAaaoaM+GGw
         E7z9I7OZvAIzVVmjMGkG39yHyGhOhFP2P2N8IwZxuexOHJG07yEsnkAQZ0v/ym39QXK0
         6ym8kERWPb9nHSz6i+pPjKZMN10cwRHEkG5V2FS8UoQUa+dk9SJUYLqvydOSC3xnUOn/
         Kz7w==
X-Gm-Message-State: ABy/qLZQkjCK3TcL/G6PLokl03eLTc9c4BkahiP8lnV5QquWCiDvid0d
        ME7GGoDsFGwB0MrC/DX03nJyfiL22WyCBH6MD/aB3Q==
X-Google-Smtp-Source: APBJJlFDqAgaimDsodW/MBkQBNBSpk8V7OSoGkxjY6nqBBULBLtxD69OYIvvS2QkvAqvpZr3m/6DyA==
X-Received: by 2002:a17:906:b352:b0:974:7713:293f with SMTP id cd18-20020a170906b35200b009747713293fmr2779883ejb.41.1688164268762;
        Fri, 30 Jun 2023 15:31:08 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b009893650453fsm8638606ejb.173.2023.06.30.15.31.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 15:31:07 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51db8a4dc60so1170a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:31:07 -0700 (PDT)
X-Received: by 2002:a50:c242:0:b0:506:90c4:b63b with SMTP id
 t2-20020a50c242000000b0050690c4b63bmr22867edf.4.1688164267585; Fri, 30 Jun
 2023 15:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230630143125.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
 <CABBYNZLtxMGQLFwZTztPo2epV2E9Z4uthFMeozxABW2KXQR1nQ@mail.gmail.com> <CAD=FV=XvSCzi1hjgcWa_AecsdG7wbe9o29n2M1cWLezqZk6Dig@mail.gmail.com>
In-Reply-To: <CAD=FV=XvSCzi1hjgcWa_AecsdG7wbe9o29n2M1cWLezqZk6Dig@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Jun 2023 15:30:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VoCaDSS17pRJredtMYPTXiK8uoLOH5hEXaCdqCb9SONA@mail.gmail.com>
Message-ID: <CAD=FV=VoCaDSS17pRJredtMYPTXiK8uoLOH5hEXaCdqCb9SONA@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 30, 2023 at 3:11=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> > > @@ -1980,9 +1981,10 @@ static int hci_remove_adv_monitor(struct hci_d=
ev *hdev,
> > >                 goto free_monitor;
> > >
> > >         case HCI_ADV_MONITOR_EXT_MSFT:
> > > +               handle =3D monitor->handle;
> > >                 status =3D msft_remove_monitor(hdev, monitor);
> > >                 bt_dev_dbg(hdev, "%s remove monitor %d msft status %d=
",
> > > -                          hdev->name, monitor->handle, status);
> > > +                          hdev->name, handle, status);
> >
> > Just move the call to bt_dev_dbg under msft_remove_monitor,
>
> Sure. I wasn't sure how much the order of the printout matters, but if
> it doesn't then just putting the print first makes sense. Done in v2.

So I assumed that this meant you just wanted me to switch the order,
which I did for v2. ...but then Manish pointed out that meant I wasn't
printing the right status.

Looking again, maybe you meant that I should move the debug statement
into the msft_remove_monitor(). I'm not convinced that's any cleaner.
That would mean adding an "exit" label to that function just for the
printout. It also makes the printout asymmetric with other similar
printouts.

I'm going back to v1 here. If I've misunderstood then I guess I can
always spin again. :-/

-Doug
