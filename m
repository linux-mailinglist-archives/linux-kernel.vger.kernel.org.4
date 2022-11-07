Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB5061E83A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 02:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiKGBZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 20:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiKGBZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 20:25:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF45A25DE
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 17:25:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D340B80D76
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C675AC433D6;
        Mon,  7 Nov 2022 01:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667784315;
        bh=tk00DWLZn8UdWpKhWBEVC5BzHAP8Recbed1ijqVL3lU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HcZDpCY2gaR9TFg+qeHgIXFqzzyNttYt9OF/v1FREAbNXTRFFEM1U5BuHW+nbUWRS
         ohChy5Gia3vCETSkUdC9DFVGrU8NJdN46n3tsCaSpgFgjOiTjzs31DbBLVk/3G3vce
         s3QqW4bao9ahI1SxPHF+eC1WbzV3RaBfEDh6085DBkoLfJ6xYNV9y13anwzguSgQC8
         q9HelmcrU794A+B69aDfRiINtRk93kZHKjPVcUlLr2O4rYUQDjPyrxZeVQXIpNvLjU
         KKw1bCp2NuSRxWBqs7c3awDhRRujHSWv5iq9ISbewom6sIkfMcU4iTE1UOF7LcgJtm
         XIUr/aFCi2uuQ==
Message-ID: <9e22b747-5e59-9a1c-5ff1-fd4f2d6e43fc@kernel.org>
Date:   Mon, 7 Nov 2022 09:25:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] f2fs: fix atgc bug on issue in 32bits platform
Content-Language: en-US
To:     "zhiguo.niu" <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     niuzhiguo84@gmail.com
References: <1667547621-26175-1-git-send-email-zhiguo.niu@unisoc.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1667547621-26175-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/4 15:40, zhiguo.niu wrote:
> From: Zhiguo Niu <zhiguo.niu@unisoc.com>
> 
> There is bug on issue after atgc feature is enabled in
> 32bits platform as the following log:
> 
> F2FS-fs (dm-x): inconsistent rbtree, cur(3470333575168) next(3320009719808)
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/gc.c:602!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> PC is at get_victim_by_default+0x13c0/0x1498
> LR is at f2fs_check_rb_tree_consistence+0xc4/0xd4
> ....
> [<c04d98b0>] (get_victim_by_default) from [<c04d4f44>] (f2fs_gc+0x220/0x6cc)
> [<c04d4f44>] (f2fs_gc) from [<c04d4780>] (gc_thread_func+0x2ac/0x708)
> [<c04d4780>] (gc_thread_func) from [<c015c774>] (kthread+0x1a8/0x1b4)
> [<c015c774>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> 
> The reason is the 64bits key in struct rb_entry has __packed attibute
> but has not in struct victim_entry, so the wrong key value got by
> in f2fs_check_rb_tree_consistence, the following are the memory layouts
> of struct rb_entry and struct victim_entry in 32bits platform:
> 
> struct rb_entry {
>     [0] struct rb_node rb_node;
>         union {
>             struct {...};
>    [12]     unsigned long long key;
>         };
> }
> struct victim_entry {
>     [0] struct rb_node rb_node;
>         union {
>             struct {...};
>    [16]     struct victim_info vi;
>         };
>    [32] struct list_head list;
> }

Shouldn't we add __packed for struct victim_entry?

> 
> This patch fix this inconsistence layout of 64bits key between
> struct rb_entry and struct victim_entry.
> 

Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")

> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

