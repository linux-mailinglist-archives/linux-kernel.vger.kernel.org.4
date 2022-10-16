Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4F76000F1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJPPvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJPPvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:51:10 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EA8CC4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1665935449; bh=AoozS+vSA6vbET7eAeKnaDEsTTnvel6kQb67esZyuBY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=ZvVQ99tSiKfAp9sQVvmK9T9+QxFfjO0I1txUeDkmRUqnIEM20I7LyA5nykpqaQobJ
         KI7iL1C/JKjk0MK/lBYhkSyxTFJivFSjng1m/botWVc2RXHJQprxwFw8Q51pktl1b3
         1aX1ZeZ/oxiimGwXjx5J9D3FJMS2w7e1rSog6aJw=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.206]
        Sun, 16 Oct 2022 17:50:49 +0200 (CEST)
X-EA-Auth: 71gdXik5VMeVCC3uHpYdR+rbfISKW7FskXk49SjjS2cyLGwOct+7TLRPYQPvabRUNd/Ytpj+QJDHDrAdTYj6pFxecK1omYyk
Date:   Sun, 16 Oct 2022 11:50:45 -0400
From:   Deepak R Varma <drv@mailo.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: loopback: enclose macro statements in
 do-while loop
Message-ID: <Y0woVSgGfUuvJUzY@debian-BULLSEYE-live-builder-AMD64>
References: <Y0wS4HQo9m/W/TrQ@debian-BULLSEYE-live-builder-AMD64>
 <alpine.DEB.2.22.394.2210161649400.2876@hadrien>
 <Y0wdDTUBrUT/cr9w@lion2204>
 <alpine.DEB.2.22.394.2210161709440.2876@hadrien>
 <Y0wi4itS3d8aExFc@debian-BULLSEYE-live-builder-AMD64>
 <Y0wmC2oi0TOpvpPM@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0wmC2oi0TOpvpPM@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 05:40:59PM +0200, Greg KH wrote:
> On Sun, Oct 16, 2022 at 11:27:30AM -0400, Deepak R Varma wrote:
> > On Sun, Oct 16, 2022 at 05:10:17PM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Sun, 16 Oct 2022, Deepak R Varma wrote:
> > >
> > > > On Sun, Oct 16, 2022 at 04:51:09PM +0200, Julia Lawall wrote:
> > > > >
> > > > >
> > > > > On Sun, 16 Oct 2022, Deepak R Varma wrote:
> > > > >
> > > > > > Include multiple statements of macro definition inside do-while{0} loop
> > > > > > to avoid possible partial program execution. Issue reported by
> > > > > > checkpatch script:
> > > > > >
> > > > > > ERROR: Macros with multiple statements should be enclosed in a do - while loop
> > > > >
> > > > > I don't think this change will compile.  See if you can figure out why
> > > > > not.
> > > >
> > > > It did compile. I built the greybus driver and loaded it as well with the
> > > > modinfo tool. Can you please tell why you think it won't compile?
> > >
> > > Do you have a .o file for the .c file that you changed?
> >
> > I see many .o files and a greybus.ko as well, but not the loopback.o
> > Am I missing anything with my configuration? I did set Greybus Support to (M) in
> > the menuconfig.
>
> CONFIG_GREYBUS_LOOPBACK has to be enabled in order to build the
> drivers/staging/greybus/loopback.c file.
>
> A simple check would be to do:
> 	make drivers/staging/greybus/loopback.o
>
> does that work with your change?

No, it did not. I understand why it did not. My apologies for not looking into
the build of loopback.o file when the greybus module was rebuilt.

Please ignore my patch.

Thank you Julia and Greg for the feedback.
./drv



>
> thanks,
>
> greg k-h
>


