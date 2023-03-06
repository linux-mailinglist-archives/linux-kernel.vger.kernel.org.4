Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736526AD2D0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCFX2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCFX2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:28:14 -0500
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDA0367DA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 15:28:12 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 8e0ab352-bc76-11ed-b972-005056bdfda7;
        Tue, 07 Mar 2023 01:28:09 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Tue, 7 Mar 2023 01:28:09 +0200
To:     Chester Lin <clin@suse.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH v5 2/3] pinctrl: add NXP S32 SoC family support
Message-ID: <ZAZ3CeYiZxR5zlRu@surfacebook>
References: <20230220023320.3499-1-clin@suse.com>
 <20230220023320.3499-3-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220023320.3499-3-clin@suse.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 20, 2023 at 10:33:19AM +0800, Chester Lin kirjoitti:
> Add the pinctrl driver for NXP S32 SoC family. This driver is mainly based
> on NXP's downstream implementation on nxp-auto-linux repo[1].

Seems Linus already applied this, but still some comments for the future, some
for the followups. However, personally I prefer this to be dropped and redone
because too many things here and there.

> [1] https://github.com/nxp-auto-linux/linux/tree/bsp35.0-5.15.73-rt/drivers/pinctrl/freescale

This can be transformed to Link: tag.

> Signed-off-by: Matthew Nunez <matthew.nunez@nxp.com>
> Signed-off-by: Phu Luu An <phu.luuan@nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@nxp.com>
> Signed-off-by: Radu Pirea <radu-nicolae.pirea@nxp.com>
> Signed-off-by: Chester Lin <clin@suse.com>

Is it for real?!
Quite a long chain and none of Co-developed-by.

...

> +	depends on ARCH_S32 && OF

Is OF necessary? Can it be

	depends OF || COMPILE_TEST

?

...

> +	depends on ARCH_S32 && OF

Ditto.

...

> +/**
> + * struct s32_pin_group - describes an S32 pin group
> + * @name: the name of this specific pin group
> + * @npins: the number of pins in this group array, i.e. the number of
> + *         elements in pin_ids and pin_sss so we can iterate over that array
> + * @pin_ids: an array of pin IDs in this group
> + * @pin_sss: an array of source signal select configs paired with pin_ids
> + */
> +struct s32_pin_group {
> +	const char *name;
> +	unsigned int npins;
> +	unsigned int *pin_ids;
> +	unsigned int *pin_sss;

Why didn't you embed struct pingroup?

> +};
> +
> +/**
> + * struct s32_pmx_func - describes S32 pinmux functions
> + * @name: the name of this specific function
> + * @groups: corresponding pin groups
> + * @num_groups: the number of groups
> + */
> +struct s32_pmx_func {
> +	const char *name;
> +	const char **groups;
> +	unsigned int num_groups;
> +};

struct pinfunction.

...

> +#ifdef CONFIG_PM_SLEEP
> +int __maybe_unused s32_pinctrl_resume(struct device *dev);
> +int __maybe_unused s32_pinctrl_suspend(struct device *dev);
> +#endif

Please, consider using new PM macros, like pm_ptr().

...

> +static u32 get_pin_no(u32 pinmux)
> +{
> +	return (pinmux & S32_PIN_ID_MASK) >> __ffs(S32_PIN_ID_MASK);

Oh, don't you have MASK to be 2^x - 1? Why to drag this with __ffs()?
Just define a complement _SHIFT.

> +}

...

> +	n_pins = of_property_count_elems_of_size(np, "pinmux", sizeof(u32));
> +	if (n_pins < 0) {
> +		dev_warn(dev, "Unable to find 'pinmux' property in node %s.\n",
> +			np->name);

Use %pOFn instead of %s.

> +	} else if (!n_pins) {
> +		return -EINVAL;
> +	}

...

> +	for (i = 0; i < grp->npins; ++i) {

Why pre-increment?

> +		if (s32_check_pin(pctldev, grp->pin_ids[i]) != 0) {
> +			dev_err(info->dev, "invalid pin: %d in group: %d\n",
> +				grp->pin_ids[i], group);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	for (i = 0, ret = 0; i < grp->npins && !ret; ++i) {

Ditto.

> +		ret = s32_regmap_update(pctldev, grp->pin_ids[i],
> +					S32_MSCR_SSS_MASK, grp->pin_sss[i]);

Traditional pattern is

		if (ret)
			return ret;

This avoids first assignment of the ret.

> +	}
> +
> +	return ret;

	return 0;

> +}

...

> +	ret = s32_regmap_read(pctldev, offset, &config);
> +	if (ret != 0)
> +		return -EINVAL;

Why not

	if (ret)
		return ret;

...

> +	list_add(&(gpio_pin->list), &(ipctl->gpio_configs));

Too many parentheses.

...

> +	list_for_each_safe(pos, tmp, &ipctl->gpio_configs) {
> +		gpio_pin = list_entry(pos, struct gpio_pin_config, list);

Why not list_for_each_entry_safe() ?


> +		if (gpio_pin->pin_id == offset) {
> +			ret = s32_regmap_write(pctldev, gpio_pin->pin_id,
> +						 gpio_pin->config);
> +			if (ret != 0)
> +				goto unlock;
> +
> +			list_del(pos);
> +			kfree(gpio_pin);
> +			break;
> +		}
> +	}

...

> +static int s32_get_slew_regval(int arg)
> +{
> +	int i;

	unsigned int i;

+ Blank line.

> +	/* Translate a real slew rate (MHz) to a register value */
> +	for (i = 0; i < ARRAY_SIZE(support_slew); i++) {
> +		if (arg == support_slew[i])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}

...

> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		if (arg)
> +			*config |= S32_MSCR_PUS;
> +		else
> +			*config &= ~S32_MSCR_PUS;

> +		fallthrough;

It's quite easy to miss this and tell us about how is it supposed to work with PU + PD?

> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		if (arg)
> +			*config |= S32_MSCR_PUE;
> +		else
> +			*config &= ~S32_MSCR_PUE;
> +		*mask |= S32_MSCR_PUE | S32_MSCR_PUS;
> +		break;
> +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> +		*config &= ~(S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE);
> +		*mask |= S32_MSCR_ODE | S32_MSCR_OBE | S32_MSCR_IBE;
> +		fallthrough;

Ditto.

> +	case PIN_CONFIG_BIAS_DISABLE:
> +		*config &= ~(S32_MSCR_PUS | S32_MSCR_PUE);
> +		*mask |= S32_MSCR_PUS | S32_MSCR_PUE;
> +		break;

...

> +	if (s32_check_pin(pctldev, pin_id) != 0)

Shadowing an error?

> +		return -EINVAL;

...

> +	ret = s32_regmap_update(pctldev, pin_id, mask, config);
> +
> +	dev_dbg(ipctl->dev, "update: pin %d cfg 0x%x\n", pin_id, config);
> +
> +	return ret;

You are not using ret in between, hence

	return _regmap_update(...);

...

> +static void s32_pinconf_dbg_show(struct pinctrl_dev *pctldev,
> +				 struct seq_file *s, unsigned int pin_id)
> +{
> +	unsigned int config;
> +	int ret = s32_regmap_read(pctldev, pin_id, &config);
> +
> +	if (!ret)
> +		seq_printf(s, "0x%x", config);


	int ret;

	ret = s32_regmap_read(pctldev, pin_id, &config);
	if (ret)
		return;

	seq_printf(s, "0x%x", config);

> +}

...

> +	npins = of_property_count_elems_of_size(np, "pinmux", sizeof(u32));

> +

Unneccessary blank line.

> +	if (npins < 0) {
> +		dev_err(dev, "Failed to read 'pinmux' property in node %s.\n",
> +			np->name);
> +		return;
> +	}
> +	if (!npins) {
> +		dev_err(dev, "The group %s has no pins.\n", np->name);
> +		return;
> +	}

...

> +	grp->pin_ids = devm_kcalloc(info->dev, grp->npins,
> +				    sizeof(unsigned int), GFP_KERNEL);
> +	grp->pin_sss = devm_kcalloc(info->dev, grp->npins,
> +				    sizeof(unsigned int), GFP_KERNEL);

> +

Ditto.

> +	if (!grp->pin_ids || !grp->pin_sss) {

> +		dev_err(dev, "Failed to allocate memory for the group %s.\n",
> +			np->name);

We do not print ENOMEM error messages.

> +		return;
> +	}

...

> +	func->groups = devm_kzalloc(info->dev,
> +			func->num_groups * sizeof(char *), GFP_KERNEL);

First of all, this is devm_kcalloc().
Second, where is the error check?

> +	for_each_child_of_node(np, child) {
> +		func->groups[i] = child->name;
> +		grp = &info->groups[info->grp_index++];
> +		s32_pinctrl_parse_groups(child, grp, info);
> +		i++;
> +	}

...

> +	ipctl->regions = devm_kzalloc(&pdev->dev,
> +				      mem_regions * sizeof(*(ipctl->regions)),
> +				      GFP_KERNEL);

devm_kcalloc()

> +	if (!ipctl->regions)
> +		return -ENOMEM;

...

> +	info->functions = devm_kzalloc(&pdev->dev,
> +				       nfuncs * sizeof(struct s32_pmx_func),
> +				       GFP_KERNEL);

Ditto.

> +	if (!info->functions)
> +		return -ENOMEM;

...

> +	info->groups = devm_kzalloc(&pdev->dev,
> +				    info->ngroups * sizeof(struct s32_pin_group),
> +				    GFP_KERNEL);

Ditto.

> +	if (!info->groups)
> +		return -ENOMEM;

...

> +	ipctl->pctl = devm_pinctrl_register(&pdev->dev, s32_pinctrl_desc,
> +					    ipctl);

> +

Unneeded blank line.

> +	if (IS_ERR(ipctl->pctl)) {

> +		dev_err(&pdev->dev, "could not register s32 pinctrl driver\n");
> +		return PTR_ERR(ipctl->pctl);

	return dev_err_probe(...);

> +	}

...

> diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pinctrl-s32g2.c

Similar issues has to be addressed, if any.

...

> +	return s32_pinctrl_probe
> +			(pdev, (struct s32_pinctrl_soc_info *) of_id->data);

Broken indentation.

...

> +static const struct dev_pm_ops s32g_pinctrl_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(s32_pinctrl_suspend,
> +				     s32_pinctrl_resume)
> +};

Consider using DEFINE_* PM macros.

...

> +static struct platform_driver s32g_pinctrl_driver = {
> +	.driver = {
> +		.name = "s32g-siul2-pinctrl",

> +		.owner = THIS_MODULE,

Duplicate assignment.

> +		.of_match_table = s32_pinctrl_of_match,
> +		.pm = &s32g_pinctrl_pm_ops,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = s32g_pinctrl_probe,
> +};

> +

Unnecessary blank line.

> +builtin_platform_driver(s32g_pinctrl_driver);

-- 
With Best Regards,
Andy Shevchenko


