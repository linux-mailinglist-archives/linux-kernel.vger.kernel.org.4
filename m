Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1C16A9A5B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjCCPOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCCPOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:14:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980CBC645;
        Fri,  3 Mar 2023 07:14:41 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PSs2R33cGz6J69J;
        Fri,  3 Mar 2023 23:14:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 3 Mar
 2023 15:14:39 +0000
Date:   Fri, 3 Mar 2023 15:14:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: ad74413r: wire up support for
 drive-strength-microamp property
Message-ID: <20230303151438.00003842@Huawei.com>
In-Reply-To: <20230302134922.1120217-3-linux@rasmusvillemoes.dk>
References: <20230302134922.1120217-1-linux@rasmusvillemoes.dk>
        <20230302134922.1120217-3-linux@rasmusvillemoes.dk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Mar 2023 14:49:21 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> Use the value specified in the channel configuration node to populate
> the DIN_SINK field of the DIN_CONFIGx register.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Hi Rasmus,

 Given you are doing a v2 for the binding issue
Rob's bot noted. One trivial comment inline.
(I'd have ignored it if everything else was fine!)

Thanks,

Jonathan

> ---
>  drivers/iio/addac/ad74413r.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index f32c8c2fb26d..cbf0f66fdc74 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -39,6 +39,7 @@ struct ad74413r_chip_info {
>  
>  struct ad74413r_channel_config {
>  	u32		func;
> +	u32		drive_strength;
>  	bool		gpo_comparator;
>  	bool		initialized;
>  };
> @@ -111,6 +112,7 @@ struct ad74413r_state {
>  #define AD74413R_REG_DIN_CONFIG_X(x)	(0x09 + (x))
>  #define AD74413R_DIN_DEBOUNCE_MASK	GENMASK(4, 0)
>  #define AD74413R_DIN_DEBOUNCE_LEN	BIT(5)
> +#define AD74413R_DIN_SINK_MASK		GENMASK(9, 6)
>  
>  #define AD74413R_REG_DAC_CODE_X(x)	(0x16 + (x))
>  #define AD74413R_DAC_CODE_MAX		GENMASK(12, 0)
> @@ -261,6 +263,19 @@ static int ad74413r_set_comp_debounce(struct ad74413r_state *st,
>  				  val);
>  }
>  
> +static int ad74413r_set_comp_drive_strength(struct ad74413r_state *st,
> +					    unsigned int offset,
> +					    unsigned int strength)
> +{
> +	if (strength > 1800)
> +		strength = 1800;

trivial but I think
	strength = min(strength, 1800);
is perhaps a little more readable?

> +
> +	return regmap_update_bits(st->regmap, AD74413R_REG_DIN_CONFIG_X(offset),
> +				  AD74413R_DIN_SINK_MASK,
> +				  FIELD_PREP(AD74413R_DIN_SINK_MASK, strength / 120));
> +}
> +
> +
>  static void ad74413r_gpio_set(struct gpio_chip *chip,
>  			      unsigned int offset, int val)
>  {
> @@ -1190,6 +1205,9 @@ static int ad74413r_parse_channel_config(struct iio_dev *indio_dev,
>  	config->gpo_comparator = fwnode_property_read_bool(channel_node,
>  		"adi,gpo-comparator");
>  
> +	fwnode_property_read_u32(channel_node, "drive-strength-microamp",
> +				 &config->drive_strength);
> +
>  	if (!config->gpo_comparator)
>  		st->num_gpo_gpios++;
>  
> @@ -1269,6 +1287,7 @@ static int ad74413r_setup_gpios(struct ad74413r_state *st)
>  	unsigned int gpo_gpio_i = 0;
>  	unsigned int i;
>  	u8 gpo_config;
> +	u32 strength;
>  	int ret;
>  
>  	for (i = 0; i < AD74413R_CHANNEL_MAX; i++) {
> @@ -1285,6 +1304,11 @@ static int ad74413r_setup_gpios(struct ad74413r_state *st)
>  		    config->func == CH_FUNC_DIGITAL_INPUT_LOOP_POWER)
>  			st->comp_gpio_offsets[comp_gpio_i++] = i;
>  
> +		strength = config->drive_strength;
> +		ret = ad74413r_set_comp_drive_strength(st, i, strength);
> +		if (ret)
> +			return ret;
> +
>  		ret = ad74413r_set_gpo_config(st, i, gpo_config);
>  		if (ret)
>  			return ret;

