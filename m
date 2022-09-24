Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB85E8E89
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiIXQkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiIXQkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:40:40 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAFA31239;
        Sat, 24 Sep 2022 09:40:38 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id g4so1896192qvo.3;
        Sat, 24 Sep 2022 09:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gE3KFEUdndJXdpY6KUQ2M1H/RzmcTG6K//Zg7fHhHug=;
        b=ukJj0wVymixTEqdbRJIyBC40lYfw+dPr+AwiEfQhSpbtz1ci6mbAM4QZd4j2xQowX8
         5artbqjv1E5zIUZary4pA79HCRoMUhnXoqf4XyonrNHq2n29+6TmAQ8xJPeI5xtRCrF9
         fAhNOsGMVa94YIAJg/+e/MAsA4AlzTufwl9/Xf6Smz0RAdcYgvHCfpBZKQkd/0zQMgD0
         KsNBaIJUYPF95wV1bKPWatUIY0/eZyZG5yBnBKP5xSabHp5pp6ag4s0j5ByPDT7s7J5n
         Tl6uE+wJ745ds36jsRZpUBaxBmTTtq3ThAvXMGR23Gk4+zNGdHg70HajYGeE+AlBZurb
         lo9Q==
X-Gm-Message-State: ACrzQf1AzGkSuC+KhasHcJhQTZCVfO36i6BaE90CwqvMf0yIo8xcMsEO
        4d1sjxKjx32s+7uNdCsu2tuWZPOfquRvqj/nRp9Jz++D
X-Google-Smtp-Source: AMsMyM7fbJVAZSVER7pZxB2EfdF8AmyZIAMGhKrJ+SS/bqBnDtUB10uawlldVrEY558Ks+NRtiNxfKUUePfB3oDqvdY=
X-Received: by 2002:a05:6214:d8d:b0:4ad:5d9d:bda8 with SMTP id
 e13-20020a0562140d8d00b004ad5d9dbda8mr11283909qve.85.1664037638085; Sat, 24
 Sep 2022 09:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220911090635.5559-1-lvjianmin@loongson.cn> <20220911090635.5559-2-lvjianmin@loongson.cn>
 <YyA9n+xMMUjSRV3y@lpieralisi>
In-Reply-To: <YyA9n+xMMUjSRV3y@lpieralisi>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 18:40:26 +0200
Message-ID: <CAJZ5v0jYy+pMWH7Y5CckhY773ypY9CkuwuegcHgTn_LH557+Mw@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] ACPI / scan: Support multiple dma windows with
 different offsets
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        loongarch@lists.linux.dev
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

On Tue, Sep 13, 2022 at 10:21 AM Lorenzo Pieralisi
<lpieralisi@kernel.org> wrote:
>
> On Sun, Sep 11, 2022 at 05:06:34PM +0800, Jianmin Lv wrote:
> > In DT systems configurations, of_dma_get_range() returns struct
> > bus_dma_region DMA regions; they are used to set-up devices
> > DMA windows with different offset available for translation between DMA
> > address and CPU address.
> >
> > In ACPI systems configuration, acpi_dma_get_range() does not return
> > DMA regions yet and that precludes setting up the dev->dma_range_map
> > pointer and therefore DMA regions with multiple offsets.
> >
> > Update acpi_dma_get_range() to return struct bus_dma_region
> > DMA regions like of_dma_get_range() does.
> >
> > After updating acpi_dma_get_range(), acpi_arch_dma_setup() is changed for
> > ARM64, where the original dma_addr and size are removed as these
> > arguments are now redundant, and pass 0 and U64_MAX for dma_base
> > and size of arch_setup_dma_ops; this is a simplification consistent
> > with what other ACPI architectures also pass to iommu_setup_dma_ops().
> >
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > ---
> >  drivers/acpi/arm64/dma.c | 28 ++++++++++++---------
> >  drivers/acpi/scan.c      | 53 +++++++++++++++++-----------------------
> >  include/acpi/acpi_bus.h  |  3 +--
> >  include/linux/acpi.h     |  7 +++---
> >  4 files changed, 44 insertions(+), 47 deletions(-)
>
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

Applied as 6.1 material along with the [2/2], thanks!

> > diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
> > index f16739ad3cc0..93d796531af3 100644
> > --- a/drivers/acpi/arm64/dma.c
> > +++ b/drivers/acpi/arm64/dma.c
> > @@ -4,11 +4,12 @@
> >  #include <linux/device.h>
> >  #include <linux/dma-direct.h>
> >
> > -void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> > +void acpi_arch_dma_setup(struct device *dev)
> >  {
> >       int ret;
> >       u64 end, mask;
> > -     u64 dmaaddr = 0, size = 0, offset = 0;
> > +     u64 size = 0;
> > +     const struct bus_dma_region *map = NULL;
> >
> >       /*
> >        * If @dev is expected to be DMA-capable then the bus code that created
> > @@ -26,7 +27,19 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> >       else
> >               size = 1ULL << 32;
> >
> > -     ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
> > +     ret = acpi_dma_get_range(dev, &map);
> > +     if (!ret && map) {
> > +             const struct bus_dma_region *r = map;
> > +
> > +             for (end = 0; r->size; r++) {
> > +                     if (r->dma_start + r->size - 1 > end)
> > +                             end = r->dma_start + r->size - 1;
> > +             }
> > +
> > +             size = end + 1;
> > +             dev->dma_range_map = map;
> > +     }
> > +
> >       if (ret == -ENODEV)
> >               ret = iort_dma_get_ranges(dev, &size);
> >       if (!ret) {
> > @@ -34,17 +47,10 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> >                * Limit coherent and dma mask based on size retrieved from
> >                * firmware.
> >                */
> > -             end = dmaaddr + size - 1;
> > +             end = size - 1;
> >               mask = DMA_BIT_MASK(ilog2(end) + 1);
> >               dev->bus_dma_limit = end;
> >               dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
> >               *dev->dma_mask = min(*dev->dma_mask, mask);
> >       }
> > -
> > -     *dma_addr = dmaaddr;
> > -     *dma_size = size;
> > -
> > -     ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
> > -
> > -     dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" : "");
> >  }
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 42cec8120f18..f96ef8536037 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/platform_data/x86/apple.h>
> >  #include <linux/pgtable.h>
> >  #include <linux/crc32.h>
> > +#include <linux/dma-direct.h>
> >
> >  #include "internal.h"
> >
> > @@ -1467,25 +1468,21 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
> >   * acpi_dma_get_range() - Get device DMA parameters.
> >   *
> >   * @dev: device to configure
> > - * @dma_addr: pointer device DMA address result
> > - * @offset: pointer to the DMA offset result
> > - * @size: pointer to DMA range size result
> > + * @map: pointer to DMA ranges result
> >   *
> > - * Evaluate DMA regions and return respectively DMA region start, offset
> > - * and size in dma_addr, offset and size on parsing success; it does not
> > - * update the passed in values on failure.
> > + * Evaluate DMA regions and return pointer to DMA regions on
> > + * parsing success; it does not update the passed in values on failure.
> >   *
> >   * Return 0 on success, < 0 on failure.
> >   */
> > -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
> > -                    u64 *size)
> > +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
> >  {
> >       struct acpi_device *adev;
> >       LIST_HEAD(list);
> >       struct resource_entry *rentry;
> >       int ret;
> >       struct device *dma_dev = dev;
> > -     u64 len, dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
> > +     struct bus_dma_region *r;
> >
> >       /*
> >        * Walk the device tree chasing an ACPI companion with a _DMA
> > @@ -1510,31 +1507,28 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
> >
> >       ret = acpi_dev_get_dma_resources(adev, &list);
> >       if (ret > 0) {
> > +             r = kcalloc(ret + 1, sizeof(*r), GFP_KERNEL);
> > +             if (!r) {
> > +                     ret = -ENOMEM;
> > +                     goto out;
> > +             }
> > +
> >               list_for_each_entry(rentry, &list, node) {
> > -                     if (dma_offset && rentry->offset != dma_offset) {
> > +                     if (rentry->res->start >= rentry->res->end) {
> > +                             kfree(r);
> >                               ret = -EINVAL;
> > -                             dev_warn(dma_dev, "Can't handle multiple windows with different offsets\n");
> > +                             dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
> >                               goto out;
> >                       }
> > -                     dma_offset = rentry->offset;
> >
> > -                     /* Take lower and upper limits */
> > -                     if (rentry->res->start < dma_start)
> > -                             dma_start = rentry->res->start;
> > -                     if (rentry->res->end > dma_end)
> > -                             dma_end = rentry->res->end;
> > -             }
> > -
> > -             if (dma_start >= dma_end) {
> > -                     ret = -EINVAL;
> > -                     dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
> > -                     goto out;
> > +                     r->cpu_start = rentry->res->start;
> > +                     r->dma_start = rentry->res->start - rentry->offset;
> > +                     r->size = resource_size(rentry->res);
> > +                     r->offset = rentry->offset;
> > +                     r++;
> >               }
> >
> > -             *dma_addr = dma_start - dma_offset;
> > -             len = dma_end - dma_start;
> > -             *size = max(len, len + 1);
> > -             *offset = dma_offset;
> > +             *map = r;
> >       }
> >   out:
> >       acpi_dev_free_resource_list(&list);
> > @@ -1624,20 +1618,19 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
> >                         const u32 *input_id)
> >  {
> >       const struct iommu_ops *iommu;
> > -     u64 dma_addr = 0, size = 0;
> >
> >       if (attr == DEV_DMA_NOT_SUPPORTED) {
> >               set_dma_ops(dev, &dma_dummy_ops);
> >               return 0;
> >       }
> >
> > -     acpi_arch_dma_setup(dev, &dma_addr, &size);
> > +     acpi_arch_dma_setup(dev);
> >
> >       iommu = acpi_iommu_configure_id(dev, input_id);
> >       if (PTR_ERR(iommu) == -EPROBE_DEFER)
> >               return -EPROBE_DEFER;
> >
> > -     arch_setup_dma_ops(dev, dma_addr, size,
> > +     arch_setup_dma_ops(dev, 0, U64_MAX,
> >                               iommu, attr == DEV_DMA_COHERENT);
> >
> >       return 0;
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index e7d27373ff71..73ac4a1d6947 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -613,8 +613,7 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
> >  int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> >                          struct fwnode_handle *fwnode,
> >                          const struct iommu_ops *ops);
> > -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
> > -                    u64 *size);
> > +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
> >  int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
> >                          const u32 *input_id);
> >  static inline int acpi_dma_configure(struct device *dev,
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 6f64b2f3dc54..bb41623dab77 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -281,12 +281,12 @@ void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
> >
> >  #ifdef CONFIG_ARM64
> >  void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
> > -void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size);
> > +void acpi_arch_dma_setup(struct device *dev);
> >  #else
> >  static inline void
> >  acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
> >  static inline void
> > -acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size) { }
> > +acpi_arch_dma_setup(struct device *dev) { }
> >  #endif
> >
> >  int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
> > @@ -977,8 +977,7 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
> >       return DEV_DMA_NOT_SUPPORTED;
> >  }
> >
> > -static inline int acpi_dma_get_range(struct device *dev, u64 *dma_addr,
> > -                                  u64 *offset, u64 *size)
> > +static inline int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
> >  {
> >       return -ENODEV;
> >  }
> > --
> > 2.31.1
> >
