Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2208E6735A5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjASKfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjASKex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:34:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8613B66FA1;
        Thu, 19 Jan 2023 02:34:49 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8B85238002;
        Thu, 19 Jan 2023 10:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674124488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vYHPclhiQzMVwKCYvpVGD/Ge/1sAj2seFNT67bApWA4=;
        b=fC3fckMClwX3NNRCLm1z8wmq7HZLuKi7FIkWVJARYfVF0r7NxW3X1p5aCO3f0C0KC7JB5v
        tp2hJ1D0PimjHSFPbJBQTaqml0SqgqrH6dL5qeyWOntqUAN3YSJO4mboeFfCCwzA1rmTQB
        JSkZnui+wTJIZzwyVKTg4obkt45OTM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674124488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vYHPclhiQzMVwKCYvpVGD/Ge/1sAj2seFNT67bApWA4=;
        b=hvEphYX/olY074SeyVLYARyiONJ9mUHoF2F5F1+gmtw+ka3ERQI/il+BpzZ0hRRcFM0om2
        zabiMC3pgWJiU+Cw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1C4892C141;
        Thu, 19 Jan 2023 10:34:47 +0000 (UTC)
Date:   Thu, 19 Jan 2023 11:34:46 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "Erhard F." <erhard_f@mailbox.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] of: Fix of platform build on powerpc due to bad of
 disaply code
Message-ID: <20230119103446.GO16547@kitsune.suse.cz>
References: <20230119095323.4659-1-msuchanek@suse.de>
 <8a9f7ba5-37a4-0927-4ab2-d212f1b098a9@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a9f7ba5-37a4-0927-4ab2-d212f1b098a9@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jan 19, 2023 at 10:24:07AM +0000, Christophe Leroy wrote:
> 
> 
> Le 19/01/2023 à 10:53, Michal Suchanek a écrit :
> > The commit 2d681d6a23a1 ("of: Make of framebuffer devices unique")
> > breaks build because of wrong argument to snprintf. That certainly
> > avoids the runtime error but is not the intended outcome.
> > 
> > Also use standard device name format of-display.N for all created
> > devices.
> > 
> > Fixes: 2d681d6a23a1 ("of: Make of framebuffer devices unique")
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > v2: Update the device name format
> > ---
> >   drivers/of/platform.c | 12 ++++++++----
> >   1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index f2a5d679a324..8c1b1de22036 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -525,7 +525,9 @@ static int __init of_platform_default_populate_init(void)
> >   	if (IS_ENABLED(CONFIG_PPC)) {
> >   		struct device_node *boot_display = NULL;
> >   		struct platform_device *dev;
> > -		int display_number = 1;
> > +		int display_number = 0;
> > +		char buf[14];
> 
> Can you declare that in the for block where it is used instead ?

No, there are two for blocks.

> 
> > +		char *of_display_format = "of-display.%d";
> 
> Should be const ?

Yes, could be.

> 
> >   		int ret;
> >   
> >   		/* Check if we have a MacOS display without a node spec */
> > @@ -556,7 +558,10 @@ static int __init of_platform_default_populate_init(void)
> >   			if (!of_get_property(node, "linux,opened", NULL) ||
> >   			    !of_get_property(node, "linux,boot-display", NULL))
> >   				continue;
> > -			dev = of_platform_device_create(node, "of-display", NULL);
> > +			ret = snprintf(buf, sizeof(buf), of_display_format, display_number++);
> > +			if (ret >= sizeof(buf))
> > +				continue;
> 
> 
> Can you make buf big enough to avoid that ?

It would be a bit fragile that way.

The buffer would have to theoretically accomodate
"of-display.-9223372036854775808", and any change to the format requires
recalculating the length, by hand.

Of course, the memory would run out way before allocating that many
devices so it's kind of pointless to try and accomodate all possible
device numbers.

> 
> And by the way could it be called something else than 'buf' ?
> 
> See exemple here : 
> https://elixir.bootlin.com/linux/v6.1/source/drivers/fsi/fsi-occ.c#L690

Yes, that is quite possible. Nonetheless, just like 'ret' generic
variable names also work.

Thanks

Michal
