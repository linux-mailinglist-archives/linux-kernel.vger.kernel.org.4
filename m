Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1C16C378E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCURBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCURBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C19E28846;
        Tue, 21 Mar 2023 10:01:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D895B61D1A;
        Tue, 21 Mar 2023 17:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE2EC4339B;
        Tue, 21 Mar 2023 17:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679418107;
        bh=wijKgZAZ2VxVg3wUlQIz/KBZ2VVi/2DuE5W458CNj8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yGJ/UGFAYSIcXhAnT6Z0C0YknK2+H4WD6fsHv3q8VzgO7xbBiUF7Ws5qbngCCfPEg
         T4ZHHM2Hy18vtHmd36Erqn6lu0j+hPsZMyeK9YmR3Wp988n9/63MhTNwCLB6Q9uLwG
         CWN8E8y8//3ONxeEYLtAh6CWvzlDTB0Ycix1QaGU=
Date:   Tue, 21 Mar 2023 18:01:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        vireshk@kernel.org, thierry.reding@gmail.com,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: greybus: use inline function for macros
Message-ID: <ZBni+Ho63jwZth9F@kroah.com>
References: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
 <1274302b52ae905dab6f75377d625598facbbdf1.1679352669.git.eng.mennamahmoud.mm@gmail.com>
 <20230321154728.3r7ut3rl2pccmo2e@pengutronix.de>
 <82a4e5f1-a1f2-c70-3645-9464ccb17bab@inria.fr>
 <20230321162629.rjmivzhbdy4pcgii@pengutronix.de>
 <9a775966-29d4-12b3-e67d-4327194f972@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a775966-29d4-12b3-e67d-4327194f972@inria.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 05:35:54PM +0100, Julia Lawall wrote:
> 
> 
> On Tue, 21 Mar 2023, Uwe Kleine-König wrote:
> 
> > On Tue, Mar 21, 2023 at 04:59:49PM +0100, Julia Lawall wrote:
> > >
> > >
> > > On Tue, 21 Mar 2023, Uwe Kleine-König wrote:
> > >
> > > > Hello,
> > > >
> > > > just some nitpicks:
> > > >
> > > > On Tue, Mar 21, 2023 at 01:04:33AM +0200, Menna Mahmoud wrote:
> > > > > Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
> > > > > static inline function.
> > > > >
> > > > > it is not great to have macro that use `container_of` macro,
> > > >
> > > > s/it/It/; s/macro/macros/; s/use/use the/;
> > > >
> > > > > because from looking at the definition one cannot tell what type
> > > > > it applies to.
> > > > > [...]
> > > > > -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> > > > > +static inline struct gbphy_device *to_gbphy_dev(const struct device *d)
> > > >
> > > > drivers/staging/greybus/gbphy.c always passes a variable named
> > > > "dev" to this macro. So I'd call the parameter "dev", too, instead of
> > > > "d". This is also a more typical name for variables of that type.
> > >
> > > I argued against that.  Because then there are two uses of dev
> > > in the argument of container_of, and they refer to completely different
> > > things.  It's true that by the way container_of works, it's fine, but it
> > > may be misleading.
> >
> > Hmm, that seems to be subjective, but I have less problems with that
> > than with using "d" for a struct device (or a struct device_driver).
> > I'd even go so far as to consider it nice if they are identical.
> >
> > Maybe that's because having the first and third argument identical is
> > quite common:
> >
> > 	$ git grep -P 'container_of\((?<ident>[A-Za-z_0-9-]*)\s*,[^,]*,\s*\g{ident}\s*\)' | wc -l
> > 	5940
> >
> > which is >44% of all the usages
> >
> > 	$ git grep -P 'container_of\((?<ident>[A-Za-z_0-9-]*)\s*,[^,]*,\s*(?&ident)\s*\)' | wc -l
> > 	13362
> 
> OK, if people like that, then why not.  But it's dangerous if the call to
> container_of is in a macro, rather than in a function.

It's not "dangerous" at all, as the macro will enforce type-safety, you
can't get it wrong when using it.

Ideally this is best as a macro as it's just doing pointer math, worst
case, the compiler turns a function like this into a real function and
you have a call/subtract/return for every time you make this call.

So this conversion to functions feels odd to me, as you potentially are
making all of this worse overall.

Wait until people realize that when we eventually turn these into
container_of_const() you HAVE to go back to using it as a macro instead
of in a function call wrapper like this...

thanks,

greg k-h
