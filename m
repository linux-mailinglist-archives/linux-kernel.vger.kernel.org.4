Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D935D65D7A5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbjADP4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjADP4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:56:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7956D11A;
        Wed,  4 Jan 2023 07:56:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 154886177E;
        Wed,  4 Jan 2023 15:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246EEC433F0;
        Wed,  4 Jan 2023 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672847775;
        bh=BFhoNEODuOM6811znfG4kUmLy5V2WTxufRli/c+8ciQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWCZl62LYN2Ze88Ll8ir8Q/NNeuw1cJqW/Zz3vMDPWfQGcIB99TpvdsPVmo5gQaky
         DQcsbaVkoZEKQytVnjdlffC0Dx6XdGHjROBGoZDf9DgRR7AOsCNlw+k4Rcd6k5a3fh
         qe+xVdHOayfuo51KNDtyPjlUSds5IZTXX93kHfy8tjVsYX8OjkNxUFw2DGyY9h9Hh9
         YyMUucpy2+pltBwZqIhopzeupYm6nqAyTvxcpOO3mjhro2gCuCSy2WlabrRlpFJCFU
         ZjDqFufWk0pSIvsKPBFd51bQCtUYtFHq/YqYnnd49ct/CHQNodzUHXT/WzTVK6JQxF
         j8c+3SmIOAawA==
Date:   Wed, 4 Jan 2023 09:56:13 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.levinsky@xilinx.com
Subject: Re: [PATCH] remoteproc: Make rproc_get_by_phandle() work for clusters
Message-ID: <20230104155613.xclae5hup2ybypdo@builder.lan>
References: <20221214221643.1286585-1-mathieu.poirier@linaro.org>
 <20221227151131.hkezt4j2om5volnu@builder.lan>
 <CANLsYkwrCoX=Mw5YDJq-1hvmB3tH2admCC5GodwU0=jggmZg0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwrCoX=Mw5YDJq-1hvmB3tH2admCC5GodwU0=jggmZg0w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:48:56AM -0700, Mathieu Poirier wrote:
> On Tue, 27 Dec 2022 at 08:11, Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Wed, Dec 14, 2022 at 03:16:43PM -0700, Mathieu Poirier wrote:
> > > Multi-cluster remoteproc designs typically have the following DT
> > > declaration:
> > >
> > >       remoteproc_cluster {
> > >               compatible = "soc,remoteproc-cluster";
> > >
> > >                 core0: core0 {
> > >                       compatible = "soc,remoteproc-core"
> > >                         memory-region;
> > >                         sram;
> > >                 };
> > >
> > >                 core1: core1 {
> > >                       compatible = "soc,remoteproc-core"
> > >                         memory-region;
> > >                         sram;
> > >                 }
> > >         };
> > >
> > > A driver exists for the cluster rather than the individual cores
> > > themselves so that operation mode and HW specific configurations
> > > applicable to the cluster can be made.
> > >
> > > Because the driver exists at the cluster level and not the individual
> > > core level, function rproc_get_by_phandle() fails to return the
> > > remoteproc associated with the phandled it is called for.
> > >
> > > This patch enhances rproc_get_by_phandle() by looking for the cluster's
> > > driver when the driver for the immediate remoteproc's parent is not
> > > found.
> > >
> >
> > Can you please help me understand why zynqmp_r5_remoteproc_probe()
> > invokes devm_of_platform_populate() to create platform_device instances
> > for the clusters?
> >
> 
> Platform device instances are created for the individual cores found
> in the cluster, following the work done on TI's K3-R5[1].
> 

Right, and this is a design pattern that I've been bitten by several
times by now. There's no real purpose of spinning up platform_devices
for those nodes.

> > Why can't the platform_device for the cluster be used as parent for both
> > remoteprocs and then the driver deal with the subnodes within the
> > driver?
> >
> 
> That is exactly how things work for both K3-R5 and R5F architectures.
> That said, if we use the cluster's platform device as parent of the
> remote processors inside the cluster, function rproc_get_by_phandle()
> will return the first remote processor it finds with a matching parent
> rather than the remote processor referenced by the phandle parameter.
> 

I missed the fact that we don't associate either the rproc or the rproc
device with the of_node, but rather just rely on the fact that
rproc->dev->parent->of_node is typically is the handle we're looking
for.

And I don't think we'll return the first instance, because
rproc->dev->parent->of_node will never match the instance's of_node.


I think it would be cleaner to add a of_node to struct rproc and use
this for matching.

And I do suggest that we don't of_platform_populate() in the TI driver.
If nothing else, doing so saves ~2kb of wasted RAM...

> [1]. https://elixir.bootlin.com/linux/v6.2-rc2/source/drivers/remoteproc/ti_k3_r5_remoteproc.c#L1728
> 
> > Regards,
> > Bjorn
> >
> > > Reported-by: Ben Levinsky <ben.levinsky@xilinx.com>
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > ---
> > >  drivers/remoteproc/remoteproc_core.c | 28 +++++++++++++++++++++++++++-
> > >  1 file changed, 27 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > index 1cd4815a6dd1..91f82886add9 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -33,6 +33,7 @@
> > >  #include <linux/idr.h>
> > >  #include <linux/elf.h>
> > >  #include <linux/crc32.h>
> > > +#include <linux/of_platform.h>
> > >  #include <linux/of_reserved_mem.h>
> > >  #include <linux/virtio_ids.h>
> > >  #include <linux/virtio_ring.h>
> > > @@ -2110,7 +2111,9 @@ EXPORT_SYMBOL(rproc_detach);
> > >  #ifdef CONFIG_OF
> > >  struct rproc *rproc_get_by_phandle(phandle phandle)
> > >  {
> > > +     struct platform_device *cluster_pdev;
> > >       struct rproc *rproc = NULL, *r;
> > > +     struct device_driver *driver;
> > >       struct device_node *np;
> > >
> > >       np = of_find_node_by_phandle(phandle);
> > > @@ -2121,7 +2124,30 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
> > >       list_for_each_entry_rcu(r, &rproc_list, node) {
> > >               if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
> > >                       /* prevent underlying implementation from being removed */
> > > -                     if (!try_module_get(r->dev.parent->driver->owner)) {
> > > +
> > > +                     /*
> > > +                      * If the remoteproc's parent has a driver, the
> > > +                      * remoteproc is not part of a cluster and we can use
> > > +                      * that driver.
> > > +                      */
> > > +                     driver = r->dev.parent->driver;
> > > +
> > > +                     /*
> > > +                      * If the remoteproc's parent does not have a driver,
> > > +                      * look for the driver associated with the cluster.
> > > +                      */
> > > +                     if (!driver) {
> > > +                             cluster_pdev = of_find_device_by_node(np->parent);

Doing so also has the added benefit that we don't add an implicitly
requirement on the rproc-device's parent being a platform_driver.

Regards,
Bjorn

> > > +                             if (!cluster_pdev) {
> > > +                                     dev_err(&r->dev, "can't get parent\n");
> > > +                                     break;
> > > +                             }
> > > +
> > > +                             driver = cluster_pdev->dev.driver;
> > > +                             put_device(&cluster_pdev->dev);
> > > +                     }
> > > +
> > > +                     if (!try_module_get(driver->owner)) {
> > >                               dev_err(&r->dev, "can't get owner\n");
> > >                               break;
> > >                       }
> > > --
> > > 2.25.1
> > >
