Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77352722C03
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjFEP4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjFEP4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:56:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADC798;
        Mon,  5 Jun 2023 08:56:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B630627C4;
        Mon,  5 Jun 2023 15:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1D7C433EF;
        Mon,  5 Jun 2023 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685980569;
        bh=IpNtFuVuKEDwemMdS4OmFiuCWO+xommx26o3j8UmfWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSqX0XiK8oho4aB/cWScg8BnPfw3W9jVHW+yAsqniIg8EmYcq7uUYyAZZrr9v9NE/
         S97rjd5OFP9KpJTapeBpC+J6IQ0l2/Cmdr9DZGCpNE/S9i/3TEpbBsHcSO+q4dnlM8
         82VhuyaBYs+arx8abzKe0tssPSYVuO6pG0QeHmUxDW5rDDYANFd4i2ou3NDcUNZnq1
         FVjQvir6uRbkg3H0pfRDCRkyHqm7XcdPlSv3qHZLOYPLabheChsUIqjIhsC7F5xuTT
         lcErf3nn/mj4diPiiJBtoE2VkHSpPXGnD6U/CVtHGv3LY2vT+DeAyD0Qu22LBgvNs9
         HS9QkmjXaBWGw==
Date:   Mon, 5 Jun 2023 16:56:05 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        jassisinghbrar@gmail.com
Subject: Re: [PATCH AUTOSEL 6.3] mailbox: mailbox-test: Fix potential
 double-free in mbox_test_message_write()
Message-ID: <20230605155605.GA2357572@google.com>
References: <20230519161348.2750641-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519161348.2750641-1-sashal@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023, Sasha Levin wrote:

> From: Lee Jones <lee@kernel.org>
> 
> [ Upstream commit 2d1e952a2b8e5e92d8d55ac88a7cf7ca5ea591ad ]
> 
> If a user can make copy_from_user() fail, there is a potential for
> UAF/DF due to a lack of locking around the allocation, use and freeing
> of the data buffers.
> 
> This issue is not theoretical.  I managed to author a POC for it:
> 
>     BUG: KASAN: double-free in kfree+0x5c/0xac
>     Free of addr ffff29280be5de00 by task poc/356
>     CPU: 1 PID: 356 Comm: poc Not tainted 6.1.0-00001-g961aa6552c04-dirty #20
>     Hardware name: linux,dummy-virt (DT)
>     Call trace:
>      dump_backtrace.part.0+0xe0/0xf0
>      show_stack+0x18/0x40
>      dump_stack_lvl+0x64/0x80
>      print_report+0x188/0x48c
>      kasan_report_invalid_free+0xa0/0xc0
>      ____kasan_slab_free+0x174/0x1b0
>      __kasan_slab_free+0x18/0x24
>      __kmem_cache_free+0x130/0x2e0
>      kfree+0x5c/0xac
>      mbox_test_message_write+0x208/0x29c
>      full_proxy_write+0x90/0xf0
>      vfs_write+0x154/0x440
>      ksys_write+0xcc/0x180
>      __arm64_sys_write+0x44/0x60
>      invoke_syscall+0x60/0x190
>      el0_svc_common.constprop.0+0x7c/0x160
>      do_el0_svc+0x40/0xf0
>      el0_svc+0x2c/0x6c
>      el0t_64_sync_handler+0xf4/0x120
>      el0t_64_sync+0x18c/0x190
> 
>     Allocated by task 356:
>      kasan_save_stack+0x3c/0x70
>      kasan_set_track+0x2c/0x40
>      kasan_save_alloc_info+0x24/0x34
>      __kasan_kmalloc+0xb8/0xc0
>      kmalloc_trace+0x58/0x70
>      mbox_test_message_write+0x6c/0x29c
>      full_proxy_write+0x90/0xf0
>      vfs_write+0x154/0x440
>      ksys_write+0xcc/0x180
>      __arm64_sys_write+0x44/0x60
>      invoke_syscall+0x60/0x190
>      el0_svc_common.constprop.0+0x7c/0x160
>      do_el0_svc+0x40/0xf0
>      el0_svc+0x2c/0x6c
>      el0t_64_sync_handler+0xf4/0x120
>      el0t_64_sync+0x18c/0x190
> 
>     Freed by task 357:
>      kasan_save_stack+0x3c/0x70
>      kasan_set_track+0x2c/0x40
>      kasan_save_free_info+0x38/0x5c
>      ____kasan_slab_free+0x13c/0x1b0
>      __kasan_slab_free+0x18/0x24
>      __kmem_cache_free+0x130/0x2e0
>      kfree+0x5c/0xac
>      mbox_test_message_write+0x208/0x29c
>      full_proxy_write+0x90/0xf0
>      vfs_write+0x154/0x440
>      ksys_write+0xcc/0x180
>      __arm64_sys_write+0x44/0x60
>      invoke_syscall+0x60/0x190
>      el0_svc_common.constprop.0+0x7c/0x160
>      do_el0_svc+0x40/0xf0
>      el0_svc+0x2c/0x6c
>      el0t_64_sync_handler+0xf4/0x120
>      el0t_64_sync+0x18c/0x190
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/mailbox/mailbox-test.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Could you ensure the follow-up patch is also applied to all branches please?

  8fe72b76db79d mailbox: mailbox-test: fix a locking issue in mbox_test_message_write()

-- 
Lee Jones [李琼斯]
