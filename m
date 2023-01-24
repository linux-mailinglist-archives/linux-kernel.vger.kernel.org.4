Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CB8679C93
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbjAXOwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbjAXOw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:52:26 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6DC4AA48;
        Tue, 24 Jan 2023 06:52:13 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id kt14so39706667ejc.3;
        Tue, 24 Jan 2023 06:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMUbBr/rdScwYBHhL+3zrpC7GVtT6nThOwqhrKrOV9c=;
        b=oklV27N6i6T2fnMzbbvb02E6+pDFkimhPwKOytleJjwrCnJrS9YwnYJ6dRyA0e5h16
         nphw6j4/zcElfFCi2I+b3cZbiJQUpfXafls8CLKGRRTHGkNbjci0JFBcI/f6qcOYEDZm
         mvxkzo45Sx7KVgINQeEJanbKRyZJWsxWGhqIUkv7QZzeCl4/ehzsVzHU2i9ZmFC2Vpjy
         9WFOifM3mr4yX2pAqKXxPslEOXK7h9JSfy4mkIgsErBlC8XYKiE0V9c67Jb56UP5Cg7e
         60J65fIQQgwuuS75Gqtrs2AkFo48CbG4cs0cCmnJmdz/O7uK+W8scRjcaWKzkYvDHV4m
         2/6Q==
X-Gm-Message-State: AFqh2krAZqbtKiFOqWVz47313ZJo4PVcxRehnSAo4+Tj7MJ/Lu/8DQlf
        4YDe8F8slRDy2mX+GAHdvDo4vCuA8bxFZYTTku30eZQu
X-Google-Smtp-Source: AMrXdXt8C1p5I0HUh53TVWpDmTW9Mv4ZDA/3rs6Z88yAbfrZowYe+m5AzMjdfxdNirjg21RS4EOPnucMitIK3TXRS8Q=
X-Received: by 2002:a17:906:4e9a:b0:84d:4dc6:1c08 with SMTP id
 v26-20020a1709064e9a00b0084d4dc61c08mr4700163eju.421.1674571932458; Tue, 24
 Jan 2023 06:52:12 -0800 (PST)
MIME-Version: 1.0
References: <5916342.lOV4Wx5bFT@kreacher> <2882611.e9J7NaK4W3@kreacher>
 <3234230.44csPzL39Z@kreacher> <19f1860e20fbc75c3d2c3eefda29cccd18ca59a9.camel@linux.intel.com>
 <CAJZ5v0gK_O-9_tPEVbmBbf+2vxVA2_C5tPGOo_qghyw86pohoA@mail.gmail.com> <ca878d5a177b68eaf5f698e0afda5c0b1718a53f.camel@linux.intel.com>
In-Reply-To: <ca878d5a177b68eaf5f698e0afda5c0b1718a53f.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jan 2023 15:52:01 +0100
Message-ID: <CAJZ5v0hSPh4u9W9XSQ=i2FdA64-343p-JtB9khn5YWDH5_LTmQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] thermal: intel: Use generic trip points in 2 drivers
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 10:35 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2023-01-23 at 20:54 +0100, Rafael J. Wysocki wrote:
> > On Mon, Jan 23, 2023 at 8:26 PM srinivas pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > On Mon, 2023-01-23 at 19:52 +0100, Rafael J. Wysocki wrote:
> > > > On Monday, January 23, 2023 7:45:30 PM CET Rafael J. Wysocki
> > > > wrote:
> > > > > On Monday, January 23, 2023 7:36:52 PM CET Rafael J. Wysocki
> > > > > wrote:
> > > > > > Hi All,
> > > > > >
> > > > > > This is a new version of the series from Daniel posted as:
> > > > > >
> > > > > > https://lore.kernel.org/linux-pm/20230120231530.2368330-1-daniel.lezcano@linaro.org/
> > > > > >
> > > > > > The first patch has been reworked (see
> > > > > > https://lore.kernel.org/linux-pm/5911499.lOV4Wx5bFT@kreacher/
> > > > > > )
> > > > > > and the other two have been rebased on top of it.
> > > > > >
> > > > > > I have retained the R-by tags from Rui, because the changes
> > > > > > in
> > > > > > patches [2-3/3] are
> > > > > > not essential, but I think that this new set needs to be
> > > > > > tested
> > > > > > again.
> > > > > >
> > > > > > Srinivas, can you test it please?
> > > > >
> > > > > Something's wrong, sorry.
> > > > >
> > > > > I get some invalid trip temperatures with this set.
> > > >
> > > > Sorry, scratch this, I got confused by THERMAL_TEMP_INVALID
> > > > showing
> > > > up in
> > > > sysfs, but it did show up before too.
> > > >
> > > > Please test!
> > > >
> > >
> > > >
> > >
> > > >
> > > It will be easy if you have some test branch to avoid dependecies
> > > on
> > > other patches.
> >
> > Please see the thermal-intel-test branch in linux-pm.git.  It's this
> > series on top of the core thermal stuff + ARM drivers.
> Tested on one system. Works fine.

Thanks!

I'll add a T-by from you to the series (which will be moved to the
thermal-intel branch).
