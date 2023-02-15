Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA4F698437
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjBOTMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBOTMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:12:47 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449132A6F7;
        Wed, 15 Feb 2023 11:12:42 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4093CD3918;
        Wed, 15 Feb 2023 19:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1676488360; bh=shedODMw16Yv6IpmFTBrQGWzEjEbWUlN2VlgOksROxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hnqVSaMRF1uIp6XCRc6IZ4LOlVYDqWJduUMZat/8Lq0wREM407GO1Okh2D8qo8Fd6
         EbyJY7eENpSE0spkMjiHlXEp5Npbsr6maK6o4Pi8JPImj75vunkQetaOyelB4MB0We
         R7q1ZxyVLQihZYGbUki8DpKK7NGMusLsCXkQ/vvw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: i2c: ov5670: Use dev_err_probe in probe function
Date:   Wed, 15 Feb 2023 20:12:39 +0100
Message-ID: <13202088.uLZWGnKmhe@z3ntu.xyz>
In-Reply-To: <20230213175504.ajxa4zgezclxvzuk@uno.localdomain>
References: <20230210-ov5670-single-lane-v1-0-71835d39c1ce@z3ntu.xyz>
 <20230210-ov5670-single-lane-v1-1-71835d39c1ce@z3ntu.xyz>
 <20230213175504.ajxa4zgezclxvzuk@uno.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 13. Februar 2023 19:04:29 CET Jacopo Mondi wrote:
> Hi Luca
> 
> On Fri, Feb 10, 2023 at 09:33:17PM +0100, Luca Weiss wrote:
> > Replace the unusual const char *err_msg usage with dev_err_probe which
> > also handles -EPROBE_DEFER better by not printing the message to kmsg.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> 
> Thanks! The *err_msg thing was weird indeed
> 
> > ---
> > 
> >  drivers/media/i2c/ov5670.c | 37 ++++++++++++-------------------------
> >  1 file changed, 12 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/ov5670.c b/drivers/media/i2c/ov5670.c
> > index f79d908f4531..189920571df2 100644
> > --- a/drivers/media/i2c/ov5670.c
> > +++ b/drivers/media/i2c/ov5670.c
> > @@ -2648,17 +2648,13 @@ static int ov5670_gpio_probe(struct ov5670
> > *ov5670)
> > 
> >  static int ov5670_probe(struct i2c_client *client)
> >  {
> >  
> >  	struct ov5670 *ov5670;
> > 
> > -	const char *err_msg;
> > 
> >  	u32 input_clk = 0;
> >  	bool full_power;
> >  	int ret;
> >  	
> >  	ov5670 = devm_kzalloc(&client->dev, sizeof(*ov5670), GFP_KERNEL);
> > 
> > -	if (!ov5670) {
> > -		ret = -ENOMEM;
> > -		err_msg = "devm_kzalloc() error";
> > -		goto error_print;
> > -	}
> > +	if (!ov5670)
> > +		return -ENOMEM;
> > 
> >  	ov5670->xvclk = devm_clk_get(&client->dev, NULL);
> >  	if (!IS_ERR_OR_NULL(ov5670->xvclk))
> > 
> > @@ -2680,29 +2676,23 @@ static int ov5670_probe(struct i2c_client *client)
> > 
> >  	v4l2_i2c_subdev_init(&ov5670->sd, client, &ov5670_subdev_ops);
> >  	
> >  	ret = ov5670_regulators_probe(ov5670);
> > 
> > -	if (ret) {
> > -		err_msg = "Regulators probe failed";
> > -		goto error_print;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(&client->dev, ret, "Regulators 
probe failed\n");
> > 
> >  	ret = ov5670_gpio_probe(ov5670);
> > 
> > -	if (ret) {
> > -		err_msg = "GPIO probe failed";
> > -		goto error_print;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(&client->dev, ret, "GPIO probe 
failed\n");
> 
> From now on, I don't think there are functions that can return
> -EPROBE_DEFER and you could
> 
>         if (ret) {
>                 dev_err(...)
>                 goto ...;
>         }
> 
> But if others are fine with what you have and consider using
> dev_err_probe() better regardless if the called function can
> return -EPROBE_DEFER or not, I'm fine with what you have here.

I like using dev_err_probe more or less everywhere in _probe so if the 
maintainers don't mind, I'd keep it that way :)

Regards
Luca

> 
> >  	full_power = acpi_dev_state_d0(&client->dev);
> >  	if (full_power) {
> >  	
> >  		ret = ov5670_runtime_resume(&client->dev);
> > 
> > -		if (ret) {
> > -			err_msg = "Power up failed";
> > -			goto error_print;
> > -		}
> > +		if (ret)
> > +			return dev_err_probe(&client->dev, ret, 
"Power up failed\n");
> > 
> >  		/* Check module identity */
> >  		ret = ov5670_identify_module(ov5670);
> >  		if (ret) {
> > 
> > -			err_msg = "ov5670_identify_module() error";
> > +			dev_err_probe(&client->dev, ret, 
"ov5670_identify_module() error\n");
> > 
> >  			goto error_power_off;
> >  		
> >  		}
> >  	
> >  	}
> > 
> > @@ -2714,7 +2704,7 @@ static int ov5670_probe(struct i2c_client *client)
> > 
> >  	ret = ov5670_init_controls(ov5670);
> >  	if (ret) {
> > 
> > -		err_msg = "ov5670_init_controls() error";
> > +		dev_err_probe(&client->dev, ret, 
"ov5670_init_controls() error\n");
> > 
> >  		goto error_mutex_destroy;
> >  	
> >  	}
> > 
> > @@ -2727,7 +2717,7 @@ static int ov5670_probe(struct i2c_client *client)
> > 
> >  	ov5670->pad.flags = MEDIA_PAD_FL_SOURCE;
> >  	ret = media_entity_pads_init(&ov5670->sd.entity, 1, &ov5670->pad);
> >  	if (ret) {
> > 
> > -		err_msg = "media_entity_pads_init() error";
> > +		dev_err_probe(&client->dev, ret, 
"media_entity_pads_init() error\n");
> > 
> >  		goto error_handler_free;
> >  	
> >  	}
> > 
> > @@ -2741,7 +2731,7 @@ static int ov5670_probe(struct i2c_client *client)
> > 
> >  	/* Async register for subdev */
> >  	ret = v4l2_async_register_subdev_sensor(&ov5670->sd);
> >  	if (ret < 0) {
> > 
> > -		err_msg = "v4l2_async_register_subdev() error";
> > +		dev_err_probe(&client->dev, ret, 
"v4l2_async_register_subdev()
> > error\n");> 
> >  		goto error_pm_disable;
> >  	
> >  	}
> > 
> > @@ -2764,9 +2754,6 @@ static int ov5670_probe(struct i2c_client *client)
> > 
> >  	if (full_power)
> >  	
> >  		ov5670_runtime_suspend(&client->dev);
> > 
> > -error_print:
> > -	dev_err(&client->dev, "%s: %s %d\n", __func__, err_msg, ret);
> > -
> > 
> >  	return ret;
> >  
> >  }
> > 
> > --
> > 2.39.1




