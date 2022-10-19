Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F893604FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiJSSap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiJSSak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:30:40 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776C711702B;
        Wed, 19 Oct 2022 11:30:39 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id o22so11293297qkl.8;
        Wed, 19 Oct 2022 11:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksoUwNbFYLLNy8hgo3QVu6DMpU3MXF6PNRL2jmsEX/w=;
        b=lQC7ixmJ9+XsTgDun3JmYo7/PQrIbLM4EwNCxnnifawsVuLBSih5FkND6HaBPhNpbs
         uPlArpoMDI7Vz+WLAJRVBbSDsI6R7axptdanBRoerQYhijnI9Q0nEPlA4pNmgT+cEAAS
         fdr59BQVHTAAhicoh3JsWKH/RiTWuViQMdTmSCoxhqSapksCV2BM0PE0yFl/8Av/kDIk
         MJ1NbFnz0mrpZjZR0GNtBOj1aP3cVuer6vJNjeQCEYeys+YH+LUXX47MdVhpQxw7paRO
         VuaXBoGUYOEA0yTAHZpAJSkAyfWa7FDidGGxiH3RPXMLZTrKPTZbh2lcngo9Yip5tQub
         piHw==
X-Gm-Message-State: ACrzQf19jio5F4fbZaqD3bbyPrxE8I86+Sf5KyuXZW1WbUy/m2c3gXJf
        JYaBLlwupLD200vawQvZTMFaSKdJuXl4U3YrmgcTJNC+
X-Google-Smtp-Source: AMsMyM5XpubSdQXcEtfcZteg4xs9UUI/l0EaFIdxTAoYYxhjzLZo+kjl+J57ZUog5PL/iOnbBTMMsju3laNUaOGKKwA=
X-Received: by 2002:a05:620a:158f:b0:6ee:93d5:e249 with SMTP id
 d15-20020a05620a158f00b006ee93d5e249mr6577755qkk.505.1666204238591; Wed, 19
 Oct 2022 11:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <e94f99cfe09a64c590f009d21c566339117394e2.1666098844.git.robin.murphy@arm.com>
 <Y0+xo2DO+M1iJc77@lpieralisi>
In-Reply-To: <Y0+xo2DO+M1iJc77@lpieralisi>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Oct 2022 20:30:27 +0200
Message-ID: <CAJZ5v0huuJj_B_zeOyx4NxA6chyvebCBLvrQx8+O=++_=oOQdQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Fix DMA range assignment
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     rafael@kernel.org, lvjianmin@loongson.cn, yangyicong@huawei.com,
        chenhuacai@loongson.cn, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lenb@kernel.org,
        jeremy.linton@arm.com
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

On Wed, Oct 19, 2022 at 10:13 AM Lorenzo Pieralisi
<lpieralisi@kernel.org> wrote:
>
> On Tue, Oct 18, 2022 at 02:14:04PM +0100, Robin Murphy wrote:
> > Assigning the device's dma_range_map from the iterator variable after
> > the loop means it always points to the empty terminator at the end of
> > the map, which is not what we want. Similarly, freeing the iterator on
> > error when it points to somwhere in the middle of the allocated array
> > won't work either. Fix this.
> >
> > Fixes: bf2ee8d0c385 ("ACPI: scan: Support multiple DMA windows with different offsets")
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >  drivers/acpi/scan.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
>
> A quick comment below, otherwise:
>
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

Applied as is and the code may be cleaned up later.

Thanks!

> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 558664d169fc..024cc373a197 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1509,9 +1509,12 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
> >                       goto out;
> >               }
> >
> > +             *map = r;
>
> I wonder whether having a local variable to stash the base pointer
> would make code easier to read (so that we avoid using *map for that
> purpose and also to return the array to the caller).
>
> Thanks for fixing it so promptly.
>
> Lorenzo
>
> > +
> >               list_for_each_entry(rentry, &list, node) {
> >                       if (rentry->res->start >= rentry->res->end) {
> > -                             kfree(r);
> > +                             kfree(*map);
> > +                             *map = NULL;
> >                               ret = -EINVAL;
> >                               dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
> >                               goto out;
> > @@ -1523,8 +1526,6 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
> >                       r->offset = rentry->offset;
> >                       r++;
> >               }
> > -
> > -             *map = r;
> >       }
> >   out:
> >       acpi_dev_free_resource_list(&list);
> > --
> > 2.36.1.dirty
> >
