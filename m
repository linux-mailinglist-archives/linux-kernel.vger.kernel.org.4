Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6419466A50F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjAMVVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjAMVU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:20:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719F985CA8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:20:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FCD660C89
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 21:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C029C4339B;
        Fri, 13 Jan 2023 21:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673644856;
        bh=e0je/nejB0D6A+EeLOrjZczSML9JeG2dwzsWlHAj4Vs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=N1uZke77w+En/GJgNBep0ba7wvWVztYzgqLpCSxnbhwbUHcAbTjXODHroCy+Q7cKe
         f/3WKfw27OrCmpnwGpUj1acFldQ8g/4LsXDJzg+tGT/lwHLzfiEeHYJ70/TBp34ys4
         jn5+2H9QSGupFXZHK6ZCLaBXN0IxIOYIGKpRRfMcAtfLfPXznlx7ItrhE3L5XWNUXV
         od5CfpISACSgBN7E8mby+tiWjRHyr76aP+s5uMO9DbG0VODF0QZoMN9Iq7nzQZjWAC
         kU6JJ1RjHpbvX04IGel9w7hyLBzb4cJz4Js/4kD4njC48Joc9TU7OrnLpkxsWwgChD
         bMKTGt6RyXzEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AF98C395CA;
        Fri, 13 Jan 2023 21:20:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec: Fix panic notifier registration
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167364485636.21086.15397302633084093242.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Jan 2023 21:20:56 +0000
References: <20230110221033.7441-1-m.szyprowski@samsung.com>
In-Reply-To: <20230110221033.7441-1-m.szyprowski@samsung.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        pmalani@chromium.org, robbarnes@google.com, dtor@chromium.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue, 10 Jan 2023 23:10:33 +0100 you wrote:
> Initialize panic notifier to avoid the following lockdep warning:
> 
> --->8---
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 0 PID: 62 Comm: kworker/u16:1 Not tainted 6.2.0-rc3-next-20230110-00037-g7c2b0426386a #6112
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: events_unbound async_run_entry_fn
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x58/0x70
>  dump_stack_lvl from register_lock_class+0x998/0x9a8
>  register_lock_class from __lock_acquire+0x6c/0x2a80
>  __lock_acquire from lock_acquire+0x124/0x3f0
>  lock_acquire from down_write+0x40/0xd8
>  down_write from blocking_notifier_chain_register+0x28/0x58
>  blocking_notifier_chain_register from cros_ec_debugfs_probe+0x324/0x3b4
>  cros_ec_debugfs_probe from platform_probe+0x5c/0xb8
>  platform_probe from really_probe+0xe0/0x414
>  really_probe from __driver_probe_device+0x9c/0x200
>  __driver_probe_device from driver_probe_device+0x30/0xc0
>  driver_probe_device from __device_attach_driver+0xa8/0x120
>  __device_attach_driver from bus_for_each_drv+0x7c/0xc0
>  bus_for_each_drv from __device_attach_async_helper+0xa0/0xf4
>  __device_attach_async_helper from async_run_entry_fn+0x40/0x154
>  async_run_entry_fn from process_one_work+0x288/0x790
>  process_one_work from worker_thread+0x44/0x504
>  worker_thread from kthread+0xf0/0x124
>  kthread from ret_from_fork+0x14/0x2c
> Exception stack(0xf0a6dfb0 to 0xf0a6dff8)
> ...
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec: Fix panic notifier registration
    https://git.kernel.org/chrome-platform/c/9e69b1b27b13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


