Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655706F7489
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjEDTvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjEDTtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:49:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29132132B6;
        Thu,  4 May 2023 12:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2B0E63799;
        Thu,  4 May 2023 19:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F174C433A8;
        Thu,  4 May 2023 19:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229567;
        bh=8PAcPdtGigjTmyNmB4KjebzR1n76DZ7lYtf9FipWSvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMUtKvaz6ZgF+ukHJvU1hZ0IN4ccSDxqMgWO459krC9Hogqrg65jDv+3c5BTRiJQt
         +5lP2tii6xkGATx/XXl+/S0VhRInQnmp6EQFjsDay4ECioHIEi+LDsOK5E4UL27QYS
         pL6CGxKrr/6WiMHf4N83R1gv3zuFH4ImF0Cyi0h+Nk4c+dI24aHa4Tom+JXaynDZub
         zm57NJGOPjdDFu88tsuG3JpkQc37e9+tkPZKY8iqkruLwLyXTO0dn9ELIDjc3zNuQE
         ZRE+p2gRPKdHwsZNrZX6u8pryhvGjO4hlR2jg8tV14LSeIoIoNRPBQQpr72fqbj60d
         jc54Z8YIzW4sg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhong Jinghua <zhongjinghua@huawei.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 6.2 42/53] nbd: fix incomplete validation of ioctl arg
Date:   Thu,  4 May 2023 15:44:02 -0400
Message-Id: <20230504194413.3806354-42-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194413.3806354-1-sashal@kernel.org>
References: <20230504194413.3806354-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhong Jinghua <zhongjinghua@huawei.com>

[ Upstream commit 55793ea54d77719a071b1ccc05a05056e3b5e009 ]

We tested and found an alarm caused by nbd_ioctl arg without verification.
The UBSAN warning calltrace like below:

UBSAN: Undefined behaviour in fs/buffer.c:1709:35
signed integer overflow:
-9223372036854775808 - 1 cannot be represented in type 'long long int'
CPU: 3 PID: 2523 Comm: syz-executor.0 Not tainted 4.19.90 #1
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x3f0 arch/arm64/kernel/time.c:78
 show_stack+0x28/0x38 arch/arm64/kernel/traps.c:158
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x170/0x1dc lib/dump_stack.c:118
 ubsan_epilogue+0x18/0xb4 lib/ubsan.c:161
 handle_overflow+0x188/0x1dc lib/ubsan.c:192
 __ubsan_handle_sub_overflow+0x34/0x44 lib/ubsan.c:206
 __block_write_full_page+0x94c/0xa20 fs/buffer.c:1709
 block_write_full_page+0x1f0/0x280 fs/buffer.c:2934
 blkdev_writepage+0x34/0x40 fs/block_dev.c:607
 __writepage+0x68/0xe8 mm/page-writeback.c:2305
 write_cache_pages+0x44c/0xc70 mm/page-writeback.c:2240
 generic_writepages+0xdc/0x148 mm/page-writeback.c:2329
 blkdev_writepages+0x2c/0x38 fs/block_dev.c:2114
 do_writepages+0xd4/0x250 mm/page-writeback.c:2344

The reason for triggering this warning is __block_write_full_page()
-> i_size_read(inode) - 1 overflow.
inode->i_size is assigned in __nbd_ioctl() -> nbd_set_size() -> bytesize.
We think it is necessary to limit the size of arg to prevent errors.

Moreover, __nbd_ioctl() -> nbd_add_socket(), arg will be cast to int.
Assuming the value of arg is 0x80000000000000001) (on a 64-bit machine),
it will become 1 after the coercion, which will return unexpected results.

Fix it by adding checks to prevent passing in too large numbers.

Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/r/20230206145805.2645671-1-zhongjinghua@huawei.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 592cfa8b765a5..e1c954094b6c0 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -325,6 +325,9 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 	if (blk_validate_block_size(blksize))
 		return -EINVAL;
 
+	if (bytesize < 0)
+		return -EINVAL;
+
 	nbd->config->bytesize = bytesize;
 	nbd->config->blksize_bits = __ffs(blksize);
 
@@ -1111,6 +1114,9 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	struct nbd_sock *nsock;
 	int err;
 
+	/* Arg will be cast to int, check it to avoid overflow */
+	if (arg > INT_MAX)
+		return -EINVAL;
 	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
-- 
2.39.2

