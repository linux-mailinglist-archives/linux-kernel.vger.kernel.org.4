Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA165EDC5B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiI1MMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiI1MMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:12:20 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3C778BCB;
        Wed, 28 Sep 2022 05:12:19 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id d17so7664832qko.13;
        Wed, 28 Sep 2022 05:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CIqGVzBaFaFFR5UclyBFi8HgM/GRxAdQUGRuC1Ped5c=;
        b=5yTBRQUphVDe+1CBMpc2f8xetTJ695YWR1tbOU8N8EoP7b1LIRkzNc+PLo7gWKPiEn
         eDM1aBW6gm6qo9MvqOQtMIKggJGX/RN513jSexOrTroDZ37G/VPWILYO+zkcH3qGz/Lj
         SH/K9KJunU2VqpT2zmxO8/EyxlHk26bkvcLc4YFLWnDcYDZDNg7DSE7+o1+dpC/Z3ohX
         s+wGrB3Q2ndvGPHXga3Ke53nacua82WQdUail7FWEFZLJQKWDN8+F3KvUqIOP3VHIemX
         zmC3wiOQTeB6DS6YZa66QCHLXFaLxDX8ztp7O19pK698vCq5/ecZ3iGMU3M8tvrXBkv3
         Yhpg==
X-Gm-Message-State: ACrzQf3PqK+xpP6I7GY1i5yKurNSWwjdfbmfYF7idxpIbMgPp//PXkZo
        P+/fvqBw+bYkE+muL4oUALBnzK/clSlz6e1s7dEMdZuJ/vY=
X-Google-Smtp-Source: AMsMyM75tbp+YtjShb747Y5XEHihnf4/GsshmS5UZxr0V4F4sqiP8NbWSDqDgZDVRfCw80XTodVOFfu68VgvS8Y3Dt0=
X-Received: by 2002:a05:620a:2988:b0:6ce:cc3f:73b9 with SMTP id
 r8-20020a05620a298800b006cecc3f73b9mr21046124qkp.9.1664367138442; Wed, 28 Sep
 2022 05:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220927142822.4095-1-andriy.shevchenko@linux.intel.com> <YzP5UkYKahQR7FtZ@kuha.fi.intel.com>
In-Reply-To: <YzP5UkYKahQR7FtZ@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Sep 2022 14:12:02 +0200
Message-ID: <CAJZ5v0jwQsqRZRX_=9aB-iDMCvp1qx__5P-2jDH9ts-_a3KTnQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] device property: Keep dev_fwnode() and
 dev_fwnode_const() separate
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Daniel Scally <djrscally@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 9:36 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Sep 27, 2022 at 05:28:17PM +0300, Andy Shevchenko wrote:
> > It's not fully correct to take a const parameter pointer to a struct
> > and return a non-const pointer to a member of that struct.
> >
> > Instead, introduce a const version of the dev_fwnode() API which takes
> > and returns const pointers and use it where it's applicable.
> >
> > Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Fixes: aade55c86033 ("device property: Add const qualifier to device_get_match_data() parameter")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> For the whole series:
>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> > ---
> >  drivers/base/property.c  | 11 +++++++++--
> >  include/linux/property.h |  3 ++-
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 4d6278a84868..699f1b115e0a 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -17,13 +17,20 @@
> >  #include <linux/property.h>
> >  #include <linux/phy.h>
> >
> > -struct fwnode_handle *dev_fwnode(const struct device *dev)
> > +struct fwnode_handle *dev_fwnode(struct device *dev)
> >  {
> >       return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> >               of_fwnode_handle(dev->of_node) : dev->fwnode;
> >  }
> >  EXPORT_SYMBOL_GPL(dev_fwnode);
> >
> > +const struct fwnode_handle *dev_fwnode_const(const struct device *dev)
> > +{
> > +     return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> > +             of_fwnode_handle(dev->of_node) : dev->fwnode;
> > +}
> > +EXPORT_SYMBOL_GPL(dev_fwnode_const);
> > +
> >  /**
> >   * device_property_present - check if a property of a device is present
> >   * @dev: Device whose property is being checked
> > @@ -1202,7 +1209,7 @@ EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
> >
> >  const void *device_get_match_data(const struct device *dev)
> >  {
> > -     return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
> > +     return fwnode_call_ptr_op(dev_fwnode_const(dev), device_get_match_data, dev);
> >  }
> >  EXPORT_SYMBOL_GPL(device_get_match_data);
> >
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index 117cc200c656..ae5d7f8eccf4 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -32,7 +32,8 @@ enum dev_dma_attr {
> >       DEV_DMA_COHERENT,
> >  };
> >
> > -struct fwnode_handle *dev_fwnode(const struct device *dev);
> > +struct fwnode_handle *dev_fwnode(struct device *dev);
> > +const struct fwnode_handle *dev_fwnode_const(const struct device *dev);
> >
> >  bool device_property_present(struct device *dev, const char *propname);
> >  int device_property_read_u8_array(struct device *dev, const char *propname,
> > --

So I would like all of you to see the response from Greg to the v2 of
this patch and provide your input in that thread:

https://lore.kernel.org/linux-acpi/YzQqcFZtJn90URrJ@kroah.com/T/#u
