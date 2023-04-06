Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423CF6D8D1B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjDFB5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjDFB5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:57:03 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D02769E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:57:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PsPkd0RQsz4f3nqD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:56:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyHoJi5kX936GA--.31319S4;
        Thu, 06 Apr 2023 09:56:58 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     dennis@kernel.org, tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     linux-kernel@vger.kernel.org, dchinner@redhat.com,
        yebin10@huawei.com, yebin@huaweicloud.com
Subject: [PATCH v2 0/2] fix dying cpu compare race
Date:   Thu,  6 Apr 2023 09:56:27 +0800
Message-Id: <20230406015629.1804722-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=a
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyHoJi5kX936GA--.31319S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
        Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21le4C262xC7I0v67AE
        wI8IwI1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I
        8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I2
        1c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6I8I3I0E14AKx2
        xKxVC2ax8xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr0_Jr4lx4CE17CEb7AF67AKxVWUtVW8Zw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU
        oOJ5UUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.1 required=5.0 tests=KHOP_HELO_FCRDNS,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

This patch set solve race between  '__percpu_counter_compare()' and cpu offline.
Before commit 5825bea05265("xfs: __percpu_counter_compare() inode count debug too expensive").
I got issue as follows when do cpu online/offline test:
smpboot: CPU 1 is now offline
XFS: Assertion failed: percpu_counter_compare(&mp->m_ifree, 0) >= 0, file: fs/xfs/xfs_trans.c, line: 622
------------[ cut here ]------------
kernel BUG at fs/xfs/xfs_message.c:110!
invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 3 PID: 25512 Comm: fsstress Not tainted 5.10.0-04288-gcb31bdc8c65d #8
RIP: 0010:assfail+0x77/0x8b fs/xfs/xfs_message.c:110
RSP: 0018:ffff88810a5df5c0 EFLAGS: 00010293
RAX: ffff88810f3a8000 RBX: 0000000000000201 RCX: ffffffffaa8bd7c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: ffff88810f3a8000 R09: ffffed103edf71cd
R10: ffff8881f6fb8e67 R11: ffffed103edf71cc R12: ffffffffab0108c0
R13: ffffffffab010220 R14: ffffffffffffffff R15: 0000000000000000
FS:  00007f8536e16b80(0000) GS:ffff8881f6f80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005617e1115f44 CR3: 000000015873a005 CR4: 0000000000370ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 xfs_trans_unreserve_and_mod_sb+0x833/0xca0 fs/xfs/xfs_trans.c:622
 xlog_cil_commit+0x1169/0x29b0 fs/xfs/xfs_log_cil.c:1325
 __xfs_trans_commit+0x2c0/0xe20 fs/xfs/xfs_trans.c:889
 xfs_create_tmpfile+0x6a6/0x9a0 fs/xfs/xfs_inode.c:1320
 xfs_rename_alloc_whiteout fs/xfs/xfs_inode.c:3193 [inline]
 xfs_rename+0x58a/0x1e00 fs/xfs/xfs_inode.c:3245
 xfs_vn_rename+0x28e/0x410 fs/xfs/xfs_iops.c:436
 vfs_rename+0x10b5/0x1dd0 fs/namei.c:4329
 do_renameat2+0xa19/0xb10 fs/namei.c:4474
 __do_sys_renameat2 fs/namei.c:4512 [inline]
 __se_sys_renameat2 fs/namei.c:4509 [inline]
 __x64_sys_renameat2+0xe4/0x120 fs/namei.c:4509
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7f853623d91d

I can reproduce above issue by injecting kernel latency to invalidate the quick
judgment of “__percpu_counter_compare()”.
For quick judgment logic, the number of CPUs may have decreased before calling
percpu_counter_cpu_dead() when concurrent with CPU offline. That leads to
calculation errors. For example:
Assumption:
(1) batch = 32
(2) The final count is 2
(3) The number of CPUs is 4
If the number of percpu variables on each CPU is as follows when CPU3 is offline:
 cpu0   cpu1   cpu2  cpu3
  31     31     31    31
 fbc->count = -122 -> 'percpu_counter_cpu_dead()' isn't called.
So at this point, check if percpu counter is greater than 0.
 abs(count - rhs) = -122
 batch * num_ online_ cpus() = 32 * 3 = 96 -> Online CPUs number become 3
That is: abs (count rhs) > batch * num_online_cpus() condition met. The actual
value is 2, but the fact that count<0 returns -1 is the opposite.

Ye Bin (2):
  cpu/hotplug: introduce 'num_dying_cpus' to get dying CPUs count
  lib/percpu_counter: fix dying cpu compare race

 include/linux/cpumask.h | 20 ++++++++++++++++----
 kernel/cpu.c            |  2 ++
 lib/percpu_counter.c    | 11 ++++++++++-
 3 files changed, 28 insertions(+), 5 deletions(-)

-- 
2.31.1

