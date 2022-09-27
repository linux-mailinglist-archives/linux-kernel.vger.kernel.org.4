Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD77B5EC0E4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiI0LRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiI0LR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:17:27 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693EA647E4;
        Tue, 27 Sep 2022 04:16:44 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id r20so5739559qtn.12;
        Tue, 27 Sep 2022 04:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FUKUzwHmRfNLiY0NPzyc3tn/CTu6dcDHzrfQc+oavds=;
        b=P2vwIehLml7xk7K4P9Br5smkdU2acViSAl+noQlc+mmgw89+/DjLCTomPRlzgu0M3Z
         YMPROhrZq6XO8IoRUvhZ7a9yp34foYGmrM+K6pILJvRgn2bt1rAaEemInVbq6OLkPJrE
         8EB4gPPnIchZ/2q2MB2wbDk9JTYbw1Z8Llkr4F6h4UjL8ioSvZpkuc2c8YPMD0+NmhkI
         KEDhM2H60N9lUOTtQTFcZFxvaU+yYjhCMJFoZR6BeYxhQGlD6DCd+E2KRyF8gngbVtHR
         y36LRFTqOtvMPwzYKzSMJubrm9O6PKQ4gyu7gR876Pp+YtnPcYQvJ1KAVQJUs3VVMMal
         7onA==
X-Gm-Message-State: ACrzQf2IhiMVZB3Kn5URJs/3KO5kxRBBHVhaUB6IrBUbSN97s28esMJ0
        RYVjhZlky1NWcRQTYKkbXIKAXGlAYgbdhcD7F4JBiB6q
X-Google-Smtp-Source: AMsMyM6HMoSLOX4Lvk9BLQik33C2AjzXW7h8RVkQaDoddt90sH7XB+BEPu0c759hiIS9Jv8KUBvOO+ji7/0ajjVuDpQ=
X-Received: by 2002:a05:622a:620a:b0:35c:bf9e:8748 with SMTP id
 hj10-20020a05622a620a00b0035cbf9e8748mr22068048qtb.494.1664277402949; Tue, 27
 Sep 2022 04:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220923124904.1373936-1-victor.liu@nxp.com> <CAPDyKFqdHX=o4V4K8GdCr4wQ5sjr=JMG6CFAy1849=CtfoSgRQ@mail.gmail.com>
 <75366bfac9fcd4f8c35309193705f0277a164ae4.camel@nxp.com> <CAPDyKFr0XjrU_udKoUKQ_q8RWaUkyqL+8fV-7s1CTMqi7u3-Rg@mail.gmail.com>
 <1b1aa20aa3b8f8255fa05d61c7fa094650dee319.camel@nxp.com>
In-Reply-To: <1b1aa20aa3b8f8255fa05d61c7fa094650dee319.camel@nxp.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Sep 2022 13:16:31 +0200
Message-ID: <CAJZ5v0ikbkJofVta_8E+653XPLMQCiqRAZOxVtZLRN3t0KkCwQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: runtime: Return properly from rpm_resume() if
 dev->power.needs_force_resume flag is set
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-imx@nxp.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 9:47 AM Liu Ying <victor.liu@nxp.com> wrote:
>
> On Mon, 2022-09-26 at 11:47 +0200, Ulf Hansson wrote:
> > On Fri, 23 Sept 2022 at 17:23, Liu Ying <victor.liu@nxp.com> wrote:
> > > On Fri, 2022-09-23 at 15:48 +0200, Ulf Hansson wrote:
> > > > On Fri, 23 Sept 2022 at 14:47, Liu Ying <victor.liu@nxp.com> wrote:
> > > > > After a device transitions to sleep state through it's system
> > > > > suspend
> > > > > callback pm_runtime_force_suspend(), the device's driver may still
> > > > > try
> > > > > to do runtime PM for the device(runtime suspend first and then
> > > > > runtime
> > > > > resume) although runtime PM is disabled by that callback.  The
> > > > > runtime
> > > > > PM operations would not touch the device effectively and the device
> > > > > is
> > > > > assumed to be resumed through it's system resume callback
> > > > > pm_runtime_force_resume().
> > > >
> > > > This sounds like a fragile use case to me. In principle you want to
> > > > allow the device to be runtime resumed/suspended, after the device
> > > > has
> > > > already been put into a low power state through the regular system
> > > > suspend callback. Normally it seems better to prevent this from
> > > > happening, completely.
> > >
> > > Not sure if we really may prevent this from happening completely.
> > >
> > > > That said, in this case, I wonder if a better option would be to
> > > > point
> > > > ->suspend_late() to pm_runtime_force_suspend() and ->resume_early()
> > > > to
> > > > pm_runtime_force_resume(), rather than using the regular
> > > > ->suspend|resume() callbacks. This should avoid the problem, I think,
> > > > no?
> > >
> > > I thought about this and it actually works for my particular
> > > panel-simple case.  What worries me is that the device(DRM device in my
> > > case) which triggers the runtime PM operations may also use
> > > ->suspend_late/resume_early() callbacks for whatever reasons, hence no
> > > fixed order to suspend/resume the two devices(like panel device and DRM
> > > device).
> > >
> > > Also, not sure if there is any sequence issue by using the
> > > ->suspend_late/resume_early() callbacks in the panel-simple driver,
> > > since it's written for quite a few display panels which may work with
> > > various DRM devices - don't want to break any of them.
> >
> > What you are describing here, is the classical problem we have with
> > suspend/resume ordering of devices.
> >
> > There are in principle two ways to solve this.
> > 1. If it makes sense, the devices might be assigned as parent/child.
> > 2. If it's more a consumer/supplier thing, we can add a device-link
> > between them.
>
> I thought about the two ways for my particular panel-simple case and
> the first impression is that it's not straightforward to use them. For
> DSI panels(with DRM_MODE_CONNECTOR_DSI connector type), it looks like
> panel device's parent is DSI host device(set in mipi_dsi_device_alloc()
> ). For other types of panels, like DPI panels, many show up in device
> tree as child-node of root node and connect a display controller or a
> display bridge through OF graph.  Seems that DRM architecture level
> lacks some sort of glue code to use the two ways.

Well, apparently, the ordering of power management operations
regarding the components in question cannot be arbitrary, but without
any information on the correct ordering in place, there is no way to
guarantee that ordering in every possible code path.  Addressing one
of them is generally insufficient and you will see problems sooner or
later.
