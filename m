Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BA6675436
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjATMLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjATMLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:11:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560554A1DC;
        Fri, 20 Jan 2023 04:10:58 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 355095F94B;
        Fri, 20 Jan 2023 12:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674216657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uP6HuWs4Kq3jd6tY+JOCJ+EPKnppWkkiTxsD4Mq6eiY=;
        b=qMaEzy7GI0C2wFVPjItQwsZzRFBmO1CP+fAhAUyYVI2DWnRxwy5BjIzHd9oVpVF3Wfug4y
        SiGuF/F13zZxZbjsymStbjUj8alsq9eaAFNHT7i2N6mgsMjqVpNHNYNj8z01u7W0kBio2T
        Ta5br4ghBWubDYgh/+jcjjpuf54l1EM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674216657;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uP6HuWs4Kq3jd6tY+JOCJ+EPKnppWkkiTxsD4Mq6eiY=;
        b=bBBVAu7fXUhsQyWdSXyxM8fENoFuG/LuY9QEil0Rp3p+EGdnuR/Lr45pvLzKcHb7NUzqdg
        eAP5vgb7aLOrt3Aw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 07CF42C141;
        Fri, 20 Jan 2023 12:10:57 +0000 (UTC)
Date:   Fri, 20 Jan 2023 13:10:55 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "Erhard F." <erhard_f@mailbox.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2] of: Fix of platform build on powerpc due to bad of
 disaply code
Message-ID: <20230120121055.GU16547@kitsune.suse.cz>
References: <20230119095323.4659-1-msuchanek@suse.de>
 <8a9f7ba5-37a4-0927-4ab2-d212f1b098a9@csgroup.eu>
 <20230119103446.GO16547@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230119103446.GO16547@kitsune.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:34:46AM +0100, Michal Such�nek wrote:
> Hello,
> 
> On Thu, Jan 19, 2023 at 10:24:07AM +0000, Christophe Leroy wrote:
> > 
> > 
> > Le 19/01/2023 � 10:53, Michal Suchanek a �crit�:
> > > The commit 2d681d6a23a1 ("of: Make of framebuffer devices unique")
> > > breaks build because of wrong argument to snprintf. That certainly
> > > avoids the runtime error but is not the intended outcome.
> > > 
> > > Also use standard device name format of-display.N for all created
> > > devices.
> > > 
> > > Fixes: 2d681d6a23a1 ("of: Make of framebuffer devices unique")
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > > v2: Update the device name format
> > > ---
> > >   drivers/of/platform.c | 12 ++++++++----
> > >   1 file changed, 8 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > index f2a5d679a324..8c1b1de22036 100644
> > > --- a/drivers/of/platform.c
> > > +++ b/drivers/of/platform.c
> > > @@ -525,7 +525,9 @@ static int __init of_platform_default_populate_init(void)
> > >   	if (IS_ENABLED(CONFIG_PPC)) {
> > >   		struct device_node *boot_display = NULL;
> > >   		struct platform_device *dev;
> > > -		int display_number = 1;
> > > +		int display_number = 0;
> > > +		char buf[14];
> > 
> > Can you declare that in the for block where it is used instead ?
> 
> No, there are two for blocks.
> 
> > 
> > > +		char *of_display_format = "of-display.%d";
> > 
> > Should be const ?
> 
> Yes, could be.
> 
> > 
> > >   		int ret;
> > >   
> > >   		/* Check if we have a MacOS display without a node spec */
> > > @@ -556,7 +558,10 @@ static int __init of_platform_default_populate_init(void)
> > >   			if (!of_get_property(node, "linux,opened", NULL) ||
> > >   			    !of_get_property(node, "linux,boot-display", NULL))
> > >   				continue;
> > > -			dev = of_platform_device_create(node, "of-display", NULL);
> > > +			ret = snprintf(buf, sizeof(buf), of_display_format, display_number++);
> > > +			if (ret >= sizeof(buf))
> > > +				continue;
> > 
> > 
> > Can you make buf big enough to avoid that ?
> 
> It would be a bit fragile that way.
> 
> The buffer would have to theoretically accomodate
> "of-display.-9223372036854775808", and any change to the format requires
> recalculating the length, by hand.
> 
> Of course, the memory would run out way before allocating that many
> devices so it's kind of pointless to try and accomodate all possible
> device numbers.
> 
> > 
> > And by the way could it be called something else than 'buf' ?
> > 
> > See exemple here : 
> > https://elixir.bootlin.com/linux/v6.1/source/drivers/fsi/fsi-occ.c#L690
> 
> Yes, that is quite possible. Nonetheless, just like 'ret' generic
> variable names also work.

And in fact judicious use of short generic variable names is more
readeable than naming all variables foobar_* as far as I am concerned.
Of course, YMMV.

Thanks

Michal
