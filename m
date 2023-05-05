Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F45D6F8A40
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjEEUf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjEEUf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:35:26 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2601A49E7
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 13:35:24 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 5addbdeb-eb84-11ed-b3cf-005056bd6ce9;
        Fri, 05 May 2023 23:35:21 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 5 May 2023 23:35:21 +0300
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Peng Fan <peng.fan@oss.nxp.com>,
        Michal Simek <michal.simek@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v2 2/3] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Message-ID: <ZFVoiWnvq7UXSBBw@surfacebook>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
 <812ae71d017b115c55648dbf0a4c3502715b1955.1682513390.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <812ae71d017b115c55648dbf0a4c3502715b1955.1682513390.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Apr 26, 2023 at 01:26:37PM +0000, Oleksii Moisieiev kirjoitti:
> scmi-pinctrl driver implements pinctrl driver interface and using
> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> SCP firmware, which does the changes in HW.
> 
> This setup expects SCP firmware (or similar system, such as ATF)
> to be installed on the platform, which implements pinctrl driver
> for the specific platform.
> 
> SCMI-Pinctrl driver should be configured from the device-tree and uses
> generic device-tree mappings for the configuration.

...

> +#include <linux/device.h>
> +#include <linux/err.h>

> +#include <linux/of.h>

I do not see any user of this header. Do you?

> +#include <linux/module.h>
> +#include <linux/seq_file.h>
> +
> +#include <linux/pinctrl/machine.h>
> +#include <linux/pinctrl/pinconf.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>

> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>

Please, move these two to the upper group of the generic headers.

> +struct scmi_pinctrl_funcs {
> +	unsigned int num_groups;
> +	const char **groups;
> +};

Please, use struct pinfunction.

...

> +struct scmi_pinctrl {

> +	struct scmi_pinctrl_funcs *functions;
> +	unsigned int nr_functions;

> +	char **groups;
> +	unsigned int nr_groups;

I'm not sure what is the difference to what "functions" above represent.

> +};

...

> +static void pinctrl_scmi_pin_dbg_show(struct pinctrl_dev *pctldev,
> +				      struct seq_file *s,
> +				      unsigned int offset)
> +{
> +	seq_puts(s, DRV_NAME);
> +}

What is the usefulness of this method?

...

> +static int pinctrl_scmi_pinconf_group_get(struct pinctrl_dev *pctldev,
> +					  unsigned int _pin,
> +					  unsigned long *config)
> +{
> +	int ret;
> +	struct scmi_pinctrl *pmx;
> +	enum pin_config_param config_type;
> +	unsigned long config_value;
> +
> +	if (!pctldev)
> +		return -EINVAL;
> +
> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph || !config)
> +		return -EINVAL;
> +
> +	config_type = pinconf_to_config_param(*config);
> +
> +	ret = pinctrl_ops->get_config(pmx->ph, _pin, GROUP_TYPE,
> +				      config_type, (u32 *)&config_value);

Endianess issue. This is, while likely working code, still ugly.

> +	if (ret)
> +		return ret;
> +
> +	*config = pinconf_to_config_packed(config_type, config_value);
> +
> +	return 0;
> +}

...

> + err:

err_free.

> +	kfree(pmx->pins);
> +	pmx->nr_pins = 0;
> +
> +	return ret;

...

> +static const struct scmi_device_id scmi_id_table[] = {
> +	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },

> +	{ },

No comma for the terminator entry.

> +};

...

> +	pinctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL,
> +						&ph);

Can be on one line.

> +	if (IS_ERR(pinctrl_ops))
> +		return PTR_ERR(pinctrl_ops);

...

> +	if (pmx->nr_functions) {
> +		pmx->functions =
> +			devm_kcalloc(&sdev->dev, pmx->nr_functions,
> +				     sizeof(*pmx->functions),
> +				     GFP_KERNEL);
> +		if (!pmx->functions) {
> +			ret = -ENOMEM;
> +			goto clean;

Interleaving devm_*() with non-devm_*() in such order is not a good idea.

> +		}
> +	}
> +
> +	if (pmx->nr_groups) {
> +		pmx->groups =
> +			devm_kcalloc(&sdev->dev, pmx->nr_groups,
> +				     sizeof(*pmx->groups),
> +				     GFP_KERNEL);
> +		if (!pmx->groups) {
> +			ret = -ENOMEM;
> +			goto clean;
> +		}
> +	}
> +
> +	return pinctrl_enable(pmx->pctldev);
> +
> +clean:

err_free:

> +	if (pmx) {
> +		kfree(pmx->functions);
> +		kfree(pmx->groups);

Ah, this is simply wrong.

> +	}
> +
> +	kfree(pmx);

-- 
With Best Regards,
Andy Shevchenko


