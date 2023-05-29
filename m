Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862BC714840
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjE2K7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjE2K7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:59:31 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4C5B2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:59:30 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d3fdcadb8so2321613b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685357970; x=1687949970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5QRkls60EmwfQ094Jr/DUlSJC+fZUUu7sTN4HHKuK4E=;
        b=hLPEdmjEn3Le+3iayfK0IFFeTrXuMhiSMq7EnaISokJmJIgx05EZOqn3PJsdmZ4DWJ
         hLydpDmyTtF0McFS/B+inVIQa6oNItzj9uzg/mGq7mnYp2CwuNB4aAmWNHrUyFugWn1s
         ENbAU7SLz9Oze6cyNXuYAsyqnk3IHwlUdFkbQqgfUKHcRciGQM4wNo7bvZn11Cz6SgqH
         vcUHGn53MHErUGiSd6WlMq2p/gNKegUrZQhi3ES7XOZUIV5uZCuStijNcl3/KekbqYfr
         TitfVnnNPtwkffVfWc0gLlFSpYlYSey7pCcDRvLgCGKM4pWXDg95IPyx8j52bALZy8JT
         Sdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685357970; x=1687949970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QRkls60EmwfQ094Jr/DUlSJC+fZUUu7sTN4HHKuK4E=;
        b=fh1iw6v6JFvt+aindjE7GYgWPkswNw16nMKlnwBrIQMKJ9KudZ3//OzapCct4sZ15n
         HVza5UAoweaZ+n25RNwFv4Knuyh6GjrWcmBZZVcys8UTsz7XaCV8g0+qaHZ/9pv7pbxM
         RByzKC4T+JxnLkmZCCfpLsRzy4+CK3zW2LVWNg7F+h9PerfxwwqtqACKLgAxWMLMmIz1
         s8ObKTIEK4ozg+gEszSSLy4u7hoJGb2OYRNvB226MEHoSPRHXHxKq30HOL4Xe+rHKy7J
         S0flB7gleJiMvk/4whs32doxm5qKR82qp+Te/aZMGqkMP25+bCkKFcEkwQT4t4d6ZEIJ
         FB1g==
X-Gm-Message-State: AC+VfDxzTQ9XVnyxVV7lnB3R6/nKtSTnBffHiG15JPrXbWyZ39gLJrkE
        IHVlY3ZOu3dmFAxbdqaNTu5Gblxge9VQObd7
X-Google-Smtp-Source: ACHHUZ5GkpLFkPZpDSKTHi7pxwqcMH5Rk8T6rfmGorTWoXyzCcO47wWG6G7+wwUTgJPV3Sb2UVVPQg==
X-Received: by 2002:a05:6a20:12d2:b0:10e:a8e6:35d1 with SMTP id v18-20020a056a2012d200b0010ea8e635d1mr8777665pzg.40.1685357969989;
        Mon, 29 May 2023 03:59:29 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id v7-20020a63d547000000b0053f22b76cdcsm6863110pgi.82.2023.05.29.03.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 03:59:29 -0700 (PDT)
From:   "brookxu.cn" <brookxu.cn@gmail.com>
To:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
Date:   Mon, 29 May 2023 18:59:22 +0800
Message-Id: <cover.1685350577.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <chunguang.xu@shopee.com>

We found that nvme_remove_namespaces() may hang in flush_work(&ctrl->scan_work)
while removing ctrl. The root cause may due to the state of ctrl changed to
NVME_CTRL_DELETING while removing ctrl , which intterupt nvme_tcp_error_recovery_work()/
nvme_reset_ctrl_work()/nvme_tcp_reconnect_or_remove().  At this time, ctrl is
freezed and queue is quiescing . Since scan_work may continue to issue IOs to
load partition table, make it blocked, and lead to nvme_tcp_error_recovery_work()
hang in flush_work(&ctrl->scan_work).

After analyzation, we found that there are mainly two case: 
1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() while it issue
   new IO to load partition table.
2. Since queus is quiescing, requeue timeouted IO may hang in hctx->dispatch
   queue, leading scan_work waiting for IO completion.

CallTrace:
Removing nvme_ctrl
[<0>] __flush_work+0x14c/0x280
[<0>] flush_work+0x14/0x20
[<0>] nvme_remove_namespaces+0x45/0x100
[<0>] nvme_do_delete_ctrl+0x79/0xa0
[<0>] nvme_sysfs_delete+0x6b/0x80
[<0>] dev_attr_store+0x18/0x30
[<0>] sysfs_kf_write+0x3f/0x50
[<0>] kernfs_fop_write_iter+0x141/0x1d0
[<0>] vfs_write+0x25b/0x3d0
[<0>] ksys_write+0x6b/0xf0
[<0>] __x64_sys_write+0x1e/0x30
[<0>] do_syscall_64+0x5d/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x72/0xdc

Scan_work:
Stack 0
[<0>] __bio_queue_enter+0x15a/0x210
[<0>] blk_mq_submit_bio+0x260/0x5e0
[<0>] __submit_bio+0xa6/0x1a0
[<0>] submit_bio_noacct_nocheck+0x2e5/0x390
[<0>] submit_bio_noacct+0x1cd/0x560
[<0>] submit_bio+0x3b/0x60
[<0>] submit_bh_wbc+0x137/0x160
[<0>] block_read_full_folio+0x24d/0x470
[<0>] blkdev_read_folio+0x1c/0x30
[<0>] filemap_read_folio+0x44/0x2a0
[<0>] do_read_cache_folio+0x135/0x390
[<0>] read_cache_folio+0x16/0x20
[<0>] read_part_sector+0x3e/0xd0
[<0>] sgi_partition+0x35/0x1d0
[<0>] bdev_disk_changed+0x1f6/0x650
[<0>] blkdev_get_whole+0x7e/0x90
[<0>] blkdev_get_by_dev+0x19c/0x2e0
[<0>] disk_scan_partitions+0x72/0x100
[<0>] device_add_disk+0x415/0x420
[<0>] nvme_scan_ns+0x636/0xcd0
[<0>] nvme_scan_work+0x26f/0x450
[<0>] process_one_work+0x21c/0x430
[<0>] worker_thread+0x4e/0x3c0
[<0>] kthread+0xfb/0x130
[<0>] ret_from_fork+0x29/0x50

Stack 1
[<0>] filemap_read_folio+0x195/0x2a0
[<0>] do_read_cache_folio+0x135/0x390
[<0>] read_cache_folio+0x16/0x20
[<0>] read_part_sector+0x3e/0xd0
[<0>] read_lba+0xcc/0x1b0
[<0>] efi_partition+0xec/0x7f0
[<0>] bdev_disk_changed+0x1f6/0x650
[<0>] blkdev_get_whole+0x7e/0x90
[<0>] blkdev_get_by_dev+0x19c/0x2e0
[<0>] disk_scan_partitions+0x72/0x100
[<0>] device_add_disk+0x433/0x440
[<0>] nvme_scan_ns+0x636/0xcd0
[<0>] nvme_scan_work+0x26f/0x450
[<0>] process_one_work+0x21c/0x430
[<0>] worker_thread+0x4e/0x3c0
[<0>] kthread+0xfb/0x130
[<0>] ret_from_fork+0x29/0x50

Here try to fix this issue by make sure ctrl is unfreezed and queue is quiescing
while exit from error recovery or reset.

Chunguang Xu (4):
  nvme: unfreeze while exit from recovery or resetting
  nvme: donot retry request for NVME_CTRL_DELETING_NOIO
  nvme: optimize nvme_check_ready() for NVME_CTRL_DELETING_NOIO
  nvme-tcp: remove admin_q quiescing from nvme_tcp_teardown_io_queues

 drivers/nvme/host/core.c |  5 ++++-
 drivers/nvme/host/nvme.h |  3 ++-
 drivers/nvme/host/tcp.c  | 25 ++++++++++++++++---------
 3 files changed, 22 insertions(+), 11 deletions(-)

-- 
2.25.1

