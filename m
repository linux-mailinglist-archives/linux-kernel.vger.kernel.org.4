Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B7F69934A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjBPLiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPLiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:38:08 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDCB42DC5;
        Thu, 16 Feb 2023 03:38:02 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id r28so1377920oiw.3;
        Thu, 16 Feb 2023 03:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0w4s3k53CjHQZ1FbdH4kvMLl4+i7Mxyq78q748S60EA=;
        b=V0D4fCeLWsL5hEYqG7tzRdiJXCVCVJUZSk9z+JZzl5u1c2kLXOwD/PJofFa1kZ/lXQ
         Fy7seDYyb5lQpGXuio68exb0RsUhR730c7D0dEIAT/QAaa0lwMfaz2Yij5RJQiPlDfqP
         P+ZTWUDErGPlc+0AZnXvSef4c4EdRtzN4PqB4rzQ0PT1fuhx7sNAyfHJ75E6drb6qY9z
         EnIALXYefj4ceJWOUVIScFhah9yg0lul4TbV030TM088BLb63xaoKMS2tiUC1d+CfOBk
         QVUD1cZWsCMIgN3oba3PnKQfdiWq6qV99sWl4fRYAZ6HWGd4PppzJTSKbsg3wGIXfVB+
         mOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0w4s3k53CjHQZ1FbdH4kvMLl4+i7Mxyq78q748S60EA=;
        b=3yXuIqN4arxpeVHcgHJEiqibfuqCSSSCYipvhP4rDPmCqD/YgCPRvpwZzOvDrHMR92
         aIFTJRi5W80GldAFdWQ8/vflRdYDLtN2qLJD6bmcHmZWP+tUuCq8uuK/MCwQYVCzvXgp
         zExQsDvGuTjTnyQLpxNM+LbD0HdBI+XRcKMibEYHiIa8icrbrOywQHx2UzPDjhYfQ+kh
         FfTrKkBkmkffUWGwcK/Nwd7SZJVSSPRdNe6kiIegtMjhRJvBqcYriMwDU0DnT2nEA6Z4
         51qwa8xPL7gn/GtqekzpE/UZLiG/1pTCsxfufdbMqik/4ZXM03qknr5i4vMwdaUo+bxK
         gnZA==
X-Gm-Message-State: AO0yUKWWFaiLRNGOxENpIlpus1Qbwl5kv6+TOyQvf+5btEu27XKTPSse
        Ym/srTWW4FEr2+akwlPhCazQ51e8HhfOc+L99z4=
X-Google-Smtp-Source: AK7set8rEt2ssiauClaagKoUR/idAJ5vK4PQwX5XfrM+5xM5bFbAGucBdEKnLaE5yj/UwNr3ib1BLdtlgDWy28yegBI=
X-Received: by 2002:a05:6808:1a02:b0:37a:c636:6af3 with SMTP id
 bk2-20020a0568081a0200b0037ac6366af3mr188630oib.77.1676547481897; Thu, 16 Feb
 2023 03:38:01 -0800 (PST)
MIME-Version: 1.0
References: <3f8627d20de711d08b8cafe0a11481a2b9ca941e.1676537236.git.fengqi@xiaomi.com>
 <Y+4C6srdFygrWsLr@kroah.com>
In-Reply-To: <Y+4C6srdFygrWsLr@kroah.com>
From:   qi feng <fengqi706@gmail.com>
Date:   Thu, 16 Feb 2023 19:37:51 +0800
Message-ID: <CACOZ=ZUFZ7YvB+uRWthECf-xKpZkbG4XE7Lhh5gWsLFN9TY+AA@mail.gmail.com>
Subject: Re: [PATCH v4] HID: add KEY_CAMERA_FOCUS event in HID
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengqi <fengqi@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there something wrong with this, I can correct it

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B42=E6=9C=8816=E6=
=97=A5=E5=91=A8=E5=9B=9B 18:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Feb 16, 2023 at 04:48:30PM +0800, Qi Feng wrote:
> > From: fengqi <fengqi@xiaomi.com>
> >
> > Our HID device need KEY_CAMERA_FOCUS event to control camera,
> > but this event is non-existent in current HID driver.
> > So we add this event in hid-input.c.
> >
> > Signed-off-by: fengqi <fengqi@xiaomi.com>
> >
> > ---
> > changes in v4:
> >
> > -add HID_UP_CAMERA in HID usage tables , Then add the mapping under HID=
_UP_CAMERA
> > -modify the commit log of patch
> > -Link to v3:https://lore.kernel.org/linux-input/9a85b268c7636ef2e4e3bbb=
e318561ba2842a591.1676536357.git.fengqi@xiaomi.com/T/#u
> > -Link to v2:https://lore.kernel.org/linux-input/CACOZ=3DZU0zgRmoRu8X5bM=
UzUrXA9x-qoDJqrQroUs=3D+qKR58MQA@mail.gmail.com/T/#t
> > -Link to v1:https://lore.kernel.org/linux-input/CACOZ=3DZWB3grJKn7wAZEZ=
0BDyN7KJF4VWUTNs-mPxeoW_oiR7=3Dg@mail.gmail.com/T/#t
> > ---
> >  drivers/hid/hid-input.c | 10 ++++++++++
> >  include/linux/hid.h     |  1 +
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > index 77c8c49852b5..c6098ae2fac7 100644
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -1225,6 +1225,16 @@ static void hidinput_configure_usage(struct hid_=
input *hidinput, struct hid_fiel
> >                       return;
> >               }
> >               goto unknown;
> > +     case HID_UP_CAMERA:
> > +             switch (usage->hid & HID_USAGE) {
> > +             case 0x020:
> > +                     map_key_clear(KEY_CAMERA_FOCUS);        break;
> > +             case 0x021:
> > +                     map_key_clear(KEY_CAMERA);              break;
> > +             default:
> > +                     goto ignore;
> > +             }
> > +             break;
> >
> >       case HID_UP_HPVENDOR:   /* Reported on a Dutch layout HP5308 */
> >               set_bit(EV_REP, input->evbit);
> > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > index 8677ae38599e..88793b77bd63 100644
> > --- a/include/linux/hid.h
> > +++ b/include/linux/hid.h
> > @@ -155,6 +155,7 @@ struct hid_item {
> >  #define HID_UP_DIGITIZER     0x000d0000
> >  #define HID_UP_PID           0x000f0000
> >  #define HID_UP_BATTERY               0x00850000
> > +#define HID_UP_CAMERA                0x00900000
> >  #define HID_UP_HPVENDOR         0xff7f0000
> >  #define HID_UP_HPVENDOR2        0xff010000
> >  #define HID_UP_MSVENDOR              0xff000000
> > --
> > 2.39.0
> >
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
