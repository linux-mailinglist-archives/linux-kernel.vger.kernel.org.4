Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D03615B23
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiKBDsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiKBDsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:48:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8FC275F2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 20:48:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 788E6617BA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 03:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACC1C433D7;
        Wed,  2 Nov 2022 03:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667360891;
        bh=2FsdKsKH+tYq1Nh5CMQAilAimPBI7XTQXud60nZ5JjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJJIu1FbnadSEvssXm3aPhb95cFa+Gvx2azUkfaAF0RuBcSDSMc+QrsGRu8x6ryrp
         W8ISutGBrEVPQ1EWneEb5URSZbIzQnI+z6eaE8QD+G3QsCJtGe/LkOenJ+xMfi2pXA
         +rD/t/ljYbcdtBuHg00VyNobvy04gAtiQlk5wvo8=
Date:   Wed, 2 Nov 2022 03:59:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shangxiaojing <shangxiaojing@huawei.com>
Cc:     Ian Abbott <abbotti@mev.co.uk>, hsweeten@visionengravers.com,
        zhangxuezhi1@coolpad.com, fmhess@users.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] comedi: Fix potential memory leak in comedi_init()
Message-ID: <Y2HdC8N+DroZ8BKu@kroah.com>
References: <20221101032125.27337-1-shangxiaojing@huawei.com>
 <Y2CkW5EVLiLUoNWh@kroah.com>
 <32c291d7-0e87-ec1f-e2af-28d7f8ca0981@huawei.com>
 <5b8ee99d-2358-39c5-b663-2d1c80353639@mev.co.uk>
 <04bf1874-77bc-ce73-28e2-04fe4d098e58@mev.co.uk>
 <dac94e1e-068b-c046-c8ea-1a8405ce91bd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dac94e1e-068b-c046-c8ea-1a8405ce91bd@huawei.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 10:51:35AM +0800, shangxiaojing wrote:
> 
> 
> On 2022/11/2 0:41, Ian Abbott wrote:
> > On 01/11/2022 11:40, Ian Abbott wrote:
> > > On 01/11/2022 06:16, shangxiaojing wrote:
> > > > 
> > > > 
> > > > On 2022/11/1 12:45, Greg KH wrote:
> > > > > On Tue, Nov 01, 2022 at 11:21:25AM +0800, Shang XiaoJing wrote:
> > > > > > comedi_init() will goto out_unregister_chrdev_region if cdev_add()
> > > > > > failed, which won't free the resource alloced in kobject_set_name().
> > > > > > Call kfree_const() to free the leaked name before goto
> > > > > > out_unregister_chrdev_region.
> > > > > > 
> > > > > > unreferenced object 0xffff8881000fa8c0 (size 8):
> > > > > >    comm "modprobe", pid 239, jiffies 4294905173 (age 51.308s)
> > > > > >    hex dump (first 8 bytes):
> > > > > >      63 6f 6d 65 64 69 00 ff                          comedi..
> > > > > >    backtrace:
> > > > > >      [<000000005f9878f7>] __kmalloc_node_track_caller+0x4c/0x1c0
> > > > > >      [<000000000fd70302>] kstrdup+0x3f/0x70
> > > > > >      [<000000009428bc33>] kstrdup_const+0x46/0x60
> > > > > >      [<00000000ed50d9de>] kvasprintf_const+0xdb/0xf0
> > > > > >      [<00000000b2766964>] kobject_set_name_vargs+0x3c/0xe0
> > > > > >      [<00000000f2424ef7>] kobject_set_name+0x62/0x90
> > > > > >      [<000000005d5a125b>] 0xffffffffa0013098
> > > > > >      [<00000000f331e663>] do_one_initcall+0x7a/0x380
> > > > > >      [<00000000aa7bac96>] do_init_module+0x5c/0x230
> > > > > >      [<000000005fd72335>] load_module+0x227d/0x2420
> > > > > >      [<00000000ad550cf1>] __do_sys_finit_module+0xd5/0x140
> > > > > >      [<00000000069a60c5>] do_syscall_64+0x3f/0x90
> > > > > >      [<00000000c5e0d521>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > > > > 
> > > > > > Fixes: ed9eccbe8970 ("Staging: add comedi core")
> > > > > > Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> > > > > > ---
> > > > > >   drivers/comedi/comedi_fops.c | 5 ++++-
> > > > > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/comedi/comedi_fops.c
> > > > > > b/drivers/comedi/comedi_fops.c
> > > > > > index e2114bcf815a..2c508c2cf6f6 100644
> > > > > > --- a/drivers/comedi/comedi_fops.c
> > > > > > +++ b/drivers/comedi/comedi_fops.c
> > > > > > @@ -3379,8 +3379,11 @@ static int __init comedi_init(void)
> > > > > >       retval = cdev_add(&comedi_cdev, MKDEV(COMEDI_MAJOR, 0),
> > > > > >                 COMEDI_NUM_MINORS);
> > > > > > -    if (retval)
> > > > > > +    if (retval) {
> > > > > > +        kfree_const(comedi_cdev.kobj.name);
> > > > > > +        comedi_cdev.kobj.name = NULL;
> > > > > >           goto out_unregister_chrdev_region;
> > > > > > +    }
> > > > > 
> > > > > A driver should never have to poke around in the internals of a cdev
> > > > > object like this.  Please fix the cdev core to not need this if
> > > > > cdev_add() fails.
> > > 
> > > Or at least there should be a function that can be called to undo
> > > the allocations of kobject_set_name().
> > 
> > Looking at it a bit more, cdev_init() calls kobject_init(), and
> > kobject_init() requires a matching call to kobject_put().  Nothing is
> > calling kobject_put() in this situation.  Calling cdev_del() will call
> > kobject_put(), so is that the correct way to clean up after cdev_init()
> > if the call to cdev_add() fails?
> > 
> 
> Some cdev call cdev_del() when cdev_add() failed (like init_dvbdev()), and
> at that time the cdev_unmap() in cdev_del() won't do anything due to the
> failure of cdev_add(), which is calling the kobject_put() when cdev_add()
> failed. But I'm not sure which one is better.

My point is that no one calling the cdev_add() call should have to do
this type of "cleanup"  The cdev code should do it automatically, we
don't want to have to audit every user of cdev_add() today, and in the
future for forever, to ensure they got it right.

Let's fix it up in the cdev code itself please.  The kobject in a cdev
is a very odd thing, it's not the "normal" type of kobject that you
expect, so the cdev code should handle all of that on its own and that
should not "leak" into any caller.

thanks,

greg k-h
