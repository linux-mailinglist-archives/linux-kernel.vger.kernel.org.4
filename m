Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C3B658866
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 02:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiL2BjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 20:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiL2BjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 20:39:20 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9841183D;
        Wed, 28 Dec 2022 17:39:18 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-14fe0e9ed11so10493885fac.2;
        Wed, 28 Dec 2022 17:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hwILtrJkryvCNSnazlhne3MC+6Pf/Nqlnb15EFVvzqI=;
        b=HwZFBjWJDM4G9OPadJUy6RApb0V0eVxyFmxleEp8YeF962m6Qh6g3s/3kRSYL7CH7C
         LNTUrcZE9iXEAsrenqpo/QUWRcu+bUmUfvsoVzKHOP+7xvL94Kf2YJRN5gH3RaK3JDnk
         achSeUEX68ZdWCyQBHSk0BOEYUjZneaqg+anov2H/d/A8VRGPZFG9y3VKJQm+JvmZecd
         OQ87ssxsNSpmmiHQhUcDyguxKJD8UQBy7DD3/1DSr+UkM2Qn8KbNqlUq//6WHgntMpIs
         KpgUtbr+1vLOBB9NlDMINzonOZxVuDXUhSPZw7QF3Cxttsxn3tewkjCQP/5XLJet83xb
         0quA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwILtrJkryvCNSnazlhne3MC+6Pf/Nqlnb15EFVvzqI=;
        b=3CrzaY3zAnijOMLQk+1979upY3wRl+hGEhncV5J7YoH1szQa/t8pRiJCEwi5sWF/5o
         ip1qapKEVugv7DirSueTqjW/hrgfd0QfARTwpdIsHLIg8Vw34yrpGbhrd1wjIihuwROK
         4zI+tn7IBSiJgQVD3zAZubaxlDe+Gz+sDOnD9vE73zlYtZRQICp3a/NshrdeGZ/R3Wre
         ua8pD/UYLuwEVHeGsGttfBAIkM4CfKc6gKrMwfehNBzfmyzV1OiPc84nsScd0Y7YdSXx
         0Gn3KErMXFYPwujbelMH0M0N6DVdBszPDUZII5cD5f5IaYWfKFQdhMEs8YOeX0zs0eEM
         kzRA==
X-Gm-Message-State: AFqh2koQDOeefKw8T7Cv25cBTolDFYPUpNg1BWToUhZnWAY9lfpl6A3I
        0Aurtw3IuJ0DHogBmHdEnTXlsuXiTGM=
X-Google-Smtp-Source: AMrXdXt7J3pyB/TOSiRU3bGaZsrxdI6PgSN5KPyUb/Dh19sHg18egrZOojs8p0x4/7ASvUfFgbpwTQ==
X-Received: by 2002:a05:6870:7d0a:b0:148:53c7:c51b with SMTP id os10-20020a0568707d0a00b0014853c7c51bmr20324331oab.34.1672277957884;
        Wed, 28 Dec 2022 17:39:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q4-20020a4aa884000000b004a382acad85sm7022166oom.15.2022.12.28.17.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 17:39:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Dec 2022 17:39:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Derek John Clark <derekjohn.clark@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Add support for the AYANEO AIR and AYANEO AIR Pro
 models of handheld devices. These devices use the same EC registers and
 logic as the One X Player mini AMD. Previous AYANEO models are not supported
 as they use a different EC and do not have the necessary fan speed write
 enable and setting registers. The driver is tested on AYANEO AIR while AIR
 Pro model EC functionality and DMI data were verified using command line
 tools by another user.
Message-ID: <20221229013915.GA1230895@roeck-us.net>
References: <20221228230632.141917-1-derekjohn.clark@gmail.com>
 <20221229001030.GA540645@roeck-us.net>
 <CAFqHKTmWTSYP_4Bq-PWu2zm9-mb70A89FJRwYsOAD68HAr1EKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqHKTmWTSYP_4Bq-PWu2zm9-mb70A89FJRwYsOAD68HAr1EKQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 04:32:44PM -0800, Derek John Clark wrote:
> On Wed, Dec 28, 2022 at 4:10 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Wed, Dec 28, 2022 at 03:06:32PM -0800, Derek J. Clark wrote:
> > > The added devices are:
> > > - AYANEO AIR (AMD 5560U)
> > > - AYANEO AIR Pro (AMD 5560U)
> > > - AYANEO AIR Pro (AMD 5825U)
> >
> > Add:
> >
> > While at it, fix spelling error (appart -> apart).
> >
> To clarify, do you want this added to the patch description? There

Yes, but ...

> were a couple other spelling errors I fixed as well (PLayer -> Player,
> capabilities -> capabilities).
> I.E.
> 
> Add:
> - AYANEO AIR (AMD 5560U)
> - AYANEO AIR Pro (AMD 5560U)
> - AYANEO AIR Pro (AMD 5825U)
> Fix spelling errors (appart -> apart, capabilities -> capabilities,
> PLayer -> Player).
> 

Confused. There is no "PLayer" anywhere in the Linux kernel, and 
"capabilities" does not even appear in the current code.

If you refer to a change from an older version of the patch to a
more recent version, that belongs into the change log, not the commit
description.

Guenter

> > > ---
> > > Bundled all cases that lead to break.
> > > Spelling and grammar fixes.
> > > More verbose description of supported devices.
> > > ---
> > > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > > ---
> > >  Documentation/hwmon/oxp-sensors.rst | 19 +++++++----
> > >  MAINTAINERS                         |  1 +
> > >  drivers/hwmon/oxp-sensors.c         | 52 ++++++++++++++++++++++++-----
> > >  3 files changed, 56 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
> > > index 39c588ec5c50..7f6e8def5aef 100644
> > > --- a/Documentation/hwmon/oxp-sensors.rst
> > > +++ b/Documentation/hwmon/oxp-sensors.rst
> > > @@ -3,18 +3,21 @@
> > >  Kernel driver oxp-sensors
> > >  =========================
> > >
> > > -Author:
> > > +Authors:
> > > +    - Derek John Clark <derekjohn.clark@gmail.com>
> > >      - Joaquín Ignacio Aramendía <samsagax@gmail.com>
> > >
> > > -Description:
> > > +Description
> > >  ------------
> >
> > I am not going to accept this. The change is POV, and it is unrelated to
> > this patch. Either submit a separate patch or let the person requesting
> > the change submit it. It is very unlikely that I am going to accept it,
> > though, since the change is POV, unnecessary, and the original author may
> > rightfully come back tomorrow and submit a revert.
> >
> > Really, seriously, please refrain from making such changes.
> >
> > Guenter
> >
> Understood, I will revert it in v4.
> 
> Thanks.
