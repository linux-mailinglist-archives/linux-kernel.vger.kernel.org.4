Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D570030B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjELI4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 04:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbjELI4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 04:56:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F1ABE43;
        Fri, 12 May 2023 01:56:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 793DEFEC;
        Fri, 12 May 2023 01:56:41 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB9E63F663;
        Fri, 12 May 2023 01:55:55 -0700 (PDT)
Date:   Fri, 12 May 2023 09:55:53 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peng Fan <peng.fan@oss.nxp.com>,
        Michal Simek <michal.simek@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v2 1/3] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZF3/Ge4b+49ni+e6@e120937-lin>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
 <b4d60f3408f8fe839933fa3938ecdc9bfceb75d7.1682513390.git.oleksii_moisieiev@epam.com>
 <ZFVeY3jVNfAkW1G9@e120937-lin>
 <20230512083805.GA3424996@EPUAKYIW0A6A>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512083805.GA3424996@EPUAKYIW0A6A>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 08:38:06AM +0000, Oleksii Moisieiev wrote:
> On Fri, May 05, 2023 at 08:52:03PM +0100, Cristian Marussi wrote:
> > On Wed, Apr 26, 2023 at 01:26:37PM +0000, Oleksii Moisieiev wrote:
> > > scmi: Introduce pinctrl SCMI protocol driver
> > > 
> > > Add basic implementation of the SCMI v3.2 pincontrol protocol
> > > excluding GPIO support. All pinctrl related callbacks and operations
> > > are exposed in the include/linux/scmi_protocol.h
> > > 
> > 
> > Hi Oleksii,
> > 
> > Thanks for this.
> > 
> > I tried out this in an emulated setup and found just a minor issue from
> > the spec/functional point of view...then I reworked the extended names
> > support using a modified hops->extended_name_get helper (as said the core
> > SCMI support needed a small modification to support PINCTRL): I'll reply
> > to this mail thread with such core SCMI modification patch, so you can
> > include this patch of mine in your next V3 and use it in your series.
> > 
> > Moreover, given that I wanted to test such rework of mine and a bunch
> > of other cleanups I did (as detailed down below), and it seemed silly
> > to throw all away just to then having to detail all to you, I'll also
> > include in another distinct reply the raw diff of what I changed in
> > your series to use the new extended_name support and a few other cleanups,
> > so that, if you want, you can just quickly merge that into your V3 patch
> > (of course if you like it and tests fine also for you...)...these are
> > small changes, if you take it, no need to bother with authorship and
> > attribution from my point of view.
> > 
> 
> Hi Cristian,
> 

Hi,

> Thank you for the patches. I've applied them and tested with powerpc,
> mx68 and clang environments (as test-robot complained about).
> 

Yes, sure, they were just tentative fixes, needed cleanup.
I forgot to add the RFC tag on my proposed fixes to avoid triggering the bots.

> > > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > > ---
> > >  MAINTAINERS                           |   6 +
> 
> [snip]
> 
> > >  SYSTEM RESET/SHUTDOWN DRIVERS
> > >  M:	Sebastian Reichel <sre@kernel.org>
> > >  L:	linux-pm@vger.kernel.org
> > > diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> > > index b31d78fa66cc..071ac65f22b9 100644
> > > --- a/drivers/firmware/arm_scmi/Makefile
> > > +++ b/drivers/firmware/arm_scmi/Makefile
> > > @@ -3,6 +3,7 @@ scmi-bus-y = bus.o
> > >  scmi-core-objs := $(scmi-bus-y)
> > >  
> > >  scmi-driver-y = driver.o notify.o
> > > +
> > 
> > Do not add spurios lines.
> > 
> 
> Thanks, removed
> 
> > >  scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) += raw_mode.o
> > >  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
> > >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += mailbox.o
> > > @@ -10,7 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
> > >  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
> > >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
> > >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
> > > -scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
> > > +scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o pinctrl.o
> > >  scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
> > >  
> 
> I've applied patches you provided and made a small fixes. I'm going to
> make patch:
> "firmware: arm_scmi: Add optional flags to extended names helper"
> as a separate and squach "Misc Fixes and refactor" to my changes in V3 if you
> don't mind.

Sure, that's what I meant: include my general extended fixes at the
start of your series and just squash the misc_fixes (additionally fixed
by you :D) in your series.

A small nitpick I noticed later in scmi_protocol_ops Dox comment

+ * struct scmi_pinctrl_protocol_ops - represents the various operations provided

should be 
  * struct scmi_pinctrl_proto_ops

Thanks,
Cristian

