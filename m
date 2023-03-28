Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A8C6CC9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjC1RzO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Mar 2023 13:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjC1RzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:55:12 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16786114;
        Tue, 28 Mar 2023 10:55:06 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id eg48so52975483edb.13;
        Tue, 28 Mar 2023 10:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680026104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zM4djXyeY54M5VkLAl8JUHt2hpd0bXhVxLFdkufkV9o=;
        b=UtAKrpjz7YFvGG2TbaA2Pttf9zL9cU5gYd81nieRUFGJrO9ZQlh0dNZp7AVWfwpNUv
         3Nv9+inVC57pHb2AeLNnPN0PoVn/Pc7+GfoFuBJNpqIQIk907EIwxstRKa9KpzOtw+Nw
         2+VXCHq5RlurmFjUqCby6bMKgd4Zzuf4gJ4YMC1mIV43ZSaztt21rblB4ndBjUPxLCiF
         Fobn4dkPjVZBHX77imJCE1kHbl2X2R4oB5FVGVtYqdCLxkV9g5+oKGYHQ//gC+tDT/t7
         n5kpqZ9c4ADXPZstzaPKybkLzxK33d9KFab+2rnn8B8pMkTmVnvD2u8BMaqY0NCY5qoD
         05pg==
X-Gm-Message-State: AAQBX9eDopD51t4OSAtmHJiKvJiXKumSQzJBGa0CUTmjM3sYz7d7PSYT
        bSb6QAs0CeyvIkZ/wqVKs76ATUaTkIvdzYMzr7Q=
X-Google-Smtp-Source: AKy350b9Z4GwCR8srptBUVQbgwRAwz0E8DIrura3Ims79FFh250KZIsb1mu7c9SmmLZVZrfKNgoDfIv5nVr96OoH/5g=
X-Received: by 2002:a17:907:d02:b0:931:6921:bdbb with SMTP id
 gn2-20020a1709070d0200b009316921bdbbmr7903400ejc.2.1680026104457; Tue, 28 Mar
 2023 10:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230324070807.6342-1-rui.zhang@intel.com> <20230324070807.6342-2-rui.zhang@intel.com>
 <CAJZ5v0gze1wBEMcuEu4Aa9343rh-3=Bu+pdSYuY3stMd8QGf0A@mail.gmail.com>
 <528f7e58507df4b6137856828e371bb8913b8b59.camel@intel.com>
 <CAJZ5v0gL_7VPdcgkmuTz=afYSbGsWZi5wW9vUvyAgverjxsNdw@mail.gmail.com> <ba48eb3b3f4b82d33faa9233dc151f65d6380ed7.camel@intel.com>
In-Reply-To: <ba48eb3b3f4b82d33faa9233dc151f65d6380ed7.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Mar 2023 19:54:53 +0200
Message-ID: <CAJZ5v0h6PX8EmPtVKbPPG+e0FZn53CGG=RvpOH-vuO0fNF6-=g@mail.gmail.com>
Subject: Re: [PATCH 2/5] thermal/core: Reset cooling state during cooling
 device unregistration
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 4:46 AM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Mon, 2023-03-27 at 17:13 +0200, Rafael J. Wysocki wrote:
> > On Mon, Mar 27, 2023 at 4:50 PM Zhang, Rui <rui.zhang@intel.com>
> > wrote:
> > > On Fri, 2023-03-24 at 14:19 +0100, Rafael J. Wysocki wrote:
> > > > On Fri, Mar 24, 2023 at 8:08 AM Zhang Rui <rui.zhang@intel.com>
> > > > wrote:
> > > > > When unregistering a cooling device, it is possible that the
> > > > > cooling
> > > > > device has been activated. And once the cooling device is
> > > > > unregistered,
> > > > > no one will deactivate it anymore.
> > > > >
> > > > > Reset cooling state during cooling device unregistration.
> > > > >
> > > > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > > > ---
> > > > > In theory, this problem that this patch fixes can be triggered
> > > > > on a
> > > > > platform with ACPI Active cooling, by
> > > > > 1. overheat the system to trigger ACPI active cooling
> > > > > 2. unload ACPI fan driver
> > > > > 3. check if the fan is still spinning
> > > > > But I don't have such a system so I didn't trigger then problem
> > > > > and
> > > > > I
> > > > > only did build & boot test.
> > > >
> > > > So I'm not sure if this change is actually safe.
> > > >
> > > > In the example above, the system will still need the fan to spin
> > > > after
> > > > the ACPI fan driver is unloaded in order to cool down, won't it?
> > >
> > > Then we can argue that the ACPI fan driver should not be unloaded
> > > in
> > > this case.
> >
> > I don't think that whether or not the driver is expected to be
> > unloaded at a given time has any bearing on how it should behave when
> > actually unloaded.
> >
> > Leaving the cooling device in its current state is "safe" from the
> > thermal control perspective, but it may affect the general user
> > experience (which may include performance too) going forward, so
> > there
> > is a tradeoff.
>
> Right.
> If we don't have a third choice, then the question is simple.
> "thermal safety" vs. "user experience"?
>
> I'd vote for "thermal safety" and drop this patch series.

Works for me.

> > What do the other cooling device drivers do in general when they get
> > removed?
>
> No cooling device driver has extra handling after cdev unregistration.

However, the question regarding what to do when the driver of a
cooling device in use is being removed is a valid one.

One possible approach that comes to mind could be to defer the driver
removal until the overheat condition goes away, but anyway it would be
better to do that in the core IMV.
