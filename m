Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CDA6D3FB0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjDCJEp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 05:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjDCJEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:04:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264E0527D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:04:42 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1pjG7B-0003Gd-DA; Mon, 03 Apr 2023 11:04:37 +0200
Message-ID: <30937b92bece48c008c1fe2b29498641df1dfd0c.camel@pengutronix.de>
Subject: Re: [PATCH V2] soc: imx: imx8m-blk-ctrl/gpcv2: fix i.MX8MP VPU_H1
 sequence
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Date:   Mon, 03 Apr 2023 11:04:36 +0200
In-Reply-To: <20230403084228.3212581-1-peng.fan@oss.nxp.com>
References: <20230403084228.3212581-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, dem 03.04.2023 um 16:42 +0800 schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per errata:
> ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMIX
> power up/down cycling.
> Description: VC8000E reset de-assertion edge and AXI clock may have a
> timing issue.
> Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
> both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
> VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
> de-asserted by HW)
> 
> Need clear BIT2 of BLK_CLK_EN_CSR before power up VPU_H1, so
> add a notifier with BIT2 cleared when GENPD_NOTIFY_PRE_ON and BIT2 set
> when GENPD_NOTIFY_ON to match NXP downstream Arm Trusted Firmware
> implementation.
> 
> NOTE: The NXP downstream ATF has VPU_H1 CLK SET before do ADB400 HDSK,
> so follow that procdure to avoid any suprise.
> 
This patch seems to be quite complex for what it is trying to achieve.
From what I can tell, we can implement the correct sequence just by
fixing the blk-ctrl driver.

First of all the i.MX8MP VPU support needs to stop using the
imx8mm_vpu_power_notifier. This is wrong, as it ungates the VPU clocks
to provide the ADB clock, which is necessary on i.MX8MM, but on i.MX8MP
there is a separate gate (bit 3) for the NoC. When this is correctly
implemented the VC8000E clock should already be gated off.

Then we just need to move the clock enable after the GPC domain has
been powered up in imx8m_blk_ctrl_power_up(), which shouldn't hurt for
the other domains, to achieve the necessary sequence.

Btw: it's quite confusing that the commit talks about both VC8K and H1.
The VPU core on the i.MX8MP is called VC8K, so we should really stick
to that when talking about patches specific to the 8MP.

Regards,
Lucas

> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Add the missing gpcv2 changes
> 
>  drivers/soc/imx/gpcv2.c          |  3 +++
>  drivers/soc/imx/imx8m-blk-ctrl.c | 28 ++++++++++++++++++++++++++++
>  include/soc/imx/gpcv2.h          |  8 ++++++++
>  3 files changed, 39 insertions(+)
>  create mode 100644 include/soc/imx/gpcv2.h
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 4b3300b090a8..81e3c09e004b 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -17,6 +17,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
> +#include <soc/imx/gpcv2.h>
>  #include <dt-bindings/power/imx7-power.h>
>  #include <dt-bindings/power/imx8mq-power.h>
>  #include <dt-bindings/power/imx8mm-power.h>
> @@ -376,6 +377,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>  
>  	reset_control_deassert(domain->reset);
>  
> +	raw_notifier_call_chain(&genpd->power_notifiers, IMX_GPCV2_NOTIFY_ON_ADB400, NULL);
> +
>  	/* request the ADB400 to power up */
>  	if (domain->bits.hskreq) {
>  		regmap_update_bits(domain->regmap, domain->regs->hsk,
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index afbca0d48c14..d88e338a54b1 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -14,6 +14,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/clk.h>
> +#include <soc/imx/gpcv2.h>
>  
>  #include <dt-bindings/power/imx8mm-power.h>
>  #include <dt-bindings/power/imx8mn-power.h>
> @@ -53,6 +54,7 @@ struct imx8m_blk_ctrl_domain_data {
>  	 * register.
>  	 */
>  	u32 mipi_phy_rst_mask;
> +	notifier_fn_t power_notifier_fn;
>  };
>  
>  #define DOMAIN_MAX_CLKS 4
> @@ -66,6 +68,7 @@ struct imx8m_blk_ctrl_domain {
>  	struct device *power_dev;
>  	struct imx8m_blk_ctrl *bc;
>  	int num_paths;
> +	struct notifier_block power_nb;
>  };
>  
>  struct imx8m_blk_ctrl_data {
> @@ -265,6 +268,15 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>  			goto cleanup_pds;
>  		}
>  
> +		if (data->power_notifier_fn) {
> +			domain->power_nb.notifier_call = data->power_notifier_fn;
> +			ret = dev_pm_genpd_add_notifier(domain->power_dev, &domain->power_nb);
> +			if (ret) {
> +				dev_err_probe(dev, ret, "failed to add power notifier\n");
> +				goto cleanup_pds;
> +			}
> +		}
> +
>  		domain->genpd.name = data->name;
>  		domain->genpd.power_on = imx8m_blk_ctrl_power_on;
>  		domain->genpd.power_off = imx8m_blk_ctrl_power_off;
> @@ -479,6 +491,21 @@ static const struct imx8m_blk_ctrl_data imx8mm_vpu_blk_ctl_dev_data = {
>  	.num_domains = ARRAY_SIZE(imx8mm_vpu_blk_ctl_domain_data),
>  };
>  
> +static int imx8mp_vpu_h1_power_notifier(struct notifier_block *nb,
> +					unsigned long action, void *data)
> +{
> +	struct imx8m_blk_ctrl_domain *domain = container_of(nb, struct imx8m_blk_ctrl_domain,
> +							    power_nb);
> +	struct imx8m_blk_ctrl *bc = domain->bc;
> +
> +	if (action == GENPD_NOTIFY_PRE_ON)
> +		regmap_clear_bits(bc->regmap, BLK_CLK_EN, BIT(2));
> +	else if (action == IMX_GPCV2_NOTIFY_ON_ADB400)
> +		regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(2));
> +
> +	return NOTIFY_OK;
> +}
> +
>  static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[] = {
>  	[IMX8MP_VPUBLK_PD_G1] = {
>  		.name = "vpublk-g1",
> @@ -509,6 +536,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[]
>  		.clk_mask = BIT(2),
>  		.path_names = (const char *[]){"vc8000e"},
>  		.num_paths = 1,
> +		.power_notifier_fn = imx8mp_vpu_h1_power_notifier,
>  	},
>  };
>  
> diff --git a/include/soc/imx/gpcv2.h b/include/soc/imx/gpcv2.h
> new file mode 100644
> index 000000000000..db09720bf638
> --- /dev/null
> +++ b/include/soc/imx/gpcv2.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __SOC_IMX_GPCV2_H
> +#define __SOC_IMX_GPCV2_H
> +
> +/* Avoid conflict with GENPD_NOTIFY_XX */
> +#define IMX_GPCV2_NOTIFY_ON_ADB400	0x80000000
> +
> +#endif /* __SOC_IMX_GPC_H */

