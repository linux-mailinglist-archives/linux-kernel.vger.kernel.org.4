Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEA16F84DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjEEOai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjEEOag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:30:36 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F8E30D4;
        Fri,  5 May 2023 07:30:34 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ac88d9edf3so8479761fa.0;
        Fri, 05 May 2023 07:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683297033; x=1685889033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVsbfG6h5RFW9xhQDAlrHWw+7sMdH/ZPJc2Cm59Pckc=;
        b=mom/jjJ3h0UjJsgHdE9Cwhwex7MpgircxA49E6Zbz5fJ7PBfIbBnkFDyH1/6AdtHcJ
         0yNBoa9lT9xIeh2hCQPX6JcT+88bg+60uXIj8sSai1zzpGJFy3Hbe0cU3exWSkh85/v+
         CTKKZWrhKCVs3ehmBI9CGxHnoRxZr9nhof22RKQZgp6f/mrMcc+eciZyki+RXJvMN9Y7
         Oyc6IjehFR9NJx0yeMcMl1v9HYbcHKIXEUgLM4Cc7Q8YIgERWmGwLrscMZlWlzgnYRHf
         ZDpVVLAYd/8FnzAstzzxru4fOyCxb6dgsq/8a0peao+420bQ25UOsmEwVpVwXrRzp6v2
         XFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683297033; x=1685889033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVsbfG6h5RFW9xhQDAlrHWw+7sMdH/ZPJc2Cm59Pckc=;
        b=L+Ze2K5KJTtZlbHAiB/cuh7jf7yJRArh3gNMFQij4+F/ggT+QdI8U8smQ7ystrzDkO
         6R/bEIscs/E9TngCyatvrYixTn1XU8dqMQjhNPlg4tlG78MmA7AgO+jwuq/RYqBJq/Bh
         x1bt1R9jVab306+nATN2DN/We22e62bgB5iV3iWVNdJCIroBL4IrF7gA0xfKBAFajF6F
         dlvRFfiwQJXsrOOp5G+s0latKdmWp3xZ23fj0BggcsowF5Q+JrWv31PGssUzx9pmO4Bo
         aX2+4SmcTjDGguTqo9KLhrf6md63Bi4Qe/HKz1ui2mGJwyFg327pzY/XEYKHfmP1PgjE
         lSKA==
X-Gm-Message-State: AC+VfDwGXz1zMM1GPUeJn6pJ8hNhTxY8velZP7siNjgmiWfHSmmEBGbR
        9Wx2XimGjlS0ef6uhR5/61nZMZx9R1gG33xtkMZxFiJkN34=
X-Google-Smtp-Source: ACHHUZ53AFxTYUnGZDzJDAwKFWkAd6Xlt8OfUVAevZt2sE+FcHSPgzgXk7+2Vm2AZxYCAR6evLbcE54YY1tMUB5nlZc=
X-Received: by 2002:a19:a40f:0:b0:4f1:4051:d77b with SMTP id
 q15-20020a19a40f000000b004f14051d77bmr640392lfc.60.1683297032785; Fri, 05 May
 2023 07:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-7-jorge.lopez2@hp.com>
 <016a9a6a-cff1-444d-b96a-63eded1ac58a@t-8ch.de> <CAOOmCE9USvpih7E6cq7sKiMmGJa_FV74g36kb6EZMSrkg5BnLg@mail.gmail.com>
 <9bbf8cb3-6333-4742-b32a-c7e9118bc618@t-8ch.de> <CAOOmCE-S-GpcmG9c6eB1hz6o3hudX8hWY9jmZ-cUwivHzijsPw@mail.gmail.com>
 <1f80c7a9-cc88-4c30-9797-e20e3cb4859c@t-8ch.de>
In-Reply-To: <1f80c7a9-cc88-4c30-9797-e20e3cb4859c@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Fri, 5 May 2023 09:30:05 -0500
Message-ID: <CAOOmCE-Yj1zEx4MY2gzS5QO=fZh17GvZKDUKZLX05on1sy0srg@mail.gmail.com>
Subject: Re: [PATCH v11 06/14] HP BIOSCFG driver - passwdobj-attributes
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 5:21=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> On 2023-05-04 16:34:06-0500, Jorge Lopez wrote:
> > On Thu, May 4, 2023 at 3:59=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-=
8ch.de> wrote:
> > >
> > > On 2023-05-04 15:29:21-0500, Jorge Lopez wrote:
> > > > On Sun, Apr 23, 2023 at 4:07=E2=80=AFAM <thomas@t-8ch.de> wrote:
> > > > >
> > > > > On 2023-04-20 11:54:46-0500, Jorge Lopez wrote:
> > > > > > ---
> > > > > >  .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 669 ++++++++++=
++++++++
> > > > > >  1 file changed, 669 insertions(+)
> > > > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdob=
j-attributes.c
>
> <snip>
>
> > > > > > +
> > > > > > +     id =3D get_password_instance_id(kobj);
> > > > > > +
> > > > > > +     if (id >=3D 0)
> > > > > > +             ret =3D validate_password_input(id, buf_cp);
> > > > > > +
> > > > > > +     if (!ret) {
> > > > > > +             strscpy(bioscfg_drv.password_data[id].current_pas=
sword,
> > > > > > +                     buf_cp,
> > > > > > +                     sizeof(bioscfg_drv.password_data[id].curr=
ent_password));
> > > > > > +             /*
> > > > > > +              * set pending reboot flag depending on
> > > > > > +              * "RequiresPhysicalPresence" value
> > > > > > +              */
> > > > > > +             if (bioscfg_drv.password_data[id].common.requires=
_physical_presence)
> > > > > > +                     bioscfg_drv.pending_reboot =3D true;
> > > > >
> > > > > Just setting this to true does not emit the necessary KOBJ_CHANGE=
 event
> > > > > on the class dev kobj which is necessary for userspace to be able=
 to
> > > > > react.
> > > >
> > > > This feature was added outside of the original design specification=
 to
> > > > be used at a later time.
> > > > Changes to the value to true does not emit a KOBJ_CHANGE event.
> > >
> > > This contradicts the documentation:
> > >
> > >         A read-only attribute reads 1 if a reboot is necessary to app=
ly
> > >         pending BIOS attribute changes. Also, an uevent_KOBJ_CHANGE i=
s
> > >         generated when it changes to 1.
> > >
> > > This will confuse userspace, there are generic userspace applications
> > > waiting for those events.
> > > If there is a reason for not emitting them it should be good and
> > > documented.
> > >
> > > Also according to the docs the authentication attributes should
> > > KOBJ_CHANGE events. I think this also affects this driver and should =
be
> > > implemented.
> > >
> >
> > HP-BIOSCFG initially is not intended for the use of fwupd tool nor was
> > it tested.
> > This does not mean the driver will interface with fwupd and other
> > tools in the future.
>
> There are probably more tools than fwupd using this ABI.
>
> The driver is implementing a well-known ABI and users of this ABI expect
> it to work as documented.
>
> Emitting these events seems straigtforward and simple.
>
> Maybe Hans can give more guidance on it.
>

Let me see how I can implement it by following the sample of other drivers.
I will reachout to Hans as my last resource.

Done!
> > > > >
> > > > > > +     }
> > > > > > +
> > > > > > +exit_password:
> > > > > > +     kfree(buf_cp);
> > > > > > +     return ret ? ret : count;
> > > > > > +}
> > > > > > +static struct kobj_attribute password_current_password =3D __A=
TTR_WO(current_password);
> > > > > > +
> > > > > > +static ssize_t new_password_store(struct kobject *kobj,
> > > > > > +                               struct kobj_attribute *attr,
> > > > > > +                               const char *buf, size_t count)
> > > > > > +{
> > > > > > +     char *p, *buf_cp =3D NULL;
> > > > > > +     int id =3D 0;
> > > > > > +     int ret =3D -EIO;
> > > > > > +
> > > > > > +     buf_cp =3D kstrdup(buf, GFP_KERNEL);
> > > > > > +     if (!buf_cp) {
> > > > > > +             ret =3D -ENOMEM;
> > > > > > +             goto exit_password;
> > > > > > +     }
> > > > > > +
> > > > > > +     p =3D memchr(buf_cp, '\n', count);
> > > > > > +
> > > > > > +     if (p !=3D NULL)
> > > > > > +             *p =3D '\0';
> > > > >
> > > > > Same as above.
> > > >
> > > > This is an expected behavior.  If the user enters '\n' as part of t=
he
> > > > password, the buffer data will be truncated since only one line per
> > > > sysfs file is permitted.
> > >
> > > If a user accidentally presses enter before entering a password this
> > > may set the password to the empty string; surprising.
> > >
> > > This should really use the helper.
> >
> > Done!  enforce_single_line_input() function is used.
> > >
> > > > >
> > <snip>
> > > > > > +
> > > > > > +ATTRIBUTE_V_COMMON_PROPERTY_SHOW(prerequisites, password);
> > > > > > +static struct kobj_attribute  password_prerequisites_val =3D
> > > > > > +             __ATTR_RO(prerequisites);
> > > > > > +
> > > > > > +ATTRIBUTE_N_PROPERTY_SHOW(encodings_size, password);
> > > > > > +static struct kobj_attribute  password_encodings_size_val =3D
> > > > > > +             __ATTR_RO(encodings_size);
> > > > >
> > > > > As before, these size attribute are fairly pointless for userspac=
e as
> > > > > they can't be relied on.
> > > >
> > > > I will remove the attribute from being reported in sysfs but they w=
ill
> > > > be kept as part of the driver internal data
> > > >
> > > > >
> > > > > > +
> > > > > > +ATTRIBUTE_VALUES_PROPERTY_SHOW(encodings, password);
> > > > > > +static struct kobj_attribute  password_encodings_val =3D
> > > > > > +             __ATTR_RO(encodings);
> > > > > > +
> > > > > > +
> > > > > > +static struct attribute *password_attrs[] =3D {
> > > > > > +     &password_is_password_set.attr,
> > > > > > +     &password_min_password_length.attr,
> > > > > > +     &password_max_password_length.attr,
> > > > > > +     &password_current_password.attr,
> > > > > > +     &password_new_password.attr,
> > > > > > +     &password_role.attr,
> > > > > > +     &password_mechanism.attr,
> > > > > > +     &password_type.attr,
> > > > > > +     &password_display_name.attr,
> > > > > > +     &password_display_langcode.attr,
> > > > > > +     &password_prerequisites_size_val.attr,
> > > > > > +     &password_prerequisites_val.attr,
> > > > > > +     &password_encodings_val.attr,
> > > > > > +     &password_encodings_size_val.attr,
> > > > > > +     NULL
> > > > > > +};
> > > > >
> > > > > Many of these attributes are not documented.
> > > >
> > > > Those attributes are documented under authentication section, lines=
 150-329
> > > >
> > > > What: /sys/class/firmware-attributes/*/authentication/
> > > > Date: February 2021
> > > > KernelVersion: 5.11
> > > > Contact: Divya Bharathi <Divya.Bharathi@Dell.com>,
> > > > Prasanth KSR <prasanth.ksr@dell.com>
> > > > Dell.Client.Kernel@dell.com
> > > > Description:
> > > > Devices support various authentication mechanisms which can be expo=
sed
> > > > as a separate configuration object.
> > >
> > > If I read that correctly the authentication attributes are not "norma=
l"
> > > attributes.
> > > So they don't need "type", "display_name", "display_langcode".
> > >
> >
> > Type, display_name, and display_langcode are required and default setti=
ngs.
> > See documentation lines 15-52
> >
> > type:
> >     A file that can be read to obtain the type of attribute.
> >     This attribute is mandatory.
> >
> > display_name:
> > A file that can be read to obtain a user friendly
> > description of the at <attr>
> >
> > display_name_language_code:
> > A file that can be read to obtain
> > the IETF language tag corresponding to the
> > "display_name" of the <attr>
>
> They are required for
>
> /sys/class/firmware-attributes/*/attributes/*/
>
> but here we implement
>
> /sys/class/firmware-attributes/*/authentication/*/
>
> which is a different ABI.
>
> >
> > > Do they need prerequisites?
> >
> > Prerequisites is optional and not documented.  I will remove it from
> > the list of items reported within sysfs
> > >
> > > >

Fair enough.  I will remove "type", "display_name" and "display_langcode".
The same three entries will be removed from spmobj-attributes (SPM)
which belong to authentication attributes.

> > > >
> > > > >
> > > > > > +
> > > > > > +static const struct attribute_group bios_password_attr_group =
=3D {
> > > > > > +     .attrs =3D password_attrs
> > > > > > +};
> > > > > > +
> > > > > > +static const struct attribute_group system_password_attr_group=
 =3D {
> > > > > > +     .attrs =3D password_attrs
> > > > > > +};
> > > > >
> > > > > These groups are the same, are both needed?
> > > >
> > > > Yes.  They will show under  'Setup Password' and 'Power-on password=
'
> > >
> > > These are identical constant structures. It should be possible to hav=
e
> > > only one and use it for both usecases.
> > >
> >
> > Both 'Setup Password' and 'Power-on password' need to coexist hence
> > the reason for keeping them separate.
> > Both attributes share the same helper routines.  Unifying  both
> > passwords into a single structure adds unnecessary complexity.
>
> They are already sharing the "password_attrs" array and all the
> attributes listed in it.
>
> It seems they could also share the attribute_group which does not really
> contain any data.

Ah.  That makes sense.  Thank you for the clarification.
Done!
