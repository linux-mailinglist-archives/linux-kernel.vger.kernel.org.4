Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19926E9BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjDTSrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDTSrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:47:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5658C268A;
        Thu, 20 Apr 2023 11:47:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9E9A1480;
        Thu, 20 Apr 2023 11:47:58 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3557D3F587;
        Thu, 20 Apr 2023 11:47:13 -0700 (PDT)
Date:   Thu, 20 Apr 2023 19:47:10 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: Re: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
Message-ID: <ZEGIrj0PyrURANDr@pluto>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
 <54119b2cb43e29f69c5858a5320d3a58f23fed21.1680793130.git.oleksii_moisieiev@epam.com>
 <ZDcqx9JVMvqr2WYu@e120937-lin>
 <ZEFw0TYs3TEHuM1D@pluto>
 <e2c3eae9-4c99-43fe-abcf-4f1840c58c64@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2c3eae9-4c99-43fe-abcf-4f1840c58c64@epam.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 05:23:05PM +0000, Oleksii Moisieiev wrote:
> Hi Cristian,
> 

Hi,

> On 20.04.23 20:05, Cristian Marussi wrote:
> > On Wed, Apr 12, 2023 at 11:04:05PM +0100, Cristian Marussi wrote:
> >> On Fri, Apr 07, 2023 at 10:18:27AM +0000, Oleksii Moisieiev wrote:
> >>> Implementation of the SCMI client driver, which implements
> >>> PINCTRL_PROTOCOL. This protocol has ID 19 and is described
> >>> in the latest DEN0056 document.
> >> Hi,
> >>
> > Hi Oleksii,
> >
> > one more thing that I missed in my previous review down below.
> >
> >>> This protocol is part of the feature that was designed to
> >>> separate the pinctrl subsystem from the SCP firmware.
> >>> The idea is to separate communication of the pin control
> >>> subsystem with the hardware to SCP firmware
> >>> (or a similar system, such as ATF), which provides an interface
> >>> to give the OS ability to control the hardware through SCMI protocol.
> >>> This is a generic driver that implements SCMI protocol,
> >>> independent of the platform type.
> >>>
> >>> DEN0056 document:
> >>> https://urldefense.com/v3/__https://developer.arm.com/documentation/den0056/latest__;!!GF_29dbcQIUBPA!0kMLQ5c3tKsMfWCqTKHp6eolY3sTZlyKmAD7B7pbiSESABUUoBzmhgrYdDgWGC_g0vgLE4zwrS4ppeTOD8KizP9fIeJkpg$ [developer[.]arm[.]com]
> >>>
> > [snip]
> >
> >>> +static int scmi_pinctrl_request_config(const struct scmi_handle *handle,
> >>> +				       u32 selector,
> >>> +				       enum scmi_pinctrl_selector_type type,
> >>> +				       u32 *config)
> >>> +{
> >>> +	struct scmi_xfer *t;
> >>> +	struct scmi_conf_tx *tx;
> >>> +	__le32 *packed_config;
> >>> +	u32 attributes = 0;
> >>> +	int ret;
> >>> +
> >>> +	if (!handle || !config || type == FUNCTION_TYPE)
> >>> +		return -EINVAL;
> >>> +
> >>> +	ret = scmi_pinctrl_validate_id(handle, selector, type);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	ret = scmi_xfer_get_init(handle, PINCTRL_CONFIG_GET,
> >>> +				 SCMI_PROTOCOL_PINCTRL,
> >>> +				 sizeof(*tx), sizeof(*packed_config), &t);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	tx = t->tx.buf;
> >>> +	packed_config = t->rx.buf;
> >>> +	tx->identifier = cpu_to_le32(selector);
> >>> +	attributes = SET_TYPE_BITS(attributes, type);
> >>> +	attributes = SET_CONFIG(attributes, *config);
> >>> +
> > Looking at scmi_conf_tx and these pinctrl get/set functions, you do not
> > seem to consider the ConfigType field in the SCMI related messages, so
> > basically using always the Default 0 Type, and as a consequence you dont
> > either expose any way to choose a Different type in the related SCMI
> > protocol ops; I imagine this is because the pinctrl driver currently using
> > this protocol, at the end, does not need any of the other available types
> > (as in Table 23 of the spec).
> >
> I'm not sure I've understood your point. Pinctrl subsystem pass config 
> in so-called Packed format. So this means that config is both input and 
> output parameter. Packed format means that u32 config has both config id 
> and config value packed inside.
> 

Sorry I was meant to make the above comment on the PINCTRL_SET path but
I messed up and commented on the GET path....my bad.

Anyway even considering the packed format and looking at the PINCTRL_SET
function scmi_pinctrl_apply_config I dont understand how this works.

> So I receive packed config with both id and value on config_set call and 
> then just send it over SCMI, expecting error from server if config is 

This is where I dont understand: you receive a packed 32bit config from
pinctrl subsystem via ops->set_config together with the pin_id and in turn
this calls down into this apply_config where you build the packet:


> +	ret = scmi_pinctrl_validate_id(handle, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = scmi_xfer_get_init(handle, PINCTRL_CONFIG_SET,
> +				 SCMI_PROTOCOL_PINCTRL,
> +				 sizeof(*tx), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	tx = t->tx.buf;
> +	tx->identifier = cpu_to_le32(selector);

you set the pin number

> +	attributes = SET_TYPE_BITS(attributes, type);

then set the Selector type as PIN_TYPE in the attributes bits 9:8


> +	attributes = SET_CONFIG(attributes, config);

And here you set the PackedFormat received from pinctrl into the
bits 7:0 of attributes...(...BUT you then assign back to attributes
which is 32 bit so I think this is another bug because this way you
clear any bit just set above with SET_TYPE_BITS...but this is not the
point now...lets ignore this... ad you should anyway use bitfield.h in V2)

...so this attributes now, as you explained me, include both the selector
type (PIN vs GROUP) in bits 9:8 (bugs apart) and then, as a packed format
the ConfigType and the Value to set, both packed into the bits 7:0

> +	tx->attributes = cpu_to_le32(attributes);
> +

You convert to proper endianity and

> +	ret = scmi_do_xfer(handle, t);
> +

send straight to the SCMI server as a payload for PINCTRL_SET....so you
send basically the pin identifier in this case (u32) AND the u32 with
the attributes which includes the Selector PIN vs GROUP and the
ConfigType ..this last as a packed thing including also the value...
(so this could contain....looking at Table23 as an example:
   Bias-pull-up (4) + a value in Ohms)

....BUT from the spec v3.2-BETA regarding PINCTRL_SET (4.11.2.7), you are
supposed to send one more u32 field "config_value" as the payload of
PINCTRL_SET (page 172) wth such field beaing the effectively carried
value to set....field which is instead now NOT considered at all and
so just sent as zero all of the time ... am I missing something ?

...so my understanding is that, being the expected format by the spec as
in 4.11.2.7, you should instead pick the PackedFormat your received as a 32bit
config, UNPACK it and split it into the attributes and config_value field....

from the v3.2 BETA spec I have I cannot see where the 32 bit attributes
payload is supposed to carry straight away the packedformat value...

...as it is implemented now, it is out of spec (at least the latest
v3.2-BETA public that I can see)... and if it works for you, it just means
your backend server is equally out-of-spec....which is probably a way of being
compliant BUT not the way we need to here :P

I cannot see any other way I can interpret this to make it
work...apologies if I am missing something, in such a case please explain...

Thanks,
Cristian
