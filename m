Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029226786E5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjAWTye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjAWTyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:54:31 -0500
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A49030EBD;
        Mon, 23 Jan 2023 11:54:30 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id w14so15948651edi.5;
        Mon, 23 Jan 2023 11:54:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OnFmO9xTR9Xu/C+ebnyO395E7LnrsXHhVtvHZqLro4=;
        b=OfUhXFjPcuBGN1Yp2tm+KNK24mlwVEF6HJ4K6Q0lkUE7srQSs02pBoovIGek5ySAfG
         0kk4KazibhHQqORSxLKejOmpdAPQLeYGuxM8j/dcgo43wrngZGG0WiqmFh6FYj3TdhSu
         J26ysP1CQ/j49U+rsJiJkXfsFr5kh/IVF3YOuveYO+56nfnDeFevu5qufGhL8IUwN8jd
         37AsRJr2I9VtpiJm808wXcF6VsTyJ2OHgp7rrojRqXrFTSzUlg0ocHlk6SyEh7I5hvIQ
         3mPsV7ZZK1IkQ6Wo4f+WpNMZJnYrXwxt5+98AD3NxbJvgpy3eMGuz1cV5VyewIyB9OXH
         OEMw==
X-Gm-Message-State: AO0yUKUoCNtRSs3YrVghaUn7wou4bLzcggCAENEgB/GRg0StG8MkpStD
        1MEyWCXnq00R9UwUevnaSyaTiZ2dFWr4VZ8UkmI=
X-Google-Smtp-Source: AK7set9cTilvBV+L5qo6TMmPzDimd8d6AOUOsy91hVUnjjLUoYABTMFOCbFaqCLdAWnKXOhc1HAxC/jEk9VOXmYMfpY=
X-Received: by 2002:a50:ec8f:0:b0:49f:6dda:9e1f with SMTP id
 e15-20020a50ec8f000000b0049f6dda9e1fmr92431edr.251.1674503668936; Mon, 23 Jan
 2023 11:54:28 -0800 (PST)
MIME-Version: 1.0
References: <5916342.lOV4Wx5bFT@kreacher> <2882611.e9J7NaK4W3@kreacher>
 <3234230.44csPzL39Z@kreacher> <19f1860e20fbc75c3d2c3eefda29cccd18ca59a9.camel@linux.intel.com>
In-Reply-To: <19f1860e20fbc75c3d2c3eefda29cccd18ca59a9.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Jan 2023 20:54:17 +0100
Message-ID: <CAJZ5v0gK_O-9_tPEVbmBbf+2vxVA2_C5tPGOo_qghyw86pohoA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] thermal: intel: Use generic trip points in 2 drivers
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 8:26 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2023-01-23 at 19:52 +0100, Rafael J. Wysocki wrote:
> > On Monday, January 23, 2023 7:45:30 PM CET Rafael J. Wysocki wrote:
> > > On Monday, January 23, 2023 7:36:52 PM CET Rafael J. Wysocki wrote:
> > > > Hi All,
> > > >
> > > > This is a new version of the series from Daniel posted as:
> > > >
> > > > https://lore.kernel.org/linux-pm/20230120231530.2368330-1-daniel.lezcano@linaro.org/
> > > >
> > > > The first patch has been reworked (see
> > > > https://lore.kernel.org/linux-pm/5911499.lOV4Wx5bFT@kreacher/)
> > > > and the other two have been rebased on top of it.
> > > >
> > > > I have retained the R-by tags from Rui, because the changes in
> > > > patches [2-3/3] are
> > > > not essential, but I think that this new set needs to be tested
> > > > again.
> > > >
> > > > Srinivas, can you test it please?
> > >
> > > Something's wrong, sorry.
> > >
> > > I get some invalid trip temperatures with this set.
> >
> > Sorry, scratch this, I got confused by THERMAL_TEMP_INVALID showing
> > up in
> > sysfs, but it did show up before too.
> >
> > Please test!
> >
>
> >
>
> >
> It will be easy if you have some test branch to avoid dependecies on
> other patches.

Please see the thermal-intel-test branch in linux-pm.git.  It's this
series on top of the core thermal stuff + ARM drivers.
