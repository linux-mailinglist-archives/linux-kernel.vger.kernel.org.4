Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1916B63C082
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiK2M71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiK2M7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:59:25 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0110E0F;
        Tue, 29 Nov 2022 04:59:24 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9FAB84E6;
        Tue, 29 Nov 2022 13:59:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669726762;
        bh=Sv4JjA1T3CLcNJwfpw43GPVNyfDqomlM5uT0+4ozKS8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jc1+VXleXR5a7JFtLGFpu7N+IeJaJnI8DKQaBP//Vm5SbiaxnYpCbbNG2R4C6JM2s
         endSU0TbkKonx5+UKHeVgLa6WtIasgc/3lb06ZbH1Ayfe8n+t3ZOrmq/grC8bVQNvK
         D4YAHk/j6h2XBTnjm5SSqjdjVV6e33qmtm5ibncY=
Message-ID: <d710ac65-655a-6a5a-ce6e-6dee4fd1760b@ideasonboard.com>
Date:   Tue, 29 Nov 2022 14:59:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 7/7] drm: rcar-du: dsi: Add r8a779g0 support
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20221123065946.40415-1-tomi.valkeinen+renesas@ideasonboard.com>
 <20221123065946.40415-8-tomi.valkeinen+renesas@ideasonboard.com>
 <Y4VlHIpS9UnvWwt/@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
In-Reply-To: <Y4VlHIpS9UnvWwt/@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 03:49, Laurent Pinchart wrote:

>> @@ -198,70 +436,53 @@ static void rcar_mipi_dsi_parameters_calc(struct rcar_mipi_dsi *dsi,
>>   	 */
>>   	fout_target = target * mipi_dsi_pixel_format_to_bpp(dsi->format)
>>   		    / (2 * dsi->lanes);
>> -	if (fout_target < 40000000 || fout_target > 1250000000)
>> +	if (fout_target < MHZ(40) || fout_target > MHZ(1250))
>>   		return;
>>   
>>   	/* Find vco_cntrl */
>> -	for (vco_cntrl = vco_cntrl_table; vco_cntrl->min_freq != 0; vco_cntrl++) {
>> -		if (fout_target > vco_cntrl->min_freq &&
>> -		    fout_target <= vco_cntrl->max_freq) {
>> -			setup_info->vco_cntrl = vco_cntrl->value;
>> -			if (fout_target >= 1150000000)
>> -				setup_info->prop_cntrl = 0x0c;
>> -			else
>> -				setup_info->prop_cntrl = 0x0b;
>> +	for (clkset = dsi->info->clk_cfg; clkset->min_freq != 0; clkset++) {
>> +		if (fout_target > clkset->min_freq &&
>> +		    fout_target <= clkset->max_freq) {
>> +			setup_info->clkset = clkset;
>>   			break;
>>   		}
>>   	}
>>   
>> -	/* Add divider */
>> -	setup_info->div = (setup_info->vco_cntrl & 0x30) >> 4;
>> +	switch (dsi->info->model) {
>> +	case RCAR_DSI_R8A779A0:
>> +		setup_info->vclk_divider = 1 << ((clkset->vco_cntrl >> 4) & 0x3);
> 
> If you stored (clkset->vco_cntrl >> 4) & 0x3 in setup_info->vclk_divider
> you wouldn't have to use __ffs() in rcar_mipi_dsi_startup(). You could
> also drop the - 1 there, which would allow dropping one of the
> switch(dsi->info->model). You can store the real divider value in
> setup_info separately for rcar_mipi_dsi_pll_calc_r8a779a0(), or pass it
> to the function.

That's true. The reason I chose this approach was to keep dsi_setup_info 
"neutral", containing only the logical values, and the register specific 
tinkering is done only where the register is written. Mixing the logical 
and the register values in the old dsi_setup_info was confusing, and 
implementing your suggestion would again go that direction. But as you 
noticed, this is uglified a bit by the need to get the divider from the 
vco_cntrl.

We could store the logical divider in the dsi_clk_config table, though, 
which would remove the need for the above code.

  Tomi

