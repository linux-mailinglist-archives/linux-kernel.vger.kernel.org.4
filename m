Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599E2658800
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 01:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiL2AFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 19:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiL2AFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 19:05:07 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589AB2AFD;
        Wed, 28 Dec 2022 16:05:06 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id x44-20020a05683040ac00b006707c74330eso10682042ott.10;
        Wed, 28 Dec 2022 16:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NlwAyp2ePGonWkoengdxdT+6OP15Q+SHwp/Pz5RrlC0=;
        b=KDFnFP/41r8wVE4dsVTXM8rn1UQRh2WWPQofgFp09TBrAUzUvzomPsYRs86sv00IuU
         PQulr2I3HLPqM+5jezNDbx7MHrgzPwgXq7ptQKC+vGhHboknX6yHoDBLeGroQ6UUby/3
         TFxui6xP0xzyV8HRGKivRbpkEaPA/PVBFFsc//OM0bC8gIpfXia5SK5NNTYP6qmBBkAX
         vSVRMKs4dXhGyr14RNt/UD7PFqmddNrHTF9i0ItFSdkHC6efjN4i6x2wg4i1vwOxwGjD
         R6ONAcH35X1RZ/7OTQxY8hszbZNv2oTJbor6Zfw+xC5cVD91Gz8McRKI30E4FsBir9t8
         GFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlwAyp2ePGonWkoengdxdT+6OP15Q+SHwp/Pz5RrlC0=;
        b=GoBwIKTiMo2Yu10Yjpzv0RQN0vDQblTo53Laz/5MD+tzFdTIHE+BNNm1z5dtTHkcPY
         XOhU26tIRtlb8rdeWxjvtNBtaQQfPTgd8wP612QNu0zn/aQ8869pl0q3zeaQDgS0CIt5
         nknIlC4CfGjANCbKjGjAKWRyWl42WuQMmr37IlvDCQA/YarO2XEQ3BxWNeJejC5w4grr
         K10S3byQXO9v/Yzn7YDfD5QwG/ieEtA1aHEOAQfi57LhWNVraYWDLcG0fF/QmT4M9FH/
         MtURhedWCFzDEhb8w00fq36jyvrpm7SAa2eXWuKRITIcrctt+wvI86oG/nNmgGvUeWG+
         i8rA==
X-Gm-Message-State: AFqh2kpYUGt+DXY/3ejQERPKh6LgU6yjge9L0dqDxWesUICNay4Z4utf
        /TJXWj8AwFxezdMYfyWrBWE37/Ntwco=
X-Google-Smtp-Source: AMrXdXu39jwb8moy5Sw5YKsFimJgCIoytGvrDwvw85CHKHrTjfFiMeoOg/lgXelewtLb0xONbZcJ7A==
X-Received: by 2002:a9d:3637:0:b0:670:5684:d87c with SMTP id w52-20020a9d3637000000b006705684d87cmr12100959otb.5.1672272305651;
        Wed, 28 Dec 2022 16:05:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c1-20020a9d6c81000000b0066c15490a55sm8346901otr.19.2022.12.28.16.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 16:05:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Dec 2022 16:05:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Derek John Clark <derekjohn.clark@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (oxp-sensors) Add AYANEO AIR and AIR Pro
Message-ID: <20221228235933.GA417463@roeck-us.net>
References: <Y5lBue87IXkhNs42@debian.me>
 <20221214154713.100648-1-derekjohn.clark@gmail.com>
 <20221228155542.GA3964987@roeck-us.net>
 <CAFqHKT=OO6367zfbEGmghahCUkV4ECLvCH+A_WLhBQyZf4k_jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqHKT=OO6367zfbEGmghahCUkV4ECLvCH+A_WLhBQyZf4k_jw@mail.gmail.com>
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

On Wed, Dec 28, 2022 at 02:50:23PM -0800, Derek John Clark wrote:
> > > ---
> > >  Documentation/hwmon/oxp-sensors.rst | 19 ++++++----
> > >  MAINTAINERS                         |  1 +
> > >  drivers/hwmon/oxp-sensors.c         | 54 ++++++++++++++++++++++++-----
> > >  3 files changed, 59 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
> > > index 39c588ec5c50..a53c961065b2 100644
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
> > Why drop ":" here ?
> To match the style of the rest of the Documentation section titles.
> Per Bagas Sanjaya previously:
> 
> >> -Author:
> >> +Authors:
> >> +    - Derek John Clark <derekjohn.clark@gmail.com>
> >>      - Joaquín Ignacio Aramendía <samsagax@gmail.com>
> >>
> >>  Description:
> >>  ------------
> 
> >Trim the trailing colon as it is not needed for section title.

That is POV, unrelated to this patch, and would have to be submitted as
separate patch. Please refrain from changes like that and get me involved
if someone requests it (actually they should provide such changes
themselves since they request it and it is unrelated, and they should
explain in the patch description why it is needed).

On a side note, '------------' would have to be changed as well.

Guenter

> 
> Additional changes forthcoming. Thanks.
