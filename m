Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C866F89DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjEETwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjEETwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:52:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3BC8F9;
        Fri,  5 May 2023 12:52:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAB2E1FB;
        Fri,  5 May 2023 12:52:50 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F51D3F64C;
        Fri,  5 May 2023 12:52:05 -0700 (PDT)
Date:   Fri, 5 May 2023 20:52:03 +0100
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
Message-ID: <ZFVeY3jVNfAkW1G9@e120937-lin>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
 <b4d60f3408f8fe839933fa3938ecdc9bfceb75d7.1682513390.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d60f3408f8fe839933fa3938ecdc9bfceb75d7.1682513390.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 01:26:37PM +0000, Oleksii Moisieiev wrote:
> scmi: Introduce pinctrl SCMI protocol driver
> 
> Add basic implementation of the SCMI v3.2 pincontrol protocol
> excluding GPIO support. All pinctrl related callbacks and operations
> are exposed in the include/linux/scmi_protocol.h
> 

Hi Oleksii,

Thanks for this.

I tried out this in an emulated setup and found just a minor issue from
the spec/functional point of view...then I reworked the extended names
support using a modified hops->extended_name_get helper (as said the core
SCMI support needed a small modification to support PINCTRL): I'll reply
to this mail thread with such core SCMI modification patch, so you can
include this patch of mine in your next V3 and use it in your series.

Moreover, given that I wanted to test such rework of mine and a bunch
of other cleanups I did (as detailed down below), and it seemed silly
to throw all away just to then having to detail all to you, I'll also
include in another distinct reply the raw diff of what I changed in
your series to use the new extended_name support and a few other cleanups,
so that, if you want, you can just quickly merge that into your V3 patch
(of course if you like it and tests fine also for you...)...these are
small changes, if you take it, no need to bother with authorship and
attribution from my point of view.

> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> ---
>  MAINTAINERS                           |   6 +
>  drivers/firmware/arm_scmi/Makefile    |   3 +-
>  drivers/firmware/arm_scmi/driver.c    |   2 +
>  drivers/firmware/arm_scmi/pinctrl.c   | 932 ++++++++++++++++++++++++++
>  drivers/firmware/arm_scmi/protocols.h |   1 +
>  include/linux/scmi_protocol.h         |  47 ++
>  6 files changed, 990 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/arm_scmi/pinctrl.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e64787aace8..0d251ebac437 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20317,6 +20317,12 @@ F:	include/linux/sc[mp]i_protocol.h
>  F:	include/trace/events/scmi.h
>  F:	include/uapi/linux/virtio_scmi.h
>  
> +PINCTRL DRIVER FOR SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/SCMI)
> +M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Maintained
> +F:	drivers/firmware/arm_scmi/pinctrl.c
> +
>  SYSTEM RESET/SHUTDOWN DRIVERS
>  M:	Sebastian Reichel <sre@kernel.org>
>  L:	linux-pm@vger.kernel.org
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index b31d78fa66cc..071ac65f22b9 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -3,6 +3,7 @@ scmi-bus-y = bus.o
>  scmi-core-objs := $(scmi-bus-y)
>  
>  scmi-driver-y = driver.o notify.o
> +

Do not add spurios lines.

>  scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) += raw_mode.o
>  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += mailbox.o
> @@ -10,7 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
>  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
> -scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
> +scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o pinctrl.o
>  scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>  
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index dbc474ff62b7..fc7ba587ae6e 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -3021,6 +3021,7 @@ static int __init scmi_driver_init(void)
>  	scmi_voltage_register();
>  	scmi_system_register();
>  	scmi_powercap_register();
> +	scmi_pinctrl_register();
>  
>  	return platform_driver_register(&scmi_driver);
>  }
> @@ -3038,6 +3039,7 @@ static void __exit scmi_driver_exit(void)
>  	scmi_voltage_unregister();
>  	scmi_system_unregister();
>  	scmi_powercap_unregister();
> +	scmi_pinctrl_unregister();
>  
>  	scmi_transports_exit();
>  
> diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
> new file mode 100644
> index 000000000000..1c643d21390f
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/pinctrl.c
> @@ -0,0 +1,932 @@
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
> +#define SET_TYPE(x) FIELD_PREP(GENMASK(1, 0), (x))
> +

This macro is really not needed given that you set just bit 0,1 on a
32bit flag field that is all 0-reserved otherwise...more on this down below.

> +#define REG_TYPE_BITS GENMASK(9, 8)
> +#define REG_CONFIG GENMASK(7, 0)
> +
> +#define GET_GROUPS_NR(x) FIELD_GET(GENMASK(31, 16), (x))
> +#define GET_PINS_NR(x) FIELD_GET(GENMASK(15, 0), (x))
> +#define GET_FUNCTIONS_NR(x) FIELD_GET(GENMASK(15, 0), (x))
> +
> +#define EXT_NAME_FLAG(x) FIELD_GET(BIT(31), (x))
> +#define NUM_ELEMS(x) FIELD_GET(GENMASK(15, 0), (x))
> +
> +#define REMAINING(x) FIELD_GET(GENMASK(31, 16), (x))
> +#define RETURNED(x) FIELD_GET(GENMASK(11, 0), (x))
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
> +struct scmi_msg_ext_name {
> +	__le32 identifier;
> +	__le32 flags;
> +};
> +
> +struct scmi_resp_ext_name {
> +	__le32 flags;
> +	u8 name[SCMI_MAX_STR_SIZE];
> +};
> +

You could drop these structs once using the common extended_name_get
helper.

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
> +	char *name;
> +	unsigned int *group_pins;
> +	unsigned int nr_pins;
> +};
> +
> +struct scmi_function_info {
> +	bool present;
> +	char *name;
> +	unsigned int *groups;
> +	unsigned int nr_groups;
> +};
> +
> +struct scmi_pin_info {
> +	bool present;
> +	char *name;
> +};
> +

I would re-define all of these 3 above *name pointers as
name[SCMI_MAX_STR_SIZE] instead and dont bother with dynalloc
and free...to avoid tricky resource tracking for a few bytes...and a
avoid a memleak that is now present :D ... more details later.

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
> +		pi->nr_functions =
> +			le16_to_cpu(GET_FUNCTIONS_NR(attr->attributes_high));
> +		pi->nr_groups = le16_to_cpu(GET_GROUPS_NR(attr->attributes_low));
> +		pi->nr_pins = le16_to_cpu(GET_PINS_NR(attr->attributes_low));

I see a couple of issues here present in general all across this patch when
you use these macros;

You should take care of the endianity in the RX msg payload BEFORE and THEN
DISSECT the bitfields AND as a consequence use also an _le helper that fits
the size of the type that you are processing as in (being attributes 32 bit
little endian in the msg payload):

	pi->nr_pins = GET_PINS_NR(le32_to_cpu(attr->attributes_low));

Now all works just because everything is little endian really so nothing
is done by these macros....

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
> +	if (!ph)
> +		return -ENODEV;
> +

You can just drop this !ph check all-over this file...you just cannot be
here if ph was not initialized by the core...no need to check.

> +	pi = ph->get_priv(ph);
> +	if (!pi)
> +		return -ENODEV;
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
> +	if (!ph)
> +		return -ENODEV;

Ditto...I wont reapet all over.

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
> +static int scmi_pinctrl_get_ext_name(const struct scmi_protocol_handle *ph,
> +				     u32 identifier,
> +				     enum scmi_pinctrl_selector_type type,
> +				     char **name)
> +{
> +	struct scmi_xfer *t;
> +	int ret = 0;
> +	struct scmi_msg_ext_name *tx;
> +	struct scmi_resp_ext_name *rx;
> +
> +	if (!ph || !name)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, identifier, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_NAME_GET, sizeof(*tx),
> +				      sizeof(*rx), &t);
> +
> +	tx = t->tx.buf;
> +	rx = t->rx.buf;
> +	tx->identifier = identifier;
> +	tx->flags = SET_TYPE(cpu_to_le32(type));
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (ret)
> +		goto out;
> +
> +	if (rx->flags) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	*name = kasprintf(GFP_KERNEL, "%s", rx->name);
> +	if (!*name)
> +		ret = -ENOMEM;
> + out:
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +

So I droppped completely the above function and used the helper with
some modifications as detailed below. (full details anyway in my
reference example patch as said above)

> +static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
> +				   enum scmi_pinctrl_selector_type type,
> +				   u32 selector, char **name,
> +				   unsigned int *n_elems)
> +{
> +	int ret = 0;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_pinctrl_attributes *tx;
> +	struct scmi_resp_pinctrl_attributes *rx;
> +
> +	if (!ph || !name)
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
> +	tx->identifier = selector;

Missing cpu_to_le32

> +	tx->flags = SET_TYPE(cpu_to_le32(type));
> +

Here we are sending so we have to build an _le32 payload AT THE END
after having built our field like in:

	tx->flags = cpu_to_le32(SET_TYPE(type));

...BUT, as mentioned above, SET_TYPE really sets only bits 0,1 in a
32bit field so you can just: 

	tx->flags = cpu_to_le32(type);

> +	ret = ph->xops->do_xfer(ph, t);
> +	if (ret)
> +		goto out;

I would revert the logic here [if (!ret)] so as to avoid the goto
since, really, it is used only once in this function so we can easily
stick to non-goto flow.

> +
> +	*n_elems = NUM_ELEMS(rx->attributes);
> +

As explained below when this function is called for a PIN n_elems is
reported as zero and NOT needed really, so I made this param optional
adding here a:

	if (n_elems)
		*n_elems = ... 

> +	if (!EXT_NAME_FLAG(rx->attributes)) {

Missing le32_to_cpu on attributes.

> +		*name = kasprintf(GFP_KERNEL, "%s", rx->name);
> +		if (!*name)
> +			ret = -ENOMEM;
> +	} else {
> +		ret = scmi_pinctrl_get_ext_name(ph, selector, type, name);
> +	}

Ok, here there are a couple of things worth noting (beside the usage of
the common helper).

You dyn-allocate *name in both cases short ot extended name and, rightly
so, in the callers of this, you take care to free it on the error-path,
BUT you never take care to release it on Success and this is not even a
devres...so if protocol is unloaded you'll have a leak.

Moreover by the spec even if you have extended names supported you are
supposed to return anyway the first 16 bytes of the resource name in
rx->name anyway, and you have to consider that the following extended_name
GET (if supported) can fail for a number of reasons (including a faulty fw).

So usually, in the otehr proto we collect the short name anyway and then
overwrite it with the extended one if possible, issuing just a warning
on failure to get the extended one, since you have anyway the short.

But beside this I would not bother to track all this tiny dynalloc and
just declare a static name[SCMI_MAX_STR_SIZE] which can hold both.

IOW this could roughly be (with the helper):

	if (!ret) {
		attrs = le32_to_cpu(rx->attributes);
		if (n_elems)
			*n_elems = NUM_ELEMS(attrs);
		strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
 	}
 	ph->xops->xfer_put(ph, t);

	/*
	 * If supported overwrite short name with the extended one;
	 * on error just carry on and use already provided short name.
	 */
	if (!ret && EXT_NAME_FLAG(attrs))
		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
					    (u32 *)&type, name,
					    SCMI_MAX_STR_SIZE);
 	return ret;

....probably more easy to grasp all of this looking at the proposed
fixes :D

> + out:
> +	ph->xops->xfer_put(ph, t);
> +	return ret;
> +}
> +
> +struct scmi_pinctrl_ipriv {
> +	u32 selector;
> +	enum scmi_pinctrl_selector_type type;
> +	unsigned int *array;
> +};
> +
> +static void iter_pinctrl_assoc_prepare_message(void *message,
> +					       unsigned int desc_index,
> +					       const void *priv)
> +{
> +	struct scmi_msg_pinctrl_list_assoc *msg = message;
> +	const struct scmi_pinctrl_ipriv *p = priv;
> +
> +	msg->identifier = cpu_to_le32(p->selector);
> +	msg->flags = SET_TYPE(cpu_to_le32(p->type));

Drop SET_TYPE as said above.

> +	/* Set the number of OPPs to be skipped/already read */
> +	msg->index = cpu_to_le32(desc_index);
> +}
> +
> +static int iter_pinctrl_assoc_update_state(struct scmi_iterator_state *st,
> +					   const void *response, void *priv)
> +{
> +	const struct scmi_resp_pinctrl_list_assoc *r = response;
> +
> +	st->num_returned = le32_to_cpu(RETURNED(r->flags));
> +	st->num_remaining = le32_to_cpu(REMAINING(r->flags));
> +

Issue le32_to_cpu before applying the macro as said.

> +	return 0;
> +}
> +
> +static int
> +iter_pinctrl_assoc_process_response(const struct scmi_protocol_handle *ph,
> +				    const void *response,
> +				    struct scmi_iterator_state *st, void *priv)
> +{
> +	const struct scmi_resp_pinctrl_list_assoc *r = response;
> +	struct scmi_pinctrl_ipriv *p = priv;
> +
> +	p->array[st->desc_index + st->loop_idx] =
> +		le16_to_cpu(r->array[st->loop_idx]);
> +
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_list_associations(const struct scmi_protocol_handle *ph,
> +					  u32 selector,
> +					  enum scmi_pinctrl_selector_type type,
> +					  u16 size, unsigned int *array)
> +{
> +	int ret;
> +	void *iter;
> +	struct scmi_iterator_ops ops = {
> +		.prepare_message = iter_pinctrl_assoc_prepare_message,
> +		.update_state = iter_pinctrl_assoc_update_state,
> +		.process_response = iter_pinctrl_assoc_process_response,
> +	};
> +	struct scmi_pinctrl_ipriv ipriv = {
> +		.selector = selector,
> +		.type = type,
> +		.array = array,
> +	};
> +
> +	if (!ph || !array || !size)
> +		return -EINVAL;
> +
> +	if (type == PIN_TYPE)
> +		return -EINVAL;
> +

You can sqaush this 2 ifs into one and drop the !ph check.

> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	iter = ph->hops->iter_response_init(ph, &ops, size,
> +					    PINCTRL_LIST_ASSOCIATIONS,
> +					    sizeof(struct scmi_msg_pinctrl_list_assoc),
> +					    &ipriv);
> +
> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);
> +
> +	return ph->hops->iter_response_run(iter);
> +}
> +
> +static int scmi_pinctrl_get_config(const struct scmi_protocol_handle *ph,
> +				   u32 selector,
> +				   enum scmi_pinctrl_selector_type type,
> +				   u8 config_type, u32 *config_value)
> +{
> +	struct scmi_xfer *t;
> +	struct scmi_msg_conf_get *tx;
> +	__le32 *le_config;

Safer if you use an existing unaligned helper for this...see below.

> +	u32 attributes = 0;
> +	int ret;
> +
> +	if (!ph || !config_value || type == FUNCTION_TYPE)
> +		return -EINVAL;
> +

Drop !ph

> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_GET, sizeof(*tx),
> +				      sizeof(*le_config), &t);
				      sizeof(__le32), &t);
> +	if (ret)
> +		return ret;
> +
> +	tx = t->tx.buf;
> +	le_config = t->rx.buf;
> +	tx->identifier = cpu_to_le32(selector);
> +	attributes = FIELD_PREP(REG_TYPE_BITS, type) |
> +		FIELD_PREP(REG_CONFIG, config_type);
> +
> +	tx->attributes = cpu_to_le32(attributes);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	if (!ret)
> +		*config_value = le32_to_cpu(*le_config);

Use an helper:

		*config_value = get_unaligned_le32(t->rx.buf);

> +
> +	ph->xops->xfer_put(ph, t);
> +	return ret;
> +}
> +
> +static int scmi_pinctrl_set_config(const struct scmi_protocol_handle *ph,
> +				   u32 selector,
> +				   enum scmi_pinctrl_selector_type type,
> +				   u8 config_type, u32 config_value)
> +{
> +	struct scmi_xfer *t;
> +	struct scmi_msg_conf_set *tx;
> +	u32 attributes = 0;
> +	int ret;
> +
> +	if (!ph || type == FUNCTION_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_SET,
> +				      sizeof(*tx), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	tx = t->tx.buf;
> +	tx->identifier = cpu_to_le32(selector);
> +	attributes = FIELD_PREP(REG_TYPE_BITS, type) |
> +		FIELD_PREP(REG_CONFIG, config_type);
> +	tx->attributes = cpu_to_le32(attributes);
> +	tx->config_value = cpu_to_le32(config_value);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +	return ret;
> +}
> +
> +static int scmi_pinctrl_function_select(const struct scmi_protocol_handle *ph,
> +					u32 identifier,
> +					enum scmi_pinctrl_selector_type type,
> +					u32 function_id)
> +{
> +	struct scmi_xfer *t;
> +	struct scmi_msg_func_set *tx;
> +	int ret;

Usually we place the shorter defs at start of the block...

> +
> +	if (!ph || type == FUNCTION_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, identifier, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_FUNCTION_SELECT,
> +				      sizeof(*tx), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	tx = t->tx.buf;
> +	tx->identifier = cpu_to_le32(identifier);
> +	tx->function_id = cpu_to_le32(function_id);
> +	tx->flags = SET_TYPE(cpu_to_le32(type));
> +
Drop SET_TYPE

> +	ret = ph->xops->do_xfer(ph, t);
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_pinctrl_request(const struct scmi_protocol_handle *ph,
> +				u32 identifier,
> +				enum scmi_pinctrl_selector_type type)
> +{
> +	struct scmi_xfer *t;
> +	int ret;
This defs at start of the block..

> +	struct scmi_msg_request *tx;
> +
> +	if (!ph || type == FUNCTION_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, identifier, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_REQUEST, sizeof(*tx),
> +				      0, &t);
> +
> +	tx = t->tx.buf;
> +	tx->identifier = identifier;
Missing cpu_to_le32

> +	tx->flags = SET_TYPE(cpu_to_le32(type));
Drop SET_TYPE

> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_pinctrl_request_pin(const struct scmi_protocol_handle *ph,
> +				    u32 pin)
> +{
> +	return scmi_pinctrl_request(ph, pin, PIN_TYPE);
> +}
> +
> +static int scmi_pinctrl_free(const struct scmi_protocol_handle *ph,
> +			     u32 identifier,
> +			     enum scmi_pinctrl_selector_type type)
> +{
> +	struct scmi_xfer *t;
> +	int ret;
> +	struct scmi_msg_request *tx;
> +
> +	if (!ph || type == FUNCTION_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, identifier, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_RELEASE,
> +				      sizeof(*tx), 0, &t);
> +
> +	tx = t->tx.buf;
> +	tx->identifier = identifier;
Missing cpu_to_le32

> +	tx->flags = SET_TYPE(cpu_to_le32(type));
Drop SET_TYPE

> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_pinctrl_free_pin(const struct scmi_protocol_handle *ph, u32 pin)
> +{
> +	return scmi_pinctrl_free(ph, pin, PIN_TYPE);
> +}
> +
> +static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *ph,
> +				       u32 selector,
> +				       struct scmi_group_info *group)
> +{
> +	int ret = 0;
> +
> +	if (!ph || !group)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
> +				      &group->name,

Just a simple pointer in the above hyp of static allocation

				      group->name,

...same for all invoctions of course.

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
> +	if (!group->group_pins) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	ret = scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
> +					     group->nr_pins, group->group_pins);
> +	if (ret)
> +		goto err_groups;
> +
> +	group->present = true;
> +	return 0;
> +
> + err_groups:
> +	kfree(group->group_pins);
> + err:
> +	kfree(group->name);
> +	return ret;

You can rework all of the above to just drop both these goto exit
labels....take a look at my proposal fixes if you like it.

> +}
> +
> +static int scmi_pinctrl_get_group_name(const struct scmi_protocol_handle *ph,
> +				       u32 selector, const char **name)
> +{
> +	int ret;
> +	struct scmi_pinctrl_info *pi;
> +
> +	if (!ph || !name)
> +		return -EINVAL;
> +
> +	pi = ph->get_priv(ph);
> +	if (!pi)
> +		return -EINVAL;
> +
> +	if (selector > pi->nr_groups)
> +		return -EINVAL;
> +
> +	if (!pi->groups[selector].present) {
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
> +	int ret;
> +	struct scmi_pinctrl_info *pi;
> +
> +	if (!ph || !pins || !nr_pins)
> +		return -EINVAL;
> +
> +	pi = ph->get_priv(ph);
> +	if (!pi)
> +		return -EINVAL;
> +
> +	if (selector > pi->nr_groups)
> +		return -EINVAL;
> +
> +	if (!pi->groups[selector].present) {
> +		ret = scmi_pinctrl_get_group_info(ph, selector,
> +						  &pi->groups[selector]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*pins = pi->groups[selector].group_pins;
> +	*nr_pins = pi->groups[selector].nr_pins;
> +
> +	return ret;
> +}
> +
> +static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handle *ph,
> +					  u32 selector,
> +					  struct scmi_function_info *func)
> +{
> +	int ret = 0;
> +
> +	if (!ph || !func)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector,
> +				      &func->name,
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
> +	if (!func->groups) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	ret = scmi_pinctrl_list_associations(ph, selector, FUNCTION_TYPE,
> +					     func->nr_groups, func->groups);
> +	if (ret)
> +		goto err_funcs;
> +
> +	func->present = true;
> +	return 0;
> +
> + err_funcs:
> +	kfree(func->groups);
> + err:
> +	kfree(func->name);
> +	return ret;

Can be reworked and dropped as above.

> +}
> +
> +static int scmi_pinctrl_get_function_name(const struct scmi_protocol_handle *ph,
> +					  u32 selector, const char **name)
> +{
> +	int ret;
> +	struct scmi_pinctrl_info *pi;
> +
> +	if (!ph || !name)
> +		return -EINVAL;
> +
> +	pi = ph->get_priv(ph);
> +	if (!pi)
> +		return -EINVAL;
> +
> +	if (selector > pi->nr_functions)
> +		return -EINVAL;
> +
> +	if (!pi->functions[selector].present) {
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
> +	int ret;
> +	struct scmi_pinctrl_info *pi;
> +
> +	if (!ph || !groups || !nr_groups)
> +		return -EINVAL;
> +
> +	pi = ph->get_priv(ph);
> +	if (!pi)
> +		return -EINVAL;
> +
> +	if (selector > pi->nr_functions)
> +		return -EINVAL;
> +
> +	if (!pi->functions[selector].present) {
> +		ret = scmi_pinctrl_get_function_info(ph, selector,
> +						     &pi->functions[selector]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*groups = pi->functions[selector].groups;
> +	*nr_groups = pi->functions[selector].nr_groups;
> +
> +	return ret;
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
> +	int ret = 0;
> +	struct scmi_pinctrl_info *pi;
> +	unsigned int n_elems;
> +
> +	if (!ph || !pin)
> +		return -EINVAL;
> +
> +	pi = ph->get_priv(ph);
> +	if (!pi)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_attributes(ph, PIN_TYPE, selector,
> +				      &pin->name,
> +				      &n_elems);
> +	if (ret)
> +		return ret;
> +
> +	if (n_elems != pi->nr_pins) {
> +		dev_err(ph->dev, "Wrong pin count expected %d has %d",
> +			pi->nr_pins, n_elems);
> +		return -ENODATA;
> +	}

This is wrong because PINCTRL_ATTRIBUTES by the spec reports this
field of attributes as ZERO when the type queried is PIN_TYPE...so
you'll fail all the time here. (or you have to fix your server too :D)

So I would just drop this and this is the reason above I made n_elems
param to scmi_pinctrl_attributes() optional: here you dont need it.
[or you could ignore it...)

> +
> +	if (*pin->name == 0) {
> +		dev_err(ph->dev, "Pin name is empty");
> +		goto err;
> +	}

And I would just drop this check too...you'll have an empty string in
case you define name as name[SCMI_MAX_STR_SIZE]...maybe a warning
not an error...picntrl seems to survive with an empty string
> +
> +	pin->present = true;
> +	return 0;
> +
> + err:
> +	kfree(pin->name);
> +	return ret;
Can be dropped if static.

> +}
> +
> +static int scmi_pinctrl_get_pin_name(const struct scmi_protocol_handle *ph,
> +				     u32 selector, const char **name)
> +{
> +	int ret;
> +	struct scmi_pinctrl_info *pi;
> +
> +	if (!ph || !name)
> +		return -EINVAL;
> +
> +	pi = ph->get_priv(ph);
> +	if (!pi)
> +		return -EINVAL;
> +
> +	if (selector > pi->nr_pins)
> +		return -EINVAL;
> +
> +	if (!pi->pins[selector].present) {
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
> +	u32 version;
> +	struct scmi_pinctrl_info *pinfo;
> +	int ret;
> +
> +	if (!ph)
> +		return -EINVAL;
Drop

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
> +	if (!ph)
> +		return -EINVAL;
> +
Drop

> +	pi = ph->get_priv(ph);
> +	if (!pi)
> +		return -EINVAL;
> +
> +	for (i = 0; i < pi->nr_groups; i++)
> +		if (pi->groups[i].present) {
> +			devm_kfree(ph->dev, pi->groups[i].group_pins);
> +			pi->groups[i].present = false;
> +		}
> +
> +	for (i = 0; i < pi->nr_functions; i++)
> +		if (pi->functions[i].present) {
> +			devm_kfree(ph->dev, pi->functions[i].groups);
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
> index 78e1a01eb656..533b94c9a9a7 100644
> --- a/drivers/firmware/arm_scmi/protocols.h
> +++ b/drivers/firmware/arm_scmi/protocols.h
> @@ -345,5 +345,6 @@ DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
>  DECLARE_SCMI_REGISTER_UNREGISTER(voltage);
>  DECLARE_SCMI_REGISTER_UNREGISTER(system);
>  DECLARE_SCMI_REGISTER_UNREGISTER(powercap);
> +DECLARE_SCMI_REGISTER_UNREGISTER(pinctrl);
>  
>  #endif /* _SCMI_PROTOCOLS_H */
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index 0ce5746a4470..8e15d2912045 100644
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
> + * struct scmi_pinctrl_protocol_ops - represents the various operations provided
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
> +			  u8 config_type, u32 *config_value);
> +	int (*set_config)(const struct scmi_protocol_handle *ph, u32 selector,
> +			  enum scmi_pinctrl_selector_type type,
> +			  u8 config_type, u32 config_value);
> +	int (*request_pin)(const struct scmi_protocol_handle *ph, u32 pin);
> +	int (*free_pin)(const struct scmi_protocol_handle *ph, u32 pin);
> +};
> +

I know this could seem pedantic but all over the SCMI stack the protocol
operations, being external facing methods, are named as <something_ACTION>
as in:

	count_get
	name_get
 	config_get
	config_set

etc etc...please rename accordingly the pinctrl_ops.

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
>  enum scmi_system_events {
> -- 
> 2.25.1

Thanks,
Cristian
