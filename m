Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEC65FAE0B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJKIJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJKIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:09:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65537C1F0;
        Tue, 11 Oct 2022 01:09:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r17so29634913eja.7;
        Tue, 11 Oct 2022 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xEo5FAiJ5ryxNni4NJfPr0NCIofnz7A8T7tCrFu2mvM=;
        b=Sa3dBB4jU4zCPvr8UhRy2aAe+rluLqQlUYTPkXXdKzAgcccJ5hhMC1lhadZusxRFLM
         bcsBEKqNO3gZzJgqg+fNgvzcV05SqsIbXLXz8iBOTG9maFZXwsbwOIp/auYwsad/J5S6
         FC6m7uZL9OZb/krLZWXRB/4MaaRaMAPYxBc9dWgOifllGr+v7EOz3WFRv0hPLC98mIC1
         ZLzER/kuRt7ai+xcpJuv03JIOUyTZSjaH1WI2JzDrYOFRKLqDL+pXqa5wC4XWJ11arIs
         xQmcofyWH7hJ38S4YbDqjwCRV7xBMxlsJ2hcyZ+tyVw9NroafqOngaEwjmjIc/vKDPZr
         M38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEo5FAiJ5ryxNni4NJfPr0NCIofnz7A8T7tCrFu2mvM=;
        b=rB6MTpObrF046xjQBiOdjkneO+zm8kLxpTiYMSQTqfiprN+rR2WFlyh7sbqSSrUa+4
         qzvqiYEhxnj3OCBwt09aPkM6/mXXkxNnbNyk92OjsCT4DLXrf1xl9c7eH4YgC4xAotQ7
         ahicG4iAC6gbfeWPmPUWMekEYxI11RgHWFfgVa0KurEdy8EkAxdyWSvMWR2B1lfBmygi
         E1bgYOn6n36GprsfBBdZYegxLsNdyRKrnuAtkwbo1u+xvTWc2s/anec6oBJz4NGU2uKG
         P+H3HWt+8boLehZo3icCcbYY7MZg4eT1IY2c4TG/IvjyIMEyVVRgLz/V/Zgviz0TwOne
         bLRQ==
X-Gm-Message-State: ACrzQf1YgBukHvKtYJyG5IYtz+4YGlLVDp7k7ztgdJO53u9tekFUR68q
        g4Cv5x/dsbNEG++cZBuGxBs6BvpG4hbYjVu2hVg=
X-Google-Smtp-Source: AMsMyM5Q8yyk1yxjqvo1cFzc1OcSlUWuBGJnyL6utMYaBROEZ3KTIHBO9Bra8WjCbiVO0hc1e6DSztORCgsOtULUjUg=
X-Received: by 2002:a17:907:75dc:b0:78b:339:63c7 with SMTP id
 jl28-20020a17090775dc00b0078b033963c7mr17803599ejc.480.1665475772343; Tue, 11
 Oct 2022 01:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220927201634.750141-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8vQce5+my5nQr=CiJf9KtuHgzmt18PT1kwp9Nq8ADHYFw@mail.gmail.com> <Y0UjCitXWh5tHQG7@paasikivi.fi.intel.com>
In-Reply-To: <Y0UjCitXWh5tHQG7@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 11 Oct 2022 09:09:06 +0100
Message-ID: <CA+V-a8tZ_e=f=G27Fisp8tfHG98OhC_dt5EGtqq0zq==fanNDg@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: ov5645: Use runtime PM
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Tue, Oct 11, 2022 at 9:02 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> On Mon, Oct 10, 2022 at 09:04:22PM +0100, Lad, Prabhakar wrote:
> > Hi,
> >
> > On Tue, Sep 27, 2022 at 9:16 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > >
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Switch to using runtime PM for power management.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  drivers/media/i2c/Kconfig  |   2 +-
> > >  drivers/media/i2c/ov5645.c | 135 +++++++++++++++++++------------------
> > >  2 files changed, 69 insertions(+), 68 deletions(-)
> > >
> > I know it's too early, but I dont want to miss the v6.2 window for
> > RZ/G2L CRU driver [0].
> >
> > Gentle ping for review.
>
> I'll check the patch now but will apply once we have -rc1 in media tree.
>
Thanks!

Cheers,
Prabhakar
