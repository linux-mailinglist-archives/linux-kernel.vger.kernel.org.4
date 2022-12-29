Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EAD65881B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 01:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiL2Ac7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 19:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiL2Ac4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 19:32:56 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C846305;
        Wed, 28 Dec 2022 16:32:56 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id s127so3116666vsb.5;
        Wed, 28 Dec 2022 16:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UJnzpyv5OSKAdAusliGI6phyCMSzBd9Eu9reXgwTRY=;
        b=JeaEKtkuGVLL3TyCnRDhPZ3EsWNaO6EvMbbZ3bLXOTpDD1+0dnTj2Y7OxKOrw1D+jL
         f20oJc5oYdw45gqgGqIJeuTW6QB/ZkeQLg36IpMGEn/YgziuMiylFz9fkum3Y6vBLjd0
         Pdoju0XUyIi0gt44lmaWq6yQttVik85ARiBoFGHbH4z6A1a29no9kBNx9It1q/4b76fD
         NFT/p9Yr7CWW8HDzc+ymPahL7sk47euJMWt/IOUNvVOML5QESv2AXkJgdVR3oYYWdypo
         t1PfjpwtMnj7ZyJ9vRMe8FsdADZdXdda5K+W6GE8zFg5zI3yOlMso8gZd8NLre5fzCIM
         FYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UJnzpyv5OSKAdAusliGI6phyCMSzBd9Eu9reXgwTRY=;
        b=TNHLJWD93BMKK/atgMISaj/AWKXFr0aB98NquNsIrv6RPP5lhOT3c9gnt3b6qObEEH
         w6IAt4OSKeRF2LyDvnrWKBnO4nlIHHIOCOqo1huHlac3dUGmuS75nDg73QP7V2eTtTx0
         nybz0Kojcbzh+IqnnFrLownV9sFwEnaNzYSFxvAbJQ/63/o4EQBK/X4w9oJrkkY5FR70
         FUC6M8YcdVE+/HY3KO6qctxyh2Taei5hrDsLVeKydkmQ+Adn9kJRCf0SM7qsyHBQhzlp
         4TnsNeGnA1k/gQTYO4APXlp+4TLKD2ULlKsFZGdJWgdUHMHxrTrEG0r0YKf3ih3pcSRy
         hcaA==
X-Gm-Message-State: AFqh2kpys14R9Oed8zkWX7oQRP+L8WiXg3Ph8VAhbb4gp2b9+LyaF0T8
        CDoY4AyO2LyOxTiLPqcQ70F0lbePn5YmaCtLTsMBhp8OUSBzz56j
X-Google-Smtp-Source: AMrXdXvPL9IoBJ1wkp7Z296xeaerPWYa5lUM3qZ8cblcErIigOUvMAweFCa7nbWHUcTZls2hZA7H/VCZh/njDB47vvw=
X-Received: by 2002:a67:fb9a:0:b0:3c9:ced4:d35b with SMTP id
 n26-20020a67fb9a000000b003c9ced4d35bmr910760vsr.14.1672273975093; Wed, 28 Dec
 2022 16:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20221228230632.141917-1-derekjohn.clark@gmail.com> <20221229001030.GA540645@roeck-us.net>
In-Reply-To: <20221229001030.GA540645@roeck-us.net>
From:   Derek John Clark <derekjohn.clark@gmail.com>
Date:   Wed, 28 Dec 2022 16:32:44 -0800
Message-ID: <CAFqHKTmWTSYP_4Bq-PWu2zm9-mb70A89FJRwYsOAD68HAr1EKQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add support for the AYANEO AIR and AYANEO AIR Pro
 models of handheld devices. These devices use the same EC registers and logic
 as the One X Player mini AMD. Previous AYANEO models are not supported as
 they use a different EC and do not have the necessary fan speed write enable
 and setting registers. The driver is tested on AYANEO AIR while AIR Pro model
 EC functionality and DMI data were verified using command line tools by
 another user.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= 
        <samsagax@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 4:10 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Dec 28, 2022 at 03:06:32PM -0800, Derek J. Clark wrote:
> > The added devices are:
> > - AYANEO AIR (AMD 5560U)
> > - AYANEO AIR Pro (AMD 5560U)
> > - AYANEO AIR Pro (AMD 5825U)
>
> Add:
>
> While at it, fix spelling error (appart -> apart).
>
To clarify, do you want this added to the patch description? There
were a couple other spelling errors I fixed as well (PLayer -> Player,
capabilities -> capabilities).
I.E.

Add:
- AYANEO AIR (AMD 5560U)
- AYANEO AIR Pro (AMD 5560U)
- AYANEO AIR Pro (AMD 5825U)
Fix spelling errors (appart -> apart, capabilities -> capabilities,
PLayer -> Player).

> > ---
> > Bundled all cases that lead to break.
> > Spelling and grammar fixes.
> > More verbose description of supported devices.
> > ---
> > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > ---
> >  Documentation/hwmon/oxp-sensors.rst | 19 +++++++----
> >  MAINTAINERS                         |  1 +
> >  drivers/hwmon/oxp-sensors.c         | 52 ++++++++++++++++++++++++-----
> >  3 files changed, 56 insertions(+), 16 deletions(-)
> >
> > diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/=
oxp-sensors.rst
> > index 39c588ec5c50..7f6e8def5aef 100644
> > --- a/Documentation/hwmon/oxp-sensors.rst
> > +++ b/Documentation/hwmon/oxp-sensors.rst
> > @@ -3,18 +3,21 @@
> >  Kernel driver oxp-sensors
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > -Author:
> > +Authors:
> > +    - Derek John Clark <derekjohn.clark@gmail.com>
> >      - Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com>
> >
> > -Description:
> > +Description
> >  ------------
>
> I am not going to accept this. The change is POV, and it is unrelated to
> this patch. Either submit a separate patch or let the person requesting
> the change submit it. It is very unlikely that I am going to accept it,
> though, since the change is POV, unnecessary, and the original author may
> rightfully come back tomorrow and submit a revert.
>
> Really, seriously, please refrain from making such changes.
>
> Guenter
>
Understood, I will revert it in v4.

Thanks.
