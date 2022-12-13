Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDDA64AFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 07:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiLMGZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 01:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiLMGZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:25:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687341D653;
        Mon, 12 Dec 2022 22:25:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C5BCB810DD;
        Tue, 13 Dec 2022 06:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D46C433EF;
        Tue, 13 Dec 2022 06:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670912744;
        bh=eMWjSga3C3hMbGjnvBP989uWEXS7JkaxC+FmhAkhfPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xSicbsLVQ4BhWrnWzKoQCDZrmwsGXB9uhhfHqLsox4Od+SI6WsiJFNiIxYhTCvaNW
         7qqxRtiBJgA9N96ZexXmwtyuOOyHAKr0Ynzcyxo5WI10sFx2x8jG5PrLKh4NzQ5aQg
         SGmKnb6d1qDe6AZV1d8NBnQcDi1I7DGidI4nz8Hs=
Date:   Tue, 13 Dec 2022 07:25:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 10/20] gunyah: rsc_mgr: Add resource manager RPC core
Message-ID: <Y5ga5T9dltMtBulF@kroah.com>
References: <20221121140009.2353512-1-quic_eberman@quicinc.com>
 <20221121140009.2353512-11-quic_eberman@quicinc.com>
 <Y3uX9ywOVLubxYkW@kroah.com>
 <a5c7089c-9880-e22a-ae33-eba91dc47f0e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5c7089c-9880-e22a-ae33-eba91dc47f0e@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 03:46:58PM -0800, Elliot Berman wrote:
> 
> 
> On 11/21/2022 7:23 AM, Greg Kroah-Hartman wrote:
> > On Mon, Nov 21, 2022 at 05:59:59AM -0800, Elliot Berman wrote:
> > > The resource manager is a special virtual machine which is always
> > > running on a Gunyah system. It provides APIs for creating and destroying
> > > VMs, secure memory management, sharing/lending of memory between VMs,
> > > and setup of inter-VM communication. Calls to the resource manager are
> > > made via message queues.
> > > 
> > > This patch implements the basic probing and RPC mechanism to make those
> > > API calls. Request/response calls can be made with gh_rm_call.
> > > Drivers can also register to notifications pushed by RM via
> > > gh_rm_register_notifier
> > > 
> > > Specific API calls that resource manager supports will be implemented in
> > > subsequent patches.
> > > 
> > > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > > ---
> > >   MAINTAINERS                          |   2 +-
> > >   drivers/virt/gunyah/Kconfig          |   7 +
> > >   drivers/virt/gunyah/Makefile         |   2 +
> > >   drivers/virt/gunyah/gunyah_rm_rpc.c  | 570 +++++++++++++++++++++++++++
> > >   drivers/virt/gunyah/gunyah_rsc_mgr.c |  50 +++
> > >   drivers/virt/gunyah/rsc_mgr.h        |  37 ++
> > >   include/linux/gunyah_rsc_mgr.h       |  18 +
> > >   7 files changed, 685 insertions(+), 1 deletion(-)
> > >   create mode 100644 drivers/virt/gunyah/gunyah_rm_rpc.c
> > >   create mode 100644 drivers/virt/gunyah/gunyah_rsc_mgr.c
> > >   create mode 100644 drivers/virt/gunyah/rsc_mgr.h
> > >   create mode 100644 include/linux/gunyah_rsc_mgr.h
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 502798197b80..b65f7ff444e5 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -8948,7 +8948,7 @@ F:	Documentation/virt/gunyah/
> > >   F:	arch/arm64/gunyah/
> > >   F:	drivers/mailbox/gunyah-msgq.c
> > >   F:	drivers/virt/gunyah/
> > > -F:	include/linux/gunyah.h
> > > +F:	include/linux/gunyah*.h
> > >   HABANALABS PCI DRIVER
> > >   M:	Oded Gabbay <ogabbay@kernel.org>
> > > diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
> > > index 127156a678a6..0bb497372d4e 100644
> > > --- a/drivers/virt/gunyah/Kconfig
> > > +++ b/drivers/virt/gunyah/Kconfig
> > > @@ -10,3 +10,10 @@ config GUNYAH
> > >   	  Say Y/M here to enable the drivers needed to interact in a Gunyah
> > >   	  virtual environment.
> > > +
> > > +if GUNYAH
> > > +config GUNYAH_RESOURCE_MANAGER
> > > +	tristate
> > > +	depends on MAILBOX
> > > +	select GUNYAH_MESSAGE_QUEUES
> > > +endif
> > > diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> > > index 2ac4ee64b89d..b62ac4045621 100644
> > > --- a/drivers/virt/gunyah/Makefile
> > > +++ b/drivers/virt/gunyah/Makefile
> > > @@ -1 +1,3 @@
> > >   obj-$(CONFIG_GUNYAH) += gunyah.o
> > > +
> > > +obj-$(CONFIG_GUNYAH_RESOURCE_MANAGER) += gunyah_rsc_mgr.o gunyah_rm_rpc.o
> > > diff --git a/drivers/virt/gunyah/gunyah_rm_rpc.c b/drivers/virt/gunyah/gunyah_rm_rpc.c
> > > new file mode 100644
> > > index 000000000000..45b1a8691982
> > > --- /dev/null
> > > +++ b/drivers/virt/gunyah/gunyah_rm_rpc.c
> > > @@ -0,0 +1,570 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> > > + */
> > > +
> > > +#include <linux/of.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/sched.h>
> > > +#include <linux/gunyah.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_irq.h>
> > > +#include <linux/kthread.h>
> > > +#include <linux/notifier.h>
> > > +#include <linux/workqueue.h>
> > > +#include <linux/completion.h>
> > > +#include <linux/gunyah_rsc_mgr.h>
> > > +#include <linux/platform_device.h>
> > 
> > This should not have anything to do with a platform device, please see
> > below.
> > 
> > > +#include <linux/gunyah_rsc_mgr.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +#include "rsc_mgr.h"
> > > +
> > > +static int gh_rm_drv_probe(struct platform_device *pdev)
> > 
> > Why is this tied to a platformm device?
> > 
> > I don't understand the relationship here, sorry.
> > >> +{
> > > +	struct gh_rm_rpc *rsc_mgr;
> > > +
> > > +	rsc_mgr = gh_rm_rpc_init(pdev);
> > 
> > Shouldn't this be creating a new one that is just a child passed in?
> > Shouldn't this call just take a 'struct device *'?
> > 
> 
> I'm following the suggestion from Arnd to have small core module that calls
> into initialization routines for the other parts of the driver, rather than
> creating bus for a few (2) devices.
> 
> https://lore.kernel.org/all/a3754259-9989-495e-a6bd-5501daff06a2@app.fastmail.com/

2 devices is still a bus.  Please don't mess with the driver model in
ways it is not ment to be messed with if at all possible.

And again, don't abuse platform devices for dynamically discovered
devices like this.

thanks,

greg k-h
