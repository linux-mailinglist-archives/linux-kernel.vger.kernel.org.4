Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555EF71EF6F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjFAQqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjFAQqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:46:32 -0400
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F410194;
        Thu,  1 Jun 2023 09:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=T1roHTPjmO0g3+Z0uzv3Zj96JFrFBt4IsbXooMmUjtE=;
        t=1685637987;x=1685727987; 
        b=DlFOlGhmPtG/QJKYUV3ZJwxY6HeG8o9FGt9bbrBrFWhtrXwixe/9727TnaiTT+tbG1XCWEjO9/W9SGCBuqGmo6dBOM4/gX1kdBjcWZpbmBlrL9/2d2LqyByIZa3/SGtDnJP3Gtfarcq8tLKrsQND5x9nGU9X/HXHsaCCIw/MAB4V+pBCXgCt2xgOEATxftpxp6t5Trx64QbSiWskY31MSjQIpc6hF1VGHMxhkeCcS8YowXN/R8XyFdBHOy1EOrQQ4c3lVOGO9drGtvJGO1RKIP1d5v2g7XpwrVifawJILtJmUpx0v6dOQ3FPhJ5OXLmV4AxvvmmFHc2FdN/G/FKrCQ==;
Received: from [10.12.4.19] (port=43852 helo=smtp43.i.mail.ru)
        by fallback1.i.mail.ru with esmtp (envelope-from <listdansp@mail.ru>)
        id 1q4lRR-00HCIo-2o; Thu, 01 Jun 2023 19:46:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=T1roHTPjmO0g3+Z0uzv3Zj96JFrFBt4IsbXooMmUjtE=;
        t=1685637985;x=1685727985; 
        b=Mz+O061v+PgC/bscJp1ws8v1FNj7nxdMOGPorhRqjgcish1fzFrEQ3N25O6VAqt2iNNYzs8rIc68voW4wO5ltvVmxXBXlHDPIC+5ONHaKB5BkVcUyYei50MHxT0YvDS3+46tP5kS5TimB1BUUz4ti5sk4CCiL0uRiYn/j2N9bn+ImtXzzZfa/TEVIDD0JvqyKDwdzRaGrHWbvTOViptsZRmgKVuLuX3j8skcKLQCy1JDS9Y8B6DES1/bvI8y6l8q7hj253PDGSxvvAC4MoLUmVx9r9ECuyPrduooOLUsHvTeQ9RBl8wIu2WGrpARdp4weiSea9FUkFqrcrjjC4hSMQ==;
Received: by smtp43.i.mail.ru with esmtpa (envelope-from <listdansp@mail.ru>)
        id 1q4lRJ-00HDXO-F3; Thu, 01 Jun 2023 19:46:17 +0300
From:   Danila Chernetsov <listdansp@mail.ru>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Danila Chernetsov <listdansp@mail.ru>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH 5.10 1/1] xfs: verify buffer contents when we skip log replay
Date:   Thu,  1 Jun 2023 16:44:39 +0000
Message-Id: <20230601164439.15404-2-listdansp@mail.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601164439.15404-1-listdansp@mail.ru>
References: <20230601164439.15404-1-listdansp@mail.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD988F25420CCA9469AC4C4DE6D3AF0D4F65E8FFE5E098C4BB3182A05F53808504091861CA6E45DA5F8899C6877C9BC8324BEF10E65185069ACC2B58AF5B9A1C970
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B8387EA37EC1BE7DEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637C904E3CF4B5CD3198638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8511DC7121FE46A914C9E115627CAB46A6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE73CD73D99384BA5CA9FA2833FD35BB23D27C277FBC8AE2E8B9DFFDBF58FA668BFA471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC3F5FF591A31BF75D3AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F7900637210EE2DB3B839582D81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006378C9D910F43C7B6246D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637A2D17A18B0C1A664EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A54FADF2DE468A873F4571F9C29A6D89D6E6B3004FBF29D3E5F87CCE6106E1FC07E67D4AC08A07B9B01DAA61796BF5227B9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF45582A3B8068140C73BF1323C9BA2FD876CA71B6FE38EFA03D6321A566D734CC6BD4E2D2DF3D4047A3AF5313DFD170D7A878DFB0662CECE3CD0ED9B8AF2F3127464E0F6E1F48538C02C26D483E81D6BE1622D42B0D48DA1897021655C84034CFF0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojItsbmePJJf1acTakpvNQ+g==
X-Mailru-Sender: 4CE1109FD677D2770147F6A9E21DCA7B5F0536A82FBE00720F07929CEAD683F637A118895F133E237E3C9C7AF06D9E7B78274A4A9E9E44FD3C3897ABF9FF211DE8284E426C7B2D9A5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4FA5F4CC6668110EA225A1FBE07D3D9FEA5202D7137733572049FFFDB7839CE9EE83D3DC30F0B9ED0C5C9FB8F834D80ECD5BD329B270939A3351E4A410FD92C4A
X-7FA49CB5: 0D63561A33F958A54EC9E4E661877748B19FA4042E8DC4111EB4AFDD721C966CCACD7DF95DA8FC8BD5E8D9A59859A8B658ABFA36AE61EFAF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdZdU6KX1s6V5v8uclVXsAFw==
X-Mailru-MI: C000000000000800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Darrick J. Wong" <djwong@kernel.org>

commit 22ed903eee23a5b174e240f1cdfa9acf393a5210 upstream.

syzbot detected a crash during log recovery:

XFS (loop0): Mounting V5 Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791
XFS (loop0): Torn write (CRC failure) detected at log block 0x180. Truncating head block from 0x200.
XFS (loop0): Starting recovery (logdev: internal)
==================================================================
BUG: KASAN: slab-out-of-bounds in xfs_btree_lookup_get_block+0x15c/0x6d0 fs/xfs/libxfs/xfs_btree.c:1813
Read of size 8 at addr ffff88807e89f258 by task syz-executor132/5074

CPU: 0 PID: 5074 Comm: syz-executor132 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:306
 print_report+0x107/0x1f0 mm/kasan/report.c:417
 kasan_report+0xcd/0x100 mm/kasan/report.c:517
 xfs_btree_lookup_get_block+0x15c/0x6d0 fs/xfs/libxfs/xfs_btree.c:1813
 xfs_btree_lookup+0x346/0x12c0 fs/xfs/libxfs/xfs_btree.c:1913
 xfs_btree_simple_query_range+0xde/0x6a0 fs/xfs/libxfs/xfs_btree.c:4713
 xfs_btree_query_range+0x2db/0x380 fs/xfs/libxfs/xfs_btree.c:4953
 xfs_refcount_recover_cow_leftovers+0x2d1/0xa60 fs/xfs/libxfs/xfs_refcount.c:1946
 xfs_reflink_recover_cow+0xab/0x1b0 fs/xfs/xfs_reflink.c:930
 xlog_recover_finish+0x824/0x920 fs/xfs/xfs_log_recover.c:3493
 xfs_log_mount_finish+0x1ec/0x3d0 fs/xfs/xfs_log.c:829
 xfs_mountfs+0x146a/0x1ef0 fs/xfs/xfs_mount.c:933
 xfs_fs_fill_super+0xf95/0x11f0 fs/xfs/xfs_super.c:1666
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f89fa3f4aca
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd5fb5ef8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00646975756f6e2c RCX: 00007f89fa3f4aca
RDX: 0000000020000100 RSI: 0000000020009640 RDI: 00007fffd5fb5f10
RBP: 00007fffd5fb5f10 R08: 00007fffd5fb5f50 R09: 000000000000970d
R10: 0000000000200800 R11: 0000000000000206 R12: 0000000000000004
R13: 0000555556c6b2c0 R14: 0000000000200800 R15: 00007fffd5fb5f50
 </TASK>

The fuzzed image contains an AGF with an obviously garbage
agf_refcount_level value of 32, and a dirty log with a buffer log item
for that AGF.  The ondisk AGF has a higher LSN than the recovered log
item.  xlog_recover_buf_commit_pass2 reads the buffer, compares the
LSNs, and decides to skip replay because the ondisk buffer appears to be
newer.

Unfortunately, the ondisk buffer is corrupt, but recovery just read the
buffer with no buffer ops specified:

	error = xfs_buf_read(mp->m_ddev_targp, buf_f->blf_blkno,
			buf_f->blf_len, buf_flags, &bp, NULL);

Skipping the buffer leaves its contents in memory unverified.  This sets
us up for a kernel crash because xfs_refcount_recover_cow_leftovers
reads the buffer (which is still around in XBF_DONE state, so no read
verification) and creates a refcountbt cursor of height 32.  This is
impossible so we run off the end of the cursor object and crash.

Fix this by invoking the verifier on all skipped buffers and aborting
log recovery if the ondisk buffer is corrupt.  It might be smarter to
force replay the log item atop the buffer and then see if it'll pass the
write verifier (like ext4 does) but for now let's go with the
conservative option where we stop immediately.

Link: https://syzkaller.appspot.com/bug?extid=7e9494b8b399902e994e
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
---
 fs/xfs/xfs_buf_item_recover.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index b374c9cee117..a053b0bf7930 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -924,6 +924,16 @@ xlog_recover_buf_commit_pass2(
 	if (lsn && lsn != -1 && XFS_LSN_CMP(lsn, current_lsn) >= 0) {
 		trace_xfs_log_recover_buf_skip(log, buf_f);
 		xlog_recover_validate_buf_type(mp, bp, buf_f, NULLCOMMITLSN);
+
+		/*
+		 * We're skipping replay of this buffer log item due to the log
+		 * item LSN being behind the ondisk buffer.  Verify the buffer
+		 * contents since we aren't going to run the write verifier.
+		 */
+		if (bp->b_ops) {
+			bp->b_ops->verify_read(bp);
+			error = bp->b_error;
+		}
 		goto out_release;
 	}
 
-- 
2.25.1

