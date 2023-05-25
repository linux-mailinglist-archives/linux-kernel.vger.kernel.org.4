Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701C67109FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241036AbjEYKVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbjEYKVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:21:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81EF1AB;
        Thu, 25 May 2023 03:20:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33E7D64484;
        Thu, 25 May 2023 10:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032F2C4339B;
        Thu, 25 May 2023 10:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685010042;
        bh=iOTbN+LF/85xc4OrL5mazWp8f/WUdpjoDOfNOUiMOEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVtB191wNaVJ0vqiy3mm2Urn38kr9zcc/cKPX4ZSBt9CeL5MFb8CcY1B0WSVvsjWD
         dwKe78z+1YdMxtlcg6qho2enSYHXcyIBbXhJcun91q8EMvKvrxqb/KlsMaDzg34a5w
         BnrTi501mplvlRbrROuu4qwmnh47myRCkaT0M5n4PZ7zWXS/U7Xpi2XjNGBIOvnbFl
         PceCf/2XyoSlHgEvSWs3K1OdpSsY8IdIhXvhbuCDKNBOHw5V58wuxzY/DJBVG8jvZs
         G+IrJ7sSSRTQzNPr66yIHtvK4a+51nUM3S8hg4QVvkU6n9JkbhUjol0HuOqMhqYsLz
         z2SThUt28eEKw==
Date:   Thu, 25 May 2023 11:20:36 +0100
From:   Lee Jones <lee@kernel.org>
To:     luhongfei <luhongfei@vivo.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        luhongfei <11117923@bbktel.com>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] led: qcom-lpg: Fix bugs in lpg_add_led & lpg_probe
Message-ID: <20230525102036.GB9691@google.com>
References: <20230515082622.24551-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515082622.24551-1-luhongfei@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please improve the subject line.  Maybe:

  "Fix resource leaks in for_each_available_child_of_node() loops"

On Mon, 15 May 2023, luhongfei wrote:

> for_each_available_child_of_node in lpg_probe and lpg_add_led need
> to execute of_node_put before return. this patch could fix this bug.

"Ensure child node references are decremented properly in the error path."

> Signed-off-by: luhongfei <luhongfei@vivo.com>

Please use your full name.

> ---
>  drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 drivers/leds/rgb/leds-qcom-lpg.c
> 
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index 55a037234df1..0e8ff36c4bf7
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -1173,8 +1173,10 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
>  		i = 0;
>  		for_each_available_child_of_node(np, child) {
>  			ret = lpg_parse_channel(lpg, child, &led->channels[i]);
> -			if (ret < 0)
> +			if (ret < 0) {
> +				of_node_put(child);
>  				return ret;
> +			}
>  
>  			info[i].color_index = led->channels[i]->color;
>  			info[i].intensity = 0;
> @@ -1352,8 +1354,10 @@ static int lpg_probe(struct platform_device *pdev)
>  
>  	for_each_available_child_of_node(pdev->dev.of_node, np) {
>  		ret = lpg_add_led(lpg, np);
> -		if (ret)
> +		if (ret) {
> +			of_node_put(np);
>  			return ret;
> +		}
>  	}

Code is fine.

-- 
Lee Jones [李琼斯]
