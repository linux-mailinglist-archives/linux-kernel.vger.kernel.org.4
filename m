Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AA6749A06
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjGFK4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjGFK43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:56:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AF0826AD;
        Thu,  6 Jul 2023 03:55:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9EFD1480;
        Thu,  6 Jul 2023 03:56:17 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D1903F663;
        Thu,  6 Jul 2023 03:55:34 -0700 (PDT)
Date:   Thu, 6 Jul 2023 11:55:32 +0100
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
Message-ID: <ZKadpOfcau9esJJq@e120937-lin>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <d388c7af3f72fd47baffe0de8c6fec8074cb483c.1686063941.git.oleksii_moisieiev@epam.com>
 <ZIAtdLTvM6qh4r9W@surfacebook>
 <ZJ78hBcjAhiU+ZBO@e120937-lin>
 <ZKM9TMHEMkMNaKt9@surfacebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKM9TMHEMkMNaKt9@surfacebook>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 12:27:40AM +0300, andy.shevchenko@gmail.com wrote:
> Fri, Jun 30, 2023 at 05:02:12PM +0100, Cristian Marussi kirjoitti:
> > On Wed, Jun 07, 2023 at 10:10:44AM +0300, andy.shevchenko@gmail.com wrote:
> > > Tue, Jun 06, 2023 at 04:22:27PM +0000, Oleksii Moisieiev kirjoitti:
> 
> ...
> 

Hi Andy,

> > > > -scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
> > > > +scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o pinctrl.o
> > > 
> > > Why not splitting it and make it ordered?
> > 
> > Maybe a good idea for a separate cleanup...not sure can fit this series
> > without causing churn with other in-flight SCMI series...I'll happily wait
> > for Sudeep to decide.
 
[snip]
 
> > > > +	}
> 
> ...
> 
> > > All the same, why devm_*() is in use and what are the object lifetimes?
> > 
> > This bit about alocation and devres deserves an explanation in the context
> > of the SCMI stack.
> > 
> > So, you can add support for a new SCMI protocol using the below macro
> > 
> >  DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER
> > 
> > to register with the core SCMI stack a few things like an
> > initialization function and the protocol operations you wish this
> > protocol to expose.
> > 
> > At run-time, once the first user of your new protocol comes up (like
> > the pinctrl driver later in the series), the core SCMI will take care
> > to setup and initialize the protocol so that can be used by the SCMI
> > drivers (like pinctrl-scmi.c) via its exposed proto_operations.
> > (assuming the protocol has been also found as supported by the fw
> > serving as the SCMI server)
> > 
> > When the last user of a protocol is gone, similarly, the protocol
> > will be deinitialized (if anything is needed to be deinit really...)
> > 
> > Basically the core calls upfront the protocol_init function you provided
> > and passes to it a ph protocol_handle that embeds a number of things
> > useful for protocol implementations, like as example the xops-> needed
> > to build and send messages using the core facilities.
> > 
> > Another thing that is embedded in the ph, as you noticed, is the ph->dev
> > device reference to be optionally used for devres in your protocol: now,
> > we do NOT have per-protocol devices, so, that device lifetine is NOT bound
> > strictly to this protocol but to the whole stack... BUT the SCMI core
> > takes care to open/close a devres group around your protocol_init invocation,
> > so that you can use devres on your .protocol_init, and be assured that when
> > your protocol will be de-initialized (since no more used by anyone) all your
> > devres allocations will be freed.
> > 
> > For this see:
> > 
> >  drivers/firmware/arm_scmi/driver.c::scmi_alloc_init_protocol_instance()
> > 
> > This clearly works ONLY for allocations descending directly from the
> > .protocol_init() call (when the devres group is open) and it was working
> > fine till today for all protocols, since all existing protocols
> > allocated all what they needed during protocol_init....
> > 
> > ... Pinctrl is a differenet beast, though, since it could make sense indeed
> > (even though still under a bit of discussion..) to delay some allocations and
> > SCMI querying to the platform after the protocol_init stage...i.e. lazy allocate
> > some resources only later when the pinctrl subsystem will parse the DT and will
> > ask the pinctrl-scmi driver just for the strictly needed resources.
> > (so you avoid to query and allocate at boot time a bunch of pin stuff that you
> > will never use...)
> > 
> > These lazy allocations instead, like the ones in scmi_pinctrl_get_group_info(),
> > happen outside of the .protocol_init path so they HAVE TO to be explicitly
> > managed manually without devres; as a consequence the addition of a
> > dedicated .protocol_deinit() function and the frees on the err path: so
> > that anything non devres allocated in the protcol devres_group can be
> > freed properly when the core deinitializes the protocol.
> > 
> > What is WRONG, though, in this patch (and I missed it ... my bad) is that such
> > explicit manual alloc/dealloc need not and should not be of devres kind but just
> > plain simple kmalloc_ / kfree.
> > (even though it is not harmful in this context...the ph->dev never unbounds till
> > the end of the stack..it is certainkly not needed and confusing)
> > 
> > Hoping not to have bored you to death with all of this SCMI digression... :D
> 
> Thank you for a dive into the implementation of the SCMI. Perhaps you can
> summarize that into some kernel doc aroung thouse callbacks, so people can
> clearly see when it's possible and when it's not to use devm_*() APIs.
>

Absolutely, this is definitely missing, it's just that till now I was
the only dealing with this, so docs was overlooked ... and I am really
the first to be in need of this documentation :P

Thanks,
Cristian

P.S.: and apologies for late replies but our mail server seems to
constantly classify you as spam :D

