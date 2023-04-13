Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4966E117D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjDMP4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMP4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:56:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E437EC2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:56:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3371A6159E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46ABFC433EF;
        Thu, 13 Apr 2023 15:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681401369;
        bh=ACf+iowbWo51ZjxMlapcfgzDPSEkREe6jY3O508f0Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=js+O8dI4chDOmFbKjiyVbkZkD8m7rJGZ1GlLmuYB05ZS/4xBPecyfzMSD0GhorrQz
         +BGNBOcIQNOGh3CQn8FAwy3brybHnF6iJ/OXlkVD4ZjLtTE5oKlAQ4B+KHZxLM5aQk
         xjKIPtVfi4HCMYcqWCzPUrkoKbWgkvQ2MI/q2/As=
Date:   Thu, 13 Apr 2023 17:56:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Yongqin Liu <yongqin.liu@linaro.org>,
        John Stultz <jstultz@google.com>,
        Zheng Wang <zyytlz.wz@163.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] misc: hisi_hikey_usb: Fix use after free bug in
 hisi_hikey_usb_remove due to race condition
Message-ID: <2023041308-unvisited-slinky-a56f@gregkh>
References: <20230312145305.1908607-1-zyytlz.wz@163.com>
 <CANDhNCr=hdhKS4c+U=+W1ONHDWv6BrwL5TovGjs0G2G+Reqc9g@mail.gmail.com>
 <CAJedcCyJnV+KnFF5h+2-0W1R4uaUxUxXFUH3Q9HGYh-5F5LmBQ@mail.gmail.com>
 <CAJedcCyERP0-9DNgeKmS3C9Soqq590PteEorr_bxKzNanht=TQ@mail.gmail.com>
 <CAMSo37Vfr0DOqN+1XjH0o3pOY=BaHnSFkUbnZPOdMQ3TbfoAKg@mail.gmail.com>
 <CAJedcCzm3MqYe3QGT7V4sMmDsVHbjVSnEc2NXWPMGVZL=a_cBA@mail.gmail.com>
 <2023041308-nerd-dry-98a6@gregkh>
 <CAJedcCyeM2a79i0=ffKwdKfnQayo7svhTTEth2ka6K9np0Ztiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJedcCyeM2a79i0=ffKwdKfnQayo7svhTTEth2ka6K9np0Ztiw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 11:35:17PM +0800, Zheng Hacker wrote:
> Greg KH <gregkh@linuxfoundation.org> 于2023年4月13日周四 20:48写道：
> >
> > On Thu, Apr 13, 2023 at 07:12:07PM +0800, Zheng Hacker wrote:
> > > Yongqin Liu <yongqin.liu@linaro.org> 于2023年4月13日周四 18:55写道：
> > > >
> > > > Hi, Zheng
> > > >
> > > > On Thu, 13 Apr 2023 at 16:08, Zheng Hacker <hackerzheng666@gmail.com> wrote:
> > > > >
> > > > > Friendly ping about the bug.
> > > >
> > > > Sorry, wasn't aware of this message before,
> > > >
> > > > Could you please help share the instructions to reproduce the problem
> > > > this change fixes?
> > > >
> > >
> > > Hi Yongqin,
> > >
> > > Thanks for your reply. This bug is found by static analysis. There is no PoC.
> > >
> > > >From my personal experience, triggering race condition bugs stably in
> > > the kernel needs some tricks.
> > > For example, you can insert some sleep-time code to slow down the
> > > thread until the related object is freed.
> > > Besides, you can use gdb to control the time window. Also, there are
> > > some other tricks as [1] said.
> > >
> > > As for the reproduction, this attack vector requires that the attacker
> > > can physically access the device.
> > > When he/she unplugs the usb, the remove function is triggered, and if
> > > the set callback is invoked, there might be a race condition.
> >
> > How does the removal of the USB device trigger a platform device
> > removal?
> 
> Sorry I made a mistake. The USB device usually calls disconnect
> callback when it's unpluged.

Yes, but you are changing the platform device disconnect, not the USB
device disconnect.

> What I want to express here is When the driver-related device(here
> it's USB GPIO Hub) was removed, the remove function is triggered.

And is this a patform device on a USB device?  If so, that's a bigger
problem that we need to fix as that is not allowed.

But in looking at the code, it does not seem to be that at all, this is
just a "normal" platform device.  So how can it ever be removed from the
system?  (and no, unloading the driver doesn't count, that can never
happen on a normal machine.)

thanks,

greg k-h
