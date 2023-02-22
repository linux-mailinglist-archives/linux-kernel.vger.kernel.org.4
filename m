Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B0D69F37A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjBVLdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBVLdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:33:12 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E34BDD3;
        Wed, 22 Feb 2023 03:33:11 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id 7A0221B000EF;
        Wed, 22 Feb 2023 13:33:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1677065588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CcIvoKjfBTRbIIqYyMX0XFzcIbMfENOSK0nzO975d+Q=;
        b=h76KPf57YBboQX5pjTosmDgXqFigwhJJb0oobn9Xg7thJEu/IjVoQaiZzWvYUA0mJtiR3X
        45Kr6bwCqfzAL6V+4IDGtcA39EC23e9taHOMxGDHfFnoPVoMffyFoSasjXgySDcPt61+tg
        misAmGrLm8wOqbLqDK4xnADqYDvMGZ3q73e7MTGiOCxEFt/qufXHUXOAoue+W/qfejBzeB
        5Eg8FXFVOY2Sx95qfSiqVJKKP5EzduDBpp/GJsf9kR7ip9J3ACsIiJPoRwaFLQsNLqq7yh
        jqiijNC89gSB/jI0wCRaThJO3x7pB2h/1ddo+doExNiDYJNW6ijn35IDsLN05A==
Received: from hillosipuli.retiisi.eu (dkzbhx1tyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4502:69d6::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 9240E20173;
        Wed, 22 Feb 2023 13:33:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1677065583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CcIvoKjfBTRbIIqYyMX0XFzcIbMfENOSK0nzO975d+Q=;
        b=eNbYLOja9Ul8ZGBAaAyE5e7wria8q0u++2b+5b6ReuZiBWAuI8W68hEodeLDAiX3cUvfUJ
        3rozgKFqW8whIx7Gmy0WfVSy8JWyEH5ErO3xwfAkY9kYRvO3o/rMssZ4JgwdKjuD8Yx3Zk
        4AVhFFbRBIQXKLJ6Lf4mqcSGOEd4XFM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1677065583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CcIvoKjfBTRbIIqYyMX0XFzcIbMfENOSK0nzO975d+Q=;
        b=KsYVC4JaVKB/nIVlZmpNNvXmhDI8QlhljNCbUeaYkOxKbpBToPYSjbBO+v+B77WBHGdoHP
        dKlvXkdKDaw06yvqE8jGylZppX+0owMqOWtzwp7qL/wqPuYqzoH4eA86i1d7QAcROZLQQL
        ien8FXUoHzme2MBYG7pwVvSmnZcvHjE=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1677065583; a=rsa-sha256; cv=none;
        b=nHWESDN6LiLuYyOnJ7oz1tQUUBvmAvHLbmc6nNsJuAi7pe8aNj1xT217zAwJDmkhHZLL6f
        n+bx5vXHjdpjU1gfS72zGCV1o8WQzXbM1gS/bse/cNzfoP+QZxP2UMAjYtm3Ya6u2Qs6ow
        XYxt2NzDaI0MAqrlDetzhLmdnL5P2Aw=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 39806634C91;
        Wed, 22 Feb 2023 13:32:50 +0200 (EET)
Date:   Wed, 22 Feb 2023 13:32:50 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Shravan.Chippa@microchip.com
Cc:     Conor.Dooley@microchip.com, paul.j.murphy@intel.com,
        daniele.alessandrelli@intel.com, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        jacopo.mondi@ideasonboard.com, Prakash.Battu@microchip.com
Subject: Re: [PATCH v11 3/5] media: i2c: imx334: support lower bandwidth mode
Message-ID: <Y/X9YiLJxDfLPNUX@valkosipuli.retiisi.eu>
References: <20230208050915.1958183-1-shravan.chippa@microchip.com>
 <20230208050915.1958183-4-shravan.chippa@microchip.com>
 <Y/Xc9RCmO8P8eKtL@valkosipuli.retiisi.eu>
 <Y/XnWOomz2N9fCvc@wendy>
 <Y/XoXZJUKKGzGVVL@valkosipuli.retiisi.eu>
 <Y/XpClyi9KMtLKcF@valkosipuli.retiisi.eu>
 <PH0PR11MB5611D8EE3F896FC0BE9A842E81AA9@PH0PR11MB5611.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5611D8EE3F896FC0BE9A842E81AA9@PH0PR11MB5611.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 10:20:56AM +0000, Shravan.Chippa@microchip.com wrote:
> Hi Sakari,
> 
> > -----Original Message-----
> > From: Sakari Ailus <sakari.ailus@iki.fi>
> > Sent: 22 February 2023 03:36 PM
> > To: Conor Dooley - M52691 <Conor.Dooley@microchip.com>
> > Cc: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>;
> > paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> > mchehab@kernel.org; robh+dt@kernel.org;
> > krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > linux-imx@nxp.com; linux-media@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; Jacopo Mondi
> > <jacopo.mondi@ideasonboard.com>; Battu Prakash Reddy - I30399
> > <Prakash.Battu@microchip.com>
> > Subject: Re: [PATCH v11 3/5] media: i2c: imx334: support lower bandwidth
> > mode
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> > content is safe
> > 
> > On Wed, Feb 22, 2023 at 12:03:10PM +0200, Sakari Ailus wrote:
> > > On Wed, Feb 22, 2023 at 09:58:48AM +0000, Conor Dooley wrote:
> > > > On Wed, Feb 22, 2023 at 11:14:29AM +0200, Sakari Ailus wrote:
> > > > > On Wed, Feb 08, 2023 at 10:39:13AM +0530, shravan kumar wrote:
> > > > > > From: Shravan Chippa <shravan.chippa@microchip.com>
> > > >
> > > > > > @@ -666,11 +885,26 @@ static int imx334_init_pad_cfg(struct
> > v4l2_subdev *sd,
> > > > > >         struct v4l2_subdev_format fmt = { 0 };
> > > > > >
> > > > > >         fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY :
> > V4L2_SUBDEV_FORMAT_ACTIVE;
> > > > > > -       imx334_fill_pad_format(imx334, &supported_mode, &fmt);
> > > > > > +       imx334_fill_pad_format(imx334, &supported_modes[0],
> > > > > > + &fmt);
> > > > >
> > > > > Now that there are multiple modes supported, this would appear to
> > > > > get the width, height as well as the other fields (apart from mbus
> > > > > code) from the first mode.
> > > >
> > > > Is this statement supposed to be a request to change something, or
> > > > just a throwaway comment? It's a little hard for me to understand
> > > > your intention here, sorry.
> > >
> > > Just pointing to what looks like a bug.
> > 
> > Ah, my bad. Please ignore the comment.
> > 
> > This is indeed about init_cfg(), not s_fmt().
> > 
> 
> I will try to fix init_cfg()

There's no problem with it. Please ignore my original comment on this.

-- 
Sakari Ailus
