Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CB66F445B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjEBMzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjEBMzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:55:04 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1217CE
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SG6So
        /JBg3TDLBHEwTKwAjabX9LbfnrKlI2nbqf0u0w=; b=m/3BIvfWsGH+nVxeDbk1g
        b2q4SmpOHQkpY9H33y2B7X0yP7sk2X1q80qwvZ6cWp7jWdjlRZzzaPzYmPYnlCMH
        HJrW7bazcSzQ/LdNb+iaXKn3TAeYg8BaiGqOpjX+h9PhgeGrS6Wy/mbVlEyCvZNV
        AhiMxYFmaGbxFpxkNoj02M=
Received: from jiwei-VirtualBox.lenovo.com (unknown [120.244.62.151])
        by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wA3j_j2B1FkHgLfAA--.26065S2;
        Tue, 02 May 2023 20:54:15 +0800 (CST)
From:   jiweisun126@126.com
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        ahuang12@lenovo.com, sunjw10@lenovo.com, jiweisun126@126.com
Subject: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Date:   Tue,  2 May 2023 20:54:12 +0800
Message-Id: <20230502125412.65633-1-jiweisun126@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3j_j2B1FkHgLfAA--.26065S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XF1fJryxZrWkWw1fWFy8Xwb_yoW3Jr17pr
        4UX348Cr4xW3W7Zr47JF4UZ3ZrXwnrA3WUXr47Ar93JF18W3s8Xr4UXr4Utr15Gws5Zry3
        t3Z8Zw1IqryDKaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEG-niUUUUU=
X-Originating-IP: [120.244.62.151]
X-CM-SenderInfo: 5mlzvxpvxqijaw6rjloofrz/1tbiXxpjjWIxn-v56gAAsP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiwei Sun <sunjw10@lenovo.com>

A soft lockup issue will be triggered when do fio test on a 448-core
server, such as the following warning:

[  519.743511] watchdog: BUG: soft lockup - CPU#305 stuck for 144s! [fio:11226]
[  519.744834] CPU: 305 PID: 11226 Comm: fio Kdump: loaded Tainted: G             L     6.3.0 #48
[  519.744850] Hardware name: Lenovo ThinkSystem SR645 V3 MB,Genoa,DDR5,Oahu,1U/SB27B31174, BIOS KAE111F-2.10 04/17/2023
[  519.744867] RIP: 0010:__do_softirq+0x93/0x2d3
[  519.744901] Code: c3 c0 5a ff c7 44 24 08 0a 00 00 00 48 c7 c7 45 6b c5 a0 e8 1f ac fe ff 65 66 c7 05 dd 76 a8 5f 00 00 fb 49 c7 c2 c0 60 20 a1 <eb> 70 48 98 48 c7 c7 f8 fc c5 a0 4d 8d 3c c2 4c 89 fd 48 81 ed c0
[  519.744916] RSP: 0018:ff6e423a8b584fa0 EFLAGS: 00000202
[  519.744944] RAX: 0000000000000131 RBX: ff3143f856cd3f80 RCX: 0000000000000000
[  519.744959] RDX: 000000562c5e4652 RSI: ffffffffa0c56b45 RDI: ffffffffa0c35ab3
[  519.744974] RBP: 0000000000000000 R08: 0000000000000b01 R09: 0000000000031600
[  519.744988] R10: ffffffffa12060c0 R11: 00000054ea7837c0 R12: 0000000000000080
[  519.745003] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  519.745017] FS:  00007fa41bb9e000(0000) GS:ff3143f7af840000(0000) knlGS:0000000000000000
[  519.745032] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  519.745046] CR2: 00007fa3fc05b000 CR3: 00000008d6f56004 CR4: 0000000000771ee0
[  519.745060] PKRU: 55555554
[  519.745075] Call Trace:
[  519.745095]  <IRQ>
[  519.745160]  ? ftrace_regs_caller_end+0x61/0x61
[  519.745185]  irq_exit_rcu+0xcd/0x100
[  519.745217]  sysvec_apic_timer_interrupt+0xa2/0xd0
[  519.745251]  </IRQ>
[  519.745265]  <TASK>
[  519.745292]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  519.745318] RIP: 0010:_raw_spin_unlock_irqrestore+0x1d/0x40
[  519.745339] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa e8 77 9b 0b 20 c6 07 00 0f 1f 00 f7 c6 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> be 65 58 ff 65 8b 05 9f 81 a8 5f 85 c0 74 05 c3 cc cc cc cc 0f
[  519.745354] RSP: 0018:ff6e423b244279f0 EFLAGS: 00000206
[  519.745381] RAX: 000000098b346200 RBX: ff3143f0f0fccc00 RCX: 0000000000000286
[  519.745396] RDX: 0000000000000700 RSI: 0000000000000286 RDI: 0000000000000001
[  519.745410] RBP: ff3143f835e5c600 R08: 000000058bb02000 R09: 0000000000000000
[  519.745424] R10: 00000107d08ab6ea R11: 0000000000000800 R12: 0000000000000820
[  519.745438] R13: ff3143f835e5c610 R14: ff6e423b24427a50 R15: ff3143f90b346200
[  519.745576]  dma_pool_alloc+0x184/0x200
[  519.745647]  nvme_prep_rq.part.58+0x416/0x840 [nvme]
[  519.745760]  nvme_queue_rq+0x7b/0x210 [nvme]
[  519.745821]  __blk_mq_try_issue_directly+0x153/0x1c0
[  519.745906]  blk_mq_try_issue_directly+0x15/0x50
[  519.745935]  blk_mq_submit_bio+0x4c4/0x510
[  519.746047]  submit_bio_noacct_nocheck+0x331/0x370
[  519.746135]  blkdev_direct_IO.part.22+0x138/0x5b0
[  519.746165]  ? __fsnotify_parent+0x119/0x350
[  519.746274]  blkdev_read_iter+0xe3/0x170
[  519.746325]  aio_read+0xf6/0x1b0
[  519.746423]  ? 0xffffffffc066309b
[  519.746567]  ? io_submit_one+0x18c/0xd60
[  519.746587]  ? aio_read+0x5/0x1b0
[  519.746608]  io_submit_one+0x18c/0xd60
[  519.746672]  ? __x64_sys_io_submit+0x4/0x180
[  519.746794]  ? __x64_sys_io_submit+0x93/0x180
[  519.746815]  __x64_sys_io_submit+0x93/0x180
[  519.746838]  ? __pfx___x64_sys_io_submit+0x10/0x10
[  519.746923]  do_syscall_64+0x3b/0x90
[  519.746958]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  519.746983] RIP: 0033:0x7fa41b83ee5d
[  519.747009] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[  519.747024] RSP: 002b:00007fff698e8cc8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
[  519.747053] RAX: ffffffffffffffda RBX: 00007fa41bb9df70 RCX: 00007fa41b83ee5d
[  519.747067] RDX: 000055a53098ba68 RSI: 0000000000000001 RDI: 00007fa3fc05b000
[  519.747082] RBP: 00007fa3fc05b000 R08: 0000000000000000 R09: 0000000000000048
[  519.747095] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[  519.747110] R13: 0000000000000000 R14: 000055a53098ba68 R15: 000055a530989440
[  519.747245]  </TASK>

and we have collected the corresponding ftrace log,
  515.948558 |   305)               |              nvme_irq [nvme]() {
+--1503 lines: 515.948560 |   305)               |                blk_mq_complete_request_remote() {---
  515.948995 |   305)               |                nvme_pci_complete_batch [nvme]() {
  515.948996 |   305)               |                  nvme_unmap_data [nvme]() {
+--  3 lines: 515.948996 |   305)               |                    dma_unmap_sg_attrs() {---
  515.948997 |   305)               |                    dma_pool_free() {
  515.948997 |   305)               |                      _raw_spin_lock_irqsave() {
  515.948997 |   305)   0.190 us    |                        preempt_count_add();
  515.948999 |   305) * 14893.70 us |                        native_queued_spin_lock_slowpath();
  515.963893 |   305) * 14895.59 us |                      }
  515.963929 |   305)               |                      _raw_spin_unlock_irqrestore() {
  515.963930 |   305)   0.160 us    |                        preempt_count_sub();
  515.963930 |   305)   1.011 us    |                      }
  515.963931 |   305) * 14933.71 us |                    }
+--  9 lines: 515.963931 |   305)               |                    mempool_free() {---
  515.963933 |   305) * 14937.45 us |                  }
  515.963933 |   305)   0.160 us    |                  nvme_complete_batch_req [nvme_core]();
  515.963934 |   305)               |                  nvme_unmap_data [nvme]() {
+--  3 lines: 515.963934 |   305)               |                    dma_unmap_sg_attrs() {---
  515.963935 |   305)               |                    dma_pool_free() {
  515.963935 |   305)               |                      _raw_spin_lock_irqsave() {
  515.963936 |   305)   0.170 us    |                        preempt_count_add();
  515.963936 |   305) * 19865.82 us |                        native_queued_spin_lock_slowpath();
  515.983803 |   305) * 19867.21 us |                      }
  515.983833 |   305)               |                      _raw_spin_unlock_irqrestore() {
  515.983833 |   305)   0.200 us    |                        preempt_count_sub();
  515.983834 |   305)   1.312 us    |                      }
  515.983834 |   305) * 19898.71 us |                    }
+--- 11 lines: 515.983834 |   305)               |                    mempool_free() {---
  515.983837 |   305) * 19902.73 us |                  }
  515.983837 |   305)   0.170 us    |                  nvme_complete_batch_req [nvme_core]();
+--40055 lines: 515.983837 |   305)               |                  nvme_unmap_data [nvme]() {---
  520.816867 |   305) $ 4867871 us  |                }
  520.816867 |   305) $ 4868309 us  |              }
  520.816868 |   305) $ 4868310 us  |            }

According to the above two logs, we can know the nvme_irq() cost too much
time, in the above case, about 4.8 second. And we can also know that the
main bottlenecks is in the competition for the spin lock pool->lock.

In order to avoid the lockup log, we can enable the nvme irq threading
by adding nvme.use_threaded_interrupts=1 in cmdline and with preempt=full,
but for the kernel with preempt=off, the nvme.use_threaded_interrupts=1
will fail. So, we can add cond_resched() in the loops of the
nvme_complete_batch().

Reviewed-by: Adrian Huang <ahuang12@lenovo.com>
Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
---
 drivers/nvme/host/nvme.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..e247cb664e9e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -725,6 +725,7 @@ static __always_inline void nvme_complete_batch(struct io_comp_batch *iob,
 	rq_list_for_each(&iob->req_list, req) {
 		fn(req);
 		nvme_complete_batch_req(req);
+		cond_resched();
 	}
 	blk_mq_end_request_batch(iob);
 }
-- 
2.27.0

