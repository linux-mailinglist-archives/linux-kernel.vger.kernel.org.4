Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE353631571
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 18:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiKTRWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 12:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKTRWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 12:22:37 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A908AC3D;
        Sun, 20 Nov 2022 09:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=3H6R74lTbSItE6Gc5khx7ihDy53GURcybs0KsLnI7b8=; b=tFf5z
        nE75nP1AA7tfuU2i7zjgDT5x36O+sfvloDYuR9FPRuUkvYkJ6g+cKFX3icJLkJPV/HeXb8sRRk37a
        fuqFZQEji/+k5BJDAOUFV95s4xlOzGp1bPC9iLzj3ongcQI9I/ePQCvTSpq1xCqLXQUgr8ktgoZSO
        KiOLJJX6D1/71qq5hIkGbdqXoCgDlNjEKDjymjCGznoWRDCFFaJHQDMj+CrNwFEqjlleeB+BBdanW
        3VcbQzZXLd8VOFcDDQfT4Uth1dps9Ymp2vd3g467c0mEUjtPwwChpB0eDetetaQmxWFKKkutaxGcJ
        0Qz09lrmef9gQJMZ0U1Yiyhf7NZZg==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1owo1L-00027Y-TI;
        Sun, 20 Nov 2022 17:22:20 +0000
Date:   Sun, 20 Nov 2022 17:22:19 +0000
From:   John Keeping <john@metanate.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Lee Jones <lee@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y3piS43drwSoipD9@donbot>
References: <20221117120813.1257583-1-lee@kernel.org>
 <Y3YuL8rSE9pNfIZN@kroah.com>
 <Y3Y7MlwV0UFcA3w8@google.com>
 <Y3ZlvyZoL+PzpbQX@rowland.harvard.edu>
 <Y3dIXUmjTfJLpPe7@google.com>
 <Y3er7nenAhbmBdBy@rowland.harvard.edu>
 <Y3e0zAa7+HiNVrKN@donbot>
 <Y3f0DJTOQ/8TVX0h@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3f0DJTOQ/8TVX0h@rowland.harvard.edu>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 04:07:24PM -0500, Alan Stern wrote:
> On Fri, Nov 18, 2022 at 04:37:32PM +0000, John Keeping wrote:
> > I don't think it's at all simple to fix this - I posted a series
> > addressing the lifetime issues here a few years ago but didn't chase it
> > up and there was no feedback:
> > 
> > 	https://lore.kernel.org/linux-usb/20191028114228.3679219-1-john@metanate.com/
> > 
> > That includes a patch to remove the embedded struct cdev and manage its
> > lifetime separately, which I think is needed as there are two different
> > struct device objects here and we cannot tie their lifetimes together.
> 
> I still don't have a clear picture of what the real problem is.  Lee's 
> original patch description just said "external references are presently 
> not tracked", with no details about what those external references are. 
> Why not add just proper cdev_get() and cdev_put() calls to whatever code 
> handles those external references, so that they _are_ tracked?
> 
> What are the two different struct device objects?  Why do their 
> lifetimes need to be tied together?  If you do need to tie their 
> lifetimes somehow, why not simply make one of them (the one which is 
> logically allowed to be shorter-lived) hold a reference to the other?

The problem is that we have a struct cdev embedded in f_hidg but the
lifetime of f_hidg is not tied to any kobject so we can't solve this in
the right way by setting the parent kobject of the cdev.

While refcounting struct f_hidg is necessary, it's not sufficient
because the only way to keep it alive long enough for the final
kobject_put() on the embedded cdev is to tie the lifetime to a kobject
of its own and there is no suitable object as this is not the model
followed by gadget function instances.

To show the problem (using libusbgx's example commands for conciseness,
but obviously this can be done via configfs directly):

	$ gadget-hid
	$ exec 3<> /dev/hidg0
	$ gadget-vid-pid-remove
	$ exec 3<&-

	==================================================================
	BUG: KASAN: use-after-free in kobject_put+0x24/0x250
	Read of size 1 at addr c61784a0 by task sh/264

	CPU: 1 PID: 264 Comm: sh Tainted: G        W          6.0.5 #1
	Hardware name: Rockchip (Device Tree)
	 unwind_backtrace from show_stack+0x10/0x14
	 show_stack from dump_stack_lvl+0x58/0x70
	 dump_stack_lvl from print_report+0x58/0x4dc
	 print_report from kasan_report+0x88/0xa8
	 kasan_report from kobject_put+0x24/0x250
	 kobject_put from __fput+0x1e4/0x358
	 __fput from task_work_run+0xb4/0xc4
	 task_work_run from do_work_pending+0x4d4/0x524
	 do_work_pending from slow_work_pending+0xc/0x20
	Exception stack(0xf284bfb0 to 0xf284bff8)
	bfa0:                                     00000000 00000003 02292190 00000000
	bfc0: 02293fc8 aed4e1d0 00000001 00000006 022925a0 00000000 022925a0 022923f4
	bfe0: 00532f38 b6864840 0049c218 aec57e38 60000010 0000000b

	Allocated by task 341:
	 kasan_set_track+0x20/0x28
	 ____kasan_kmalloc+0x80/0x88
	 hidg_alloc+0x24/0x1f0
	 usb_get_function+0x28/0x48
	 config_usb_cfg_link+0x90/0x114
	 configfs_symlink+0x24c/0x5d8
	 vfs_symlink+0x58/0x74
	 do_symlinkat+0xdc/0x16c
	 ret_fast_syscall+0x0/0x1c

	Freed by task 352:
	 kasan_set_track+0x20/0x28
	 kasan_set_free_info+0x28/0x34
	 ____kasan_slab_free+0xf8/0x108
	 __kasan_slab_free+0x10/0x18
	 slab_free_freelist_hook+0x9c/0xfc
	 kfree+0x118/0x258
	 hidg_free+0x44/0x6c
	 config_usb_cfg_unlink+0xd4/0xf4
	 configfs_unlink+0x118/0x15c
	 vfs_unlink+0xd8/0x1c4
	 do_unlinkat+0x180/0x28c
	 ret_fast_syscall+0x0/0x1c

	The buggy address belongs to the object at c6178400
	 which belongs to the cache kmalloc-512 of size 512
	The buggy address is located 160 bytes inside of
	 512-byte region [c6178400, c6178600)
