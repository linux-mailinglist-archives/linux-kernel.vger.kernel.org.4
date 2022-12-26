Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6086562F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 14:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiLZNy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 08:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiLZNyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 08:54:24 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D184026B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 05:54:23 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id a64so6794413vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 05:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C69dvC4LnTBwydvtx1x0cjfrCfE5thwsIPOI8FCmf/I=;
        b=efPiEsaOAjyrB8MDmrb//kHs0eNEJGSM7TuvKQgMQHtSqdaocptPdAsP1uzjUlNqHh
         10a9dKbeihq19n28jiVGJRug5rPSQYr5w9Wqvxfat2V8Xjh55zU+iDXF7Li12IQZdMdo
         l+cJ6lqqNDE5qxJivDCRvxoCiG6nyrxzmDzV4XL8QeByNARlf+iI6rFWDZIMYXIDVftQ
         pbX2H0Z3R60k3ZN5FtGbfSVvIV2fbMcqCAHE/4oRia/aAG2n2++kM8hIBoOMTx1ZMlqJ
         3Gk4dJVdG6+W1NQwfjXvAn6G+F0PzlukHZjJhd4SBQlo8SswDTXnO5V74WTgG0ctQ1rb
         d21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C69dvC4LnTBwydvtx1x0cjfrCfE5thwsIPOI8FCmf/I=;
        b=eR7vvQcNNxb1dckWUBrYGeTxtXBUl5YUdOuj8dfy9o3jrc2PK1O2MWsQEhqP33g3H/
         gijlMRVtcFXMxnVSG7kkZOfQt9+can3pcoijrio/qfKWbJ5fmT/YW5GPyD0XCeE3QMqQ
         Tytz1p9gAzf0/gFH2mihLG8/zE4MUJw4F9ezn3+zvVvNBVZ79umQyYop9HCui4BvKzcy
         hzGZYqzJ901tDGIp4jRoa2vtfRg05EvLtnIp+nBYelqtzp3Wewap0zOhoP6tnE5o4m6X
         uiyYZqSjUxiPCE17oels1aznAJpTbabGL0dbjqon0g4A9KDziW+dzfRQeFn1mD5I8uDS
         S0/Q==
X-Gm-Message-State: AFqh2ko2B8mtvr8qQunS0LpmV288nkuHqnn/mZRTGVhjynkZ3F4WZ6wt
        DWh6QtAkPznh9tLMnU/O9PR6W/vK0Nma5Z8daVU+K4FzcQL11g==
X-Google-Smtp-Source: AMrXdXve5YCsV+fuWeMxEzYvNqxvwpmIIRnVS6PQurjDOFfXsd5goBkV3sgT6rFwqPN9+IVCFFcIGqJ8zhnt67BJoGE=
X-Received: by 2002:a67:2204:0:b0:3b5:2762:568b with SMTP id
 i4-20020a672204000000b003b52762568bmr2131805vsi.62.1672062862895; Mon, 26 Dec
 2022 05:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20221222185049.737625-1-cristian.marussi@arm.com>
 <CAFA6WYP++tYORr+-EDPF1EKakwJHaH+_WFq8kzWY-UU3yQJ7Gg@mail.gmail.com> <Y6WS9/dmeGpS7wqV@e120937-lin>
In-Reply-To: <Y6WS9/dmeGpS7wqV@e120937-lin>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 26 Dec 2022 19:24:11 +0530
Message-ID: <CAFA6WYNA22OHXXXOUF_KOmXJmkEBAFZrHxmOgA0zYbo5dMc3ag@mail.gmail.com>
Subject: Re: [PATCH 0/9] Rework SCMI initialization and probing sequence
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, Ludvig.Parsson@axis.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2022 at 17:07, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Fri, Dec 23, 2022 at 11:06:29AM +0530, Sumit Garg wrote:
> > On Fri, 23 Dec 2022 at 00:22, Cristian Marussi <cristian.marussi@arm.com> wrote:
> > >
> > > Hi,
> > >
> > > under some configurations the SCMI core stack, which is now initialized
> > > as a whole at the subsys_initcall level, can be dependent on some other
> > > Kernel subsystems (like TEE) when some SCMI transport backend like optee
> > > is used.
> >
> > Thanks Cristian for the rework, but this doesn't seem to address
> > reluctance to carry forward the DT legacy (see [1]).
> >
> > TLDR, it has led to misrepresentation of OP-TEE transport as follows:
> >
> >     First represented as a platform device via DT (compatible =
> > "linaro,scmi-optee";) and then
> >     Migrated to being a TEE bus device (UUID: 0xa8cfe406, 0xd4f5,
> > 0x4a2e, 0x9f, 0x8d, 0xa2, 0x5d, 0xc7, 0x54, 0xc0, 0x99)
> >
> > Do we really need to have a platform device for every SCMI transport?
> >
> > [1] https://lore.kernel.org/lkml/CAFA6WYPwku8d7EiJ8rF5pVh568oy+jXMXLdxSr6r476e0SD2nw@mail.gmail.com/
> >
>
> Hi Sumit,
>
> thanks for the feedback first of all.
>
> This series represents really a long standing point on my todo-list and it
> is meant to start addressing/reviewing the whole SCMI stack init/probe
> sequencing and transports setup while taking the chance/opportunity to
> fix the issue reported by Ludvig.
>
> The natural next step in my (and Sudeep) view would be to split out the SCMI
> transports too into proper full fledged drivers, that can be probed by their
> own susbsys eventually (when possible) and that will then register with the
> SCMI core as available transports; so that we can avoid some of the cruft
> when multiple backend subsystems are involved...
>
> ...it is just that I have NOT dug deep into this further evolution and I did
> NOT want to do it in this series, but just starting laying out some basic rework
> toward this direction while fixing Ludvig issue. (... also because there are a
> lot of bit and pieces to get right in SCMI around protocols/modules and DT
> parsing and I was trying not to break too many things at a time :P...)
>
> Anyway, even in the perspective of the above possible evolution into full
> fledged drivers, I doubt that we can get rid completely of the DT based
> per-transport platform devices since their DT nodes can carry a bit of
> transport related information (even for auto-discoverable transport I think)
>
> ...it will just be that such devices, bound to the compatibles, will be used
> probably in a different way (also for backward compatibility with DT
> bindings...)...indeed...such platform devices now DO carry some information
> about the underlying transport to use BUT most of all they represent also
> an SCMI platform instance, so that will not definitely go away completely,
> it will just loose most of the transport related functionalities
>
> ..but... as said...I have not dived too much into this further evolution so
> I maybe wrong here on the details... anyway the plan going further, as spoken
> also with Sudeep offline, could/should be that depicted above.
>
> Not sure if this answers all of your questions but I'll keep you posted
> on this series and next evolutions...

Thanks for the detailed clarification. I don't have the deep insights
regarding how SCMI subsystem works but generally dealing with a device
being probed on multiple buses is prone to system integration problems
such as:

- Is the device present on the platform bus (in DT)? Is the device
present on a discoverable bus (eg. TEE bus)?
- Do both buses represent synchronised device views? IOW, version skew problems.

I hope we should be able to address those with the evolution you are planning.

-Sumit

>
> Thanks,
> Cristian
