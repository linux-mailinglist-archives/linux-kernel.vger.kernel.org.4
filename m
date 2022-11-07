Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6742861F693
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiKGOvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiKGOve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:51:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB171A817
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:51:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F07FB61146
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B22CC433C1;
        Mon,  7 Nov 2022 14:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667832692;
        bh=FkN6S5b4LUuRdRi3lyMah/SfaGO7kTVajUyQza/pc8I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rpDPq3JIJCrAO+SoKiIixRKufJ/gDJ/BfaEYaECxpcNsLVY8SEHgxbO2cOb1pIR+k
         degcjVUP2oDTKKNv1sb8qW2gZ6ebMNsb3OkaSpje6OBchvRLELT26GIp8YXxaaJi7B
         Xjc1U5suralpSoh/aOLdzw/vpksdt/kSxzcYOd8ImG3RuXoKYfTnxn1dgOHmKvztIG
         vKmN4XwScwmZwB85NT5mSn6vdXXBnTFxjBAjfJUyrrRbrYNeI85IlChfe736xnIYeP
         9mc1r3PmbRmBWbCxs38RSb9sXeSNwZantKWcTJJ0L9L5TlDiU4vCZ9V0rqRN9Yvfqw
         YjgVhpbyDMseQ==
Message-ID: <33a06664-cfad-f8dc-e11e-58106bfa1890@kernel.org>
Date:   Mon, 7 Nov 2022 22:51:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] f2fs: fix atgc bug on issue in 32bits platform
Content-Language: en-US
To:     Zhiguo Niu <niuzhiguo84@gmail.com>
Cc:     "zhiguo.niu" <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1667547621-26175-1-git-send-email-zhiguo.niu@unisoc.com>
 <9e22b747-5e59-9a1c-5ff1-fd4f2d6e43fc@kernel.org>
 <CAHJ8P3KGTJgvde2V-75XNcZHzbQrkFzDN5sY9r75rp8JBGC_PA@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3KGTJgvde2V-75XNcZHzbQrkFzDN5sY9r75rp8JBGC_PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/7 13:04, Zhiguo Niu wrote:
> Dear Chao
> 
> Chao Yu <chao@kernel.org <mailto:chao@kernel.org>> 于2022年11月7日周一 09:25写道：
> 
>     On 2022/11/4 15:40, zhiguo.niu wrote:
>      > From: Zhiguo Niu <zhiguo.niu@unisoc.com <mailto:zhiguo.niu@unisoc.com>>
>      >
>      > There is bug on issue after atgc feature is enabled in
>      > 32bits platform as the following log:
>      >
>      > F2FS-fs (dm-x): inconsistent rbtree, cur(3470333575168) next(3320009719808)
>      > ------------[ cut here ]------------
>      > kernel BUG at fs/f2fs/gc.c:602!
>      > Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>      > PC is at get_victim_by_default+0x13c0/0x1498
>      > LR is at f2fs_check_rb_tree_consistence+0xc4/0xd4
>      > ....
>      > [<c04d98b0>] (get_victim_by_default) from [<c04d4f44>] (f2fs_gc+0x220/0x6cc)
>      > [<c04d4f44>] (f2fs_gc) from [<c04d4780>] (gc_thread_func+0x2ac/0x708)
>      > [<c04d4780>] (gc_thread_func) from [<c015c774>] (kthread+0x1a8/0x1b4)
>      > [<c015c774>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
>      >
>      > The reason is the 64bits key in struct rb_entry has __packed attibute
>      > but has not in struct victim_entry, so the wrong key value got by
>      > in f2fs_check_rb_tree_consistence, the following are the memory layouts
>      > of struct rb_entry and struct victim_entry in 32bits platform:
>      >
>      > struct rb_entry {
>      >     [0] struct rb_node rb_node;
>      >         union {
>      >             struct {...};
>      >    [12]     unsigned long long key;
>      >         };
>      > }
>      > struct victim_entry {
>      >     [0] struct rb_node rb_node;
>      >         union {
>      >             struct {...};
>      >    [16]     struct victim_info vi;
>      >         };
>      >    [32] struct list_head list;
>      > }
> 
>     Shouldn't we add __packed for struct victim_entry?
> 
>   I try to keep it consistent with struct rb_entry (__packed is only added to union for 64bits key),
> victim_entry.vi.mtime is used to store the key, and rb_entry.key is used to verify the key,
> so make sure that the memory offsets of the 64 bits key in these two structures are the same.
> Other members of victim_entry, such as list, i think there is no problem because of it storaged and loaded
> are both based on struct victim_entry

I'm not sure, there will be any further update in struct rb_node and
struct list_head later, so, IMO, it will be more safe to add __packed to
align all fields in structure to byte.

Thanks,

> 
>      >
>      > This patch fix this inconsistence layout of 64bits key between
>      > struct rb_entry and struct victim_entry.
>      >
> 
>     Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
> 
>      > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com <mailto:zhiguo.niu@unisoc.com>>
> 
