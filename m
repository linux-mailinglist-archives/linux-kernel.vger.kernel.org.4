Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3B6604CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiJSQDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiJSQCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:02:53 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B96D6466
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666193377; bh=UiL1Iaru5FKLDfW2TZHa5bXJhCrCD//G7RrOecKut5I=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=eVK/VWD3QaPqu9Yi/knaOPGldppHJNKZq+7xtQuYprb7jaczWL3lpd0oEKO//miK5
         nhR7S4DetL37Wq6u9wiyur8IPbLFSFw7RgMakjrMGytrF+l7Ia+ae7sc1fi8ncq2F4
         3KfPokfrzs0G+KogAlMT6zBNb7Ec4oiPwWgtQt6g=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.206]
        Wed, 19 Oct 2022 17:29:37 +0200 (CEST)
X-EA-Auth: 4uPeXEa/J4DtPm7TM+egQMdxr22kESKAjQNFaV7UP99mI+kxoWn7oBgRZlc06D0p+tDi1BiLSB0f58DyqCB/VhohnfwyXCXC
Date:   Wed, 19 Oct 2022 20:58:17 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: loopback: enclose macro statements in
 do-while loop
Message-ID: <Y1AXkRJRtmnEom5T@debian-BULLSEYE-live-builder-AMD64>
References: <Y0wS4HQo9m/W/TrQ@debian-BULLSEYE-live-builder-AMD64>
 <alpine.DEB.2.22.394.2210161649400.2876@hadrien>
 <Y0wdDTUBrUT/cr9w@lion2204>
 <alpine.DEB.2.22.394.2210161709440.2876@hadrien>
 <Y0wi4itS3d8aExFc@debian-BULLSEYE-live-builder-AMD64>
 <Y0wmC2oi0TOpvpPM@kroah.com>
 <Y0woVSgGfUuvJUzY@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0woVSgGfUuvJUzY@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 11:50:45AM -0400, Deepak R Varma wrote:
> On Sun, Oct 16, 2022 at 05:40:59PM +0200, Greg KH wrote:
> > On Sun, Oct 16, 2022 at 11:27:30AM -0400, Deepak R Varma wrote:
> > > On Sun, Oct 16, 2022 at 05:10:17PM +0200, Julia Lawall wrote:
> > > >
> > > >
> > > > On Sun, 16 Oct 2022, Deepak R Varma wrote:
> > > >
> > > > > On Sun, Oct 16, 2022 at 04:51:09PM +0200, Julia Lawall wrote:
> > > > > >
> > > > > >
> > > > > > On Sun, 16 Oct 2022, Deepak R Varma wrote:
> > > > > >
> > > > > > > Include multiple statements of macro definition inside do-while{0} loop
> > > > > > > to avoid possible partial program execution. Issue reported by
> > > > > > > checkpatch script:
> > > > > > >
> > > > > > > ERROR: Macros with multiple statements should be enclosed in a do - while loop
> > > > > >
> > > > > > I don't think this change will compile.  See if you can figure out why
> > > > > > not.
> > > > >
> > > > > It did compile. I built the greybus driver and loaded it as well with the
> > > > > modinfo tool. Can you please tell why you think it won't compile?
> > > >
> > > > Do you have a .o file for the .c file that you changed?
> > >
> > > I see many .o files and a greybus.ko as well, but not the loopback.o
> > > Am I missing anything with my configuration? I did set Greybus Support to (M) in
> > > the menuconfig.
> >
> > CONFIG_GREYBUS_LOOPBACK has to be enabled in order to build the
> > drivers/staging/greybus/loopback.c file.
> >
> > A simple check would be to do:
> > 	make drivers/staging/greybus/loopback.o
> >
> > does that work with your change?
>
> No, it did not. I understand why it did not. My apologies for not looking into
> the build of loopback.o file when the greybus module was rebuilt.
>
> Please ignore my patch.

I just received a message from Kernel Test Robot that this patch failed to
compile. I had requested to drop/ignore this patch. However, looks like it
included in the staging-testing tree????

Let me know anything required from me to fix the bot complaint. Thank you.

>
> Thank you Julia and Greg for the feedback.
> ./drv
>
>
>
> >
> > thanks,
> >
> > greg k-h
> >
>
>
>


