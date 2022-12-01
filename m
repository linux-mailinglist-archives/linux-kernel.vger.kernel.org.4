Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A5E63E9BC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 07:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLAGPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 01:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLAGPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 01:15:17 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4049EA85DD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 22:15:16 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NN5Q03XVmzmWK0;
        Thu,  1 Dec 2022 14:14:32 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 14:15:14 +0800
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 14:15:13 +0800
Message-ID: <771e309e-d7c6-d4db-ab11-0df05db6b9a0@huawei.com>
Date:   Thu, 1 Dec 2022 14:15:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [syzbot] INFO: task hung in gfs2_gl_hash_clear (3)
Content-Language: en-US
To:     syzbot <syzbot+ed7d0f71a89e28557a77@syzkaller.appspotmail.com>,
        <brauner@kernel.org>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <madvenka@linux.microsoft.com>,
        <scott@os.amperecomputing.com>, <syzkaller-bugs@googlegroups.com>,
        <will@kernel.org>
References: <000000000000d482ba05ee97d4e3@google.com>
CC:     <bobo.shaobowang@huawei.com>, <liwei391@huawei.com>
From:   Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <000000000000d482ba05ee97d4e3@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/29 16:32, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=167aebbb880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=54b747d981acc7b7
> dashboard link: https://syzkaller.appspot.com/bug?extid=ed7d0f71a89e28557a77
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16467353880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168c3d03880000
> 

Fix missing call gfs2_make_fs_ro() int gfs2_put_super()

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
b7b275e60bcd

--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -584,9 +584,7 @@ static void gfs2_put_super(struct super_block *sb)
 	}
 	spin_unlock(&sdp->sd_jindex_spin);

-	if (!sb_rdonly(sb)) {
-		gfs2_make_fs_ro(sdp);
-	}
+	gfs2_make_fs_ro(sdp);
 	WARN_ON(gfs2_withdrawing(sdp));

 	/*  At this point, we're through modifying the disk  */
-- 

