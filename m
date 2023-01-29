Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0C267FE86
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 12:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjA2LYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 06:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjA2LYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 06:24:20 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99FA7DA0;
        Sun, 29 Jan 2023 03:24:18 -0800 (PST)
Received: from ideasonboard.com (host-212-171-97-20.retail.telecomitalia.it [212.171.97.20])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 34FB5D6;
        Sun, 29 Jan 2023 12:24:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674991457;
        bh=cNswasFRVi1E8LrpLpSPQQcfdZA2U7o48N1KecQGVR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=miZUE6EYmCVdHzqRZNUBD/vItzZvpgHnT+Bbdms+39yPwfSiaoMR9yPBTePWkqzI8
         x3B0Df3rQYYEDj6NMhurx3hjIV+S0sQKecES+OTDFy1u++fiVu87Gmy+zEyAAU5yr+
         rs1/TD61krRL157ViSIrIk8V/PxsJMhUSMwxlOOg=
Date:   Sun, 29 Jan 2023 12:24:13 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] media: i2c: ov2685: Add print for power on write
 failed
Message-ID: <20230129112413.vrlcwkdujvl2msex@uno.localdomain>
References: <20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz>
 <20230129-ov2685-improvements-v1-2-f281bd49399c@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230129-ov2685-improvements-v1-2-f281bd49399c@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca

On Sun, Jan 29, 2023 at 10:42:36AM +0100, Luca Weiss wrote:
> If the sensor doens't power up correctly, for example due to incorrect
> devicetree description, the power up i2c writes will fail.
>
> Add an error print for this situation.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  drivers/media/i2c/ov2685.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
> index a422f4c8a2eb..844a91dbc8e5 100644
> --- a/drivers/media/i2c/ov2685.c
> +++ b/drivers/media/i2c/ov2685.c
> @@ -419,8 +419,10 @@ static int __ov2685_power_on(struct ov2685 *ov2685)
>  	 * writing register before .s_stream() as a workaround
>  	 */
>  	ret = ov2685_write_array(ov2685->client, ov2685->cur_mode->reg_list);
> -	if (ret)
> +	if (ret) {
> +		dev_err(dev, "Failed to set regs for power on\n");
>  		goto disable_supplies;
> +	}

This is fine. I would also consider if it's worth to fail loud in
ov2685_write_reg().

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>
>  	return 0;
>
>
> --
> 2.39.1
>
