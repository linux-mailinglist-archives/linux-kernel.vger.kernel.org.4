Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592BB702D01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbjEOMqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjEOMqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:46:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E37A6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E90BD61DC0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDEFC433EF;
        Mon, 15 May 2023 12:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684154795;
        bh=SDOeZrX4VpMn0ye2iffOvOcDXTWV8Cz8KoiAWyZ6oNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M15SYvqECuUFz53cmXGWzDvLSnWO6jStcFASbkm64BqjNK1xR3ZaORVjfozYUrM9l
         6azCMyGhDVZ0pf7P5xv968EnUFOgY2qjodeZqHcFhmfJgSbMz2pXSiPG8cbZj6WFTt
         hvaK1gDKNFd4wbayZCS2De+ZgO5Cjk9BV+kHIS5daOmXp1ikCyHrUadWChCQsghEzz
         iODhiKdPugpF4JRvYuBUryVQ8GT2/BNhKCTfi6tpcguEPtFzz66Dw1R4KBUxieOrs3
         9/CQv68WjKSF7BT6d1wBdW9TxfeXtVAxL9s1a7maInkmpU6u5O/d7cKx8l8dYnoHAl
         ELGzN27BmuRwg==
Date:   Mon, 15 May 2023 13:46:31 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     p.paillet@st.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: stpmic1: add pmic poweroff via sys-off handler
Message-ID: <20230515124631.GF10825@google.com>
References: <20230428112847.2146348-1-sean@geanix.com>
 <20230428112847.2146348-2-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230428112847.2146348-2-sean@geanix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023, Sean Nyekjaer wrote:

> Use devm_register_sys_off_handler() that allows to register multiple
> power-off handlers.
> 
> This can be enabled by adding "st,pmic-poweroff" to device-tree.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/mfd/stpmic1.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

You need to submit the Device Tree binding with this patch.

> diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
> index 4c9b18d9dec8..c628141eb03c 100644
> --- a/drivers/mfd/stpmic1.c
> +++ b/drivers/mfd/stpmic1.c
> @@ -7,6 +7,7 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/stpmic1.h>
>  #include <linux/module.h>
> +#include <linux/reboot.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> @@ -117,6 +118,33 @@ static const struct regmap_irq_chip stpmic1_regmap_irq_chip = {
>  	.num_irqs = ARRAY_SIZE(stpmic1_irqs),
>  };
>  
> +static int stpmic1_power_off(struct sys_off_data *data)
> +{
> +	struct stpmic1 *ddata = data->cb_data;
> +
> +	regmap_update_bits(ddata->regmap, MAIN_CR,
> +			   SOFTWARE_SWITCH_OFF, SOFTWARE_SWITCH_OFF);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int stpmic1_power_off_prepare_init(struct stpmic1 *ddata)

This function looks superfluous.

Why not just call devm_register_sys_off_handler() inside the if?

> +{
> +	int ret;
> +
> +	ret = devm_register_sys_off_handler(ddata->dev,
> +					    SYS_OFF_MODE_POWER_OFF,
> +					    SYS_OFF_PRIO_DEFAULT,
> +					    stpmic1_power_off,
> +					    ddata);
> +	if (ret) {
> +		dev_err(ddata->dev, "failed to register sys-off handler: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int stpmic1_probe(struct i2c_client *i2c)
>  {
>  	struct stpmic1 *ddata;
> @@ -159,6 +187,12 @@ static int stpmic1_probe(struct i2c_client *i2c)
>  		return ret;
>  	}
>  
> +	if (of_property_read_bool(i2c->dev.of_node,  "st,pmic-poweroff")) {
> +		ret = stpmic1_power_off_prepare_init(ddata);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return devm_of_platform_populate(dev);
>  }
>  
> -- 
> 2.40.0
> 

-- 
Lee Jones [李琼斯]
