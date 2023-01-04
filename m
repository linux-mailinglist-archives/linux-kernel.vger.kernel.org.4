Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B112265CEEF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjADJAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbjADI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:59:50 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3324B222;
        Wed,  4 Jan 2023 00:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672822777; bh=MI19Bt6j5+vEb0xMTmFMufyPhjb/G2VdVdfSJyngXD4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=D26SDwqEZYm04/bd7F7nTISPscO8ULSmnLTq+oeBqdx25JKeKRDQIMNIC379hjrIT
         v5eDcg5AL6MP0grpr5R4oY0uX01fvTPpSV+zr6333naHzMbYupbBIhMthVU4V9QRS+
         5M6r2Ega5TMYW4PCCcHIf1qJ/+Lhkbl0IYUj1yZU=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed,  4 Jan 2023 09:59:37 +0100 (CET)
X-EA-Auth: 3dYqcVzlZK1WvubetNrJWt8ppfWde/HMNvQ0EK01li/n4JhPYD5rf0RiytvtHMVkS3hYJaukvBTjexSuWZHOcVytsiYiLNcD
Date:   Wed, 4 Jan 2023 14:29:31 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v4 1/2] tty: serial: dz: convert atomic_* to refcount_*
 APIs for map_guard
Message-ID: <Y7U/8zMVwTP7NKXI@qemulion>
References: <cover.1671898144.git.drv@mailo.com>
 <d85c7441b96ce387d9010142efc3469d53b6aedc.1671898144.git.drv@mailo.com>
 <e42d5d19-7ed5-468b-98cc-13d0187dc555@kernel.org>
 <Y7P926/+N9IDKCyR@qemulion>
 <Y7U4ncG4Gkd5uRsb@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7U4ncG4Gkd5uRsb@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 09:28:13AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 03, 2023 at 03:35:15PM +0530, Deepak R Varma wrote:
> > > > -			printk(KERN_ERR
> > > > -			       "dz: Unable to reserve MMIO resource\n");
> > > > +	refcount_inc(&mux->map_guard);
> > > > +	if (refcount_read(&mux->map_guard) == 1) {
> > >
> > > This is now racy, right?
> >
> > Hello Jiri,
> > Thank you for the feedback. You are correct. I have split a single instruction
> > in two (or more?) instructions potentially resulting in race conditions. I
> > looked through the refcount_* APIs but did not find a direct match.
> >
> >
> > Can you please comment if the the following variation will avoid race condition?
> >
> > 	if (!refcount_add_not_zero(1, &mux->map_guard)) {
> > 		refcount_inc(&mux->map_guard);
> > 		...
> > 	}
>
> What do you think?  The onus is on you to prove the conversion is
> correct, otherwise, why do the conversion at all?

Hello Greg,
Okay. Sounds good. I think the revised approach should be safer. I will work on
finding a means to prove that.

>
> Actually, why do this at all, what is the goal here?  And how was this
> tested?

The objective here is to migrate to specific and improved APIs that are already
proved to be better for different reasons as mentioned in the patch log
messages. This is as per the Linux Kernel documentation.

In terms of testing, First, I did a compile and build test of the changes.
I also wrote separate small dummy modules and tested the API transformation.
However, these modules were standalone and limited in complexity and intensity.
I will try to make these more intense, multithreaded and run the test again.

Thank you as always :)
./drv

>
> thanks,
>
> greg k-h


