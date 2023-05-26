Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F79712720
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243505AbjEZM7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjEZM7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:59:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0D4116
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:59:17 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QSQ1C4V6QzsSFn;
        Fri, 26 May 2023 20:57:03 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 20:59:12 +0800
Message-ID: <d127a181-b734-a6b1-5752-b8597f6adc92@huawei.com>
Date:   Fri, 26 May 2023 20:59:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [syzbot] [damon?] divide error in damon_set_attrs
Content-Language: en-US
To:     syzbot <syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com>,
        <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <sj@kernel.org>, <syzkaller-bugs@googlegroups.com>
References: <00000000000055fc4e05fc975bc2@google.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <00000000000055fc4e05fc975bc2@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/26 19:51, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    44c026a73be8 Linux 6.4-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a92b31280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f389ffdf4e9ba3f0
> dashboard link: https://syzkaller.appspot.com/bug?extid=841a46899768ec7bec67
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/35f16ee05df7/disk-44c026a7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/10399498a570/vmlinux-44c026a7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5c72201ea4ba/bzImage-44c026a7.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com
> 
> divide error: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 13527 Comm: syz-executor.1 Not tainted 6.4.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
> RIP: 0010:damon_nr_accesses_to_accesses_bp mm/damon/core.c:491 [inline]
> RIP: 0010:damon_nr_accesses_for_new_attrs mm/damon/core.c:497 [inline]
> RIP: 0010:damon_update_monitoring_result mm/damon/core.c:506 [inline]
> RIP: 0010:damon_update_monitoring_results mm/damon/core.c:534 [inline]
> RIP: 0010:damon_set_attrs+0x224/0x460 mm/damon/core.c:555

make aggr_interval great than or equal sample_interval?

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d9ef62047bf5..6fe1960f3d6b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -525,8 +525,8 @@ static void damon_update_monitoring_results(struct 
damon_ctx *ctx,

         /* if any interval is zero, simply forgive conversion */
         if (!old_attrs->sample_interval || !old_attrs->aggr_interval ||
-                       !new_attrs->sample_interval ||
-                       !new_attrs->aggr_interval)
+           !new_attrs->sample_interval || !new_attrs->aggr_interval ||
+           new_attrs->aggr_interval < new_attrs->sample_interval)
                 return;
