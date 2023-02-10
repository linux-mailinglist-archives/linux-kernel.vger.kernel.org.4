Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A376927A0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjBJUHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjBJUHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:07:50 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51123749AD;
        Fri, 10 Feb 2023 12:07:49 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s8so4438150pgg.11;
        Fri, 10 Feb 2023 12:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xOCx+0IpO09UJU1o2QCYZhqkoYTOSv9XlPmo1vQD37k=;
        b=EsbKmjalrU7uSoty7Rw58cUoNc6YIFB8IJnhUx0n9VykuPw79zfXMBkrYfqGdbkGjT
         yCzOHegsGhEW1Vd1CcSBnTX3SOiXQaZQw6OPhTOttCIODE8IcF+1dCHbjHt/Py94fyFm
         jxnnXgMHB30o7KQpScrG9ptY/FTiMa/hY+oTUCU3HuLLncb1jJTHfgipew/uadMmm0E3
         77U0CxE5UHvSZWj1OToilsR3BcKc3w78XeSWmGMVd02wAC4K3UtR/dgVJ+Aej8urnwNp
         LYq+7a4QlIJYk0xIM2KLxzKul1cIweH8vdYV/OwZwLrM1NE7NVDFO0IVeC6N3RneVmGV
         zDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOCx+0IpO09UJU1o2QCYZhqkoYTOSv9XlPmo1vQD37k=;
        b=4CY6Kr7ktYVOWL6x2ioJ/NXgCXc0W31+EOLI+Fy4/sO8PjUjgtTlkAfOIgAIlsDI7d
         D4NZyqWYFnHfk6rGS+TU5fraOWVzjTrjQoOGF7GwQaANaKtZ8YAhPgKNGFNIpO3vspjN
         qb3uv+qv/vK3CkZFx+9ksDAohAydXFlNpeIhvF15I6Lk1hFWDToGe6B9aBh3GUUAEENK
         DGHfs1gs1Y1S/DAJc8xIwORxbkjI6vI3d6gYbHJBZCPLQLxEmCVxplpItUllG3mJVUty
         1hBwk/cfNdbA5aHlgdH7JXhd4f4+zDZktQ0zRYGr8KzwdF0FZqp2KGNnw3aZ9f8fIz/9
         +9pA==
X-Gm-Message-State: AO0yUKUwUkmYena7qFEIA1NRyNA3y+QJ/PjRKq2LSgPJCROj/FnA9rV5
        udh3hKRwkScUli0Ykjv+SEqTQbUAyseKkq/Rp7M=
X-Google-Smtp-Source: AK7set8royKT2mfJHugBCuD7Uni7PKE5aqLVmGuXuXS0TxIyvCzQNsU9flfKl7JrFytOUg4Ng9XMLYAqmFeWePQ28qU=
X-Received: by 2002:a62:2903:0:b0:59d:553e:c81 with SMTP id
 p3-20020a622903000000b0059d553e0c81mr3149951pfp.51.1676059668417; Fri, 10 Feb
 2023 12:07:48 -0800 (PST)
MIME-Version: 1.0
References: <20200629201845.28138-1-ruslan.bilovol@gmail.com>
 <20200630015843.GB12443@b29397-desktop> <CAB=otbSnP7ecO9W5osxqSHSa4JRCUU4KR-g2BjBweDBUwjWobA@mail.gmail.com>
 <20200704104258.GB5695@b29397-desktop>
In-Reply-To: <20200704104258.GB5695@b29397-desktop>
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date:   Fri, 10 Feb 2023 15:07:36 -0500
Message-ID: <CAB=otbTKiJsBmAPgi4-=9vyWKFAz7Om7PrHep0xMPeDi6vJweA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: epautoconf: claim smallest endpoints first
To:     Peter Chen <peter.chen@nxp.com>, Peter Chen <peter.chen@kernel.org>
Cc:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

  for On Sat, Jul 4, 2020 at 6:42 AM Peter Chen <peter.chen@nxp.com> wrote:
>
> On 20-07-03 13:46:27, Ruslan Bilovol wrote:
> > On Tue, Jun 30, 2020 at 4:58 AM Peter Chen <peter.chen@nxp.com> wrote:
> > >
> > > On 20-06-29 23:18:45, Ruslan Bilovol wrote:
> > > > UDC hardware may have endpoints with different maxpacket
> > > > size. Current endpoint matching code takes first matching
> > > > endpoint from the list.
> > > >
> > > > It's always possible that gadget allocates endpoints for
> > > > small transfers (maxpacket size) first, then larger ones.
> > > > That works fine if all matching UDC endpoints have same
> > > > maxpacket size or are big enough to serve that allocation.
> > > >
> > > > However, some UDCs have first endpoints in the list with
> > > > bigger maxpacket size, whereas last endpoints are much
> > > > smaller. In this case endpoint allocation will fail for
> > > > the gadget (which allocates smaller endpoints first) on
> > > > final endpoint allocations.
> > > >
> > > > To make endpoint allocation fair, pick up smallest
> > > > matching endpoints first, leaving bigger ones for
> > > > heavier applications.
> > > >
> > > > Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
> > > > ---
> > > >
> > > > v2: rebased onto latest balbi/next branch
> > > >
> > > >  drivers/usb/gadget/epautoconf.c | 23 ++++++++++++++++++-----
> > > >  1 file changed, 18 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
> > > > index 1eb4fa2e623f..6c453b5d87bb 100644
> > > > --- a/drivers/usb/gadget/epautoconf.c
> > > > +++ b/drivers/usb/gadget/epautoconf.c
> > > > @@ -66,7 +66,7 @@ struct usb_ep *usb_ep_autoconfig_ss(
> > > >       struct usb_ss_ep_comp_descriptor *ep_comp
> > > >  )
> > > >  {
> > > > -     struct usb_ep   *ep;
> > > > +     struct usb_ep   *ep, *ep_min = NULL;
> > > >
> > > >       if (gadget->ops->match_ep) {
> > > >               ep = gadget->ops->match_ep(gadget, desc, ep_comp);
> > > > @@ -74,14 +74,27 @@ struct usb_ep *usb_ep_autoconfig_ss(
> > > >                       goto found_ep;
> > > >       }
> > > >
> > > > -     /* Second, look at endpoints until an unclaimed one looks usable */
> > > > +     /*
> > > > +      * Second, look at endpoints until an unclaimed one looks usable.
> > > > +      * Try to find one with smallest maxpacket limit, leaving larger
> > > > +      * endpoints for heavier applications
> > > > +      */
> > > >       list_for_each_entry (ep, &gadget->ep_list, ep_list) {
> > > > -             if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
> > > > -                     goto found_ep;
> > > > +             if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp)) {
> > > > +                     if (desc->wMaxPacketSize == 0)
> > > > +                             goto found_ep;
> > >
> > > Why you do special handling for this? You still could give the smallest
> > > maxpacket_limit EP for it, right?
> >
> > Of course it's technically possible. However in case "wMaxPacketSize == 0"
> > gadget driver wants to get maximum possible wMaxPacketSize from endpoint
> > configuration and I was thinking about avoiding regressions if we always provide
> > smaller endpoints.
>
> You may only want to change the match logic, not but the special case.
>
> Currently, it returns the first matched endpoint no matter
> "wMaxPacketSize == 0" or not. And you changed the match logic
> as returning the smallest maxPacketsize endpoint, you also don't need
> to consider whether "wMaxPacketSize == 0" or not, otherwise, it may
> introduce the complexity.
>

The reason I kept the old behavior when "wMaxPacketSize == 0" is because
it's a special case. In this case a gadget driver wants to use a whole
available MaxPacketSize of claimed endpoint. Since it doesn't know
what MaxPacketSize may be in a particular UDC endpoint, it just
relies on epautoconf core and gets what's available.
So the behavior looks like the opposite of claiming a smallest endpoint, but
rather using as big as possible MaxPacketSize provided by the endpoint.

We even may want to implement a 'claim biggest endpoint' policy for the
"wMaxPacketSize == 0" case.

Looking at gadget drivers sources, it seems there is no such usecase
in any driver (at least with simple 'grep' over sources), so I'm not sure
if we need to worry about it at all, that's why I decided to keep an old
behavior here.

Thanks
Ruslan

> >
> > As I can see, providing smallest endpoint that matches requested wMaxPacketSize
> > is OK, but if gadget driver just wants autoconf core to use it with
> > maximum possible
> > value, I'm thinking now if we can even change this part and if wMaxPacketSize
> > is zero, find endpoint with maximum possible wMaxPacketSize
> >
> > Does it make sense?
> >
> > Thanks
> > Ruslan
> >
> > >
> > > Peter
> > >
> > > > +                     else if (!ep_min)
> > > > +                             ep_min = ep;
> > > > +                     else if (ep->maxpacket_limit < ep_min->maxpacket_limit)
> > > > +                             ep_min = ep;
> > > > +             }
> > > >       }
> > > >
> > > >       /* Fail */
> > > > -     return NULL;
> > > > +     if (!ep_min)
> > > > +             return NULL;
> > > > +
> > > > +     ep = ep_min;
> > > >  found_ep:
> > > >
> > > >       /*
> > > > --
> > > > 2.17.1
> > > >
> > >
> > > --
> > >
> > > Thanks,
> > > Peter Chen
>
> --
>
> Thanks,
> Peter Chen
