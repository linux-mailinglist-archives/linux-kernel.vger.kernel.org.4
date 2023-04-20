Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3D26E9E97
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjDTWHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjDTWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:06:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1271701;
        Thu, 20 Apr 2023 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682028407; x=1713564407;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PLmT3wEI8LeOQJN1deZiV4fV7HaRJgT28M0+D9lpClU=;
  b=Yz1CjNT1RZRkdINKIgXNL7cf1+ZEogUgQNoWGRvHbPGEIgYnkbif/wLn
   P1qTbMXMt8WCMWh7JWIV1M9PAoE0GaGMfWtriiIKenOV7qz+SKMkhco0U
   2sqAju2P1yan0ahNTt5voZ8NqmIWpHcHLYz9C4ZuvmS0179F3Ev8M/yhn
   eJvc2RvhNKxx78z1K+YvVZvBPZhMFvVxFn33iN/2SX+MdU+9YKWxaD2HC
   tYIEk5zw5lIXJzkP9zXmhhdxX6FXSvchFz2IMfWuGVOh+rxn7gHmg4RnP
   Dd11kF7LbBiXgQzJWrT27BsgUssh0juPhK42N1/K8T7KxVfbmHPwk4gzf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="432137920"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="432137920"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 15:06:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="761355684"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="761355684"
Received: from lmruiz-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.101.68])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 15:06:31 -0700
Message-ID: <152c96f65a848f43a6b84807db91551dc07dd38a.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/3] platform/x86/intel-uncore-freq: Uncore frequency
 control via TPMI
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
Date:   Thu, 20 Apr 2023 15:06:30 -0700
In-Reply-To: <2adb9bd-864f-5bd7-449-8291f067d2d8@linux.intel.com>
References: <20230418171340.681662-1-srinivas.pandruvada@linux.intel.com>
         <20230418171340.681662-2-srinivas.pandruvada@linux.intel.com>
         <2adb9bd-864f-5bd7-449-8291f067d2d8@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-20 at 14:25 +0300, Ilpo Järvinen wrote:
> On Tue, 18 Apr 2023, Srinivas Pandruvada wrote:
> 
> > Implement support of uncore frequency control via TPMI (Topology
> > Aware
> > Register and PM Capsule Interface). This driver provides the
> > similar
> > functionality as the current uncore frequency driver using MSRs.
> > 
> > The hardware interface to read/write is basically substitution of
> > MSR
> > 0x620 and 0x621. There are specific MMIO offset and bits to get/set
> > minimum and maximum uncore ratio, similar to MSRs.
> > 
> > The scope of the uncore MSRs is package/die. But new generation of
> > CPUs
> > have more granular control at a cluster level. Each package/die can
> > have
> > multiple power domains, which further can have multiple clusters.
> > The
> > TPMI interface allows control at cluster level.
> > 
> > The primary use case for uncore sysfs is to set maximum and minimum
> > uncore frequency to reduce power consumption or latency. The
> > current
> > uncore sysfs control is per package/die. This is enough for the
> > majority
> > of users as workload will move to different power domains as it
> > moves
> > between different CPUs.
> > 
> > The current uncore sysfs provides controls at package/die level.
> > When
> > user sets maximum/minimum limits, the driver sets the same limits
> > to
> > each cluster.
> > 
> > Here number of power domains = number of resources in this aux
> > device.
> > There are offsets and bits to discover number of clusters and
> > offset for
> > each cluster level controls.
> > 
> > The TPMI documentation can be downloaded from:
> > https://github.com/intel/tpmi_power_management
> > 
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> > Tested-by: Wendy Wang <wendy.wang@intel.com>
> > ---
Submitted update with the suggested changes here.

Thanks,
Srinivas

> > v2
> > - Changed mmio to u8* (Hans)
> > - Not setting pd_info->uncore_base to NULL (Hans)
> > - Handling failure of devm_kcalloc() (Hans)
> > - Merged init/remove to probe/remove functions (Rui)
> > - Log when platform is NULL (Rui)
> > 
> >  .../x86/intel/uncore-frequency/Kconfig        |   4 +
> >  .../x86/intel/uncore-frequency/Makefile       |   2 +
> >  .../uncore-frequency/uncore-frequency-tpmi.c  | 338
> > ++++++++++++++++++
> >  3 files changed, 344 insertions(+)
> >  create mode 100644 drivers/platform/x86/intel/uncore-
> > frequency/uncore-frequency-tpmi.c
> > 
> > diff --git a/drivers/platform/x86/intel/uncore-frequency/Kconfig
> > b/drivers/platform/x86/intel/uncore-frequency/Kconfig
> > index 21b209124916..a56d55056927 100644
> > --- a/drivers/platform/x86/intel/uncore-frequency/Kconfig
> > +++ b/drivers/platform/x86/intel/uncore-frequency/Kconfig
> > @@ -6,9 +6,13 @@
> >  menu "Intel Uncore Frequency Control"
> >         depends on X86_64 || COMPILE_TEST
> >  
> > +config INTEL_UNCORE_FREQ_CONTROL_TPMI
> > +       tristate
> > +
> >  config INTEL_UNCORE_FREQ_CONTROL
> >         tristate "Intel Uncore frequency control driver"
> >         depends on X86_64
> > +       select INTEL_UNCORE_FREQ_CONTROL_TPMI if INTEL_TPMI
> >         help
> >           This driver allows control of Uncore frequency limits on
> >           supported server platforms.
> > diff --git a/drivers/platform/x86/intel/uncore-frequency/Makefile
> > b/drivers/platform/x86/intel/uncore-frequency/Makefile
> > index e0f7968e8285..08ff57492b28 100644
> > --- a/drivers/platform/x86/intel/uncore-frequency/Makefile
> > +++ b/drivers/platform/x86/intel/uncore-frequency/Makefile
> > @@ -7,3 +7,5 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL) += intel-
> > uncore-frequency.o
> >  intel-uncore-frequency-y               := uncore-frequency.o
> >  obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)        += intel-uncore-
> > frequency-common.o
> >  intel-uncore-frequency-common-y                := uncore-
> > frequency-common.o
> > +obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL_TPMI)   += intel-uncore-
> > frequency-tpmi.o
> > +intel-uncore-frequency-tpmi-y          := uncore-frequency-tpmi.o
> > diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-
> > frequency-tpmi.c b/drivers/platform/x86/intel/uncore-
> > frequency/uncore-frequency-tpmi.c
> > new file mode 100644
> > index 000000000000..5e454e9dd4a7
> > --- /dev/null
> > +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > tpmi.c
> > @@ -0,0 +1,338 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * uncore-frquency-tpmi: Uncore frequency scaling using TPMI
> > + *
> > + * Copyright (c) 2023, Intel Corporation.
> > + * All Rights Reserved.
> > + *
> > + * The hardware interface to read/write is basically substitution
> > of
> > + * MSR 0x620 and 0x621.
> > + * There are specific MMIO offset and bits to get/set minimum and
> > + * maximum uncore ratio, similar to MSRs.
> > + * The scope of the uncore MSRs was package scope. But TPMI allows
> > + * new gen CPUs to have multiple uncore controls at uncore-cluster
> > + * level. Each package can have multiple power domains which
> > further
> > + * can have multiple clusters.
> > + * Here number of power domains = number of resources in this aux
> > + * device. There are offsets and bits to discover number of
> > clusters
> > + * and offset for each cluster level controls.
> > + *
> > + */
> > +
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/intel_tpmi.h>
> > +
> > +#include "uncore-frequency-common.h"
> > +
> > +#define        UNCORE_HEADER_VERSION           1
> > +#define UNCORE_HEADER_INDEX            0
> > +#define UNCORE_FABRIC_CLUSTER_OFFSET   8
> > +
> > +/* status + control + adv_ctl1 + adv_ctl2 */
> > +#define UNCORE_FABRIC_CLUSTER_SIZE     (4 * 8)
> > +
> > +#define UNCORE_STATUS_INDEX            0
> > +#define UNCORE_CONTROL_INDEX           8
> > +
> > +#define UNCORE_FREQ_KHZ_MULTIPLIER     100000
> > +
> > +struct tpmi_uncore_struct;
> > +
> > +/* Information for each cluster */
> > +struct tpmi_uncore_cluster_info {
> > +       u8 __iomem *cluster_base;
> > +       struct uncore_data uncore_data;
> > +       struct tpmi_uncore_struct *uncore_root;
> > +};
> > +
> > +/* Information for each power domain */
> > +struct tpmi_uncore_power_domain_info {
> > +       u8 __iomem *uncore_base;
> > +       int ufs_header_ver;
> > +       int cluster_count;
> > +       struct tpmi_uncore_cluster_info *cluster_infos;
> > +};
> > +
> > +/* Information for all power domains in a package */
> > +struct tpmi_uncore_struct {
> > +       int power_domain_count;
> > +       struct tpmi_uncore_power_domain_info *pd_info;
> > +       struct tpmi_uncore_cluster_info root_cluster;
> > +};
> > +
> > +#define UNCORE_GENMASK_MIN_RATIO       GENMASK_ULL(21, 15)
> > +#define UNCORE_GENMASK_MAX_RATIO       GENMASK_ULL(14, 8)
> > +
> > +/* Helper function to read MMIO offset for max/min control
> > frequency */
> > +static void read_control_freq(struct tpmi_uncore_cluster_info
> > *cluster_info,
> > +                            unsigned int *min, unsigned int *max)
> > +{
> > +       u64 control;
> > +
> > +       control = readq(cluster_info->cluster_base +
> > UNCORE_CONTROL_INDEX);
> > +       *max = FIELD_GET(UNCORE_GENMASK_MAX_RATIO, control) *
> > UNCORE_FREQ_KHZ_MULTIPLIER;
> > +       *min = FIELD_GET(UNCORE_GENMASK_MIN_RATIO, control) *
> > UNCORE_FREQ_KHZ_MULTIPLIER;
> > +}
> > +
> > +#define UNCORE_MAX_RATIO       0x7F
> 
> FIELD_MAX(UNCORE_GENMASK_MAX_RATIO) ?
> 
> > +
> > +/* Callback for sysfs read for max/min frequencies. Called under
> > mutex locks */
> > +static int uncore_read_control_freq(struct uncore_data *data,
> > unsigned int *min,
> > +                                   unsigned int *max)
> > +{
> > +       struct tpmi_uncore_cluster_info *cluster_info;
> > +       struct tpmi_uncore_struct *uncore_root;
> > +       int i, _min = 0, _max = 0;
> > +
> > +       cluster_info = container_of(data, struct
> > tpmi_uncore_cluster_info, uncore_data);
> > +       uncore_root = cluster_info->uncore_root;
> > +
> > +       *min = UNCORE_MAX_RATIO * UNCORE_FREQ_KHZ_MULTIPLIER;
> > +       *max = 0;
> > +
> > +       /*
> > +        * Get the max/min by looking at each cluster. Get the
> > lowest
> > +        * min and highest max.
> > +        */
> > +       for (i = 0; i < uncore_root->power_domain_count; ++i) {
> > +               int j;
> > +
> > +               for (j = 0; j < uncore_root-
> > >pd_info[i].cluster_count; ++j) {
> > +                       read_control_freq(&uncore_root-
> > >pd_info[i].cluster_infos[j],
> > +                                         &_min, &_max);
> > +                       if (*min > _min)
> > +                               *min = _min;
> > +                       if (*max < _max)
> > +                               *max = _max;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/* Helper function to write MMIO offset for max/min control
> > frequency */
> > +static void write_control_freq(struct tpmi_uncore_cluster_info
> > *cluster_info, unsigned int input,
> > +                             unsigned int min_max)
> > +{
> > +       u64 control;
> > +
> > +       control = readq(cluster_info->cluster_base +
> > UNCORE_CONTROL_INDEX);
> > +
> > +       if (min_max) {
> > +               control &= ~UNCORE_GENMASK_MAX_RATIO;
> > +               control |= FIELD_PREP(UNCORE_GENMASK_MAX_RATIO,
> > input);
> > +       } else {
> > +               control &= ~UNCORE_GENMASK_MIN_RATIO;
> > +               control |= FIELD_PREP(UNCORE_GENMASK_MIN_RATIO,
> > input);
> > +       }
> > +
> > +       writeq(control, (cluster_info->cluster_base +
> > UNCORE_CONTROL_INDEX));
> > +}
> > +
> > +/* Callback for sysfs write for max/min frequencies. Called under
> > mutex locks */
> > +static int uncore_write_control_freq(struct uncore_data *data,
> > unsigned int input,
> > +                                    unsigned int min_max)
> > +{
> > +       struct tpmi_uncore_cluster_info *cluster_info;
> > +       struct tpmi_uncore_struct *uncore_root;
> > +       int i;
> > +
> > +       input /= UNCORE_FREQ_KHZ_MULTIPLIER;
> > +       if (!input || input > UNCORE_MAX_RATIO)
> > +               return -EINVAL;
> > +
> > +       cluster_info = container_of(data, struct
> > tpmi_uncore_cluster_info, uncore_data);
> > +       uncore_root = cluster_info->uncore_root;
> > +
> > +       /* Update each cluster in a package */
> > +       for (i = 0; i < uncore_root->power_domain_count; ++i) {
> > +               int j;
> > +
> > +               for (j = 0; j < uncore_root-
> > >pd_info[i].cluster_count; ++j)
> > +                       write_control_freq(&uncore_root-
> > >pd_info[i].cluster_infos[j],
> > +                                          input, min_max);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/* Callback for sysfs read for the current uncore frequency.
> > Called under mutex locks */
> > +static int uncore_read_freq(struct uncore_data *data, unsigned int
> > *freq)
> > +{
> > +       return -ENODATA;
> > +}
> > +
> > +#define UNCORE_GENMASK_VERSION                 GENMASK_ULL(7, 0)
> 
> GENMASK makes the name little bit confusing (what is "uncore genmask"
> ??). 
> Either drop it entirely (my preference) or add _MASK to the end
> instead.
> 
> > +#define UNCORE_LOCAL_FABRIC_CLUSTER_ID_MASK    GENMASK_ULL(15, 8)
> > +#define
> > UNCORE_CLUSTER_OFF_MASK                        GENMASK_ULL(7, 0)
> > +#define UNCORE_MAX_CLUSTER_PER_DOMAIN          8
> > +
> > +static int uncore_probe(struct auxiliary_device *auxdev, const
> > struct auxiliary_device_id *id)
> > +{
> > +       struct intel_tpmi_plat_info *plat_info;
> > +       struct tpmi_uncore_struct *tpmi_uncore;
> > +       int ret, i, pkg = 0;
> > +       int num_resources;
> > +
> > +       /* Get number of power domains, which is equal to number of
> > resources */
> > +       num_resources = tpmi_get_resource_count(auxdev);
> > +       if (!num_resources)
> > +               return -EINVAL;
> > +
> > +       /* Register callbacks to uncore core */
> > +       ret = uncore_freq_common_init(uncore_read_control_freq,
> > uncore_write_control_freq,
> > +                                     uncore_read_freq);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Allocate uncore instance per package */
> > +       tpmi_uncore = devm_kzalloc(&auxdev->dev,
> > sizeof(*tpmi_uncore), GFP_KERNEL);
> > +       if (!tpmi_uncore) {
> > +               ret = -ENOMEM;
> > +               goto err_rem_common;
> > +       }
> > +
> > +       /* Allocate memory for all power domains in a package */
> > +       tpmi_uncore->pd_info = devm_kcalloc(&auxdev->dev,
> > num_resources,
> > +                                           sizeof(*tpmi_uncore-
> > >pd_info),
> > +                                           GFP_KERNEL);
> > +       if (!tpmi_uncore->pd_info) {
> > +               ret = -ENOMEM;
> > +               goto err_rem_common;
> > +       }
> > +
> > +       tpmi_uncore->power_domain_count = num_resources;
> > +
> > +       /* Get the package ID from the TPMI core */
> > +       plat_info = tpmi_get_platform_data(auxdev);
> > +       if (plat_info)
> > +               pkg = plat_info->package_id;
> > +       else
> > +               dev_info(&auxdev->dev, "Platform information is
> > NULL\n");
> > +
> > +       for (i = 0; i < num_resources; ++i) {
> > +               struct tpmi_uncore_power_domain_info *pd_info;
> > +               struct resource *res;
> > +               u64 cluster_offset;
> > +               u8 cluster_mask;
> > +               int mask, j;
> > +               u64 header;
> > +
> > +               res = tpmi_get_resource_at_index(auxdev, i);
> > +               if (!res)
> > +                       continue;
> > +
> > +               pd_info = &tpmi_uncore->pd_info[i];
> > +
> > +               pd_info->uncore_base =
> > devm_ioremap_resource(&auxdev->dev, res);
> > +               if (IS_ERR(pd_info->uncore_base)) {
> > +                       ret = PTR_ERR(pd_info->uncore_base);
> > +                       goto err_rem_common;
> > +               }
> > +
> > +               /* Check for version and skip this resource if
> > there is mismatch */
> > +               header = readq(pd_info->uncore_base);
> > +               pd_info->ufs_header_ver = header &
> > UNCORE_GENMASK_VERSION;
> > +               if (pd_info->ufs_header_ver !=
> > UNCORE_HEADER_VERSION) {
> > +                       dev_info(&auxdev->dev, "Uncore: Unsupported
> > version:%d\n",
> > +                               pd_info->ufs_header_ver);
> > +                       continue;
> > +               }
> > +
> > +               /* Get Cluster ID Mask */
> > +               cluster_mask =
> > FIELD_GET(UNCORE_LOCAL_FABRIC_CLUSTER_ID_MASK, header);
> > +               if (!cluster_mask) {
> > +                       dev_info(&auxdev->dev, "Uncore: Invalid
> > cluster mask:%x\n", cluster_mask);
> > +                       continue;
> > +               }
> > +
> > +               /* Find out number of clusters in this resource */
> > +               mask = 0x01;
> > +               for (j = 0; j < UNCORE_MAX_CLUSTER_PER_DOMAIN; ++j)
> > {
> > +                       if (cluster_mask & mask)
> > +                               pd_info->cluster_count++;
> > +                       mask <<= 1;
> > +               }
> 
> pd_info->cluster_count = hweight8(cluster_mask);
> 
> ?
> 
> 

