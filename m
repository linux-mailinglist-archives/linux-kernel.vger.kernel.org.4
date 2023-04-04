Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948B36D55CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjDDBSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjDDBSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870671FE0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:18:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D61D2616A9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7498EC433EF;
        Tue,  4 Apr 2023 01:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680571099;
        bh=omvd1hoh8VRO0NpDO8klPxjFF4gsouVc4emYNNhV+x0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=QqWBg9qvN/7v6mfGsRigTTa1XLb2wufnvh1I5ezXp3RTvT1D2UL3oiqMcLUTwGLAe
         ZWwmXOdG4Z0Od6LQw1ZqPXXa/8VVcUwdTv7deH8F6xkCKxwZAU9Vp0nxYWEnd3z5pE
         1N7YfHM5LG2SMHsZ+ISwW9QNxh+kKi209HTEsT3QKl6qTnZMsiLc+baDmdTe+Jib9d
         wC1pPEh501SdPY0iBkyl4+kQVYh9HtBwsQfiOL0wYOnT+U9Y3ZlIc7heu/z8j/aitO
         SIlh9DYqBVjuferu2LB76GBNtcDXOxkpWM6pBlJ/AsIdIISOJ5Odj4JaDg8T7Go7Z4
         ELoh0B3+cbC1g==
Message-ID: <07d1c848-fd1e-7e5e-6b56-90ac2a1a86ef@kernel.org>
Date:   Tue, 4 Apr 2023 09:18:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix null pointer panic in tracepoint
 in __replace_atomic_write_block
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230403165038.3018949-1-jaegeuk@kernel.org>
 <ZCsEytDjqEjQDPiO@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZCsEytDjqEjQDPiO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/4 0:54, Jaegeuk Kim wrote:
> We got a kernel panic if old_addr is NULL.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=217266
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
>   Call Trace:
>    <TASK>
>    f2fs_commit_atomic_write+0x619/0x990 [f2fs a1b985b80f5babd6f3ea778384908880812bfa43]
>    __f2fs_ioctl+0xd8e/0x4080 [f2fs a1b985b80f5babd6f3ea778384908880812bfa43]
>    ? vfs_write+0x2ae/0x3f0
>    ? vfs_write+0x2ae/0x3f0
>    __x64_sys_ioctl+0x91/0xd0
>    do_syscall_64+0x5c/0x90
>    entry_SYSCALL_64_after_hwframe+0x72/0xdc
>   RIP: 0033:0x7f69095fe53f
> 
> Fixes: 2f3a9ae990a7 ("f2fs: introduce trace_f2fs_replace_atomic_write_block")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Thanks for fixing this. :)

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
