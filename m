Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66FD5F3290
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJCPez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJCPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E887ABC1F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664811286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqsEWenkkxG3d+8eGwddnf9BdMPGOTzm3zE5yD9Z50g=;
        b=F7q0vM1IHMXtcZoZgor2Q6jk8L8z4SvW4UgbCzLbMo+SOneUoIBmKdUxKumEipi5ZBIqOp
        SckaFy3Fz6TgXvStojoSaXEJ3wk/AXeXyOB/Uj7ClTBYgJ2LvBHPJCK9DPHyk485+K9VF2
        OvmSTXZHDjJj3ZoMCNUgIwDMEay/6qc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-204-8m_4FXIZM66AvSNZ0HIAqQ-1; Mon, 03 Oct 2022 11:34:45 -0400
X-MC-Unique: 8m_4FXIZM66AvSNZ0HIAqQ-1
Received: by mail-wm1-f69.google.com with SMTP id v5-20020a1cac05000000b003b884c5b09eso2745921wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eqsEWenkkxG3d+8eGwddnf9BdMPGOTzm3zE5yD9Z50g=;
        b=ZGc4oi8+XJ6gF+GCYMYw6sOv1f08MUs53nKN99yzWibguwcqD6lYqZUNRI8Q6FKEXj
         w5PGwsnWkd/JgUEbvrUDqRzn3TcXsnL3gdkV9PxilrsRFfnPByoyHV1j5EOZ1/kLeVSc
         LnvQ2uZ0a3mODIZ+Tuy6bYVOx081sLai0gtKlA9SZlYwJgeUrpqbU8Ilixj5md1/UbQ2
         oVDMTBykYSbsDTdRxYMDHJwBvzjOVtUIgqL4MbYEjUkHQXCVO2iXZEuX0MVTuGDdea81
         IOO0SdPWm+q4LIOAI3nOAQFsVFslS/Zc+DcfHqorv6hU+I3+bCIR9j6tEZvrkZc9MyDa
         HeAA==
X-Gm-Message-State: ACrzQf3l0bnk07gDbAWPnk0w/0V4hPFq/CakQFSw+LR5QLqCKLiRWUXU
        IZ74rO0SVegiTfbD7xxgQcUamq7LbTv3iWiP3P0tvfKF0ToVBu6qgeVkzJi6eqM93eZZPUsDc16
        oRzvRWVnJ+VPQj+DC2IF6F0T6
X-Received: by 2002:a05:600c:3511:b0:3b4:bb85:f1e3 with SMTP id h17-20020a05600c351100b003b4bb85f1e3mr7402326wmq.0.1664811282665;
        Mon, 03 Oct 2022 08:34:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6N/tiZtv+buwIsgJCAUILRSHo8cXt2iCO72yhosTjOIvYDphNYg9irITQGmr5FDL9l4PDtEg==
X-Received: by 2002:a05:600c:3511:b0:3b4:bb85:f1e3 with SMTP id h17-20020a05600c351100b003b4bb85f1e3mr7402314wmq.0.1664811282459;
        Mon, 03 Oct 2022 08:34:42 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a5c244fc13sm18343151wms.2.2022.10.03.08.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:34:41 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH bitmap-for-next 1/5] blk_mq: Fix cpumask_check() warning in blk_mq_hctx_next_cpu()
Date:   Mon,  3 Oct 2022 16:34:16 +0100
Message-Id: <20221003153420.285896-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221003153420.285896-1-vschneid@redhat.com>
References: <20221003153420.285896-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent commit made cpumask_next*() trigger a warning when passed
n = nr_cpu_ids - 1. This means extra care must be taken when feeding CPU
numbers back into cpumask_next*().

The warning occurs nearly every boot on QEMU:

[    5.398453] WARNING: CPU: 3 PID: 162 at include/linux/cpumask.h:110 __blk_mq_delay_run_hw_queue+0x16b/0x180
[    5.399317] Modules linked in:
[    5.399646] CPU: 3 PID: 162 Comm: ssh-keygen Tainted: G                 N 6.0.0-rc4-00004-g93003cb24006 #55
[    5.400135] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[    5.405430] Call Trace:
[    5.406152]  <TASK>
[    5.406452]  blk_mq_sched_insert_requests+0x67/0x150
[    5.406759]  blk_mq_flush_plug_list+0xd0/0x280
[    5.406987]  ? bit_wait+0x60/0x60
[    5.407317]  __blk_flush_plug+0xdb/0x120
[    5.407561]  ? bit_wait+0x60/0x60
[    5.407765]  io_schedule_prepare+0x38/0x40
[    5.407974]  io_schedule+0x6/0x40
[    5.408283]  bit_wait_io+0x8/0x60
[    5.408485]  __wait_on_bit+0x72/0x90
[    5.408668]  out_of_line_wait_on_bit+0x8c/0xb0
[    5.408879]  ? swake_up_one+0x30/0x30
[    5.409158]  ext4_read_bh+0x7a/0x80
[    5.409381]  ext4_get_branch+0xc0/0x130
[    5.409583]  ext4_ind_map_blocks+0x1ac/0xb30
[    5.409844]  ? __es_remove_extent+0x61/0x6d0
[    5.410128]  ? blk_account_io_merge_bio+0x67/0xd0
[    5.410416]  ? percpu_counter_add_batch+0x59/0xb0
[    5.410720]  ? percpu_counter_add_batch+0x59/0xb0
[    5.410949]  ? _raw_read_unlock+0x13/0x30
[    5.411323]  ext4_map_blocks+0xc2/0x590
[    5.411609]  ? xa_load+0x7c/0xa0
[    5.411859]  ext4_mpage_readpages+0x4a2/0xaa0
[    5.412192]  read_pages+0x69/0x2b0
[    5.412477]  ? folio_add_lru+0x4f/0x70
[    5.412696]  page_cache_ra_unbounded+0x11d/0x170
[    5.412960]  filemap_get_pages+0x109/0x5d0
[    5.413340]  ? __vma_adjust+0x348/0x930
[    5.413576]  filemap_read+0xb7/0x380
[    5.413805]  ? vma_merge+0x2e9/0x330
[    5.414067]  ? vma_set_page_prot+0x43/0x80
[    5.414309]  ? __inode_security_revalidate+0x5e/0x80
[    5.414581]  ? selinux_file_permission+0x107/0x130
[    5.414889]  vfs_read+0x205/0x2e0
[    5.415162]  ksys_read+0x54/0xd0
[    5.415348]  do_syscall_64+0x3a/0x90
[    5.415584]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: 78e5a3399421 ("cpumask: fix checking valid cpu range")
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 block/blk-mq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c96c8c4f751b..30ae51eda95e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2046,8 +2046,13 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 
 	if (--hctx->next_cpu_batch <= 0) {
 select_cpu:
-		next_cpu = cpumask_next_and(next_cpu, hctx->cpumask,
-				cpu_online_mask);
+		if (next_cpu == nr_cpu_ids - 1)
+			next_cpu = nr_cpu_ids;
+		else
+			next_cpu = cpumask_next_and(next_cpu,
+						    hctx->cpumask,
+						    cpu_online_mask);
+
 		if (next_cpu >= nr_cpu_ids)
 			next_cpu = blk_mq_first_mapped_cpu(hctx);
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
-- 
2.31.1

