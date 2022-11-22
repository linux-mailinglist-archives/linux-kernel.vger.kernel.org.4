Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3254C633BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiKVL6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiKVL6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:58:12 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F54811A20
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:58:03 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NGjRw2C5Kz15Mp6;
        Tue, 22 Nov 2022 19:57:32 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 19:58:01 +0800
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 19:58:01 +0800
Message-ID: <55a7be14-6ebc-2ee8-34a2-98781b32e29c@huawei.com>
Date:   Tue, 22 Nov 2022 19:57:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [syzbot] KASAN: use-after-free Write in expire_timers
Content-Language: en-US
To:     syzbot <syzbot+38ee3533e07da8749f85@syzkaller.appspotmail.com>,
        <arnd@arndb.de>, <catalin.marinas@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
        <will@kernel.org>, <zhengqi.arch@bytedance.com>,
        "liwei (GF)" <liwei391@huawei.com>
References: <0000000000006ca1a705edff52cf@google.com>
From:   Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <0000000000006ca1a705edff52cf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/22 2:35, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b6e7fdfd6f6a Merge tag 'iommu-fixes-v6.1-rc5' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11c28f95880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=95fb379f123ba8ce
> dashboard link: https://syzkaller.appspot.com/bug?extid=38ee3533e07da8749f85
> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64

Fix data race between virtual_ncidev_close() and virtual_ncidev_open().

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
b6e7fdfd6f6a

--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -161,12 +161,8 @@ static int virtual_ncidev_close(struct inode *inode,
struct file *file)

    if (state == virtual_ncidev_enabled) {
        state = virtual_ncidev_disabling;
-       mutex_unlock(&nci_mutex);
-
        nci_unregister_device(ndev);
        nci_free_device(ndev);
-
-       mutex_lock(&nci_mutex);
    }

    state = virtual_ncidev_disabled;
-- 
