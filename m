Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C772551A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjFGHKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238720AbjFGHKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:10:50 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C210B19AA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:10:47 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 6b8f1cc4-0502-11ee-b972-005056bdfda7;
        Wed, 07 Jun 2023 10:10:45 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 7 Jun 2023 10:10:44 +0300
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
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
Message-ID: <ZIAtdLTvM6qh4r9W@surfacebook>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <d388c7af3f72fd47baffe0de8c6fec8074cb483c.1686063941.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d388c7af3f72fd47baffe0de8c6fec8074cb483c.1686063941.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Jun 06, 2023 at 04:22:27PM +0000, Oleksii Moisieiev kirjoitti:
> scmi: Introduce pinctrl SCMI protocol driver

Seems like you forgot to remove previous line(s) in the commit message and
the above has to be the Subject here.

> Add basic implementation of the SCMI v3.2 pincontrol protocol
> excluding GPIO support. All pinctrl related callbacks and operations
> are exposed in the include/linux/scmi_protocol.h

drop include/ part, everybody will understand that. Also mind the grammar
period.

...

> -scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
> +scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o pinctrl.o

Why not splitting it and make it ordered?

...

Missing headers:

	bitfield.h
	bits.h
	byteorder/
	types.h

> +#include <linux/module.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>

Missing

	asm/unaligned.h

...

> +struct scmi_group_info { 
> +       bool present; 
> +       char name[SCMI_MAX_STR_SIZE]; 
> +       unsigned int *group_pins; 
> +       unsigned int nr_pins; 
> +}; 
 
So, why struct pingroup can't be embeded here?

> +struct scmi_function_info {
> +	bool present;
> +	char name[SCMI_MAX_STR_SIZE];
> +	unsigned int *groups;
> +	unsigned int nr_groups;
> +};

So, why and struct pinfunction can't be embedded here (yes, you would need a
duplication of groups as here they are integers)?

As far as I understand these data structures are not part of any ABI (otherwise
the wrong type(s) / padding might be in use) and hence don't see the impediments
to use them, but would be nice to have a comment on top of each.

...

> +struct scmi_pin_info {
> +	bool present;
> +	char name[SCMI_MAX_STR_SIZE];

Swapping order might help compiler to generate a better code.
Also this applies to the _group_info and _function_info.

> +};

...

> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {

Can you rather follow the usual pattern, i.e. checking for the errors?

	if (ret)
		goto out_put_xfer;

> +		pi->nr_functions = GET_FUNCTIONS_NR(attr->attributes_high);
> +		pi->nr_groups = GET_GROUPS_NR(attr->attributes_low);
> +		pi->nr_pins = GET_PINS_NR(attr->attributes_low);
> +	}

out_put_xfer:

> +	ph->xops->xfer_put(ph, t);
> +	return ret;

...

> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {

Ditto.

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

	if (ret)
		return ret;

> +		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
> +					    (u32 *)&type, name,
> +					    SCMI_MAX_STR_SIZE);
> +	return ret;

	return 0;

> +}

...

> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret)

	if (ret)
		goto out_put_xfer;

(but in this and similar, aka one line, cases the current wouldn't be bad, just
matter of the consistency with the rest of the code)

> +		*config_value = get_unaligned_le32(t->rx.buf);
> +
> +	ph->xops->xfer_put(ph, t);
> +	return ret;

...

> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_RELEASE,
> +				      sizeof(*tx), 0, &t);

This is perfectly one line. Please also check entire code for such an unneeded
wrap.

...

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
> +
> +	ret = scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
> +					     group->nr_pins, group->group_pins);
> +	if (ret) {
> +		devm_kfree(ph->dev, group->group_pins);

This is a red flag. Is this function is solely used at the ->probe() stage?
I do not think so. Why then the devm_*() is being used to begin with?

Also what are the object lifetimes for device here and the _group_info
instances?

> +		return ret;
> +	}
> +
> +	group->present = true;
> +	return 0;
> +}

...

> +static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handle *ph,
> +					  u32 selector,
> +					  struct scmi_function_info *func)
> +{

As per above.

> +}

...

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

It's not a terminator item, so leave trailing comma. It will reduce the burden
in case of update of this.

> +};

...

> +static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handle *ph)
> +{

> +	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
> +	if (!pinfo)
> +		return -ENOMEM;

All the same, why devm_*() is in use and what are the object lifetimes?

> +}

...

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

Missing outer {}, but see above as well.

...

> +static const struct scmi_protocol scmi_pinctrl = {
> +	.id = SCMI_PROTOCOL_PINCTRL,

> +	.owner = THIS_MODULE,

This is not needed if you use a trick from ~15 years back...

> +	.instance_init = &scmi_pinctrl_protocol_init,
> +	.instance_deinit = &scmi_pinctrl_protocol_deinit,
> +	.ops = &pinctrl_proto_ops,
> +};
> +

Redundant blank line.

> +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(pinctrl, scmi_pinctrl)

...i.e. initializing the owner by this macro.

It might require some update to the above macro and its users.

...


> +enum scmi_pinctrl_selector_type {
> +	PIN_TYPE = 0,
> +	GROUP_TYPE,
> +	FUNCTION_TYPE

Leave trailing comma.

> +};

-- 
With Best Regards,
Andy Shevchenko


