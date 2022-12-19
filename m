Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C9F650DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiLSOp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiLSOpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:45:00 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B9912AD2;
        Mon, 19 Dec 2022 06:44:18 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 51D1AE0007;
        Mon, 19 Dec 2022 14:44:14 +0000 (UTC)
Date:   Mon, 19 Dec 2022 15:44:14 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] media: i2c: imx334: modify link frequency as for
 the configureation
Message-ID: <20221219144414.lfusj67ojjk2phkv@uno.localdomain>
References: <20221219061526.3169369-1-shravan.chippa@microchip.com>
 <20221219061526.3169369-2-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221219061526.3169369-2-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan

On Mon, Dec 19, 2022 at 11:45:22AM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
>
> Currently imx334 sensor driver is configured for 1782Mbps/lane for
> 3840x2160@60 resolution with reqired reg mode values but if we run the
> command "v4l2-ctl --all -d /dev/v4l-subdevX" it is showing incorrect link
> frequeny, This is because of the incorrect value of IMX334_LINK_FREQ
> witch is 891000000. it should be 1782000000.
>
> In general with the value of 891000000 link frequency it is not possible
> to configure 3840x2160@60 resolution.
>
> Fixes: 9746b11715c3 ("media: i2c: Add imx334 camera sensor driver")
>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/media/i2c/imx334.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> index 7b0a9086447d..acc9f9f15e47 100644
> --- a/drivers/media/i2c/imx334.c
> +++ b/drivers/media/i2c/imx334.c
> @@ -49,7 +49,7 @@
>  #define IMX334_INCLK_RATE	24000000
>
>  /* CSI2 HW configuration */
> -#define IMX334_LINK_FREQ	891000000
> +#define IMX334_LINK_FREQ	1782000000

Is this your reasoning ?

width: 3840
hblank: 560
height: 2160
vblank: 2340
bpp: 12
fps: 60
lanes: 4

Total bandwidth: (3840 + 560) * (2160 + 2340) * 60 * 12 = 14.256.000.000
Bandwidth per lane = Total / 4 = 3.564.000.000
mipi clock = Bandwidth_per_lane / 2 = 1.782.000.000

Two questions:

- Should you update the pixel clock as well ? It is currently set to
  594000000 while as per the above reasoning it should be doubled too.

- Where is the sensor's clock tree programmed in the driver ?
  It's kind of weird that the pixel_clock and link_freq in the driver
  are half of what they theoretically should be...



>  #define IMX334_NUM_DATA_LANES	4
>
>  #define IMX334_REG_MIN		0x00
> --
> 2.34.1
>
