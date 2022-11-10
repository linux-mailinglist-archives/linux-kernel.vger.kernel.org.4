Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910F1623E75
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiKJJUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJJUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:20:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D19968C64
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:20:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27D58B82130
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51241C433D6;
        Thu, 10 Nov 2022 09:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668072038;
        bh=YFRAfTm6C+ZlOBvYjh/2TEJ/OXnJuqoAVu8O5lNu85c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqaZUNyYM4y7YBGqObEYLvylKeqrdjivkItSHQ3miPrURDYtxUHetCE4msgNAIxRg
         i1LX8FHbwCY82rbnwRuQ3YwBtwrIESwmBcYfgwtQiIof9bjAdlHl9oth/IGraDOTJa
         6hRvluun8cWZMVgdc2LQ7khi688enOLV+2PYbNmw=
Date:   Thu, 10 Nov 2022 10:20:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Tejun Heo <tj@kernel.org>,
        Florian Mickler <florian@mickler.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        systemd-devel@lists.freedesktop.org
Subject: Re: BUG: kworker + systemd-udevd memory leaks found in 6.1.0-rc4
Message-ID: <Y2zCYwNNvQWppLWZ@kroah.com>
References: <0d9c3f6c-3948-d5d1-bcc1-baf31141beaa@alu.unizg.hr>
 <a6b76ce0-0fb3-4434-cc3e-ab6f39fb1cf9@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6b76ce0-0fb3-4434-cc3e-ab6f39fb1cf9@alu.unizg.hr>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DEAR_SOMETHING,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 05:57:57AM +0100, Mirsad Goran Todorovac wrote:
> On 04. 11. 2022. 11:40, Mirsad Goran Todorovac wrote:
> 
> > Dear Sirs,
> > 
> > When building a RPM 6.1.0-rc3 for AlmaLinux 8.6, I have enabled
> > CONFIG_DEBUG_KMEMLEAK=y
> > and the result showed an unreferenced object in kworker process:
> > 
> > # cat /sys/kernel/debug/kmemleak
> > unreferenced object 0xffffa01dabff6100 (size 16):
> > � comm "kworker/u12:4", pid 400, jiffies 4294894771 (age 5284.956s)
> > � hex dump (first 16 bytes):
> > ��� 6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
> > � backtrace:
> > ��� [<000000009ff951f6>] __kmem_cache_alloc_node+0x380/0x4e0
> > ��� [<00000000451f4268>] __kmalloc_node_track_caller+0x55/0x150
> > ��� [<0000000005472512>] kstrdup+0x36/0x70
> > ��� [<000000002f797ac4>] kstrdup_const+0x28/0x30
> > ��� [<00000000e3f86581>] kvasprintf_const+0x78/0xa0
> > ��� [<00000000e15920f7>] kobject_set_name_vargs+0x23/0xa0
> > ��� [<000000004158a6c0>] dev_set_name+0x53/0x70
> > ��� [<000000001a120541>] memstick_check+0xff/0x384 [memstick]
> > ��� [<00000000122bb894>] process_one_work+0x214/0x3f0
> > ��� [<00000000fcf282cc>] worker_thread+0x34/0x3d0
> > ��� [<0000000002409855>] kthread+0xed/0x120
> > ��� [<000000007b02b4a3>] ret_from_fork+0x1f/0x30
> > unreferenced object 0xffffa01dabff6ec0 (size 16):
> > � comm "kworker/u12:4", pid 400, jiffies 4294894774 (age 5284.944s)
> > � hex dump (first 16 bytes):
> > ��� 6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
> > � backtrace:
> > ��� [<000000009ff951f6>] __kmem_cache_alloc_node+0x380/0x4e0
> > ��� [<00000000451f4268>] __kmalloc_node_track_caller+0x55/0x150
> > ��� [<0000000005472512>] kstrdup+0x36/0x70
> > ��� [<000000002f797ac4>] kstrdup_const+0x28/0x30
> > ��� [<00000000e3f86581>] kvasprintf_const+0x78/0xa0
> > ��� [<00000000e15920f7>] kobject_set_name_vargs+0x23/0xa0
> > ��� [<000000004158a6c0>] dev_set_name+0x53/0x70
> > ��� [<000000001a120541>] memstick_check+0xff/0x384 [memstick]
> > ��� [<00000000122bb894>] process_one_work+0x214/0x3f0
> > ��� [<00000000fcf282cc>] worker_thread+0x34/0x3d0
> > ��� [<0000000002409855>] kthread+0xed/0x120
> > ��� [<000000007b02b4a3>] ret_from_fork+0x1f/0x30
> > #
> > 
> > Please fing the build config and lshw output attached.
> > 
> > dmesg is useless, as it is filled with events like:
> > 
> > [ 6068.996120] evbug: Event. Dev: input4, Type: 1, Code: 31, Value: 0
> > [ 6068.996121] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0
> > [ 6069.124145] evbug: Event. Dev: input4, Type: 4, Code: 4, Value: 458762
> > [ 6069.124149] evbug: Event. Dev: input4, Type: 1, Code: 34, Value: 1
> > [ 6069.124150] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0
> > [ 6069.196003] evbug: Event. Dev: input4, Type: 4, Code: 4, Value: 458762
> > [ 6069.196007] evbug: Event. Dev: input4, Type: 1, Code: 34, Value: 0
> > [ 6069.196009] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0
> > [ 6069.788129] evbug: Event. Dev: input4, Type: 4, Code: 4, Value: 458792
> > [ 6069.788133] evbug: Event. Dev: input4, Type: 1, Code: 28, Value: 1
> > [ 6069.788135] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0
> 
> This bug is confirmed in 6.1-rc4, among the "thermald" and "systemd-dev"
> kernel memory leaks, potentially exposing race conditions or other more
> serious bug.

How is a memory leak a race condition?

> The bug is now also confirmed and now manifested also in the Ubuntu 22.04
> LTS jammy 6.1-rc4 build.
> 
> Here is the kmemleak output:
> 
> unreferenced object 0xffff9242b13b3980 (size 64):
> � comm "kworker/5:3", pid 43106, jiffies 4305052439 (age 71828.792s)
> � hex dump (first 32 bytes):
> ��� 80 8b a0 f0 42 92 ff ff 00 00 00 00 00 00 00 00 ....B...........
> ��� 20 86 a0 f0 42 92 ff ff 00 00 00 00 00 00 00 00 ...B...........
> � backtrace:
> ��� [<00000000c5dea4db>] __kmem_cache_alloc_node+0x380/0x4e0
> ��� [<000000002b17af47>] kmalloc_node_trace+0x27/0xa0
> ��� [<000000004c09eee5>] xhci_alloc_command+0x6e/0x180

This is a totally different backtrace from above, how are they related?

This looks like a potential xhci issue.  Can you use 'git bisect' to
track down the offending change that caused this?

thanks,

greg k-h
