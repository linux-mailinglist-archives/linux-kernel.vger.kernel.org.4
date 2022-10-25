Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D9360CAF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiJYLeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiJYLeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:34:03 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D804E127BD5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:34:01 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id B5ECE20191;
        Tue, 25 Oct 2022 14:33:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1666697635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pIy5CC4MQIyCvYcEm0XYoddACRXHkrXTjOrrA/K9QYE=;
        b=pTmZrhSnj58/dr2jl521atuCBRCfAnKAxSis6SF0Kge3DDdCwZUwoacZ1C3h6+XztPvIHf
        eLywiBn6q4HPE+8V8gJFc2SVFR7blhUE5342zkMRMLTMqNtKp3CjTvzDkm8mxo/VoFkwM+
        u3+pedgC2Y1LDuNd5EiHBLg4vgE8x/s=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 028C2634DB0;
        Tue, 25 Oct 2022 14:33:54 +0300 (EEST)
Date:   Tue, 25 Oct 2022 14:33:54 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Hidenori Kobayashi <hidenorik@chromium.org>
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] media: ov8856: Add runtime PM callbacks
Message-ID: <Y1fJokE9mfZJ8fad@valkosipuli.retiisi.eu>
References: <20220921092417.2579126-1-hidenorik@chromium.org>
 <20221006095846.pvhmis44z777fnsl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006095846.pvhmis44z777fnsl@google.com>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1666697635; a=rsa-sha256; cv=none;
        b=YXSQkgaqyTOgx3io6Wq1NwIHki44WyZYYqNgZpb/ktbvs8hq3zEmDJN0WzxSzVANEIENMt
        Tc/gKaRmu3E2JyZ+nndrHdH/mFsFGk9NeDX5bDzaZQrs18ru2vZ43/N+R6F8K2/5fozC4h
        QEL77Mlsqk926dkU26YF9wPmfpVBK5U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1666697635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pIy5CC4MQIyCvYcEm0XYoddACRXHkrXTjOrrA/K9QYE=;
        b=Y8K93OWP+gxqN7YeeRGg/5auGyciLdKRBaIFwaO+S8oO8U2gZG35cxDvU3AicPVeAUkHXg
        8+daG4MSDJfQv+Mog3hhXsK363OfztURyznT2pu4rAnbtrIf2BI7irVRwE7iL38jOtwOvv
        ErL29Wnv1JP9tgejCmph7XAoIDohJP8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hidenori,

On Thu, Oct 06, 2022 at 06:58:46PM +0900, Hidenori Kobayashi wrote:
> > @@ -2148,17 +2149,20 @@ static int __ov8856_power_on(struct ov8856 *ov8856)
> >  	return ret;
> >  }
> >  
> > -static void __ov8856_power_off(struct ov8856 *ov8856)
> > +static int ov8856_power_off(struct device *dev)
> >  {
> > -	struct i2c_client *client = v4l2_get_subdevdata(&ov8856->sd);
> > +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
> > +	struct ov8856 *ov8856 = to_ov8856(sd);
> >  
> > -	if (is_acpi_node(dev_fwnode(&client->dev)))
> > -		return;
> > +	if (is_acpi_node(dev_fwnode(dev)))
> > +		return 0;
> >  
> >  	gpiod_set_value_cansleep(ov8856->reset_gpio, 1);
> >  	regulator_bulk_disable(ARRAY_SIZE(ov8856_supply_names),
> >  			       ov8856->supplies);
> >  	clk_disable_unprepare(ov8856->xvclk);
> > +
> > +	return 0;
> >  }
> >  
> >  static int __maybe_unused ov8856_suspend(struct device *dev)

Applied with the following diff as the remove function's return type is now
void.

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index 9e1361eed91f0..cf8384e09413b 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -2456,8 +2456,6 @@ static void ov8856_remove(struct i2c_client *client)
 	mutex_destroy(&ov8856->mutex);
 
 	ov8856_power_off(&client->dev);
-
-	return 0;
 }
 
 static int ov8856_probe(struct i2c_client *client)

-- 
Sakari Ailus
