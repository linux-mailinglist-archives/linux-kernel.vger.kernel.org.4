Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0830B65C6BA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbjACSuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238800AbjACStY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:49:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08F213D0F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:49:08 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id az7so6166452wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 10:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EClO0eHZ1ZJTRLCT268bG05mzbFFKh0lHqO8s/xO1kk=;
        b=k7FQg5RzPgxmKbPgb5mNDLxvWLIeik0YusJeYvDd/AvjkCX7QT89J8ToSCvh1FzaEl
         PN3NapKsfaLIJptreMlTSBtqH1JTfn6HuSLCTvkwBSPbta8Uh+7NwUZpUE0cWKftgdrE
         s9x8R9JyLehSOxhrB6wlnGzlksrOEbcydJgiobN7G9TGKOIXa0ceAspZxwZanb9azXmU
         voHYHUbBNDfBnuTWTzFS1rMK5qNtahmEL3ZApYJt+OhAsKUawqmKos9ilJ3Hnt/Inetp
         4oK2LX6bfmTQ5Ck0hN/oW3Sk4LCp9Z21VeWgS42GHbw1zvDoKzhv6cOnzWMgPefUBgr0
         f26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EClO0eHZ1ZJTRLCT268bG05mzbFFKh0lHqO8s/xO1kk=;
        b=SSnhtzYHDfBtwojyGv70DAYTX2Pex0JNvxihjxIOg0hpISiyyQuiuTvUNxVhgGjvnq
         Lz27nT09C4gVoTVUXzoIRe2NtZmdifEAUAdXCfcsKnieXbT70Lt4ctsp9cRMo/J8ZByv
         zAlfvf7MrLyrpLtA3GMqH++PUlhShUAoWbawTRKq30oVn39rErakql1+MZF/dV4z1boG
         eHWWaThSGkhHqn7LDgAnml2qYG7KjEBCYCMEAx9IyMXfjYnoZ0CvrO9h0uwq0kaiO61f
         sixZAdX/W1j9Bnm2bfgd/dtJOYvFCaM7D8LSQgsFQu9GkzEay7YAdgd517jesyVqF4o3
         /jjA==
X-Gm-Message-State: AFqh2koMONorZvNbqzcpr8XhcZGWpq5rxBq0eQrQI4XOlsl1yxe7J/t7
        yTqOwZ8i7QzCMpgVfhd03wNvIesYFaix+BXxQvB7BSNigUljcwQw
X-Google-Smtp-Source: AMrXdXvCMhSN98FeNpcisc6mzx12pLOOnLKrYEUr+nxMFAz4ph9VTNujcEWbOf7kYXCzitxDDwl1bnNOcRDQy69jmPk=
X-Received: by 2002:a5d:4305:0:b0:29d:780d:182c with SMTP id
 h5-20020a5d4305000000b0029d780d182cmr149100wrq.251.1672771747211; Tue, 03 Jan
 2023 10:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20221214221643.1286585-1-mathieu.poirier@linaro.org> <20221227151131.hkezt4j2om5volnu@builder.lan>
In-Reply-To: <20221227151131.hkezt4j2om5volnu@builder.lan>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 3 Jan 2023 11:48:56 -0700
Message-ID: <CANLsYkwrCoX=Mw5YDJq-1hvmB3tH2admCC5GodwU0=jggmZg0w@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: Make rproc_get_by_phandle() work for clusters
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.levinsky@xilinx.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022 at 08:11, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Wed, Dec 14, 2022 at 03:16:43PM -0700, Mathieu Poirier wrote:
> > Multi-cluster remoteproc designs typically have the following DT
> > declaration:
> >
> >       remoteproc_cluster {
> >               compatible = "soc,remoteproc-cluster";
> >
> >                 core0: core0 {
> >                       compatible = "soc,remoteproc-core"
> >                         memory-region;
> >                         sram;
> >                 };
> >
> >                 core1: core1 {
> >                       compatible = "soc,remoteproc-core"
> >                         memory-region;
> >                         sram;
> >                 }
> >         };
> >
> > A driver exists for the cluster rather than the individual cores
> > themselves so that operation mode and HW specific configurations
> > applicable to the cluster can be made.
> >
> > Because the driver exists at the cluster level and not the individual
> > core level, function rproc_get_by_phandle() fails to return the
> > remoteproc associated with the phandled it is called for.
> >
> > This patch enhances rproc_get_by_phandle() by looking for the cluster's
> > driver when the driver for the immediate remoteproc's parent is not
> > found.
> >
>
> Can you please help me understand why zynqmp_r5_remoteproc_probe()
> invokes devm_of_platform_populate() to create platform_device instances
> for the clusters?
>

Platform device instances are created for the individual cores found
in the cluster, following the work done on TI's K3-R5[1].

> Why can't the platform_device for the cluster be used as parent for both
> remoteprocs and then the driver deal with the subnodes within the
> driver?
>

That is exactly how things work for both K3-R5 and R5F architectures.
That said, if we use the cluster's platform device as parent of the
remote processors inside the cluster, function rproc_get_by_phandle()
will return the first remote processor it finds with a matching parent
rather than the remote processor referenced by the phandle parameter.

[1]. https://elixir.bootlin.com/linux/v6.2-rc2/source/drivers/remoteproc/ti_k3_r5_remoteproc.c#L1728

> Regards,
> Bjorn
>
> > Reported-by: Ben Levinsky <ben.levinsky@xilinx.com>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 1cd4815a6dd1..91f82886add9 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/idr.h>
> >  #include <linux/elf.h>
> >  #include <linux/crc32.h>
> > +#include <linux/of_platform.h>
> >  #include <linux/of_reserved_mem.h>
> >  #include <linux/virtio_ids.h>
> >  #include <linux/virtio_ring.h>
> > @@ -2110,7 +2111,9 @@ EXPORT_SYMBOL(rproc_detach);
> >  #ifdef CONFIG_OF
> >  struct rproc *rproc_get_by_phandle(phandle phandle)
> >  {
> > +     struct platform_device *cluster_pdev;
> >       struct rproc *rproc = NULL, *r;
> > +     struct device_driver *driver;
> >       struct device_node *np;
> >
> >       np = of_find_node_by_phandle(phandle);
> > @@ -2121,7 +2124,30 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
> >       list_for_each_entry_rcu(r, &rproc_list, node) {
> >               if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
> >                       /* prevent underlying implementation from being removed */
> > -                     if (!try_module_get(r->dev.parent->driver->owner)) {
> > +
> > +                     /*
> > +                      * If the remoteproc's parent has a driver, the
> > +                      * remoteproc is not part of a cluster and we can use
> > +                      * that driver.
> > +                      */
> > +                     driver = r->dev.parent->driver;
> > +
> > +                     /*
> > +                      * If the remoteproc's parent does not have a driver,
> > +                      * look for the driver associated with the cluster.
> > +                      */
> > +                     if (!driver) {
> > +                             cluster_pdev = of_find_device_by_node(np->parent);
> > +                             if (!cluster_pdev) {
> > +                                     dev_err(&r->dev, "can't get parent\n");
> > +                                     break;
> > +                             }
> > +
> > +                             driver = cluster_pdev->dev.driver;
> > +                             put_device(&cluster_pdev->dev);
> > +                     }
> > +
> > +                     if (!try_module_get(driver->owner)) {
> >                               dev_err(&r->dev, "can't get owner\n");
> >                               break;
> >                       }
> > --
> > 2.25.1
> >
