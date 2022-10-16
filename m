Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268AF6000C6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJPPmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJPPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:42:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C40220D0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89F8EB80CC3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 15:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66CEC433C1;
        Sun, 16 Oct 2022 15:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665934918;
        bh=+4RVTTrbXN+/4vqERN49TufdDPKikKJhXlmgMKsWEa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pW1hVPZRwRW6UK3mrJJuJqasNXV0IR0NECIEAanaRD2TVTXTPm4K2quhIRScFnvyD
         nztnlhqv0E0AEoQY20/2wDgsc0alYVQfbSWdaLVRjeGK93AKQRT7mjHVOXRTLvQFT/
         uEtiHeh+aeJmO5USr66hvm9ntpAVO3/LspBlDPCQ=
Date:   Sun, 16 Oct 2022 17:40:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: loopback: enclose macro statements in
 do-while loop
Message-ID: <Y0wmC2oi0TOpvpPM@kroah.com>
References: <Y0wS4HQo9m/W/TrQ@debian-BULLSEYE-live-builder-AMD64>
 <alpine.DEB.2.22.394.2210161649400.2876@hadrien>
 <Y0wdDTUBrUT/cr9w@lion2204>
 <alpine.DEB.2.22.394.2210161709440.2876@hadrien>
 <Y0wi4itS3d8aExFc@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0wi4itS3d8aExFc@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 11:27:30AM -0400, Deepak R Varma wrote:
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

CONFIG_GREYBUS_LOOPBACK has to be enabled in order to build the
drivers/staging/greybus/loopback.c file.

A simple check would be to do:
	make drivers/staging/greybus/loopback.o

does that work with your change?

thanks,

greg k-h
