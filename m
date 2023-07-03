Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72C7459F8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjGCKRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjGCKQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:16:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CD87BE;
        Mon,  3 Jul 2023 03:16:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A75982F4;
        Mon,  3 Jul 2023 03:17:33 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72C273F762;
        Mon,  3 Jul 2023 03:16:49 -0700 (PDT)
Date:   Mon, 3 Jul 2023 11:16:47 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
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
Message-ID: <ZKKgD1QxF085kE+c@e120937-lin>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <d388c7af3f72fd47baffe0de8c6fec8074cb483c.1686063941.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d388c7af3f72fd47baffe0de8c6fec8074cb483c.1686063941.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:22:27PM +0000, Oleksii Moisieiev wrote:
> scmi: Introduce pinctrl SCMI protocol driver
>

Hi Oleksii,

spurios line above.

> Add basic implementation of the SCMI v3.2 pincontrol protocol
> excluding GPIO support. All pinctrl related callbacks and operations
> are exposed in the include/linux/scmi_protocol.h
> 

As Andy said already, you can drop the second sentence here, but I would
ALSO drop the GPIO part in the first sentence, since there is nothing
specific to GPIO in the SCMI spec and this patch is about the SCMI protocol
not the pinctrl driver.

> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> ---
>  MAINTAINERS                           |   6 +
>  drivers/firmware/arm_scmi/Makefile    |   2 +-
>  drivers/firmware/arm_scmi/driver.c    |   2 +
>  drivers/firmware/arm_scmi/pinctrl.c   | 836 ++++++++++++++++++++++++++
>  drivers/firmware/arm_scmi/protocols.h |   1 +
>  include/linux/scmi_protocol.h         |  47 ++
>  6 files changed, 893 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/arm_scmi/pinctrl.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0dab9737ec16..297b2512963d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20522,6 +20522,12 @@ F:	include/linux/sc[mp]i_protocol.h
>  F:	include/trace/events/scmi.h
>  F:	include/uapi/linux/virtio_scmi.h
>  
> +PINCTRL DRIVER FOR SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/SCMI)

SCPI is a leftover here I suppose...

> +M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Maintained
> +F:	drivers/firmware/arm_scmi/pinctrl.c
> +
>  SYSTEM RESET/SHUTDOWN DRIVERS
>  M:	Sebastian Reichel <sre@kernel.org>
>  L:	linux-pm@vger.kernel.org
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index b31d78fa66cc..603430ec0bfe 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -10,7 +10,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
>  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
> -scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
> +scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o pinctrl.o
>  scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>  
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 5be931a07c84..a9fd337b9596 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -3025,6 +3025,7 @@ static int __init scmi_driver_init(void)
>  	scmi_voltage_register();
>  	scmi_system_register();
>  	scmi_powercap_register();
> +	scmi_pinctrl_register();
>  
>  	return platform_driver_register(&scmi_driver);
>  }
> @@ -3042,6 +3043,7 @@ static void __exit scmi_driver_exit(void)
>  	scmi_voltage_unregister();
>  	scmi_system_unregister();
>  	scmi_powercap_unregister();
> +	scmi_pinctrl_unregister();
>  
>  	scmi_transports_exit();
>  
> diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
> new file mode 100644
> index 000000000000..fc0fcc26dfb6
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/pinctrl.c
> @@ -0,0 +1,836 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Management Interface (SCMI) Pinctrl Protocol
> + *
> + * Copyright (C) 2023 EPAM
> + */
> +
> +#include <linux/module.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>
> +
> +#include "protocols.h"
> +
> +#define REG_TYPE_BITS GENMASK(9, 8)
> +#define REG_CONFIG GENMASK(7, 0)
> +
> +#define GET_GROUPS_NR(x)	le32_get_bits((x), GENMASK(31, 16))
> +#define GET_PINS_NR(x)		le32_get_bits((x), GENMASK(15, 0))
> +#define GET_FUNCTIONS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
> +
> +#define EXT_NAME_FLAG(x)	le32_get_bits((x), BIT(31))
> +#define NUM_ELEMS(x)		le32_get_bits((x), GENMASK(15, 0))
> +
> +#define REMAINING(x)		le32_get_bits((x), GENMASK(31, 16))
> +#define RETURNED(x)		le32_get_bits((x), GENMASK(11, 0))
> +
> +enum scmi_pinctrl_protocol_cmd {
> +	PINCTRL_ATTRIBUTES = 0x3,
> +	PINCTRL_LIST_ASSOCIATIONS = 0x4,
> +	PINCTRL_CONFIG_GET = 0x5,
> +	PINCTRL_CONFIG_SET = 0x6,
> +	PINCTRL_FUNCTION_SELECT = 0x7,
> +	PINCTRL_REQUEST = 0x8,
> +	PINCTRL_RELEASE = 0x9,
> +	PINCTRL_NAME_GET = 0xa,
> +	PINCTRL_SET_PERMISSIONS = 0xb
> +};
> +
> +struct scmi_msg_conf_set {
> +	__le32 identifier;
> +	__le32 attributes;
> +	__le32 config_value;
> +};
> +
> +struct scmi_msg_conf_get {
> +	__le32 identifier;
> +	__le32 attributes;
> +};
> +
> +struct scmi_msg_pinctrl_protocol_attributes {
> +	__le32 attributes_low;
> +	__le32 attributes_high;
> +};
> +
> +struct scmi_msg_pinctrl_attributes {
> +	__le32 identifier;
> +	__le32 flags;
> +};
> +
> +struct scmi_resp_pinctrl_attributes {
> +	__le32 attributes;
> +	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
> +};
> +
> +struct scmi_msg_pinctrl_list_assoc {
> +	__le32 identifier;
> +	__le32 flags;
> +	__le32 index;
> +};
> +
> +struct scmi_resp_pinctrl_list_assoc {
> +	__le32 flags;
> +	__le16 array[];
> +};
> +
> +struct scmi_msg_func_set {
> +	__le32 identifier;
> +	__le32 function_id;
> +	__le32 flags;
> +};
> +
> +struct scmi_msg_request {
> +	__le32 identifier;
> +	__le32 flags;
> +};
> +
> +struct scmi_group_info {
> +	bool present;
> +	char name[SCMI_MAX_STR_SIZE];
> +	unsigned int *group_pins;
> +	unsigned int nr_pins;
> +};
> +
> +struct scmi_function_info {
> +	bool present;
> +	char name[SCMI_MAX_STR_SIZE];
> +	unsigned int *groups;
> +	unsigned int nr_groups;
> +};
> +

A small note related to Andy remarks about directly embedding here pinctrl
subsystem structures (like pingroup / pinfucntion) that I forgot to say
in my reply to him.

These structs above indeed are very similar to the Pinctrl ones but this is
the protocol layer inside SCMI, I would not mix here stuff from the Pinctrl
subsystem which is, at the end the, one of the possible users of this layer
(via the SCMI pinctrl driver) but not necessarily the only one in the
future; moreover Pinctrl subsystem is not even needed at all if you think
about a testing scenario, so I would not build up a dependency here between
SCMI and Pinctrl by using Pinctrl structures...what if these latter change
in the future ?

All of this to just say this is fine for me as it is now :D

> +struct scmi_pin_info {
> +	bool present;
> +	char name[SCMI_MAX_STR_SIZE];
> +};
> +
> +struct scmi_pinctrl_info {
> +	u32 version;
> +	int nr_groups;
> +	int nr_functions;
> +	int nr_pins;
> +	struct scmi_group_info *groups;
> +	struct scmi_function_info *functions;
> +	struct scmi_pin_info *pins;
> +};
> +
> +static int scmi_pinctrl_attributes_get(const struct scmi_protocol_handle *ph,
> +				       struct scmi_pinctrl_info *pi)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_pinctrl_protocol_attributes *attr;
> +
> +	if (!pi)
> +		return -EINVAL;

You can drop this, cannot happen given the code paths.

> +
> +	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
> +				      0, sizeof(*attr), &t);
> +	if (ret)
> +		return ret;
> +
> +	attr = t->rx.buf;
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		pi->nr_functions = GET_FUNCTIONS_NR(attr->attributes_high);
> +		pi->nr_groups = GET_GROUPS_NR(attr->attributes_low);
> +		pi->nr_pins = GET_PINS_NR(attr->attributes_low);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +	return ret;
> +}
> +
> +static int scmi_pinctrl_get_count(const struct scmi_protocol_handle *ph,
> +				  enum scmi_pinctrl_selector_type type)
> +{
> +	struct scmi_pinctrl_info *pi;
> +
> +	pi = ph->get_priv(ph);
> +	if (!pi)
> +		return -ENODEV;

You dont need to check for NULL here and nowhere else.
You set protocol private data with set_priv at the end of protocol init
which is called as soon as a user tries to use this protocol operations,
so it cannot ever be NULL in any of these following ops.

> +
> +	switch (type) {
> +	case PIN_TYPE:
> +		return pi->nr_pins;
> +	case GROUP_TYPE:
> +		return pi->nr_groups;
> +	case FUNCTION_TYPE:
> +		return pi->nr_functions;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int scmi_pinctrl_validate_id(const struct scmi_protocol_handle *ph,
> +				    u32 identifier,
> +				    enum scmi_pinctrl_selector_type type)
> +{
> +	int value;
> +
> +	value = scmi_pinctrl_get_count(ph, type);
> +	if (value < 0)
> +		return value;
> +
> +	if (identifier >= value)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
> +				   enum scmi_pinctrl_selector_type type,
> +				   u32 selector, char *name,
> +				   unsigned int *n_elems)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_pinctrl_attributes *tx;
> +	struct scmi_resp_pinctrl_attributes *rx;
> +
> +	if (!name)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx),
> +				      sizeof(*rx), &t);
> +	if (ret)
> +		return ret;
> +
> +	tx = t->tx.buf;
> +	rx = t->rx.buf;
> +	tx->identifier = cpu_to_le32(selector);
> +	tx->flags = cpu_to_le32(type);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		if (n_elems)
> +			*n_elems = NUM_ELEMS(rx->attributes);
> +
> +		strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	/*
> +	 * If supported overwrite short name with the extended one;
> +	 * on error just carry on and use already provided short name.
> +	 */
> +	if (!ret && EXT_NAME_FLAG(rx->attributes))
> +		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
> +					    (u32 *)&type, name,
> +					    SCMI_MAX_STR_SIZE);
> +	return ret;
> +}
> +

[snip]

> +
> +static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *ph,
> +				       u32 selector,
> +				       struct scmi_group_info *group)
> +{
> +	int ret;
> +
> +	if (!group)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
> +				      group->name,
> +				      &group->nr_pins);
> +	if (ret)
> +		return ret;
> +
> +	if (!group->nr_pins) {
> +		dev_err(ph->dev, "Group %d has 0 elements", selector);
> +		return -ENODATA;
> +	}
> +
> +	group->group_pins = devm_kmalloc_array(ph->dev, group->nr_pins,
> +					       sizeof(*group->group_pins),
> +					       GFP_KERNEL);
> +	if (!group->group_pins)
> +		return -ENOMEM;

This is a lazy-allocation happening outside of the protocol init path so you
are rigthly tracking it manually here and in protocol_deinit, BUT you
should not use devm_ helpers, it is fuorviating even though harmless;
just plain kmalloc/kcalloc/kfree will do. (As I said oin the reply to
Andy I miss this previously, apologies)

> +
> +	ret = scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
> +					     group->nr_pins, group->group_pins);
> +	if (ret) {
> +		devm_kfree(ph->dev, group->group_pins);

kfree

> +		return ret;
> +	}
> +
> +	group->present = true;
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_get_group_name(const struct scmi_protocol_handle *ph,
> +				       u32 selector, const char **name)
> +{
> +	struct scmi_pinctrl_info *pi;
> +
> +	if (!name)
> +		return -EINVAL;
> +
> +	pi = ph->get_priv(ph);
> +	if (!pi)

Ditto.

> +		return -EINVAL;
> +
> +	if (selector > pi->nr_groups)
> +		return -EINVAL;

selector >=  ?

> +
> +	if (!pi->groups[selector].present) {
> +		int ret;
> +
> +		ret = scmi_pinctrl_get_group_info(ph, selector,
> +						  &pi->groups[selector]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*name = pi->groups[selector].name;
> +
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_get_group_pins(const struct scmi_protocol_handle *ph,
> +				       u32 selector, const unsigned int **pins,
> +				       unsigned int *nr_pins)
> +{
> +	struct scmi_pinctrl_info *pi;
> +
> +	if (!pins || !nr_pins)
> +		return -EINVAL;
> +
> +	pi = ph->get_priv(ph);
> +	if (!pi)
> +		return -EINVAL;

Ditto.

> +
> +	if (selector > pi->nr_groups)
> +		return -EINVAL;
> +

selector >=  ?

> +	if (!pi->groups[selector].present) {
> +		int ret;
> +
> +		ret = scmi_pinctrl_get_group_info(ph, selector,
> +						  &pi->groups[selector]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*pins = pi->groups[selector].group_pins;
> +	*nr_pins = pi->groups[selector].nr_pins;
> +
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handle *ph,
> +					  u32 selector,
> +					  struct scmi_function_info *func)
> +{
> +	int ret;
> +
> +	if (!func)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector,
> +				      func->name,
> +				      &func->nr_groups);
> +	if (ret)
> +		return ret;
> +
> +	if (!func->nr_groups) {
> +		dev_err(ph->dev, "Function %d has 0 elements", selector);
> +		return -ENODATA;
> +	}
> +
> +	func->groups = devm_kmalloc_array(ph->dev, func->nr_groups,
> +					  sizeof(*func->groups),
> +					  GFP_KERNEL);
> +	if (!func->groups)
> +		return -ENOMEM;

Same as above...lazy allocation properly tracked BUT do not use devm_
variants.

> +
> +	ret = scmi_pinctrl_list_associations(ph, selector, FUNCTION_TYPE,
> +					     func->nr_groups, func->groups);
> +	if (ret) {
> +		devm_kfree(ph->dev, func->groups);
> +		return ret;

kfree

> +	}
> +
> +	func->present = true;
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_get_function_name(const struct scmi_protocol_handle *ph,
> +					  u32 selector, const char **name)
> +{
> +	struct scmi_pinctrl_info *pi;
> +
> +	if (!name)
> +		return -EINVAL;
> +
> +	pi = ph->get_priv(ph);
> +	if (!pi)
> +		return -EINVAL;

Ditto.

> +
> +	if (selector > pi->nr_functions)
> +		return -EINVAL;

selector >=  ?

> +
> +	if (!pi->functions[selector].present) {
> +		int ret;
> +
> +		ret = scmi_pinctrl_get_function_info(ph, selector,
> +						     &pi->functions[selector]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*name = pi->functions[selector].name;
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_get_function_groups(const struct scmi_protocol_handle *ph,
> +					    u32 selector,
> +					    unsigned int *nr_groups,
> +					    const unsigned int **groups)
> +{
> +	struct scmi_pinctrl_info *pi;
> +
> +	if (!groups || !nr_groups)
> +		return -EINVAL;
> +
> +	pi = ph->get_priv(ph);
> +	if (!pi)
> +		return -EINVAL;

Ditto.

> +
> +	if (selector > pi->nr_functions)
> +		return -EINVAL;

selector >=  ?

> +
> +	if (!pi->functions[selector].present) {
> +		int ret;
> +
> +		ret = scmi_pinctrl_get_function_info(ph, selector,
> +						     &pi->functions[selector]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*groups = pi->functions[selector].groups;
> +	*nr_groups = pi->functions[selector].nr_groups;
> +
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_set_mux(const struct scmi_protocol_handle *ph,
> +				u32 selector, u32 group)
> +{
> +	return scmi_pinctrl_function_select(ph, group, GROUP_TYPE,
> +					    selector);
> +}
> +
> +static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle *ph,
> +				     u32 selector, struct scmi_pin_info *pin)
> +{
> +	int ret;
> +	struct scmi_pinctrl_info *pi;
> +
> +	if (!pin)
> +		return -EINVAL;
> +
> +	pi = ph->get_priv(ph);
> +	if (!pi)
> +		return -EINVAL;

Ditto.

> +
> +	ret = scmi_pinctrl_attributes(ph, PIN_TYPE, selector,
> +				      pin->name, NULL);
> +	if (ret)
> +		return ret;
> +
> +	pin->present = true;
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_get_pin_name(const struct scmi_protocol_handle *ph,
> +				     u32 selector, const char **name)
> +{
> +	struct scmi_pinctrl_info *pi;
> +
> +	if (!name)
> +		return -EINVAL;
> +
> +	pi = ph->get_priv(ph);
> +	if (!pi)
> +		return -EINVAL;

Ditto.

> +
> +	if (selector > pi->nr_pins)
> +		return -EINVAL;

selector >=  ?

> +
> +	if (!pi->pins[selector].present) {
> +		int ret;
> +
> +		ret = scmi_pinctrl_get_pin_info(ph, selector,
> +						&pi->pins[selector]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*name = pi->pins[selector].name;
> +
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_get_name(const struct scmi_protocol_handle *ph,
> +				 u32 selector,
> +				 enum scmi_pinctrl_selector_type type,
> +				 const char **name)
> +{
> +	switch (type) {
> +	case PIN_TYPE:
> +		return scmi_pinctrl_get_pin_name(ph, selector, name);
> +	case GROUP_TYPE:
> +		return scmi_pinctrl_get_group_name(ph, selector, name);
> +	case FUNCTION_TYPE:
> +		return scmi_pinctrl_get_function_name(ph, selector, name);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops = {
> +	.get_count = scmi_pinctrl_get_count,
> +	.get_name = scmi_pinctrl_get_name,
> +	.get_group_pins = scmi_pinctrl_get_group_pins,
> +	.get_function_groups = scmi_pinctrl_get_function_groups,
> +	.set_mux = scmi_pinctrl_set_mux,
> +	.get_config = scmi_pinctrl_get_config,
> +	.set_config = scmi_pinctrl_set_config,
> +	.request_pin = scmi_pinctrl_request_pin,
> +	.free_pin = scmi_pinctrl_free_pin
> +};
> +
> +static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handle *ph)
> +{
> +	int ret;
> +	u32 version;
> +	struct scmi_pinctrl_info *pinfo;
> +
> +	ret = ph->xops->version_get(ph, &version);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(ph->dev, "Pinctrl Version %d.%d\n",
> +		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> +
> +	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
> +	if (!pinfo)
> +		return -ENOMEM;
> +
> +	ret = scmi_pinctrl_attributes_get(ph, pinfo);
> +	if (ret)
> +		return ret;
> +
> +	pinfo->pins = devm_kcalloc(ph->dev, pinfo->nr_pins,
> +				   sizeof(*pinfo->pins),
> +				   GFP_KERNEL);
> +	if (!pinfo->pins)
> +		return -ENOMEM;
> +
> +	pinfo->groups = devm_kcalloc(ph->dev, pinfo->nr_groups,
> +				     sizeof(*pinfo->groups),
> +				     GFP_KERNEL);
> +	if (!pinfo->groups)
> +		return -ENOMEM;
> +
> +	pinfo->functions = devm_kcalloc(ph->dev, pinfo->nr_functions,
> +					sizeof(*pinfo->functions),
> +					GFP_KERNEL);
> +	if (!pinfo->functions)
> +		return -ENOMEM;
> +
> +	pinfo->version = version;
> +
> +	return ph->set_priv(ph, pinfo);
> +}
> +
> +static int scmi_pinctrl_protocol_deinit(const struct scmi_protocol_handle *ph)
> +{
> +	int i;
> +	struct scmi_pinctrl_info *pi;
> +
> +	pi = ph->get_priv(ph);
> +	if (!pi)
> +		return -EINVAL;

Ditto. You never get even here if protocol init had not succesfully
completed.

> +
> +	for (i = 0; i < pi->nr_groups; i++)
> +		if (pi->groups[i].present) {
> +			devm_kfree(ph->dev, pi->groups[i].group_pins);

kfree..you are managing these.

> +			pi->groups[i].present = false;
> +		}
> +
> +	for (i = 0; i < pi->nr_functions; i++)
> +		if (pi->functions[i].present) {
> +			devm_kfree(ph->dev, pi->functions[i].groups);

kfree..you are managing these.

> +			pi->functions[i].present = false;
> +		}
> +
> +	return 0;
> +}
> +
> +static const struct scmi_protocol scmi_pinctrl = {
> +	.id = SCMI_PROTOCOL_PINCTRL,
> +	.owner = THIS_MODULE,
> +	.instance_init = &scmi_pinctrl_protocol_init,
> +	.instance_deinit = &scmi_pinctrl_protocol_deinit,
> +	.ops = &pinctrl_proto_ops,
> +};
> +
> +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(pinctrl, scmi_pinctrl)
> diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
> index b3c6314bb4b8..674f949354f9 100644
> --- a/drivers/firmware/arm_scmi/protocols.h
> +++ b/drivers/firmware/arm_scmi/protocols.h
> @@ -346,5 +346,6 @@ DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
>  DECLARE_SCMI_REGISTER_UNREGISTER(voltage);
>  DECLARE_SCMI_REGISTER_UNREGISTER(system);
>  DECLARE_SCMI_REGISTER_UNREGISTER(powercap);
> +DECLARE_SCMI_REGISTER_UNREGISTER(pinctrl);
>  
>  #endif /* _SCMI_PROTOCOLS_H */
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index 0ce5746a4470..97631783a5a4 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -735,6 +735,52 @@ struct scmi_notify_ops {
>  					 struct notifier_block *nb);
>  };
>  
> +enum scmi_pinctrl_selector_type {
> +	PIN_TYPE = 0,
> +	GROUP_TYPE,
> +	FUNCTION_TYPE
> +};
> +
> +/**
> + * struct scmi_pinctrl_proto_ops - represents the various operations provided
> + * by SCMI Pinctrl Protocol
> + *
> + * @get_count: returns count of the registered elements in given type
> + * @get_name: returns name by index of given type
> + * @get_group_pins: returns the set of pins, assigned to the specified group
> + * @get_function_groups: returns the set of groups, assigned to the specified
> + *	function
> + * @set_mux: set muxing function for groups of pins
> + * @get_config: returns configuration parameter for pin or group
> + * @set_config: sets the configuration parameter for pin or group
> + * @request_pin: aquire pin before selecting mux setting
> + * @free_pin: frees pin, acquired by request_pin call
> + */
> +struct scmi_pinctrl_proto_ops {
> +	int (*get_count)(const struct scmi_protocol_handle *ph,
> +			 enum scmi_pinctrl_selector_type type);
> +	int (*get_name)(const struct scmi_protocol_handle *ph,
> +			u32 selector,
> +			enum scmi_pinctrl_selector_type type,
> +			const char **name);
> +	int (*get_group_pins)(const struct scmi_protocol_handle *ph,
> +			      u32 selector,
> +			      const unsigned int **pins, unsigned int *nr_pins);
> +	int (*get_function_groups)(const struct scmi_protocol_handle *ph,
> +				   u32 selector, unsigned int *nr_groups,
> +				   const unsigned int **groups);
> +	int (*set_mux)(const struct scmi_protocol_handle *ph, u32 selector,
> +		       u32 group);
> +	int (*get_config)(const struct scmi_protocol_handle *ph, u32 selector,
> +			  enum scmi_pinctrl_selector_type type,
> +			  u8 config_type, unsigned long *config_value);
> +	int (*set_config)(const struct scmi_protocol_handle *ph, u32 selector,
> +			  enum scmi_pinctrl_selector_type type,
> +			  u8 config_type, unsigned long config_value);
> +	int (*request_pin)(const struct scmi_protocol_handle *ph, u32 pin);
> +	int (*free_pin)(const struct scmi_protocol_handle *ph, u32 pin);
> +};
> +

Can you move all of these before .notify_ops where all others protocol
ops lives ? ... and rename all pinctrl_ops to match the ".<object>_<verb>"
pattern like other ops (i.e. count_get/name_get ... instead get_count/get_name)

>  /**
>   * struct scmi_handle - Handle returned to ARM SCMI clients for usage.
>   *
> @@ -783,6 +829,7 @@ enum scmi_std_protocol {
>  	SCMI_PROTOCOL_RESET = 0x16,
>  	SCMI_PROTOCOL_VOLTAGE = 0x17,
>  	SCMI_PROTOCOL_POWERCAP = 0x18,
> +	SCMI_PROTOCOL_PINCTRL = 0x19,
>  };
>  

Thanks,
Cristian
