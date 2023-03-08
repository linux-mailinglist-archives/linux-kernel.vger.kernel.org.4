Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526596B103E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCHRfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCHRfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:35:33 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1E2BCBA0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:35:30 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id l2so10825208ilg.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 09:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678296928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSyUj9sOQAg1bto5phGO0kdMN7B410cjZoU9zGMstis=;
        b=jq3SyMYYuTIgvU+sGELF+gqjQAmnVWzWaFRFgf7Hx3xedzgG2D4EFUTGJm5qp3TVfK
         b4WD7CWaoOYbABuXo7RXPIcyYdX4SIZXGycuDjyR0FkPNuaxgIoJr/WqvV34oMLNj3FI
         f6bIdf8HzZRTzOzXyQe+Rr/bi3bF0guyfDJU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678296928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSyUj9sOQAg1bto5phGO0kdMN7B410cjZoU9zGMstis=;
        b=hWJeOh+BgttredZFMx9fJIWqFPbDH916nfGQdCQO2fICDqEJ5HbMnf2TDpr2hPBmK7
         vcJdJDWMG4B1/QokK6PG1QI23PJmZNhGS+3mKyr9vY8zPxeuNoj61MpZgrXpUNtt8Om/
         73dWyMtQx9D6Sjkmtm+CzGQWmnNhexPVOFvzZlSSuoCMdbuVmcqAAtnrxM/Kfh/v3n9Z
         O+qv0uqvA+YkM7exO5pV0fENOIW2ZqLmEadMOXrgfVVUVJzTupnUGYp0m6BALpASl53/
         mXgx3aduYd3dwnwPi8EAHf61PVQyIbWlzpZqAhBf74zquBkpQ6WzVn4sfMPnBdVRKffZ
         mgwg==
X-Gm-Message-State: AO0yUKUvTXHzhmFkoNr8kqtdCkY+ijaVY6MPX76HGaUyK1xxTPHF5m2t
        91dEE1dSia7mqfwaPgOT6vu5Q6+HfoeUO4Wd+NM=
X-Google-Smtp-Source: AK7set/vPzdJRH7nPYS29yUfNPWdHXL+tN3TpDbmvgPN9U/TBGTZf0lkwalVaKL4nl6iXFoZJq7WVg==
X-Received: by 2002:a05:6e02:1c4d:b0:313:c32b:de26 with SMTP id d13-20020a056e021c4d00b00313c32bde26mr19822689ilg.9.1678296928570;
        Wed, 08 Mar 2023 09:35:28 -0800 (PST)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id b9-20020a05663801a900b003de9c6a73edsm5127175jaq.169.2023.03.08.09.35.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 09:35:27 -0800 (PST)
Received: by mail-il1-f170.google.com with SMTP id j8so5987121ilf.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 09:35:27 -0800 (PST)
X-Received: by 2002:a05:6e02:ca6:b0:315:4c21:a377 with SMTP id
 6-20020a056e020ca600b003154c21a377mr9109185ilg.6.1678296927307; Wed, 08 Mar
 2023 09:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20230224070506.4157738-1-saravanak@google.com>
 <20230224070506.4157738-3-saravanak@google.com> <CAD=FV=WaWmHDX0FVH1KO7b_QDM9xxt86q60MGOtPVVvGZJ+t7A@mail.gmail.com>
 <CAGETcx_2f4atf-bpvj3o5FVcWrsbJRuY_Kwu5_NU6ESbNM8MFQ@mail.gmail.com>
In-Reply-To: <CAGETcx_2f4atf-bpvj3o5FVcWrsbJRuY_Kwu5_NU6ESbNM8MFQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Mar 2023 09:35:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Uv0JZDZ4adVkXN=Wkkv+N2EXnBsREx-bHyeeefYc4s6A@mail.gmail.com>
Message-ID: <CAD=FV=Uv0JZDZ4adVkXN=Wkkv+N2EXnBsREx-bHyeeefYc4s6A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] driver core: Make state_synced device attribute writeable
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 3, 2023 at 4:53=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> > > --- a/drivers/base/base.h
> > > +++ b/drivers/base/base.h
> > > @@ -164,6 +164,14 @@ static inline int driver_match_device(struct dev=
ice_driver *drv,
> > >         return drv->bus->match ? drv->bus->match(dev, drv) : 1;
> > >  }
> > >
> > > +static inline void dev_sync_state(struct device *dev)
> >
> > IMO don't force inline. The compiler is probably smarter than you. I
> > could even believe that it might be more optimal for this rarely
> > called function to be _not_ inline if it kept the kernel smaller. I
> > guess that means moving it out of the header...
>
> I'm following the style of every other function in the .h file.

Right, that's why I suggested moving it out of the .h file. I see
plenty of non-inline function definitions in the header file.

-Doug
