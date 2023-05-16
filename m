Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137A8704ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjEPKiB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 May 2023 06:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjEPKh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:37:58 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ED6213A;
        Tue, 16 May 2023 03:37:52 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-94a342f4c8eso355435066b.0;
        Tue, 16 May 2023 03:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684233471; x=1686825471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZvG9EwxbAkTIUCb+ia3g2SAb5ao369dYmZpB1L75vM=;
        b=jW+7dxsscE9FYigkF8o5v8o5XGtHiAt4GanywSyeOo19Rs5lmTgT9I5vsyma3DbXCO
         jYg+BQz9kPXr9my20V3vJZtMHBMSdt02xZFaqV4DcAUpoMRZi5RSVqyb75M3E9k5wNjt
         c5/k/4xk6Gc7U7Cwi5XWHN4xay9CLfaqLR/5nvoteeA/k43hN+XWPR+6voauSHJdilbQ
         Z6e9GNiGZafEtBcgzGQKe1Q416/q/rkrJMJ4hbvyi1w5wWOGafDi5VApFSe6Khbgi5tq
         zjWTGUi50E5gqWkN2MR1kIGWcTdjsX0JHpcqAhgNQu14QTUsQ8bjabCb4mVkTgjBuCkY
         ELvg==
X-Gm-Message-State: AC+VfDwIW47nyhqlwCHpFE6j/Hd8N1in0lg1QXOoIAV5YENvm4oSr+XM
        UfM56eXTU4DHn4rsiyB+RPFPKPIOlFl36R4ZFGp+TKqY
X-Google-Smtp-Source: ACHHUZ4XAIHLNhqsjB3xkqymaxap0VVLgEqJosjP7KKpP9ZI6U0MBT02pTufAM2NO1jDA8rTrOcbDb2ntpCgvbLEiMQ=
X-Received: by 2002:a17:906:51cb:b0:94e:d688:fca6 with SMTP id
 v11-20020a17090651cb00b0094ed688fca6mr9001606ejk.0.1684233471153; Tue, 16 May
 2023 03:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <12223415.O9o76ZdvQC@kreacher> <f665b082-6114-d132-915b-e5b45f52af99@redhat.com>
In-Reply-To: <f665b082-6114-d132-915b-e5b45f52af99@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 May 2023 12:37:37 +0200
Message-ID: <CAJZ5v0hRzeq201Wt98TdPp6k90Z4J5+eMmibsCXXugGKXzAknA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: scan: Reduce overhead related to devices with dependencies
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Tue, May 16, 2023 at 12:33 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> On 5/16/23 12:25, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] ACPI: scan: Reduce overhead related to devices with dependencies
> >
> > Notice that all of the objects for which the acpi_scan_check_dep()
> > return value is greater than 0 are present in acpi_dep_list as consumers
> > (there may be multiple entries for one object, but that is not a
> > problem), so after carrying out the initial ACPI namespace walk in which
> > devices with dependencies are skipped, acpi_bus_scan() can simply walk
> > acpi_dep_list and enumerate all of the unique consumer objects from
> > there and their descendants instead of walking the entire target branch
> > of the ACPI namespace and looking for device objects that have not been
> > enumerated yet in it.
> >
> > Because walking acpi_dep_list is generally less overhead than walking
> > the entire ACPI namespace, use the observation above to reduce the
> > system initialization overhead related to ACPI, which is particularly
> > important on large systems.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > -> v2: Hold acpi_dep_list_lock around the acpi_fetch_acpi_dev() invocation in
> >        acpi_scan_postponed() (Hans).
>
> This looks good to me now:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> with the remark that this obviously is going to need a lot
> of testing in case this somehow breaks some weird corner case.
>
> I'll add it to my personal git kernel tree with all my
> pending work right away, so that it will get tested on
> various devices as I test other patches on those devices.
>
> I'll let you know if I hit any problems which seem to be
> caused by this.

Awesome, thanks!


> >
> > ---
> >  drivers/acpi/scan.c     |   81 ++++++++++++++++++++++++++++++++++++------------
> >  include/acpi/acpi_bus.h |    2 +
> >  2 files changed, 63 insertions(+), 20 deletions(-)
> >
> > Index: linux-pm/include/acpi/acpi_bus.h
> > ===================================================================
> > --- linux-pm.orig/include/acpi/acpi_bus.h
> > +++ linux-pm/include/acpi/acpi_bus.h
> > @@ -289,6 +289,8 @@ struct acpi_dep_data {
> >       acpi_handle supplier;
> >       acpi_handle consumer;
> >       bool honor_dep;
> > +     bool met;
> > +     bool free_when_met;
> >  };
> >
> >  /* Performance Management */
> > Index: linux-pm/drivers/acpi/scan.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -2029,8 +2029,6 @@ static u32 acpi_scan_check_dep(acpi_hand
> >       return count;
> >  }
> >
> > -static bool acpi_bus_scan_second_pass;
> > -
> >  static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
> >                                     struct acpi_device **adev_p)
> >  {
> > @@ -2050,10 +2048,8 @@ static acpi_status acpi_bus_check_add(ac
> >                       return AE_OK;
> >
> >               /* Bail out if there are dependencies. */
> > -             if (acpi_scan_check_dep(handle, check_dep) > 0) {
> > -                     acpi_bus_scan_second_pass = true;
> > +             if (acpi_scan_check_dep(handle, check_dep) > 0)
> >                       return AE_CTRL_DEPTH;
> > -             }
> >
> >               fallthrough;
> >       case ACPI_TYPE_ANY:     /* for ACPI_ROOT_OBJECT */
> > @@ -2301,6 +2297,12 @@ static bool acpi_scan_clear_dep_queue(st
> >       return true;
> >  }
> >
> > +static void acpi_scan_delete_dep_data(struct acpi_dep_data *dep)
> > +{
> > +     list_del(&dep->node);
> > +     kfree(dep);
> > +}
> > +
> >  static int acpi_scan_clear_dep(struct acpi_dep_data *dep, void *data)
> >  {
> >       struct acpi_device *adev = acpi_get_acpi_dev(dep->consumer);
> > @@ -2311,8 +2313,10 @@ static int acpi_scan_clear_dep(struct ac
> >                       acpi_dev_put(adev);
> >       }
> >
> > -     list_del(&dep->node);
> > -     kfree(dep);
> > +     if (dep->free_when_met)
> > +             acpi_scan_delete_dep_data(dep);
> > +     else
> > +             dep->met = true;
> >
> >       return 0;
> >  }
> > @@ -2406,6 +2410,55 @@ struct acpi_device *acpi_dev_get_next_co
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_dev_get_next_consumer_dev);
> >
> > +static void acpi_scan_postponed_branch(acpi_handle handle)
> > +{
> > +     struct acpi_device *adev = NULL;
> > +
> > +     if (ACPI_FAILURE(acpi_bus_check_add(handle, false, &adev)))
> > +             return;
> > +
> > +     acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
> > +                         acpi_bus_check_add_2, NULL, NULL, (void **)&adev);
> > +     acpi_bus_attach(adev, NULL);
> > +}
> > +
> > +static void acpi_scan_postponed(void)
> > +{
> > +     struct acpi_dep_data *dep, *tmp;
> > +
> > +     mutex_lock(&acpi_dep_list_lock);
> > +
> > +     list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
> > +             acpi_handle handle = dep->consumer;
> > +
> > +             /*
> > +              * In case there are multiple acpi_dep_list entries with the
> > +              * same consumer, skip the current entry if the consumer device
> > +              * object corresponding to it is present already.
> > +              */
> > +             if (!acpi_fetch_acpi_dev(handle)) {
> > +                     /*
> > +                      * Even though the lock is released here, tmp is
> > +                      * guaranteed to be valid, because none of the list
> > +                      * entries following dep is marked as "free when met"
> > +                      * and so they cannot be deleted.
> > +                      */
> > +                     mutex_unlock(&acpi_dep_list_lock);
> > +
> > +                     acpi_scan_postponed_branch(handle);
> > +
> > +                     mutex_lock(&acpi_dep_list_lock);
> > +             }
> > +
> > +             if (dep->met)
> > +                     acpi_scan_delete_dep_data(dep);
> > +             else
> > +                     dep->free_when_met = true;
> > +     }
> > +
> > +     mutex_unlock(&acpi_dep_list_lock);
> > +}
> > +
> >  /**
> >   * acpi_bus_scan - Add ACPI device node objects in a given namespace scope.
> >   * @handle: Root of the namespace scope to scan.
> > @@ -2424,8 +2477,6 @@ int acpi_bus_scan(acpi_handle handle)
> >  {
> >       struct acpi_device *device = NULL;
> >
> > -     acpi_bus_scan_second_pass = false;
> > -
> >       /* Pass 1: Avoid enumerating devices with missing dependencies. */
> >
> >       if (ACPI_SUCCESS(acpi_bus_check_add(handle, true, &device)))
> > @@ -2438,19 +2489,9 @@ int acpi_bus_scan(acpi_handle handle)
> >
> >       acpi_bus_attach(device, (void *)true);
> >
> > -     if (!acpi_bus_scan_second_pass)
> > -             return 0;
> > -
> >       /* Pass 2: Enumerate all of the remaining devices. */
> >
> > -     device = NULL;
> > -
> > -     if (ACPI_SUCCESS(acpi_bus_check_add(handle, false, &device)))
> > -             acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
> > -                                 acpi_bus_check_add_2, NULL, NULL,
> > -                                 (void **)&device);
> > -
> > -     acpi_bus_attach(device, NULL);
> > +     acpi_scan_postponed();
> >
> >       return 0;
> >  }
> >
> >
> >
>
