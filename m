Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31667704A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjEPKJh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 May 2023 06:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjEPKJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:09:04 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B40219B4;
        Tue, 16 May 2023 03:08:45 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-96a6c0cc0fbso172280866b.1;
        Tue, 16 May 2023 03:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684231724; x=1686823724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1t9Bau1lfd4vutiJJ00b0zRmldsH9nedKcDr87zDcH4=;
        b=TwOXLnstK2Az0kRZ5T6/wWmuMdPO6dWouOFM3P2JuakzetDnufpTmZQQ8eRy+ciWZs
         YPcPM574w0Htb3SMKXcRXPeVI9yg89aiW/MERKXCKU6hhxv6+umDViX86BcuN0RBFEDp
         DO8AWWBVAyD4120jLT10HP84JLEAyhGRMknJK87HrCOaXNG4/Zs2cIIl9mGyZmRHInKh
         HJSZ8tUUZzNHygjFl/rxu5z0d1km1c3stu0CNaoJqvetOeN2F1zPeCLHZr3c3R8fButy
         7jRu3sUpryAROgJJwGL+8vBCg/xMl30fSCIPtDxsIUYtRcJtV0gjBrl9dMvs5zAoUOqr
         BBcw==
X-Gm-Message-State: AC+VfDx4cpPOzDii/BH6YIwEuGufORt2lGB/GoyFSf0CS84sIc0yXOL2
        wDrJmK50+2SEBiP26H6gRvgXSHrETWWtjxBdZdsOgK4L
X-Google-Smtp-Source: ACHHUZ5kWUMsfZTD+yxgp4QF7cOBgReXyDG9MyzygSKDZA+NMgDUIONcE0zZUNZem66dlR2L312VrEbDPvgKsavXfws=
X-Received: by 2002:a17:906:74d5:b0:965:a6c1:9b96 with SMTP id
 z21-20020a17090674d500b00965a6c19b96mr1641438ejl.2.1684231723965; Tue, 16 May
 2023 03:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <2694293.mvXUDI8C0e@kreacher> <b2082cef-2e23-253d-4833-542c3460972a@redhat.com>
In-Reply-To: <b2082cef-2e23-253d-4833-542c3460972a@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 May 2023 12:08:30 +0200
Message-ID: <CAJZ5v0j1iC8ghQemUMs4T-zs-vW=Tx3W7DUqiYv22zD2u-KzZw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Reduce overhead related to devices with dependencies
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
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

Hi Hans,

On Tue, May 16, 2023 at 10:32 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> On 5/15/23 18:30, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
> >  drivers/acpi/scan.c     |   79 +++++++++++++++++++++++++++++++++++-------------
> >  include/acpi/acpi_bus.h |    2 +
> >  2 files changed, 61 insertions(+), 20 deletions(-)
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
> > @@ -2406,6 +2410,53 @@ struct acpi_device *acpi_dev_get_next_co
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
> > +              * Even though the lock is released here, tmp is guaranteed to
> > +              * be valid, because none of the list entries following dep is
> > +              * marked as "free when met" and so they cannot be deleted.
> > +              */
> > +             mutex_unlock(&acpi_dep_list_lock);
> > +
> > +             /*
> > +              * In case there are multiple acpi_dep_list entries with the
> > +              * same consumer, skip the current entry if the consumer device
> > +              * object corresponding to it is present already.
> > +              */
> > +             if (!acpi_fetch_acpi_dev(handle))
> > +                     acpi_scan_postponed_branch(handle);
>
> acpi_fetch_acpi_dev(handle) does not need/take the acpi_dep_list_lock,
> so you can avoid a needless unlock/lock in case acpi_fetch_acpi_dev(handle)
> finds a device already, which will happen quite regular since devices
> with _DEP lists regularly have more then 1 dep so they will be present
> as consumer on the _DEP list more then once.
>
> So maybe:
>
>         list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
>                 acpi_handle handle = dep->consumer;
>                 struct acpi_device *device = acpi_fetch_acpi_dev(handle);
>
>                 /*
>                  * In case there are multiple acpi_dep_list entries with the
>                  * same consumer, skip scanning the current entry if the consumer
>                  * device object corresponding to it is present already.
>                  */
>                 if (device)
>                         goto check_dep;
>
>                 /*
>                  * Even though the lock is released here, tmp is guaranteed to
>                  * be valid, because none of the list entries following dep is
>                  * marked as "free when met" and so they cannot be deleted.
>                  */
>                 mutex_unlock(&acpi_dep_list_lock);
>                 acpi_scan_postponed_branch(handle);
>                 mutex_lock(&acpi_dep_list_lock);
>
> check_dep:
>                 if (dep->met)
>                         acpi_scan_delete_dep_data(dep);
>                 else
>                         dep->free_when_met = true;
>         }
>
> ?

Thanks for the suggestion, sounds good.

I'll send a v2 modified along these lines shortly.
