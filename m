Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987DC69F274
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjBVKGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjBVKGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:06:23 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE36523850;
        Wed, 22 Feb 2023 02:06:21 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id E5F6A1B001D8;
        Wed, 22 Feb 2023 12:06:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1677060379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KRnfLK2iNF5bbCbFaYZXqDpFhozCNRd7MpFRyqNrNqI=;
        b=VGDrXE8MGzsh/zLpPQVNuoO7+gJWpHszcfNzcVlqJXtCA4+ITUUob5grZ/JDV/jX8jvp1O
        pXKGcVzRjP9HqvCxK0xHRe6LYxmESURyxLguVijrVu2Q/IyxTA+kjsvBdVrTJOS1I2mk/N
        wG69cOi00D8S5510QeCjvSOU9fFff2XdooOFgsodbjaQyX0GUlm+m3cMKiN6E96eBOpInA
        jBj/892iszveAXZ0crGSpfgcGLukhIE2mjIPVPhn/MWaup4CF0BlYyVNErw6NCxfMxPhKO
        zpkZqQx3H6AI6fTucfR76PTiz/371z66sg8xMEVwokItMDM5V6Bo6VqdXTKzPA==
Received: from hillosipuli.retiisi.eu (dkzbhx1tyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4502:69d6::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id CC48B20173;
        Wed, 22 Feb 2023 12:06:14 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1677060375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KRnfLK2iNF5bbCbFaYZXqDpFhozCNRd7MpFRyqNrNqI=;
        b=sW+QYG03Dv9NN+j/ulGGJ5k4tYMa4j75qtZHr0FqYihLaXhsAqbUYR3B7WFUMbqRYla3om
        qxxszYE3OcTuZ6R70EHv9smJAOwCOBjDxgVVPBnJF2XagLneu5aRCsdLD2lGv9D3cOJr74
        QNJaAgyYOjqLjqXzLIcYMWgM+EnJcOQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1677060375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KRnfLK2iNF5bbCbFaYZXqDpFhozCNRd7MpFRyqNrNqI=;
        b=LeYx2zHAD1Zo5udIRJl9J/hMNMkrrAH4rxJ5r3G0/n9sO5GmEQVXPGaSG7J88INVGqu2aB
        dZoRBKIb0KrzIiJkUyLqRKe3n290pJuSwdaM1lEQMoWIkgiEwk7Skj1HGQvlSBBKGckIa8
        R2HhE2G7AetdzJ9N9pRO5q2+a6VCp/A=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1677060375; a=rsa-sha256; cv=none;
        b=CYb8qlr1N9zt3W9EBEAt1/rufWEFJbXMNywQl6hW8F6JGd21cipnZaofZxBAq6S8ByPGsJ
        2QFd0mql05HC8QTDPIKiUAsENy5b4rHeclULLbWm/OX0QTgIsoLSuuWc0zpNnteMG0HurR
        oAVLeCSyMc1ltCQSC99m1wZ8aS06ePc=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id C5B1E634C91;
        Wed, 22 Feb 2023 12:06:01 +0200 (EET)
Date:   Wed, 22 Feb 2023 12:06:02 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     shravan kumar <shravan.chippa@microchip.com>,
        paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Prakash Battu <Prakash.Battu@microchip.com>
Subject: Re: [PATCH v11 3/5] media: i2c: imx334: support lower bandwidth mode
Message-ID: <Y/XpClyi9KMtLKcF@valkosipuli.retiisi.eu>
References: <20230208050915.1958183-1-shravan.chippa@microchip.com>
 <20230208050915.1958183-4-shravan.chippa@microchip.com>
 <Y/Xc9RCmO8P8eKtL@valkosipuli.retiisi.eu>
 <Y/XnWOomz2N9fCvc@wendy>
 <Y/XoXZJUKKGzGVVL@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/XoXZJUKKGzGVVL@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 12:03:10PM +0200, Sakari Ailus wrote:
> On Wed, Feb 22, 2023 at 09:58:48AM +0000, Conor Dooley wrote:
> > On Wed, Feb 22, 2023 at 11:14:29AM +0200, Sakari Ailus wrote:
> > > On Wed, Feb 08, 2023 at 10:39:13AM +0530, shravan kumar wrote:
> > > > From: Shravan Chippa <shravan.chippa@microchip.com>
> > 
> > > > @@ -666,11 +885,26 @@ static int imx334_init_pad_cfg(struct v4l2_subdev *sd,
> > > >  	struct v4l2_subdev_format fmt = { 0 };
> > > >  
> > > >  	fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
> > > > -	imx334_fill_pad_format(imx334, &supported_mode, &fmt);
> > > > +	imx334_fill_pad_format(imx334, &supported_modes[0], &fmt);
> > > 
> > > Now that there are multiple modes supported, this would appear to get the
> > > width, height as well as the other fields (apart from mbus code) from the
> > > first mode.
> > 
> > Is this statement supposed to be a request to change something, or just
> > a throwaway comment? It's a little hard for me to understand your
> > intention here, sorry.
> 
> Just pointing to what looks like a bug.

Ah, my bad. Please ignore the comment.

This is indeed about init_cfg(), not s_fmt().

-- 
Sakari Ailus
