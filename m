Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D455D680730
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbjA3IPT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Jan 2023 03:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbjA3IO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:14:57 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8012D40FD;
        Mon, 30 Jan 2023 00:14:32 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id v19so9293201qtq.13;
        Mon, 30 Jan 2023 00:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7fRCUm0+mZO3MCq7UV1u68gA0oeT47CFJL7j8NId5w=;
        b=2aDR+DwiUzqjMunc+lmZBi+RQ2xoxHoCht5Go9tUExVLBEREjr0CLgARAlGAMEq/Qg
         wWiRcIUpwTFaW7qrtjMLaHKWEiTYssTB4KVhHqFQ6eEHRyt4eV/CquPf5Or8VN4qtpMY
         8vxG/lUmvp/8/hS4IDcnFkXQNyPZb73P1X6FU64y7/t9Qxmi4w18SjbT7HtiVcgfRwkB
         /yIYZfWcD4GlbyocanASGOP0VXB5MBzPksOMAnAEN6vferlWYL/aO7zLnOhQQBkP/cIy
         xQWS9QZE71D8GhfHzqetTn8VttJHYdNdzQ4DGa4Mi9SCou9CF0SNRz8iJM6yen6GT/Xu
         ulYw==
X-Gm-Message-State: AO0yUKXfveuehQQ81Rl5bJtIvQnukhxfoBP/HApxjk0ij4YUFoWGdDIb
        iSb9o5xsje0B6OEvkGfrpbiGG2MT5/SYkw==
X-Google-Smtp-Source: AK7set9p6MOJaaS8bGYs1SSSRPJX0c1E2QNeCvSd3cVTl4vePgOiOrxi/cYJUx/vjMpu+dmKn5Lxcw==
X-Received: by 2002:a05:622a:83:b0:3b8:629e:afd9 with SMTP id o3-20020a05622a008300b003b8629eafd9mr7154646qtw.17.1675066412900;
        Mon, 30 Jan 2023 00:13:32 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id p74-20020a37424d000000b0071a5dbcafbfsm4816787qka.29.2023.01.30.00.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 00:13:32 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id m199so13018180ybm.4;
        Mon, 30 Jan 2023 00:13:32 -0800 (PST)
X-Received: by 2002:a25:e650:0:b0:80b:8b72:39fc with SMTP id
 d77-20020a25e650000000b0080b8b7239fcmr1827613ybh.202.1675066412208; Mon, 30
 Jan 2023 00:13:32 -0800 (PST)
MIME-Version: 1.0
References: <20230125083248.1305270-1-victor.liu@nxp.com> <CAMuHMdU0KaRyP0qxJLwit1G=7zMr1k5wpCkG-wD31958mrKRWg@mail.gmail.com>
 <7c84cbd1808dc89f9ddaece13f846c4fbd12935a.camel@nxp.com> <eea19462-8dfa-8e10-2638-70f6f1ecc193@linaro.org>
 <2d06468ab1274af3c84e61dbca8d172b9d64cd68.camel@nxp.com> <f551d663-f7b6-5ae3-89a9-af1ae0d6216e@linaro.org>
In-Reply-To: <f551d663-f7b6-5ae3-89a9-af1ae0d6216e@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Jan 2023 09:13:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV0EJP5UXri3phWsCDRaoXuB=ZWK=ibwd6i-V=9f_bLkA@mail.gmail.com>
Message-ID: <CAMuHMdV0EJP5UXri3phWsCDRaoXuB=ZWK=ibwd6i-V=9f_bLkA@mail.gmail.com>
Subject: Re: [PATCH] driver: bus: simple-pm-bus: Add Freescale i.MX8qm/qxp CSR
 compatible strings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liu Ying <victor.liu@nxp.com>, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-imx@nxp.com,
        Rob Herring <robh@kernel.org>, Lee Jones <lee@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun, Jan 29, 2023 at 11:49 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 29/01/2023 09:13, Liu Ying wrote:
> > On Thu, 2023-01-26 at 13:45 +0100, Krzysztof Kozlowski wrote:
> >> On 26/01/2023 03:54, Liu Ying wrote:
> >>> On Wed, 2023-01-25 at 10:05 +0100, Geert Uytterhoeven wrote:
> >>>> On Wed, Jan 25, 2023 at 9:31 AM Liu Ying <victor.liu@nxp.com>
> >>>> wrote:
> >>>>> Freescale i.MX8qm/qxp CSR module matches with what the simple
> >>>>> power
> >>>>> managed bus driver does, considering it needs an IPG clock to
> >>>>> be
> >>>>> enabled before accessing it's child devices, the child devices
> >>>>> need
> >>>>> to be populated by the CSR module and the child devices' power
> >>>>> management operations need to be propagated to their parent
> >>>>> devices.
> >>>>> Add the CSR module's compatible strings to
> >>>>> simple_pm_bus_of_match[]
> >>>>> table to support the CSR module.
> >>>>>
> >>>>> Suggested-by: Rob Herring <robh@kernel.org>
> >>>>> Suggested-by: Lee Jones <lee@kernel.org>
> >>>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>

> >>>>> The CSR module's dt-binding documentation can be found at
> >>>>> Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> >>>>>
> >>>>> Suggested by Rob and Lee in this thread:

> >>>
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20221017075702.4182846-1-victor.liu%40nxp.com%2F&data=05%7C01%7Cvictor.liu%40nxp.com%7C87515adc8fc3401f410808daff9b3279%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638103339276325657%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=FFz5gSIPc6vyvb1IJ1Umu62WpzjNLIiQIi2sOA3RQGc%3D&reserved=0
> >>>>>
> >>>>>  drivers/bus/simple-pm-bus.c | 2 ++
> >>>>>  1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-
> >>>>> pm-
> >>>>> bus.c
> >>>>> index 7afe1947e1c0..4a7575afe6c6 100644
> >>>>> --- a/drivers/bus/simple-pm-bus.c
> >>>>> +++ b/drivers/bus/simple-pm-bus.c
> >>>>> @@ -120,6 +120,8 @@ static const struct of_device_id
> >>>>> simple_pm_bus_of_match[] = {
> >>>>>         { .compatible = "simple-mfd",   .data = ONLY_BUS },
> >>>>>         { .compatible = "isa",          .data = ONLY_BUS },
> >>>>>         { .compatible = "arm,amba-bus", .data = ONLY_BUS },
> >>>>> +       { .compatible = "fsl,imx8qm-lvds-csr", },
> >>>>> +       { .compatible = "fsl,imx8qxp-mipi-lvds-csr", },
> >>>>
> >>>> I did read the thread linked above, and I still think you should
> >>>> just
> >>>> add "simple-pm-bus" to the compatible value in DTS, so no driver
> >>>> change
> >>>> is needed, cfr.
> >>>> Documentation/devicetree/bindings/bus/renesas,bsc.yaml.
> >>
> >> I don't think we want to start putting specific compatibles here. We
> >> don't do it for simple-mfd, syscon and simple-bus, so neither should
> >> we
> >> do it here.
> >>
> >>> This means that i.MX8qm/qxp CSR module dt-binding documentation
> >>> needs
> >>> to be changed.  I'd like to know how Rob and Krzysztof think about
> >>> that.
> >>
> >> The fsl,imx8qxp-csr.yaml bindings are broken anyway... You have
> >> device
> >> specific bindings for non-simple device but use simple-mfd. You
> >> cannot.
> >> simple-mfd means it is simple and none of the resources are needed
> >> for
> >> children, but that binding contradicts it.
> >>
> >> Now you kind of try to extend it even more make it more and more
> >> broken.
> >>
> >> Rework the bindings keeping them backwards compatible. The
> >> combination
> >> with simple-mfd should be deprecated and you can add whatever is
> >> needed
> >> for a proper setup.
> >
> > I did try to rework the bindings and make the combination with simple-
> > mfd deprecated. However, it reminds me the problem that "simple-pm-bus"
> > and "syscon" can not be in compatible string at the same time,
> > otherwise, nodename should match '^syscon@[0-9a-f]+$' and '^bus@[0-9a-
> > f]+$' at the same time. I mentioned the problem in the same thread[1]
> > where Rob and Lee suggest to go with this patch. "syscon" is needed
> > since i.MX8qxp MIPI DSI/LVDS combo PHY node references the CSR module
> > through a phandle, so dropping/deprecating "syscon" is a no-go.
> >
> > Also, as Rob mentioned in [1] "if register space is all mixed together,
> > then it is the former and an MFD", I think the CSR module should fall
> > into the simple-mfd category.
>
> You are now mixing MFD with simple-mfd. If you have clocks there or any
> other resources, it's not simple-mfd anymore.

I beg to differ (but not w.r.t. the other resources): if any "glue" device
between parent and child hierarchies does not call pm_runtime_enable(),
Runtime PM (which is a Linux thing, not a DT thing) for the children
may not work correctly, as it won't propagate correctly to the parent.
So IMHO this is something to fix in Linux, not in DT.

> > Take i.MX8qxp MIPI DSI/LVDS CSR module as
> > an example, child device pxl2dpi register offset is 0x40, while child
> > device ldb register offsets are 0x20 and 0xe0.
> >
> > Geert, Krzysztof, can you please consider to keep this patch as-is,
> > since it seems that there is no other option?
>
> There are other options, why do you say there is no? Making it proper
> binding/driver for its children without abusing simple bindings. Simple
> bindings are for simple cases and this turns out not the simple case.

Or drop the ".data = ONLY_BUS" for "simple-mfd"?
(and treat "simple-bus" the same as "simple-pm-bus", too ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
