Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4A173E180
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjFZODx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjFZODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BC810C6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687788181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfxuETl8s7aF9KHlaxBs8EdhOATKraN8iziLKe+xGhA=;
        b=dugUa6bIM4ppc3XYv5Xh9/Sw8q4sBFbQxk7x8cc1dDy9fCOLpmKGkEszmoobi94rB7og7t
        pY5SaDPlLysZQww3v0Nn4fpAvcl8pzOlbZNnPNgCLziBQhNgX4XkF3IO2M2RQY77tyJ5bE
        QBhFILA2bcNMdNpDJjzixiGh6cE4ekM=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-y0jvYh1fNfi5733yegZRrw-1; Mon, 26 Jun 2023 10:02:59 -0400
X-MC-Unique: y0jvYh1fNfi5733yegZRrw-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-bc77a2d3841so4372866276.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687788179; x=1690380179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfxuETl8s7aF9KHlaxBs8EdhOATKraN8iziLKe+xGhA=;
        b=NFRRSnhKAp5ur75DbzjJt9h0veqTVlMei4g74BkcOMZbjImW2vKUMfO4cEcXj8mJne
         3iDYf9dGTeRUeyZR66XQr3KURf34ij9Wcy41Nw4hpabwa+ihrwhwpyb1Agg3T8LokIj1
         fU3GXqFygXdmg6gzIQGPUaqswr2eGHxJVytDm9NuxWIpNRJ11nnpETkXMQdlJCDiomjB
         OkKdCsh5/2+3K3IAFbY6EsmRjcvIKSzX8aQh1Fc72/t0spwW/5rJ8m/YwzoUbYpYydui
         tqJj72ytBFCN5NaaSrKBCKtJFWa9+QBgnvrotsn3IAGHUpjKduBqeCiQlCpHcDZ0aN7Y
         yodA==
X-Gm-Message-State: AC+VfDwPiaBrNpwnMGMaMI1UHecJrP/HuhgTMCRp7oOlg2tVG31ela/0
        LChiZ1H1y1Mr4wcCoDB2SRpZqCQXSKL0AwDjDnQOIeMcx/NQJJ5LGE1JjiRC2q/7YtUciPLpqIy
        rZAiOohkYZr8UH9QFfHG4Iqdkg4bDjQR2vDsvUHz5
X-Received: by 2002:a25:48d:0:b0:c1e:a1b8:1666 with SMTP id 135-20020a25048d000000b00c1ea1b81666mr3656747ybe.51.1687788179008;
        Mon, 26 Jun 2023 07:02:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7+FNlkeJz4AqSCvPHDn9Iekkq6Y/XO+Y72PlRsNWWiLXYE7W+BlBxx7EZwRXASz1U89m32/vnrSe29njQDVZA=
X-Received: by 2002:a25:48d:0:b0:c1e:a1b8:1666 with SMTP id
 135-20020a25048d000000b00c1ea1b81666mr3656724ybe.51.1687788178684; Mon, 26
 Jun 2023 07:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230621-logitech-fixes-v1-1-32e70933c0b0@redhat.com>
 <2023062156-trespass-pandemic-7f4f@gregkh> <qbvmv3eexohswyagmllfh3xsxoftwa3wbmsdafmwak2bxlnlft@jz74dijlfxlz>
 <31ce32e018a9fa410e9e1f3e5900621b16a56091.camel@hadess.net>
In-Reply-To: <31ce32e018a9fa410e9e1f3e5900621b16a56091.camel@hadess.net>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 26 Jun 2023 16:02:46 +0200
Message-ID: <CAO-hwJLFSUJaGK5DAOz30+YyC1hGgHnbeJbc5iQ47jxBcbRSCg@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: rework one more time the retries attempts
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 10:30=E2=80=AFAM Bastien Nocera <hadess@hadess.net>=
 wrote:
>
> On Fri, 2023-06-23 at 10:37 +0200, Benjamin Tissoires wrote:
> >
> > On Jun 21 2023, Greg KH wrote:
> > >
> > > On Wed, Jun 21, 2023 at 11:42:30AM +0200, Benjamin Tissoires wrote:
> > > > Make the code looks less like Pascal.
> > > >
> > > > Extract the internal code inside a helper function, fix the
> > > > initialization of the parameters used in the helper function
> > > > (`hidpp->answer_available` was not reset and `*response` wasn't
> > > > too),
> > > > and use a `do {...} while();` loop.
> > > >
> > > > Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when
> > > > device is busy")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > > ---
> > > > as requested by
> > > > https://lore.kernel.org/all/CAHk-=3DwiMbF38KCNhPFiargenpSBoecSXTLQA=
CKS2UMyo_Vu2ww@mail.gmail.com/
> > > > This is a rewrite of that particular piece of code.
> > > > ---
> > > >  drivers/hid/hid-logitech-hidpp.c | 102 +++++++++++++++++++++++--
> > > > --------------
> > > >  1 file changed, 61 insertions(+), 41 deletions(-)
> > > >
> > > > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> > > > logitech-hidpp.c
> > > > index dfe8e09a18de..3d1ffe199f08 100644
> > > > --- a/drivers/hid/hid-logitech-hidpp.c
> > > > +++ b/drivers/hid/hid-logitech-hidpp.c
> > > > @@ -275,21 +275,20 @@ static int __hidpp_send_report(struct
> > > > hid_device *hdev,
> > > >  }
> > > >
> > > >  /*
> > > > - * hidpp_send_message_sync() returns 0 in case of success, and
> > > > something else
> > > > - * in case of a failure.
> > > > - * - If ' something else' is positive, that means that an error
> > > > has been raised
> > > > - *   by the protocol itself.
> > > > - * - If ' something else' is negative, that means that we had a
> > > > classic error
> > > > - *   (-ENOMEM, -EPIPE, etc...)
> > > > + * Effectively send the message to the device, waiting for its
> > > > answer.
> > > > + *
> > > > + * Must be called with hidpp->send_mutex locked
> > > > + *
> > > > + * Same return protocol than hidpp_send_message_sync():
> > > > + * - success on 0
> > > > + * - negative error means transport error
> > > > + * - positive value means protocol error
> > > >   */
> > > > -static int hidpp_send_message_sync(struct hidpp_device *hidpp,
> > > > +static int __do_hidpp_send_message_sync(struct hidpp_device
> > > > *hidpp,
> > > >         struct hidpp_report *message,
> > > >         struct hidpp_report *response)
> > >
> > > __must_hold(&hidpp->send_mutex)  ?
> > >
> >
> > Good point. I'll add this in v2.
> >
> > I'm still waiting for some feedback from the people who particpated
> > in
> > the original BZ, but the new bug is harder to reproduce. Anyway,
> > there
> > is no rush IMO.
>
> The problem is only ever going to show up in very limited circumstances
> after the logic fix was applied.
>
> You need a hardware problem (such as the controller being too busy to
> answer) to trigger the problems fixed by this patch. I don't see a way
> to reliably reproduce it unless you inject that hardware error.
>

Some people on the Bz were able to reproduce with multiple reboots.
But it's not as urgent as previously, and we were close to the 6.4
final when I sent it. I'll make sure this goes into 6.5 and gets
proper stable backports FWIW.

Cheers,
Benjamin

