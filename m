Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D672C6000C4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJPPhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJPPhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:37:50 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A1D25E94
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eU5vnCKd2piSgviMCdccLd6NpuEhhE6avHccbWMAHuI=;
  b=MMcLda8/yp0YdxQmYklUxOmmR9oQJiDbdQAm7mJkUjs4RSRJXJbbn8T6
   0JE82wYXchouJ8J5uO/5UzaanEl7ElJe+fUREgIGOaQccjXolJwAK/VGq
   W9OOwR2sfhyfy6vzA8yiLTbsOXicd3Z2ASjBpdNwSTGCFbjq20l0c440m
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,189,1661810400"; 
   d="scan'208";a="31575261"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2022 17:37:47 +0200
Date:   Sun, 16 Oct 2022 17:37:46 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Deepak R Varma <drv@mailo.com>
cc:     outreachy@lists.linux.dev, pure.logic@nexus-software.ie,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: loopback: enclose macro statements in
 do-while loop
In-Reply-To: <Y0wi4itS3d8aExFc@debian-BULLSEYE-live-builder-AMD64>
Message-ID: <alpine.DEB.2.22.394.2210161735060.2876@hadrien>
References: <Y0wS4HQo9m/W/TrQ@debian-BULLSEYE-live-builder-AMD64> <alpine.DEB.2.22.394.2210161649400.2876@hadrien> <Y0wdDTUBrUT/cr9w@lion2204> <alpine.DEB.2.22.394.2210161709440.2876@hadrien> <Y0wi4itS3d8aExFc@debian-BULLSEYE-live-builder-AMD64>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Oct 2022, Deepak R Varma wrote:

> On Sun, Oct 16, 2022 at 05:10:17PM +0200, Julia Lawall wrote:
> >
> >
> > On Sun, 16 Oct 2022, Deepak R Varma wrote:
> >
> > > On Sun, Oct 16, 2022 at 04:51:09PM +0200, Julia Lawall wrote:
> > > >
> > > >
> > > > On Sun, 16 Oct 2022, Deepak R Varma wrote:
> > > >
> > > > > Include multiple statements of macro definition inside do-while{0} loop
> > > > > to avoid possible partial program execution. Issue reported by
> > > > > checkpatch script:
> > > > >
> > > > > ERROR: Macros with multiple statements should be enclosed in a do - while loop
> > > >
> > > > I don't think this change will compile.  See if you can figure out why
> > > > not.
> > >
> > > It did compile. I built the greybus driver and loaded it as well with the
> > > modinfo tool. Can you please tell why you think it won't compile?
> >
> > Do you have a .o file for the .c file that you changed?
>
> I see many .o files and a greybus.ko as well, but not the loopback.o
> Am I missing anything with my configuration? I did set Greybus Support to (M) in
> the menuconfig.

Something must be missing in the configuration.

With make allyesconfig, you can just compile the file you changed, eg make
drivers/staging/greybus/loopback.o and see if just that file compiles.

Sometimes you can's compile an individual file.  In that case, it may be
possible to do make linux/file/path/ (assuming your file is in
linux/file/path/foo.c).  The trailing / is essential.  make
linux/file/path will do nothing.

julia

>
> Thank you,
> ./drv
>
> >
> > julia
> >
> > >
> > > ./drv
> > >
> > > >
> > > > julia
> > > >
> > > > >
> > > > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > > > ---
> > > > >  drivers/staging/greybus/loopback.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> > > > > index 1a61fce98056..37214cb43937 100644
> > > > > --- a/drivers/staging/greybus/loopback.c
> > > > > +++ b/drivers/staging/greybus/loopback.c
> > > > > @@ -163,9 +163,11 @@ static ssize_t name##_avg_show(struct device *dev,		\
> > > > >  static DEVICE_ATTR_RO(name##_avg)
> > > > >
> > > > >  #define gb_loopback_stats_attrs(field)				\
> > > > > +do {								\
> > > > >  	gb_loopback_ro_stats_attr(field, min, u);		\
> > > > >  	gb_loopback_ro_stats_attr(field, max, u);		\
> > > > > -	gb_loopback_ro_avg_attr(field)
> > > > > +	gb_loopback_ro_avg_attr(field);				\
> > > > > +} while (0)
> > > > >
> > > > >  #define gb_loopback_attr(field, type)					\
> > > > >  static ssize_t field##_show(struct device *dev,				\
> > > > > --
> > > > > 2.30.2
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > >
> > >
> > >
> >
>
>
>
