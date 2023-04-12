Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6A6DFDD7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjDLSpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDLSpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:45:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A08E3C21;
        Wed, 12 Apr 2023 11:45:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 126C5D75;
        Wed, 12 Apr 2023 11:45:47 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155CC3F6C4;
        Wed, 12 Apr 2023 11:45:00 -0700 (PDT)
Date:   Wed, 12 Apr 2023 19:44:54 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        michal.simek@amd.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [RFC v1 0/2] Introducing generic SCMI pinctrl driver
 implementation
Message-ID: <ZDb8JvQd3Sv3xfRn@e120937-lin>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680793130.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 10:18:26AM +0000, Oleksii Moisieiev wrote:
> This RFC patch series is intended to introduce the potential generic driver for
> pin controls over SCMI protocol, provided in the latest beta version of DEN0056 [0].
> 

Hi Oleksii,

a few general remarks here down below and more specific comments will
come inline in the remaining patches of the series.

CC'ing also a few more people possibly interested in your series.

> On ARM-based systems, a separate Cortex-M based System Control Processor (SCP)
> provides control on pins, as well as with power, clocks, reset controllers. In this case,
> kernel should use one of the possible transports, described in [0] to access SCP and
> control clocks/power-domains etc. This driver is using SMC transport to communicate with SCP via
> SCMI protocol and access to the Pin Control Subsystem.
> 
> The provided driver consists of 2 parts:
>  - firmware/arm_scmi/pinctrl.c - the SCMI pinctrl protocol inmplementation
>    responsible for the communication with SCP firmware.
> 
>  - drivers/pinctrl/pinctrl-scmi.c - pinctrl driver, which is using pinctrl
>   protocol implementation to access all necessary data.
> 

As discussed offline, the patches you posted to add support for the new
SCMI pinctrl protocol and the related SCMI pinctrl driver are using the
old SCMI API (include/linux/scmi_protocol.h) that changed significantly
since v5.13, so at first they need to be ported to current mainline API.

You can look on the latest v6.3-rc  at:

	drivers/firmware/arm_scmi/power.c
 	drivers/firmware/arm_scmi/scmi_pm_domain.c

for a simple example of a core protocol and related driver using the new API.

On the protocol side you can ignore really the part related to "scmi_protocol_events"
that you find there since it is related to notifications and there are no notifs in
SCMI Pinctrl as of now.

In a nutshell the protocol layer now receives a protocol handle (instead
of the instance handle) during protocol_init and uses that to build/send
messages; it has to be used also to store any protocol private data
with ph->set/get_priv() (no more direct access to handle->privs)

That same protocol handle is then used by the SCMI driver users during
tehir probes, so, in your pinctrl SCMI driver probe, you should do something like
this early on:

	pinctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL, &ph);

store the 'ph' somewhere and and then use it all over:

	pinctrl_ops->set_mux(ph, selector, group);

Beside the API a few helpers has been added too (ph->hops) that can be
re-used by protocol code to implement straight away some common SCMI machinery
like the extended_name_get and the handling of multi-part replies
(like in PINCTRL_LIST_ASSOCIATIONS)...I think you can ignore these ph->hops and
just keep your original code, I'll take care to port these functionalities to
the common helpers later on top of your series if it is fine for you...
(also because I think at least a small modification in the core helpers will be
needed to support PINCTRL usage since it deviates a bit from existent protos...:P)

> Configuration:
> The scmi-pinctrl driver can be configured using DT bindings.
> For example:
> / {
> 	cpu_scp_shm: scp-shmem@0x53FF0000 {
> 		compatible = "arm,scmi-shmem";
> 		reg = <0x0 0x53FF0000 0x0 0x1000>;
> 	};
> 
> 	firmware {
> 		scmi {
> 			compatible = "arm,scmi-smc";
> 			arm,smc-id = <0x82000002>;
> 			shmem = <&cpu_scp_shm>;
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			scmi_pinctrl: protocol@19 {
> 				reg = <0x18>;
> 				#pinctrl-cells = <0>;
> 
> 				i2c2_pins: i2c2 {
> 					groups = "i2c2_a";
> 					function = "i2c2";
> 				};
> 			};
> 		};
> 	};
> };
> 

These will need a proper formal explanation in DT bindings at:

	Documentation/devicetree/bindings/firmware/arm,scmi.yaml

to highlight the usage of "#pinctrl-cells" and whatever else is needed
to be documented with related links to existing reused bindings is any.
(and CC that patch to the proper DT maintainers and MLs... IOW look at
what get_maintanel.pl says)

> &pfc {
> 	/delete-node/i2c2;
> };
> 
> So basically, it's enough to move pfc subnode, which configures pin group that should work through
> SCMI protocol to scmi_pinctrl node. The current driver implementation is using generic pinctrl dt_node
> format.
> 
> I've tested this driver on the Renesas H3ULCB Kingfisher board with pinctrl driver ported to the
> Arm-trusted-firmware. Unfortunately, not all hardware was possible to test because the Renesas
> pinctrl driver has gaps in pins and groups numeration, when Spec [0] requires pins, groups and
> functions numerations to be 0..n without gaps.
> 
> This implementation still reqires some features, such as gpio support, but I've posted it as RFC to
> start the discussion regarding the driver format.
> 
> [0] https://developer.arm.com/documentation/den0056/latest
> 

Thanks for this,
Cristian
