Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C60675C23
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjATRxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjATRxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:53:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D44C16D;
        Fri, 20 Jan 2023 09:52:56 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2C66C33795;
        Fri, 20 Jan 2023 17:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674237175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UNyEsjm7hTRHmPW+XmOpTTJAr6gba2jkZnI10liz/yE=;
        b=GjbiRjgqTWyXCgMsFjtKYs9AvuDkHg49it+0qX0XS2aTMfPj7Mw2LGq4NMAoFYcaj9PVej
        vMAyYMvPMBYBuZ3p8DCAt5IgRAcn/Lj3Sm6fk2rJ/G7ZgTQRF8kz1VRmIiI7Mso2WhAkiI
        qH5MslyqTpbp47xkbnG2yy0C43RDIu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674237175;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UNyEsjm7hTRHmPW+XmOpTTJAr6gba2jkZnI10liz/yE=;
        b=JKFUMRfVDlOz7Gei5bw7WnRU5/xBTxCqxl9tiG+nANWfa+RRqPUrsxile+0ykUzlS10JwM
        oHseEXEeJdaFmKAQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F157F2C141;
        Fri, 20 Jan 2023 17:52:54 +0000 (UTC)
Date:   Fri, 20 Jan 2023 18:52:53 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "Erhard F." <erhard_f@mailbox.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2] of: Fix of platform build on powerpc due to bad of
 disaply code
Message-ID: <20230120175253.GW16547@kitsune.suse.cz>
References: <20230118215045.5551-1-msuchanek@suse.de>
 <20230119095323.4659-1-msuchanek@suse.de>
 <CAL_JsqKo+mdjA485KDb1ZauJcbOU-FR1G-Z2sYYNu7+Zn32wSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKo+mdjA485KDb1ZauJcbOU-FR1G-Z2sYYNu7+Zn32wSA@mail.gmail.com>
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

On Fri, Jan 20, 2023 at 11:23:39AM -0600, Rob Herring wrote:
> On Thu, Jan 19, 2023 at 3:53 AM Michal Suchanek <msuchanek@suse.de> wrote:
> >
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
> >  drivers/of/platform.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index f2a5d679a324..8c1b1de22036 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -525,7 +525,9 @@ static int __init of_platform_default_populate_init(void)
> >         if (IS_ENABLED(CONFIG_PPC)) {
> >                 struct device_node *boot_display = NULL;
> >                 struct platform_device *dev;
> > -               int display_number = 1;
> > +               int display_number = 0;
> > +               char buf[14];
> > +               char *of_display_format = "of-display.%d";
> 
> static const as suggested and can we just move on please...
Only const, static could be dodgy

> >                 int ret;
> >
> >                 /* Check if we have a MacOS display without a node spec */
> > @@ -556,7 +558,10 @@ static int __init of_platform_default_populate_init(void)
> >                         if (!of_get_property(node, "linux,opened", NULL) ||
> >                             !of_get_property(node, "linux,boot-display", NULL))
> >                                 continue;
> > -                       dev = of_platform_device_create(node, "of-display", NULL);
> > +                       ret = snprintf(buf, sizeof(buf), of_display_format, display_number++);
> 
> The boot display is always "of-display.0". Just use the fixed string
> here. Then we can get rid of the whole debate around static const.

I prefer to use the same format string when the names should be
consistent. Also it would resurrect the starting from 1 debate.

But if you really want to have two strings I do not care all that much.

> 
> > +                       if (ret >= sizeof(buf))
> > +                               continue;
> 
> This only happens if display_number becomes too big. Why continue on?
> The next iteration will fail too.

Yes, there is no need to continue with the loop.

Thanks

Michal

> 
> > +                       dev = of_platform_device_create(node, buf, NULL);
> >                         if (WARN_ON(!dev))
> >                                 return -ENOMEM;
> >                         boot_display = node;
> > @@ -564,10 +569,9 @@ static int __init of_platform_default_populate_init(void)
> >                 }
> >
> >                 for_each_node_by_type(node, "display") {
> > -                       char *buf[14];
> >                         if (!of_get_property(node, "linux,opened", NULL) || node == boot_display)
> >                                 continue;
> > -                       ret = snprintf(buf, "of-display-%d", display_number++);
> > +                       ret = snprintf(buf, sizeof(buf), of_display_format, display_number++);
> >                         if (ret >= sizeof(buf))
> >                                 continue;
> 
> Here too in the original change.
> 
> >                         of_platform_device_create(node, buf, NULL);
> > --
> > 2.35.3
> >
