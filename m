Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9EE6097CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 03:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJXBbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 21:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJXBbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 21:31:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF9E6B16B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 18:31:50 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mwcqk2vXkz15M1S;
        Mon, 24 Oct 2022 09:26:58 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 09:31:48 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 09:31:47 +0800
Subject: Re: [PATCH] ubifs: Fix memory leak in alloc_wbufs()
To:     Li Zetao <lizetao1@huawei.com>, <richard@nod.at>,
        <Artem.Bityutskiy@nokia.com>, <ext-adrian.hunter@nokia.com>
CC:     <yi.zhang@huawei.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221022115211.1969429-1-lizetao1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f4a4e992-9efd-b4ca-1788-efe99e4b7d87@huawei.com>
Date:   Mon, 24 Oct 2022 09:31:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20221022115211.1969429-1-lizetao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2022/10/22 19:52, Li Zetao Ð´µÀ:
> kmemleak reported a sequence of memory leaks, and show them as following:
> 
>    unreferenced object 0xffff8881575f8400 (size 1024):
>      comm "mount", pid 19625, jiffies 4297119604 (age 20.383s)
>      hex dump (first 32 bytes):
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      backtrace:
>        [<ffffffff8176cecd>] __kmalloc+0x4d/0x150
>        [<ffffffffa0406b2b>] ubifs_mount+0x307b/0x7170 [ubifs]
>        [<ffffffff819fa8fd>] legacy_get_tree+0xed/0x1d0
>        [<ffffffff81936f2d>] vfs_get_tree+0x7d/0x230
>        [<ffffffff819b2bd4>] path_mount+0xdd4/0x17b0
>        [<ffffffff819b37aa>] __x64_sys_mount+0x1fa/0x270
>        [<ffffffff83c14295>] do_syscall_64+0x35/0x80
>        [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
>    unreferenced object 0xffff8881798a6e00 (size 512):
>      comm "mount", pid 19677, jiffies 4297121912 (age 37.816s)
>      hex dump (first 32 bytes):
>        6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
>        6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
>      backtrace:
>        [<ffffffff8176cecd>] __kmalloc+0x4d/0x150
>        [<ffffffffa0418342>] ubifs_wbuf_init+0x52/0x480 [ubifs]
>        [<ffffffffa0406ca5>] ubifs_mount+0x31f5/0x7170 [ubifs]
>        [<ffffffff819fa8fd>] legacy_get_tree+0xed/0x1d0
>        [<ffffffff81936f2d>] vfs_get_tree+0x7d/0x230
>        [<ffffffff819b2bd4>] path_mount+0xdd4/0x17b0
>        [<ffffffff819b37aa>] __x64_sys_mount+0x1fa/0x270
>        [<ffffffff83c14295>] do_syscall_64+0x35/0x80
>        [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> The problem is that the ubifs_wbuf_init() returns an error in the
> loop which in the alloc_wbufs(), then the wbuf->buf and wbuf->inodes
> that were successfully alloced before are not freed.
> 
> Fix it by adding error hanging path in alloc_wbufs() which frees
> the memory alloced before when ubifs_wbuf_init() returns an error.
> 
> Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>   fs/ubifs/super.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

