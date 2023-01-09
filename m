Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543AC662356
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbjAIKli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbjAIKk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:40:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1DA186B9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:33:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1179160FD2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA15AC433EF;
        Mon,  9 Jan 2023 10:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673260401;
        bh=ZUImioBdrk3XKJsixsqfdOKeV/GUBIF4fNM0CYvWFR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ybbsx1md5/zhL+OBdguHE/hSq9xkxsIUV68LQPrt04qspADxNXhB4ckBbpdU5v8Ou
         ZNaT2UTxEaPU9B5bcQYfnX9wLmhfH5jaMAlYQEib+mjXxERtVu1Cxx0MjRAfphlgZx
         Za+hF+fLZc7FfqT8ECTQ7LP+9o7sMT+ib96A05Xg=
Date:   Mon, 9 Jan 2023 11:33:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        anthony.l.nguyen@intel.com, rafael@kernel.org,
        jesse.brandeburg@intel.com, alice.chao@mediatek.com
Subject: Re: [PATCH v2] kobject: Fix slab-out-of-bounds in fill_kobj_path()
Message-ID: <Y7vtbayi+2GfkhEa@kroah.com>
References: <20221220012143.52141-1-wanghai38@huawei.com>
 <54066d0e-ef50-183f-74fe-551bb99741eb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54066d0e-ef50-183f-74fe-551bb99741eb@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 05:37:23PM +0800, Wang Hai wrote:
> 
> 在 2022/12/20 9:21, Wang Hai 写道:
> > In kobject_get_path(), if kobj->name is changed between calls
> > get_kobj_path_length() and fill_kobj_path() and the length becomes
> > longer, then fill_kobj_path() will have an out-of-bounds bug.
> > 
> > The actual current problem occurs when the ixgbe probe.
> > 
> > In ixgbe_mii_bus_init(), if the length of netdev->dev.kobj.name
> > length becomes longer, out-of-bounds will occur.
> > 
> > cpu0                                         cpu1
> > ixgbe_probe
> >   register_netdev(netdev)
> >    netdev_register_kobject
> >     device_add
> >      kobject_uevent // Sending ADD events
> >                                               systemd-udevd // rename netdev
> >                                                dev_change_name
> >                                                 device_rename
> >                                                  kobject_rename
> >   ixgbe_mii_bus_init                             |
> >    mdiobus_register                              |
> >     __mdiobus_register                           |
> >      device_register                             |
> >       device_add                                 |
> >        kobject_uevent                            |
> >         kobject_get_path                         |
> >          len = get_kobj_path_length // old name  |
> >          path = kzalloc(len, gfp_mask);          |
> >                                                  kobj->name = name;
> >                                                  /* name length becomes
> >                                                   * longer
> >                                                   */
> >          fill_kobj_path /* kobj path length is
> >                          * longer than path,
> >                          * resulting in out of
> >                          * bounds when filling path
> >                          */
> > 
> > This is the kasan report:
> > 
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in fill_kobj_path+0x50/0xc0
> > Write of size 7 at addr ff1100090573d1fd by task kworker/28:1/673
> > 
> >   Workqueue: events work_for_cpu_fn
> >   Call Trace:
> >   <TASK>
> >   dump_stack_lvl+0x34/0x48
> >   print_address_description.constprop.0+0x86/0x1e7
> >   print_report+0x36/0x4f
> >   kasan_report+0xad/0x130
> >   kasan_check_range+0x35/0x1c0
> >   memcpy+0x39/0x60
> >   fill_kobj_path+0x50/0xc0
> >   kobject_get_path+0x5a/0xc0
> >   kobject_uevent_env+0x140/0x460
> >   device_add+0x5c7/0x910
> >   __mdiobus_register+0x14e/0x490
> >   ixgbe_probe.cold+0x441/0x574 [ixgbe]
> >   local_pci_probe+0x78/0xc0
> >   work_for_cpu_fn+0x26/0x40
> >   process_one_work+0x3b6/0x6a0
> >   worker_thread+0x368/0x520
> >   kthread+0x165/0x1a0
> >   ret_from_fork+0x1f/0x30
> > 
> > This reproducer triggers that bug:
> > 
> > while:
> > do
> >      rmmod ixgbe
> >      sleep 0.5
> >      modprobe ixgbe
> >      sleep 0.5
> > 
> > When calling fill_kobj_path() to fill path, if the name length of
> > kobj becomes longer, return failure and retry. This fixes the problem.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Wang Hai <wanghai38@huawei.com>
> > ---
> Hi, greg k-h.
> Sorry to bother you. Can this patch be merged into the mainline?

It's in my "to review" queue that I am working on.  As this is not
anything that a normal user can trigger, it's not that high of a
priority, right?

thanks,

greg k-h
