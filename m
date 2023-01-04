Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CFA65DF3F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbjADVqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbjADVq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:46:28 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F18A1EAE9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 13:45:44 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso656144pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 13:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3utNW8RyigO23mXhzyAM84LPO/J9Py8x9A9gfeJacsM=;
        b=uqyUyuv9D6cJdFh1fJwsUslZYYhtS+WbN4OS0kyL4ak8DFkI32Nug/9+Z89u0i+lW3
         fgQIA6LT2k0RBkICx8Z1XSO3H3KeRYWv9B8otFiS7PHN3haTbucXojCU2J5kqQOy8WXz
         oeJLbyosSsuTEhif6dwZEWW0fYeVFqFNyr5cfcTzScDXX0fNknMQoFp3DfF9NCjkFmkX
         MNpq4yE/BjoQPy42jv5jx3VqRmXHS5rsYuTUiZYgFvDl7q8+xk2QlCTvZYv21IOaMZzU
         VE5PrjZR/cnKKKkl39wPGP0DsozbgNQ1Onj2VwpANQqJ2CeH4p558e50BX76mSKjC1BG
         r5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3utNW8RyigO23mXhzyAM84LPO/J9Py8x9A9gfeJacsM=;
        b=Kus/bPmVMREWtrZrSuNFoJb1U6m5rGpVEjt5PSgOoFYoscVrV1/KL6cpVfldjqgwhh
         Yvdh12NCsdWPatb9ghBX5n4yBepwf9pR8SSMcKaXPH0SxeGPjEufn6Pz8IaO3/CHgdzx
         oC1jakUVzLUZgbujnIwMmCcJXH0A7xm4ylSz+nijxx39gtRcYx2ewSy9xfDXQS3EtO4X
         oTR7LUbK2ilAsORbwtFf7JcjWA3GSK+2iVt1nlg8G6GSeRzGpu+3WXDirz0mUSWi8v1y
         UvFvW8pdn9BgFgYBb/cYZsuX8WznYFVeSLvQ3uYCFXf9oRpsRo9u3nAfwciYa503N8OE
         4xAw==
X-Gm-Message-State: AFqh2kpwvNv9rx07exmglTEogFuWCr+l2P0WDGsR4NDmVPz8aT3VSJ5L
        owctWQwIM4CCsBRs5B9LCnnyeA==
X-Google-Smtp-Source: AMrXdXuRR3Pne1sYUyvbr5mO/M88f4ab+h2SFLd5CsKmzd0yYrql72jhvfC5Ue9Ewd6Pz5SvJSATpA==
X-Received: by 2002:a17:902:b60d:b0:188:8745:35af with SMTP id b13-20020a170902b60d00b00188874535afmr60684138pls.63.1672868743886;
        Wed, 04 Jan 2023 13:45:43 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:1328:ca09:d4c2:fcbc])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709029a4400b00189af02aba4sm24722158plv.3.2023.01.04.13.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:45:43 -0800 (PST)
Date:   Wed, 4 Jan 2023 14:45:41 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.levinsky@xilinx.com
Subject: Re: [PATCH] remoteproc: Make rproc_get_by_phandle() work for clusters
Message-ID: <20230104214541.GA2112402@p14s>
References: <20221214221643.1286585-1-mathieu.poirier@linaro.org>
 <20221227151131.hkezt4j2om5volnu@builder.lan>
 <CANLsYkwrCoX=Mw5YDJq-1hvmB3tH2admCC5GodwU0=jggmZg0w@mail.gmail.com>
 <20230104155613.xclae5hup2ybypdo@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104155613.xclae5hup2ybypdo@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 09:56:13AM -0600, Bjorn Andersson wrote:
> On Tue, Jan 03, 2023 at 11:48:56AM -0700, Mathieu Poirier wrote:
> > On Tue, 27 Dec 2022 at 08:11, Bjorn Andersson <andersson@kernel.org> wrote:
> > >
> > > On Wed, Dec 14, 2022 at 03:16:43PM -0700, Mathieu Poirier wrote:
> > > > Multi-cluster remoteproc designs typically have the following DT
> > > > declaration:
> > > >
> > > >       remoteproc_cluster {
> > > >               compatible = "soc,remoteproc-cluster";
> > > >
> > > >                 core0: core0 {
> > > >                       compatible = "soc,remoteproc-core"
> > > >                         memory-region;
> > > >                         sram;
> > > >                 };
> > > >
> > > >                 core1: core1 {
> > > >                       compatible = "soc,remoteproc-core"
> > > >                         memory-region;
> > > >                         sram;
> > > >                 }
> > > >         };
> > > >
> > > > A driver exists for the cluster rather than the individual cores
> > > > themselves so that operation mode and HW specific configurations
> > > > applicable to the cluster can be made.
> > > >
> > > > Because the driver exists at the cluster level and not the individual
> > > > core level, function rproc_get_by_phandle() fails to return the
> > > > remoteproc associated with the phandled it is called for.
> > > >
> > > > This patch enhances rproc_get_by_phandle() by looking for the cluster's
> > > > driver when the driver for the immediate remoteproc's parent is not
> > > > found.
> > > >
> > >
> > > Can you please help me understand why zynqmp_r5_remoteproc_probe()
> > > invokes devm_of_platform_populate() to create platform_device instances
> > > for the clusters?
> > >
> > 
> > Platform device instances are created for the individual cores found
> > in the cluster, following the work done on TI's K3-R5[1].
> > 
> 
> Right, and this is a design pattern that I've been bitten by several
> times by now. There's no real purpose of spinning up platform_devices
> for those nodes.
> 

Calling of_platform_populate() happened before my time in this subsystem.  I
thought you were favourable to it.  Can you give one or two examples where it caused
you grief?

> > > Why can't the platform_device for the cluster be used as parent for both
> > > remoteprocs and then the driver deal with the subnodes within the
> > > driver?
> > >
> > 
> > That is exactly how things work for both K3-R5 and R5F architectures.
> > That said, if we use the cluster's platform device as parent of the
> > remote processors inside the cluster, function rproc_get_by_phandle()
> > will return the first remote processor it finds with a matching parent
> > rather than the remote processor referenced by the phandle parameter.
> > 
> 
> I missed the fact that we don't associate either the rproc or the rproc
> device with the of_node, but rather just rely on the fact that
> rproc->dev->parent->of_node is typically is the handle we're looking
> for.
> 
> And I don't think we'll return the first instance, because
> rproc->dev->parent->of_node will never match the instance's of_node.
> 

My first suggestion was also to use the cluster's device as parent to the remote
processors inside the cluster but it didn't work, though the exact details are
lost in the holiday's fairy dust.  Looking more closely at the code I think you
are correct.

> 
> I think it would be cleaner to add a of_node to struct rproc and use
> this for matching.
> 

I also considered that option but decided to proceed differently because it
duplicates of_node information that is already available and requires
modifications to the drivers already using rproc_get_by_phandle().   Unless
I'm missing something we would still have to call of_platform_populate() to get
the of_node information...  And modify the parameters to rproc_alloc(), which
cascades exponentially.

> And I do suggest that we don't of_platform_populate() in the TI driver.
> If nothing else, doing so saves ~2kb of wasted RAM...
> 

And that would require a serious refactoring exercise that, in my opinion, far
outweigh the benefits.

Thanks,
Mathieu
 

> > [1]. https://elixir.bootlin.com/linux/v6.2-rc2/source/drivers/remoteproc/ti_k3_r5_remoteproc.c#L1728
> > 
> > > Regards,
> > > Bjorn
> > >
> > > > Reported-by: Ben Levinsky <ben.levinsky@xilinx.com>
> > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > ---
> > > >  drivers/remoteproc/remoteproc_core.c | 28 +++++++++++++++++++++++++++-
> > > >  1 file changed, 27 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > > index 1cd4815a6dd1..91f82886add9 100644
> > > > --- a/drivers/remoteproc/remoteproc_core.c
> > > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > > @@ -33,6 +33,7 @@
> > > >  #include <linux/idr.h>
> > > >  #include <linux/elf.h>
> > > >  #include <linux/crc32.h>
> > > > +#include <linux/of_platform.h>
> > > >  #include <linux/of_reserved_mem.h>
> > > >  #include <linux/virtio_ids.h>
> > > >  #include <linux/virtio_ring.h>
> > > > @@ -2110,7 +2111,9 @@ EXPORT_SYMBOL(rproc_detach);
> > > >  #ifdef CONFIG_OF
> > > >  struct rproc *rproc_get_by_phandle(phandle phandle)
> > > >  {
> > > > +     struct platform_device *cluster_pdev;
> > > >       struct rproc *rproc = NULL, *r;
> > > > +     struct device_driver *driver;
> > > >       struct device_node *np;
> > > >
> > > >       np = of_find_node_by_phandle(phandle);
> > > > @@ -2121,7 +2124,30 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
> > > >       list_for_each_entry_rcu(r, &rproc_list, node) {
> > > >               if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
> > > >                       /* prevent underlying implementation from being removed */
> > > > -                     if (!try_module_get(r->dev.parent->driver->owner)) {
> > > > +
> > > > +                     /*
> > > > +                      * If the remoteproc's parent has a driver, the
> > > > +                      * remoteproc is not part of a cluster and we can use
> > > > +                      * that driver.
> > > > +                      */
> > > > +                     driver = r->dev.parent->driver;
> > > > +
> > > > +                     /*
> > > > +                      * If the remoteproc's parent does not have a driver,
> > > > +                      * look for the driver associated with the cluster.
> > > > +                      */
> > > > +                     if (!driver) {
> > > > +                             cluster_pdev = of_find_device_by_node(np->parent);
> 
> Doing so also has the added benefit that we don't add an implicitly
> requirement on the rproc-device's parent being a platform_driver.
> 
> Regards,
> Bjorn
> 
> > > > +                             if (!cluster_pdev) {
> > > > +                                     dev_err(&r->dev, "can't get parent\n");
> > > > +                                     break;
> > > > +                             }
> > > > +
> > > > +                             driver = cluster_pdev->dev.driver;
> > > > +                             put_device(&cluster_pdev->dev);
> > > > +                     }
> > > > +
> > > > +                     if (!try_module_get(driver->owner)) {
> > > >                               dev_err(&r->dev, "can't get owner\n");
> > > >                               break;
> > > >                       }
> > > > --
> > > > 2.25.1
> > > >
