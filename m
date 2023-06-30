Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3DF743899
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjF3Jp6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 05:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjF3Jpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:45:51 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26885125;
        Fri, 30 Jun 2023 02:45:50 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-98273ae42d0so47340866b.0;
        Fri, 30 Jun 2023 02:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688118348; x=1690710348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Vw8jMWNOm82RPNOF2hjNaDBARTFH1+TBodiiRe6jac=;
        b=cn5MmXgIqb8oOCUucgGw6e4/r0D++GguKkhOd1nfoc7Ly4bQVfreIe4l75q58goxGQ
         fHX7ZtX40rNMKRtmWkaO16apKZ1fiyBh5xTxNcHmkT5V3j5UGcNFcp3+zEk1vaytosXp
         mk20dj793gjmN2Ddp2A0Pns5IXtelh+SvyEW4C1ntTc/xmTECnh2QwUcslft06LCkVMq
         pU5Sl04FIMECRODW4JDM4H5kOu736QGAnLoyFIy8ZZC7KLT6QikbsKHtGA3SBNgLIS7W
         akmm2LrgMvNxlLvMqmxIsQQLXaC1sTNzgb/MyAb+vvNlOEcgdEkMmTQMK3gKFMt6/bxc
         ucTA==
X-Gm-Message-State: ABy/qLbpHai/SqIHe45vO4FeFm84AG9AgP5ExYfXSEB6mzdNqrAKUI/E
        c6s1sqCELF6yCIxd+j5uKm3Po1bV+eCYR5e6Mw0=
X-Google-Smtp-Source: APBJJlEGmpAmEljK1mrMe58BsdmDqPNaakW6BsCreX0ihf6RbLR0X6656Z/A97c7B1QNWPH652dexyylEL9xVKx14bw=
X-Received: by 2002:a17:906:199b:b0:976:50a4:ac40 with SMTP id
 g27-20020a170906199b00b0097650a4ac40mr1491509ejd.0.1688118348393; Fri, 30 Jun
 2023 02:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-4-michal.wilczynski@intel.com> <CAJZ5v0ippMo1Haa-YFszyWZNgUE_pPUtkFngQWjUyjJe4tm94g@mail.gmail.com>
 <ff596664-1062-92ff-a1fe-3b644925aeae@intel.com> <CAJZ5v0gj5Pf_Ut0v+gTd34ubpGOs7okitFEXV3eFJxPPHYFrgw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gj5Pf_Ut0v+gTd34ubpGOs7okitFEXV3eFJxPPHYFrgw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Jun 2023 11:45:37 +0200
Message-ID: <CAJZ5v0hNaL6Y0AGmpC2bJ0X3Fxd0qAkJnY1nzoYQWGopQSmG0A@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] acpi/ac: Move handler installing logic to driver
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:41 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jun 30, 2023 at 11:39 AM Wilczynski, Michal
> <michal.wilczynski@intel.com> wrote:
> >
> >
> >
> > On 6/29/2023 5:55 PM, Rafael J. Wysocki wrote:
> > > On Fri, Jun 16, 2023 at 6:51 PM Michal Wilczynski
> > > <michal.wilczynski@intel.com> wrote:
> > >> Currently logic for installing notifications from ACPI devices is
> > >> implemented using notify callback in struct acpi_driver. Preparations
> > >> are being made to replace acpi_driver with more generic struct
> > >> platform_driver, which doesn't contain notify callback. Furthermore
> > >> as of now handlers are being called indirectly through
> > >> acpi_notify_device(), which decreases performance.
> > >>
> > >> Call acpi_dev_install_notify_handler() at the end of .add() callback.
> > >> Call acpi_dev_remove_notify_handler() at the beginning of .remove()
> > >> callback. Change arguments passed to the notify function to match with
> > >> what's required by acpi_install_notify_handler(). Remove .notify
> > >> callback initialization in acpi_driver.
> > >>
> > >> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> > >> ---
> > >>  drivers/acpi/ac.c | 33 ++++++++++++++++++++++++---------
> > >>  1 file changed, 24 insertions(+), 9 deletions(-)
> > >>
> > >> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> > >> index 1ace70b831cd..207ee3c85bad 100644
> > >> --- a/drivers/acpi/ac.c
> > >> +++ b/drivers/acpi/ac.c
> > >> @@ -34,7 +34,7 @@ MODULE_LICENSE("GPL");
> > >>
> > >>  static int acpi_ac_add(struct acpi_device *device);
> > >>  static void acpi_ac_remove(struct acpi_device *device);
> > >> -static void acpi_ac_notify(struct acpi_device *device, u32 event);
> > >> +static void acpi_ac_notify(acpi_handle handle, u32 event, void *data);
> > >>
> > >>  static const struct acpi_device_id ac_device_ids[] = {
> > >>         {"ACPI0003", 0},
> > >> @@ -54,11 +54,9 @@ static struct acpi_driver acpi_ac_driver = {
> > >>         .name = "ac",
> > >>         .class = ACPI_AC_CLASS,
> > >>         .ids = ac_device_ids,
> > >> -       .flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
> > >>         .ops = {
> > >>                 .add = acpi_ac_add,
> > >>                 .remove = acpi_ac_remove,
> > >> -               .notify = acpi_ac_notify,
> > >>                 },
> > >>         .drv.pm = &acpi_ac_pm,
> > >>  };
> > >> @@ -128,9 +126,12 @@ static enum power_supply_property ac_props[] = {
> > >>  };
> > >>
> > >>  /* Driver Model */
> > >> -static void acpi_ac_notify(struct acpi_device *device, u32 event)
> > >> +static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
> > >>  {
> > >> -       struct acpi_ac *ac = acpi_driver_data(device);
> > > This line doesn't need to be changed.  Just add the device variable
> > > definition above it.
> > >
> > > And the same pattern is present in the other patches in the series.
> >
> > I like the Reverse Christmas Tree, but sure will change that
>
> I do too, but in the cases when it costs 3 extra lines of code I'd
> rather have something simpler.

Besides, moving code around is not strictly related to the functional
changes made by the patch and it kind of hides those changes.  It is
better to move code around in a separate patch if you really want to
do that.
