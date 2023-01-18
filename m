Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118B7672ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjARVq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjARVqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:46:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22C1CACE;
        Wed, 18 Jan 2023 13:46:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 472725BEFB;
        Wed, 18 Jan 2023 21:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674078380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IzvhNBEDond1bMUJ1A5xbmF0h2vm61ldNgtjCSRkqYY=;
        b=swyQHK2rv734pRTyYVLVbazA1S/KXLpGGpQnMpJvVVR4iNjKHivIyAZ8uyCJPsx0GaUEsH
        hGwL9rQFw9vAmeVG+OpClgKR0XBrokXN3utCG+MIoROFXU9szhV/X5suSLtPXZ9O9ok+iX
        IpmnLVhIoqTb/a9crsbndzETNs3MH6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674078380;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IzvhNBEDond1bMUJ1A5xbmF0h2vm61ldNgtjCSRkqYY=;
        b=9Y+u+wPlaedpJNko+qyomGqIic2z8UZC/zp9hCZj1Tz6H+DJeEHf7tLnsSlg0REQm6p8+2
        zyuKvlHS4Oa0hZCA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C71112C141;
        Wed, 18 Jan 2023 21:46:19 +0000 (UTC)
Date:   Wed, 18 Jan 2023 22:46:18 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     "Erhard F." <erhard_f@mailbox.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] of: Make of framebuffer devices unique
Message-ID: <20230118214618.GM16547@kitsune.suse.cz>
References: <20230117165804.18036-1-msuchanek@suse.de>
 <20230118211305.42e50a4a@yea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118211305.42e50a4a@yea>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 09:13:05PM +0100, Erhard F. wrote:
> On Tue, 17 Jan 2023 17:58:04 +0100
> Michal Suchanek <msuchanek@suse.de> wrote:
> 
> > Since Linux 5.19 this error is observed:
> > 
> > sysfs: cannot create duplicate filename '/devices/platform/of-display'
> > 
> > This is because multiple devices with the same name 'of-display' are
> > created on the same bus.
> > 
> > Update the code to create numbered device names for the non-boot
> > disaplay.
> > 
> > cc: linuxppc-dev@lists.ozlabs.org
> > References: https://bugzilla.kernel.org/show_bug.cgi?id=216095
> > Fixes: 52b1b46c39ae ("of: Create platform devices for OF framebuffers")
> > Reported-by: Erhard F. <erhard_f@mailbox.org>
> > Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  drivers/of/platform.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 81c8c227ab6b..f2a5d679a324 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -525,6 +525,7 @@ static int __init of_platform_default_populate_init(void)
> >  	if (IS_ENABLED(CONFIG_PPC)) {
> >  		struct device_node *boot_display = NULL;
> >  		struct platform_device *dev;
> > +		int display_number = 1;
> >  		int ret;
> >  
> >  		/* Check if we have a MacOS display without a node spec */
> > @@ -561,10 +562,15 @@ static int __init of_platform_default_populate_init(void)
> >  			boot_display = node;
> >  			break;
> >  		}
> > +
> >  		for_each_node_by_type(node, "display") {
> > +			char *buf[14];
> >  			if (!of_get_property(node, "linux,opened", NULL) || node == boot_display)
> >  				continue;
> > -			of_platform_device_create(node, "of-display", NULL);
> > +			ret = snprintf(buf, "of-display-%d", display_number++);
> > +			if (ret >= sizeof(buf))
> > +				continue;
> > +			of_platform_device_create(node, buf, NULL);
> >  		}
> >  
> >  	} else {
> > -- 
> > 2.35.3
> > 
> 
> Thank you for the patch Michal!
> 
> It applies on 6.2-rc4 but I get this build error with my config:

Indeed, it's doubly bad.

Where is the kernel test robot when you need it?

It should not be that easy to miss this file but clearly it can happen.

I will send a fixup.

Sorry about the mess.

Thanks

Michal
