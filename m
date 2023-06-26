Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E27973E163
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjFZOCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjFZOCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0851A10F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687788086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2y6qtyWy9IckWDMv65TOkYb/0eahHLsrQ1yR5Rwyltc=;
        b=FEITXewP9y9WAmKVe6f1GRv+41vtws4v9Mlew7S0p+H1dqgC5d2IZd9x+Mw1ms4TyoOWdm
        OMthUPM/cr2WihwnaxautL3glN4VCIrbRmGnM60W58MLUvIF2l2aNNeRE17xbGCC3yEOUh
        TEVR+WvwP0MM1BMfT2P2JYe9KFqsdsk=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-jNEWp8r7PqeFCdxduP701A-1; Mon, 26 Jun 2023 10:01:24 -0400
X-MC-Unique: jNEWp8r7PqeFCdxduP701A-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b756023e76so193701a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687788082; x=1690380082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2y6qtyWy9IckWDMv65TOkYb/0eahHLsrQ1yR5Rwyltc=;
        b=Vyt8nR4CzqYrYnQklQWWjqRNFtpLBiGDSmAMtLnmUCQhh7IpKcLddqqnyE22qyxxJB
         n9i/IOEdkQFwj1tsyS0uyficyCoiOyq612kWWdcPR7zsUVwQWu7uIM9NYLkNV09cqQLS
         4trcWSZWAylHICQVGNxLGtD1ITwDC7NQ97WX2nS3807/xDfIbjFZNaZ0teJo5g0tI4kP
         /zd0MJxYostCqs8nMkivxtUFxVOxI4DJoHvU+jA0wHTuuqIOoQDEcXDuTO7jUXZmgN49
         y1bV73rJx7dHU+3/oozWJTDEjfWu180E6nxWbiAiZgu7RSIs54xww3Z5d5Sp04s7r4Gy
         Rj5w==
X-Gm-Message-State: AC+VfDx2OJP2eNOeMVoZJw/tZDFTIWzeGb2FSodA55ggqTQPWvWChEr/
        uiyFDpFtPaXUNh8cw6pPcjAvSWmB7foNjuEJdk9fovAPiJSEAjByKPISKFAHsCpZquNhHCCm1Yd
        Zr3JAV82P0HsU4FkI0n+AX0qjLLcq/TZBj6n0eJHmQlap/7Mr
X-Received: by 2002:a05:6358:9faa:b0:132:d3b1:c34d with SMTP id fy42-20020a0563589faa00b00132d3b1c34dmr5814282rwb.17.1687788082224;
        Mon, 26 Jun 2023 07:01:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7E3dXMlEJO/KnS5Zst6laAFwkuPszf/RngrTBNuJRfbqBYRKYLcwxwIcEgXGYvlbnNmuXkUtBvJ3IyDyZ3dKI=
X-Received: by 2002:a05:6358:9faa:b0:132:d3b1:c34d with SMTP id
 fy42-20020a0563589faa00b00132d3b1c34dmr5814197rwb.17.1687788080340; Mon, 26
 Jun 2023 07:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230621-logitech-fixes-v1-1-32e70933c0b0@redhat.com> <df4cc4a907c6d617036aea6da6f06de6bba30ca1.camel@hadess.net>
In-Reply-To: <df4cc4a907c6d617036aea6da6f06de6bba30ca1.camel@hadess.net>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 26 Jun 2023 16:01:09 +0200
Message-ID: <CAO-hwJJCvVUKgxZVwnksd7t5By6vc4UBzAOARS1WcNkbs2XWTA@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: rework one more time the retries attempts
To:     Bastien Nocera <hadess@hadess.net>
Cc:     =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
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
> On Wed, 2023-06-21 at 11:42 +0200, Benjamin Tissoires wrote:
> > Make the code looks less like Pascal.
>
> Honestly, while this was written in jest in an email is fine, putting
> this in the commit message is quite insulting.
>
> The "retry" patch tried to fix real world problems by making minimal
> code changes, eg. avoiding the review problem that the present patch
> has, and even then, all of us missed the logic bug.
>
> I also haven't written any Pascal code since 1996.

Apologies for that. I honestly took Linus' remark to myself only,
because I was fixing your fix on my original code.
And while initially fixing your for loop, I should have realized that
this was very hard to follow, because of the "if (sth; sth < 1 && foo
&& bar; sth+=3D1)".

I'll amend v2

>
> > Extract the internal code inside a helper function, fix the
> > initialization of the parameters used in the helper function
> > (`hidpp->answer_available` was not reset and `*response` wasn't too),
>
> "wasn't either".
>
> > and use a `do {...} while();` loop.
> >
> > Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device
> > is busy")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> > as requested by
> > https://lore.kernel.org/all/CAHk-=3DwiMbF38KCNhPFiargenpSBoecSXTLQACKS2=
UMyo_Vu2ww@mail.gmail.com/
> > This is a rewrite of that particular piece of code.
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 102 +++++++++++++++++++++++------
> > ----------
> >  1 file changed, 61 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> > logitech-hidpp.c
> > index dfe8e09a18de..3d1ffe199f08 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -275,21 +275,20 @@ static int __hidpp_send_report(struct
> > hid_device *hdev,
> >  }
> >
> >  /*
> > - * hidpp_send_message_sync() returns 0 in case of success, and
> > something else
> > - * in case of a failure.
> > - * - If ' something else' is positive, that means that an error has
> > been raised
> > - *   by the protocol itself.
> > - * - If ' something else' is negative, that means that we had a
> > classic error
> > - *   (-ENOMEM, -EPIPE, etc...)
> > + * Effectively send the message to the device, waiting for its
> > answer.
> > + *
> > + * Must be called with hidpp->send_mutex locked
> > + *
> > + * Same return protocol than hidpp_send_message_sync():
> > + * - success on 0
> > + * - negative error means transport error
> > + * - positive value means protocol error
> >   */
> > -static int hidpp_send_message_sync(struct hidpp_device *hidpp,
> > +static int __do_hidpp_send_message_sync(struct hidpp_device *hidpp,
> >         struct hidpp_report *message,
> >         struct hidpp_report *response)
> >  {
> > -       int ret =3D -1;
> > -       int max_retries =3D 3;
> > -
> > -       mutex_lock(&hidpp->send_mutex);
> > +       int ret;
> >
> >         hidpp->send_receive_buf =3D response;
> >         hidpp->answer_available =3D false;
> > @@ -300,41 +299,62 @@ static int hidpp_send_message_sync(struct
> > hidpp_device *hidpp,
> >          */
> >         *response =3D *message;
> >
> > -       for (; max_retries !=3D 0 && ret; max_retries--) {
> > -               ret =3D __hidpp_send_report(hidpp->hid_dev, message);
> > +       ret =3D __hidpp_send_report(hidpp->hid_dev, message);
> > +       if (ret) {
> > +               dbg_hid("__hidpp_send_report returned err: %d\n",
> > ret);
> > +               memset(response, 0, sizeof(struct hidpp_report));
> > +               return ret;
> > +       }
> >
> > -               if (ret) {
> > -                       dbg_hid("__hidpp_send_report returned err:
> > %d\n", ret);
> > -                       memset(response, 0, sizeof(struct
> > hidpp_report));
> > -                       break;
> > -               }
> > +       if (!wait_event_timeout(hidpp->wait, hidpp->answer_available,
> > +                               5*HZ)) {
> > +               dbg_hid("%s:timeout waiting for response\n",
> > __func__);
> > +               memset(response, 0, sizeof(struct hidpp_report));
> > +               return -ETIMEDOUT;
> > +       }
> >
> > -               if (!wait_event_timeout(hidpp->wait, hidpp-
> > >answer_available,
> > -                                       5*HZ)) {
> > -                       dbg_hid("%s:timeout waiting for response\n",
> > __func__);
> > -                       memset(response, 0, sizeof(struct
> > hidpp_report));
> > -                       ret =3D -ETIMEDOUT;
> > -                       break;
> > -               }
> > +       if (response->report_id =3D=3D REPORT_ID_HIDPP_SHORT &&
> > +           response->rap.sub_id =3D=3D HIDPP_ERROR) {
> > +               ret =3D response->rap.params[1];
> > +               dbg_hid("%s:got hidpp error %02X\n", __func__, ret);
> > +               return ret;
> > +       }
> >
> > -               if (response->report_id =3D=3D REPORT_ID_HIDPP_SHORT &&
> > -                   response->rap.sub_id =3D=3D HIDPP_ERROR) {
> > -                       ret =3D response->rap.params[1];
> > -                       dbg_hid("%s:got hidpp error %02X\n",
> > __func__, ret);
> > +       if ((response->report_id =3D=3D REPORT_ID_HIDPP_LONG ||
> > +            response->report_id =3D=3D REPORT_ID_HIDPP_VERY_LONG) &&
> > +           response->fap.feature_index =3D=3D HIDPP20_ERROR) {
> > +               ret =3D response->fap.params[1];
> > +               dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__,
> > ret);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * hidpp_send_message_sync() returns 0 in case of success, and
> > something else
> > + * in case of a failure.
> > + * - If ' something else' is positive, that means that an error has
> > been raised
> > + *   by the protocol itself.
> > + * - If ' something else' is negative, that means that we had a
> > classic error
> > + *   (-ENOMEM, -EPIPE, etc...)
>
> Do we really need to re-explain the possible return values that were
> already explained above __do_hidpp_send_message_sync()?

Right, maybe we don't need to duplicate the comment after all.

>
> If we do, why don't also do it for hidpp_send_fap_command_sync() and
> hidpp_send_rap_command_sync(), or their callers?

In a way it would make sense to do, because this is non standard.

>
> If it's absolutely necessary, a "see __do_hidpp_send_message_sync()"
> should be enough.

Good point.

>
> I've double-checked that none of the existing callers expected a
> partially filled in "response" struct on error.
>
> Reviewed-by: Bastien Nocera <hadess@hadess.net>

Thanks!

Cheers,
Benjamin

>
> > + */
> > +static int hidpp_send_message_sync(struct hidpp_device *hidpp,
> > +       struct hidpp_report *message,
> > +       struct hidpp_report *response)
> > +{
> > +       int ret;
> > +       int max_retries =3D 3;
> > +
> > +       mutex_lock(&hidpp->send_mutex);
> > +
> > +       do {
> > +               ret =3D __do_hidpp_send_message_sync(hidpp, message,
> > response);
> > +               if (ret !=3D HIDPP20_ERROR_BUSY)
> >                         break;
> > -               }
> >
> > -               if ((response->report_id =3D=3D REPORT_ID_HIDPP_LONG ||
> > -                    response->report_id =3D=3D
> > REPORT_ID_HIDPP_VERY_LONG) &&
> > -                   response->fap.feature_index =3D=3D HIDPP20_ERROR) {
> > -                       ret =3D response->fap.params[1];
> > -                       if (ret !=3D HIDPP20_ERROR_BUSY) {
> > -                               dbg_hid("%s:got hidpp 2.0 error
> > %02X\n", __func__, ret);
> > -                               break;
> > -                       }
> > -                       dbg_hid("%s:got busy hidpp 2.0 error %02X,
> > retrying\n", __func__, ret);
> > -               }
> > -       }
> > +               dbg_hid("%s:got busy hidpp 2.0 error %02X,
> > retrying\n", __func__, ret);
> > +       } while (--max_retries);
> >
> >         mutex_unlock(&hidpp->send_mutex);
> >         return ret;
> >
> > ---
> > base-commit: b98ec211af5508457e2b1c4cc99373630a83fa81
> > change-id: 20230621-logitech-fixes-a4c0e66ea2ad
> >
> > Best regards,
>

