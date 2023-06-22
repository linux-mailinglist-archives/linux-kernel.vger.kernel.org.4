Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495DC73A7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjFVRtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjFVRsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:48:43 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC4D1FE8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:48:40 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-62fff19e8fdso4665236d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687456120; x=1690048120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKLqaAnysX1QzB0ag1Ma2pQveOqhDMSMNtpC7qGJVGA=;
        b=DCdLo81mM22VguEkaVeALMk5etLUEl6R08vdcNDRFw4V9u+OIpLsS99abC3//kaG1B
         Fqihr9ZLn8z+bJqh/Xx7osg5/Zqyub3M67Ovq+cAM9k0LoxU57uoNOhLZonUKMQGCH2J
         Mrs7yXCcrPtN/Kw1Do1ZHH27o78KUw4DtQPgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687456120; x=1690048120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKLqaAnysX1QzB0ag1Ma2pQveOqhDMSMNtpC7qGJVGA=;
        b=E89I8DYeOTDnVQoUpWTfYC12HkatnxM5UBqXKcL68DJZ4XYm33lCONLotdeQ5i1Vgg
         1HGDCJ9+aCszIrrgYjZtM6ooJ/ERrA1zSeEXxcu2whw045vrC/itpy0AdmgvxZrcaJhz
         FHNYjGfsqfRscw8RlybrbdAa2+WVjE7BWMfaVBjEklRVxY3bv0rpzGanCdAGnJmY/o/C
         T/nX25iirUWX93r6HTKZH+HT1IFh/MBbgDf0oOHlMr3aYTyDQGw6ZtI3o6KK9UKE+lRD
         3NSMAQ+Lwyh5Ycs+Rowvh8Ll+T0/Ha0lBd/mf1hJF4O3XIWbDdt+WxODYYjjbMXxNidN
         8Ztg==
X-Gm-Message-State: AC+VfDzcNu/mhmw6xIieFBJaLDF1KrKSHXxjFCSGOLUlXCBs1D2fX+Dj
        t+OxsJtbUivDdid2E9QKTJiYiHunKxti66gXLYvRew==
X-Google-Smtp-Source: ACHHUZ4ZlapO0hAF63on3Jm0hjQmOEMUF9pokcEQvVa5BunUGvF5+BgOeSjIIRK0b7Y1nbRDxKmUDiQo0vqs+5vfaFk=
X-Received: by 2002:a05:6214:2aa9:b0:62d:e8d0:b137 with SMTP id
 js9-20020a0562142aa900b0062de8d0b137mr19133708qvb.14.1687456119798; Thu, 22
 Jun 2023 10:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230605010117.794691-1-utkarsh.h.patel@intel.com>
 <20230605010117.794691-2-utkarsh.h.patel@intel.com> <CACeCKaeVw4UJ8oCj-wmWgf6TCcKYdprqb8Wdu-g2ZC5npgs71g@mail.gmail.com>
 <MWHPR11MB0048F68F717892378FF64E5FA958A@MWHPR11MB0048.namprd11.prod.outlook.com>
 <CACeCKac9YRbGYVSVjVWKX0hzJ2PJnenWxasABf2QoUQKK52XvA@mail.gmail.com> <MWHPR11MB00487A8E79B50419848CC5ECA922A@MWHPR11MB0048.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB00487A8E79B50419848CC5ECA922A@MWHPR11MB0048.namprd11.prod.outlook.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 22 Jun 2023 10:48:29 -0700
Message-ID: <CACeCKaf3fniGhxn3KeDLdUSU6Q_QYtePAs49E9zHv0E1sX-74Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
To:     "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Utkarsh,

On Thu, Jun 22, 2023 at 10:40=E2=80=AFAM Patel, Utkarsh H
<utkarsh.h.patel@intel.com> wrote:
>
> Hi Prashant,
> >
> > Hi Utkarsh,
> >
> > On Fri, Jun 16, 2023 at 2:57=E2=80=AFPM Patel, Utkarsh H <utkarsh.h.pat=
el@intel.com>
> > wrote:
> > >
> > > Hi Prashant,
> > >
> > > Thank you for the review and feedback.
> > >
> > > > > Connector class driver only configure cable type active or passiv=
e.
> > > > > With this change it will also configure if the cable type is
> > > > > retimer or redriver if required by AP. This details will be
> > > > > provided by Chrome EC as a part of cable discover mode VDO.
> > > > >
> > > > > This change also brings in corresponding EC header updates from
> > > > > the EC code base [1].
> > > >
> > > > Please separate this into another patch.
> > >
> > > I can do that but since it's just one line change and related, kept i=
t together.
> >
> > It's fine to have a 1 line patch. That said (see below)...
>
> Ack.
>
> >
> > >
> > > > > a/include/linux/platform_data/cros_ec_commands.h
> > > > > b/include/linux/platform_data/cros_ec_commands.h
> > > > > index ab721cf13a98..c9aa5495c666 100644
> > > > > --- a/include/linux/platform_data/cros_ec_commands.h
> > > > > +++ b/include/linux/platform_data/cros_ec_commands.h
> > > > > @@ -4963,6 +4963,8 @@ struct ec_response_usb_pd_control_v1 {
> > > > > #define USB_PD_CTRL_TBT_LEGACY_ADAPTER  BIT(2)
> > > > >  /* Active Link Uni-Direction */
> > > > >  #define USB_PD_CTRL_ACTIVE_LINK_UNIDIR  BIT(3)
> > > > > +/* Retimer/Redriver cable */
> > > > > +#define USB_PD_CTRL_RETIMER_CABLE BIT(4)
> > > >
> > > > Why are we adding this to this host commands interface? Is this
> > > > information not available from the Cable (plug)'s Identity
> > > > information? We register all of that in the port driver already [1]=
,
> > > > so we should just use that, instead of changing the host command in=
terface.
> > >
> > > All the cable details used to configure Alternate mode and USB4 mode =
in this
> > driver are provided from EC host command.
> > > To stay consistent with the existing implementation, it was added to =
the
> > existing host command.
> >
> > I think it's fine to use the cable VDO from the registered port plug fo=
r this. It's
> > less disruptive than introducing another (superfluous) host command
> > modification.
> > It is also more clear; right now we don't know what information populat=
es the
> > USB_PD_CTRL_RETIMER_CABLE. Please use the existing cable VDO from the
> > cable struct for this purpose.
>
> This information is provided from EC where it gets TBT3 Cable Discover Mo=
de VDO Responses.
> Like any other cable capabilities e.g. active/passive, rounded support, c=
able speed, cable's retimer/redvier capabilities is also
> populated from this response in bit 22. (https://chromium.googlesource.co=
m/chromiumos/platform/ec/+/HEAD/include/usb_pd_tbt.h#251)
> * <22>    : Re-timer
>  *           0 =3D Not re-timer
>  *           1 =3D Re-timer
>
> This is already being used by EC to configure retimer with the cable capa=
bilities and the goal of this patch here is to provide  the same cable reti=
mer/redriver capabilities to SOC.
> When all other cable details are populated from EC in alternate mode and =
usb4 mode and send it to SOC, it's better to stick to the same framework to=
 use cable capabilities which is already available instead of
> new implementation just to get retimer/redriver cable capabilities.

Sorry, but that is not a sufficient justification. We used the old
interface because when this code was first implemented, we didn't have
the cable discovery information being sent to the AP/kernel. Now we
do. Please just use the Cable Discover Mode VDO response (which is
**already there in this driver**) to extract this information. What
the EC is doing to fashion this information is not really relevant
here, and if it is also pulling this information from the Cable
Discover Mode VDO response as you say, then there is no difference.

Please don't modify legacy EC host interfaces that we are trying hard
to not modify any further.

Regards,

-Prashant
