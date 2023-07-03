Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E7C7464D7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGCV1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjGCV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:27:47 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80342E62
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 14:27:45 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 70b68763-19e8-11ee-abf4-005056bdd08f;
        Tue, 04 Jul 2023 00:27:41 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 4 Jul 2023 00:27:40 +0300
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     andy.shevchenko@gmail.com,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
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
Message-ID: <ZKM9TMHEMkMNaKt9@surfacebook>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <d388c7af3f72fd47baffe0de8c6fec8074cb483c.1686063941.git.oleksii_moisieiev@epam.com>
 <ZIAtdLTvM6qh4r9W@surfacebook>
 <ZJ78hBcjAhiU+ZBO@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJ78hBcjAhiU+ZBO@e120937-lin>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jun 30, 2023 at 05:02:12PM +0100, Cristian Marussi kirjoitti:
> On Wed, Jun 07, 2023 at 10:10:44AM +0300, andy.shevchenko@gmail.com wrote:
> > Tue, Jun 06, 2023 at 04:22:27PM +0000, Oleksii Moisieiev kirjoitti:

...

> > > -scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
> > > +scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o pinctrl.o
> > 
> > Why not splitting it and make it ordered?
> 
> Maybe a good idea for a separate cleanup...not sure can fit this series
> without causing churn with other in-flight SCMI series...I'll happily wait
> for Sudeep to decide.

Sure.

...

> > Missing headers:
> > 
> > 	bitfield.h
> > 	bits.h
> > 	byteorder/
> > 	types.h
> > 
> > > +#include <linux/module.h>
> > > +#include <linux/scmi_protocol.h>
> > > +#include <linux/slab.h>
> > 
> > Missing
> > 
> > 	asm/unaligned.h
> 
> Most if not all of these headers are already included by the
> 
> 	#include "protocols.h"
> 
> above that introduces a lot of common other stuff needed to implement
> a new SCMI protocol.

OK!

...

> > > +	ret = ph->xops->do_xfer(ph, t);
> > > +	if (!ret) {
> > 
> > Can you rather follow the usual pattern, i.e. checking for the errors?
> 
> I think Oleksii here followed the (opinable maybe) pattern we have in
> the SCMI stack where typically you get/build/send/put an scmi message
> (xfer) while doing a few things only if the message was sent
> successfully (if !ret ... most of the time): checking for success avoid
> a lot of 'goto err:' all around.

If it's
	ret = fpp();
	if (!ret)
		ret = bpp();
	return ret;

I would agree with you, but in some cases it involves more core and that code
doesn't affect ret itself.

> > > +	}

...

> > All the same, why devm_*() is in use and what are the object lifetimes?
> 
> This bit about alocation and devres deserves an explanation in the context
> of the SCMI stack.
> 
> So, you can add support for a new SCMI protocol using the below macro
> 
>  DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER
> 
> to register with the core SCMI stack a few things like an
> initialization function and the protocol operations you wish this
> protocol to expose.
> 
> At run-time, once the first user of your new protocol comes up (like
> the pinctrl driver later in the series), the core SCMI will take care
> to setup and initialize the protocol so that can be used by the SCMI
> drivers (like pinctrl-scmi.c) via its exposed proto_operations.
> (assuming the protocol has been also found as supported by the fw
> serving as the SCMI server)
> 
> When the last user of a protocol is gone, similarly, the protocol
> will be deinitialized (if anything is needed to be deinit really...)
> 
> Basically the core calls upfront the protocol_init function you provided
> and passes to it a ph protocol_handle that embeds a number of things
> useful for protocol implementations, like as example the xops-> needed
> to build and send messages using the core facilities.
> 
> Another thing that is embedded in the ph, as you noticed, is the ph->dev
> device reference to be optionally used for devres in your protocol: now,
> we do NOT have per-protocol devices, so, that device lifetine is NOT bound
> strictly to this protocol but to the whole stack... BUT the SCMI core
> takes care to open/close a devres group around your protocol_init invocation,
> so that you can use devres on your .protocol_init, and be assured that when
> your protocol will be de-initialized (since no more used by anyone) all your
> devres allocations will be freed.
> 
> For this see:
> 
>  drivers/firmware/arm_scmi/driver.c::scmi_alloc_init_protocol_instance()
> 
> This clearly works ONLY for allocations descending directly from the
> .protocol_init() call (when the devres group is open) and it was working
> fine till today for all protocols, since all existing protocols
> allocated all what they needed during protocol_init....
> 
> ... Pinctrl is a differenet beast, though, since it could make sense indeed
> (even though still under a bit of discussion..) to delay some allocations and
> SCMI querying to the platform after the protocol_init stage...i.e. lazy allocate
> some resources only later when the pinctrl subsystem will parse the DT and will
> ask the pinctrl-scmi driver just for the strictly needed resources.
> (so you avoid to query and allocate at boot time a bunch of pin stuff that you
> will never use...)
> 
> These lazy allocations instead, like the ones in scmi_pinctrl_get_group_info(),
> happen outside of the .protocol_init path so they HAVE TO to be explicitly
> managed manually without devres; as a consequence the addition of a
> dedicated .protocol_deinit() function and the frees on the err path: so
> that anything non devres allocated in the protcol devres_group can be
> freed properly when the core deinitializes the protocol.
> 
> What is WRONG, though, in this patch (and I missed it ... my bad) is that such
> explicit manual alloc/dealloc need not and should not be of devres kind but just
> plain simple kmalloc_ / kfree.
> (even though it is not harmful in this context...the ph->dev never unbounds till
> the end of the stack..it is certainkly not needed and confusing)
> 
> Hoping not to have bored you to death with all of this SCMI digression... :D

Thank you for a dive into the implementation of the SCMI. Perhaps you can
summarize that into some kernel doc aroung thouse callbacks, so people can
clearly see when it's possible and when it's not to use devm_*() APIs.

-- 
With Best Regards,
Andy Shevchenko


