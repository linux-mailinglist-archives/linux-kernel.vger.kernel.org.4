Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9BA6224DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiKIHq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKIHqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:46:23 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDDA186FE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 23:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667979968; bh=4y+p6G+6Eyrf3pYDyQ3PW7+HxDBRFvP76sfcfvr405o=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Tx3A3hiw1+wUw/GGd3EY1Vy10Eu0OfaNks4pN6IpVUGYN0NPsu7J6GTniwOdr2OS+
         OrFvVOtSWLzW4iqDe6C5CaMXmc4BPWWE27bCpCW3421zQSqM+JUCn+00wnXvZ1pijO
         sPkMmsgjE5CZvrPAxec1kwNX0kFus2Tg3CMOiXIE=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed,  9 Nov 2022 08:46:08 +0100 (CET)
X-EA-Auth: 5WhwHM9XqEWUpElfHoVsyiSNRigbkBV1oekffDsZQS3OO3TMni5CBDdtyn7IdurPP3ccJ3dnRKFudoW0pY8qUOwkWzy7vJiN
Date:   Wed, 9 Nov 2022 13:16:02 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fieldbus: replace snprintf in show functions
 with sysfs_emit
Message-ID: <Y2taurqOvGiPo3jB@qemulion>
References: <Y2tBJFSsyUzdb+eO@qemulion>
 <Y2tXEibm2QxH37FK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2tXEibm2QxH37FK@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 08:30:26AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 09, 2022 at 11:26:52AM +0530, Deepak R Varma wrote:
> > The show() methods should only use sysfs_emit() when formatting values
> > to be returned to the user space.
> > Ref: Documentation/filesystems/sysfs.rst
> > Issue identified by coccicheck.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> >  	/*
> > -	 * card_name was provided by child driver, could potentially be long.
> > -	 * protect against buffer overrun.
> > +	 * sysfs provides PAGE_SIZE long buffer to take care of potentially
>
> No need to ever mention PAGE_SIZE at all, this comment should just be:
> 	/* card_name was provided by child driver */

Sure. I will update the comment in the revision.

>
> But the larger question is, why did you only convert one of the sysfs
> show functions in this file?  Why not do them all?

I was limiting it to what is reported by coccicheck. I will review other such
show functions and send a consolidated patch.

Thank you,
./drv

>
> thanks,
>
> greg k-h
>


