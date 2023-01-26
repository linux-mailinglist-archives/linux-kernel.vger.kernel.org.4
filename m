Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6867C5C0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjAZIbK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Jan 2023 03:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjAZIbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:31:08 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AD15E524
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:31:03 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id h10so973419qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=to+fldf5qEU+Y7LXRvwtu7CdGLcmlM0u1zfd5smQEg4=;
        b=omzVyMxzspu8M6Q3RfDiy875M8EuwkEvYU1/y1BTDiOTE+Q5m+lZdN0V9f+HYYK83X
         T2+SFXQm/zDUBXCoGhrLbks7scdr1Ptcosul4fiHildTKJ8iOVty5W6g5Q1is4YbWPba
         fOlPUwD+CB2LJLhHThhAMLwNXrnrR5UvzZKk5gSYFGHZZKiuNPBVuk8t3234+8mBpxLf
         loH7qZ44XLKK3GI87kmJ+nvnuZxt/kUJVA+UT9soUzKSrD7inBnT6K/+GoNMwlLhgK3o
         zEG/Jn30xU93NTPIvy859ENFFR/I2kEerfOFwiFiMnTBnWDQ7jbRndxyjfGeoOJJ5Coz
         Cx7g==
X-Gm-Message-State: AFqh2kr2FlOssoAsE9RjJ0k2j72TWy3HUNcSrK6EWU6V5ufe/dJB6XmW
        5ISeXOG7dDR5bjnABr4uvC8ZzogLuB5YLg==
X-Google-Smtp-Source: AMrXdXvzh5dwLy/QyZFiq8kEZVNFXOeAmMHWfBXKqNW6zSdw2QU6c4WAqKJztZidNmfJFDEqgAcUTw==
X-Received: by 2002:a0c:ef01:0:b0:535:53eb:d1cc with SMTP id t1-20020a0cef01000000b0053553ebd1ccmr34096063qvr.6.1674721862812;
        Thu, 26 Jan 2023 00:31:02 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id i1-20020a37b801000000b00702d1c6e7bbsm507566qkf.130.2023.01.26.00.31.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 00:31:02 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5063029246dso13783337b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:31:02 -0800 (PST)
X-Received: by 2002:a81:68c4:0:b0:506:6059:e949 with SMTP id
 d187-20020a8168c4000000b005066059e949mr693905ywc.502.1674721861951; Thu, 26
 Jan 2023 00:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20230125083248.1305270-1-victor.liu@nxp.com> <CAMuHMdU0KaRyP0qxJLwit1G=7zMr1k5wpCkG-wD31958mrKRWg@mail.gmail.com>
 <7c84cbd1808dc89f9ddaece13f846c4fbd12935a.camel@nxp.com>
In-Reply-To: <7c84cbd1808dc89f9ddaece13f846c4fbd12935a.camel@nxp.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Jan 2023 09:30:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWCBNctQq8Bg0DQFC-Ap_JRzoMtAFozfaB1OssE7Lr6Bg@mail.gmail.com>
Message-ID: <CAMuHMdWCBNctQq8Bg0DQFC-Ap_JRzoMtAFozfaB1OssE7Lr6Bg@mail.gmail.com>
Subject: Re: [PATCH] driver: bus: simple-pm-bus: Add Freescale i.MX8qm/qxp CSR
 compatible strings
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-imx@nxp.com, Rob Herring <robh@kernel.org>,
        Lee Jones <lee@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

On Thu, Jan 26, 2023 at 3:55 AM Liu Ying <victor.liu@nxp.com> wrote:
> On Wed, 2023-01-25 at 10:05 +0100, Geert Uytterhoeven wrote:
> > On Wed, Jan 25, 2023 at 9:31 AM Liu Ying <victor.liu@nxp.com> wrote:
> > > Freescale i.MX8qm/qxp CSR module matches with what the simple power
> > > managed bus driver does, considering it needs an IPG clock to be
> > > enabled before accessing it's child devices, the child devices need
> > > to be populated by the CSR module and the child devices' power
> > > management operations need to be propagated to their parent
> > > devices.
> > > Add the CSR module's compatible strings to simple_pm_bus_of_match[]
> > > table to support the CSR module.
> > >
> > > Suggested-by: Rob Herring <robh@kernel.org>
> > > Suggested-by: Lee Jones <lee@kernel.org>
> > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> >
> > Thanks for your patch!
>
> Thanks for your review!
>
> >
> > > ---
> > > The CSR module's dt-binding documentation can be found at
> > > Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> > >
> > > Suggested by Rob and Lee in this thread:
> > >
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20221017075702.4182846-1-victor.liu%40nxp.com%2F&data=05%7C01%7Cvictor.liu%40nxp.com%7C3fa98ff270534078019508dafeb34b10%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638102343312884116%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=zm8Z5gWt9yGXakYlxopUfZKLMUJRWTxq1kWHLyqhyww%3D&reserved=0
> > >
> > >  drivers/bus/simple-pm-bus.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-
> > > bus.c
> > > index 7afe1947e1c0..4a7575afe6c6 100644
> > > --- a/drivers/bus/simple-pm-bus.c
> > > +++ b/drivers/bus/simple-pm-bus.c
> > > @@ -120,6 +120,8 @@ static const struct of_device_id
> > > simple_pm_bus_of_match[] = {
> > >         { .compatible = "simple-mfd",   .data = ONLY_BUS },
> > >         { .compatible = "isa",          .data = ONLY_BUS },
> > >         { .compatible = "arm,amba-bus", .data = ONLY_BUS },
> > > +       { .compatible = "fsl,imx8qm-lvds-csr", },
> > > +       { .compatible = "fsl,imx8qxp-mipi-lvds-csr", },
> >
> > I did read the thread linked above, and I still think you should just
> > add "simple-pm-bus" to the compatible value in DTS, so no driver
> > change
> > is needed, cfr.
> > Documentation/devicetree/bindings/bus/renesas,bsc.yaml.
>
> This means that i.MX8qm/qxp CSR module dt-binding documentation needs
> to be changed.  I'd like to know how Rob and Krzysztof think about
> that.
>
> >
> > If that doesn't work due to DT binding constraints, the latter should
> > be fixed.
>
> Adding "simple-pm-bus" to the compatible value in DTS doesn't work,
> because "simple-mfd" is matched first and "ONLY_BUS" is set for

Is that because you have both "simple-mfd" and "simple-pm-bus",
and the former is listed first in DTS?
Does it work if you change the order?

> "simple-mfd".  s/simple-mfd/simple-pm-bus/ for the compatbile value in
> DTS does work, but it means that fsl,imx8qxp-csr.yaml needs to be
> changed and moved from mfd directory to bus directory...

BTW, originally I didn't want to introduce "simple-pm-bus" at all,
and make it just call pm_runtime_enable() for "simple-bus" (PM is
everywhere anyway), but that was rejected...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
