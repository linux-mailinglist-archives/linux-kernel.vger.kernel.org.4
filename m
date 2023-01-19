Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83267341B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjASJBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:01:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA616796A;
        Thu, 19 Jan 2023 01:01:46 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0A2A15CB56;
        Thu, 19 Jan 2023 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674118905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJjkIKKbDNZd/ESWe6P7/ngAac/K7/Dffw9Klu11+kY=;
        b=GvYJW40AKUaPIxT7/fZb5VtwH9UINs+LZqFfT8Z4QNdHC9DwXJzGCH91XoAwsbbeOyP9gc
        W5tjc3kFYliFFNJjnclyejzvldAad+pWmtfjyzyzT8gXMdsFXA/52rHQBsx4AvA/LhGTIi
        voL2cbqTM9XTS7ihyw7XTeqOogVCjZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674118905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJjkIKKbDNZd/ESWe6P7/ngAac/K7/Dffw9Klu11+kY=;
        b=IslDj+AOHOitb1mQoIKIQmwchzFrCNs9O0AxMs7soKB4+QsWKUgOGkiXubclJDkMaWZ42f
        7AX9WBQ5mmaBQFAA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CDF782C142;
        Thu, 19 Jan 2023 09:01:44 +0000 (UTC)
Date:   Thu, 19 Jan 2023 10:01:43 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     "Erhard F." <erhard_f@mailbox.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] of: Make of framebuffer devices unique
Message-ID: <20230119090143.GN16547@kitsune.suse.cz>
References: <20230117165804.18036-1-msuchanek@suse.de>
 <20230118211305.42e50a4a@yea>
 <20230118214618.GM16547@kitsune.suse.cz>
 <f57f29a6-1db3-ab0b-a1f7-77074d1c10e8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f57f29a6-1db3-ab0b-a1f7-77074d1c10e8@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 09:00:44AM +0100, Thomas Zimmermann wrote:
> Hi Michal,
> 
> thanks for fixing this issue. But the review time was way too short. Please
> see my comments below.
> 
> Am 18.01.23 um 22:46 schrieb Michal Suchánek:
> > On Wed, Jan 18, 2023 at 09:13:05PM +0100, Erhard F. wrote:
> > > On Tue, 17 Jan 2023 17:58:04 +0100
> > > Michal Suchanek <msuchanek@suse.de> wrote:
> > > 
> > > > Since Linux 5.19 this error is observed:
> > > > 
> > > > sysfs: cannot create duplicate filename '/devices/platform/of-display'
> > > > 
> > > > This is because multiple devices with the same name 'of-display' are
> > > > created on the same bus.
> > > > 
> > > > Update the code to create numbered device names for the non-boot
> > > > disaplay.
> > > > 
> > > > cc: linuxppc-dev@lists.ozlabs.org
> > > > References: https://bugzilla.kernel.org/show_bug.cgi?id=216095
> > > > Fixes: 52b1b46c39ae ("of: Create platform devices for OF framebuffers")
> > > > Reported-by: Erhard F. <erhard_f@mailbox.org>
> > > > Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > ---
> > > >   drivers/of/platform.c | 8 +++++++-
> > > >   1 file changed, 7 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > > index 81c8c227ab6b..f2a5d679a324 100644
> > > > --- a/drivers/of/platform.c
> > > > +++ b/drivers/of/platform.c
> > > > @@ -525,6 +525,7 @@ static int __init of_platform_default_populate_init(void)
> > > >   	if (IS_ENABLED(CONFIG_PPC)) {
> > > >   		struct device_node *boot_display = NULL;
> > > >   		struct platform_device *dev;
> > > > +		int display_number = 1;
> > > >   		int ret;
> > > >   		/* Check if we have a MacOS display without a node spec */
> > > > @@ -561,10 +562,15 @@ static int __init of_platform_default_populate_init(void)
> > > >   			boot_display = node;
> > > >   			break;
> > > >   		}
> > > > +
> > > >   		for_each_node_by_type(node, "display") {
> > > > +			char *buf[14];
> > > >   			if (!of_get_property(node, "linux,opened", NULL) || node == boot_display)
> > > >   				continue;
> > > > -			of_platform_device_create(node, "of-display", NULL);
> > > > +			ret = snprintf(buf, "of-display-%d", display_number++);
> 
> Platform devices use a single dot (.) as separator before the index.
> Counting starts at zero. See /sys/bus/platform/ for examples. Can we please
> stick with that scheme? Generated names would then be of-display.0,
> of-display.1, etc.

Yes, there was surprisingly no bikeshedding.

Do we also want to change the name of the device that did manage to
instantiate before?

This scheme changes the name only for those that did not in the past,
hence "of-display" and "of-display-%d", starting from 1.

Sure, replacing '-' with '.' is easy enough, and using the same format
for both as well.

Thanks

Michal

> 
> Best regards
> Thomas
> 
> 
> 
> > > > +			if (ret >= sizeof(buf))
> > > > +				continue;
> > > > +			of_platform_device_create(node, buf, NULL);
> > > >   		}
> > > >   	} else {
> > > > -- 
> > > > 2.35.3
> > > > 
> > > 
> > > Thank you for the patch Michal!
> > > 
> > > It applies on 6.2-rc4 but I get this build error with my config:
> > 
> > Indeed, it's doubly bad.
> > 
> > Where is the kernel test robot when you need it?
> > 
> > It should not be that easy to miss this file but clearly it can happen.
> > 
> > I will send a fixup.
> > 
> > Sorry about the mess.
> > 
> > Thanks
> > 
> > Michal
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Ivo Totev



