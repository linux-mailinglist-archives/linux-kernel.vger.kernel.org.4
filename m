Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D28B743F61
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjF3QCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjF3QCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:02:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA60310A;
        Fri, 30 Jun 2023 09:02:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27FAC2F4;
        Fri, 30 Jun 2023 09:03:00 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20BF23F73F;
        Fri, 30 Jun 2023 09:02:15 -0700 (PDT)
Date:   Fri, 30 Jun 2023 17:02:12 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     andy.shevchenko@gmail.com
Cc:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZJ78hBcjAhiU+ZBO@e120937-lin>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <d388c7af3f72fd47baffe0de8c6fec8074cb483c.1686063941.git.oleksii_moisieiev@epam.com>
 <ZIAtdLTvM6qh4r9W@surfacebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIAtdLTvM6qh4r9W@surfacebook>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:10:44AM +0300, andy.shevchenko@gmail.com wrote:
> Tue, Jun 06, 2023 at 04:22:27PM +0000, Oleksii Moisieiev kirjoitti:

Hi Andy,

I'll answer some of your remarks down below, since more generally
related to the SCMI stack.

> > scmi: Introduce pinctrl SCMI protocol driver
> 
> Seems like you forgot to remove previous line(s) in the commit message and
> the above has to be the Subject here.
> 
> > Add basic implementation of the SCMI v3.2 pincontrol protocol
> > excluding GPIO support. All pinctrl related callbacks and operations
> > are exposed in the include/linux/scmi_protocol.h
> 
> drop include/ part, everybody will understand that. Also mind the grammar
> period.
> 
> ...
> 
> > -scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
> > +scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o pinctrl.o
> 
> Why not splitting it and make it ordered?
>

Maybe a good idea for a separate cleanup...not sure can fit this series
without causing churn with other in-flight SCMI series...I'll happily wait
for Sudeep to decide.

> ...
> 
> Missing headers:
> 
> 	bitfield.h
> 	bits.h
> 	byteorder/
> 	types.h
> 
> > +#include <linux/module.h>
> > +#include <linux/scmi_protocol.h>
> > +#include <linux/slab.h>
> 
> Missing
> 
> 	asm/unaligned.h
> 
> ...
>

Most if not all of these headers are already included by the

	#include "protocols.h"

above that introduces a lot of common other stuff needed to implement
a new SCMI protocol.

> > +struct scmi_group_info { 
> > +       bool present; 
> > +       char name[SCMI_MAX_STR_SIZE]; 
> > +       unsigned int *group_pins; 
> > +       unsigned int nr_pins; 
> > +}; 
>  
> So, why struct pingroup can't be embeded here?
> 
> > +struct scmi_function_info {
> > +	bool present;
> > +	char name[SCMI_MAX_STR_SIZE];
> > +	unsigned int *groups;
> > +	unsigned int nr_groups;
> > +};
> 
> So, why and struct pinfunction can't be embedded here (yes, you would need a
> duplication of groups as here they are integers)?
> 
> As far as I understand these data structures are not part of any ABI (otherwise
> the wrong type(s) / padding might be in use) and hence don't see the impediments
> to use them, but would be nice to have a comment on top of each.
> 
> ...
> 
> > +struct scmi_pin_info {
> > +	bool present;
> > +	char name[SCMI_MAX_STR_SIZE];
> 
> Swapping order might help compiler to generate a better code.
> Also this applies to the _group_info and _function_info.
> 
> > +};
> 
> ...
> 
> > +	ret = ph->xops->do_xfer(ph, t);
> > +	if (!ret) {
> 
> Can you rather follow the usual pattern, i.e. checking for the errors?
> 

I think Oleksii here followed the (opinable maybe) pattern we have in
the SCMI stack where typically you get/build/send/put an scmi message
(xfer) while doing a few things only if the message was sent
successfully (if !ret ... most of the time): checking for success avoid
a lot of 'goto err:' all around.
 
[snip]

> > +static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *ph,
> > +				       u32 selector,
> > +				       struct scmi_group_info *group)
> > +{
> > +	int ret;
> > +
> > +	if (!group)
> > +		return -EINVAL;
> > +
> > +	ret = scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
> > +				      group->name,
> > +				      &group->nr_pins);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!group->nr_pins) {
> > +		dev_err(ph->dev, "Group %d has 0 elements", selector);
> > +		return -ENODATA;
> > +	}
> > +
> > +	group->group_pins = devm_kmalloc_array(ph->dev, group->nr_pins,
> > +					       sizeof(*group->group_pins),
> > +					       GFP_KERNEL);
> > +	if (!group->group_pins)
> > +		return -ENOMEM;
> > +
> > +	ret = scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
> > +					     group->nr_pins, group->group_pins);
> > +	if (ret) {
> > +		devm_kfree(ph->dev, group->group_pins);
> 
> This is a red flag. Is this function is solely used at the ->probe() stage?
> I do not think so. Why then the devm_*() is being used to begin with?
> 
> Also what are the object lifetimes for device here and the _group_info
> instances?
> 
> > +		return ret;
> > +	}
> > +
> > +	group->present = true;
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handle *ph,
> > +					  u32 selector,
> > +					  struct scmi_function_info *func)
> > +{
> 
> As per above.
> 
> > +}
> 
> ...
> 
> > +static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops = {
> > +	.get_count = scmi_pinctrl_get_count,
> > +	.get_name = scmi_pinctrl_get_name,
> > +	.get_group_pins = scmi_pinctrl_get_group_pins,
> > +	.get_function_groups = scmi_pinctrl_get_function_groups,
> > +	.set_mux = scmi_pinctrl_set_mux,
> > +	.get_config = scmi_pinctrl_get_config,
> > +	.set_config = scmi_pinctrl_set_config,
> > +	.request_pin = scmi_pinctrl_request_pin,
> > +	.free_pin = scmi_pinctrl_free_pin
> 
> It's not a terminator item, so leave trailing comma. It will reduce the burden
> in case of update of this.
> 
> > +};
> 
> ...
> 
> > +static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handle *ph)
> > +{
> 
> > +	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
> > +	if (!pinfo)
> > +		return -ENOMEM;
> 
> All the same, why devm_*() is in use and what are the object lifetimes?
> 
> > +}
> 

This bit about alocation and devres deserves an explanation in the context
of the SCMI stack.

So, you can add support for a new SCMI protocol using the below macro

 DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER

to register with the core SCMI stack a few things like an
initialization function and the protocol operations you wish this
protocol to expose.

At run-time, once the first user of your new protocol comes up (like
the pinctrl driver later in the series), the core SCMI will take care
to setup and initialize the protocol so that can be used by the SCMI
drivers (like pinctrl-scmi.c) via its exposed proto_operations.
(assuming the protocol has been also found as supported by the fw
serving as the SCMI server)

When the last user of a protocol is gone, similarly, the protocol
will be deinitialized (if anything is needed to be deinit really...)

Basically the core calls upfront the protocol_init function you provided
and passes to it a ph protocol_handle that embeds a number of things
useful for protocol implementations, like as example the xops-> needed
to build and send messages using the core facilities.

Another thing that is embedded in the ph, as you noticed, is the ph->dev
device reference to be optionally used for devres in your protocol: now,
we do NOT have per-protocol devices, so, that device lifetine is NOT bound
strictly to this protocol but to the whole stack... BUT the SCMI core
takes care to open/close a devres group around your protocol_init invocation,
so that you can use devres on your .protocol_init, and be assured that when
your protocol will be de-initialized (since no more used by anyone) all your
devres allocations will be freed.

For this see:

 drivers/firmware/arm_scmi/driver.c::scmi_alloc_init_protocol_instance()

This clearly works ONLY for allocations descending directly from the
.protocol_init() call (when the devres group is open) and it was working
fine till today for all protocols, since all existing protocols
allocated all what they needed during protocol_init....

... Pinctrl is a differenet beast, though, since it could make sense indeed
(even though still under a bit of discussion..) to delay some allocations and
SCMI querying to the platform after the protocol_init stage...i.e. lazy allocate
some resources only later when the pinctrl subsystem will parse the DT and will
ask the pinctrl-scmi driver just for the strictly needed resources.
(so you avoid to query and allocate at boot time a bunch of pin stuff that you
will never use...)

These lazy allocations instead, like the ones in scmi_pinctrl_get_group_info(),
happen outside of the .protocol_init path so they HAVE TO to be explicitly
managed manually without devres; as a consequence the addition of a
dedicated .protocol_deinit() function and the frees on the err path: so
that anything non devres allocated in the protcol devres_group can be
freed properly when the core deinitializes the protocol.

What is WRONG, though, in this patch (and I missed it ... my bad) is that such
explicit manual alloc/dealloc need not and should not be of devres kind but just
plain simple kmalloc_ / kfree.
(even though it is not harmful in this context...the ph->dev never unbounds till
the end of the stack..it is certainkly not needed and confusing)

Hoping not to have bored you to death with all of this SCMI digression... :D

Thanks,
Cristian

