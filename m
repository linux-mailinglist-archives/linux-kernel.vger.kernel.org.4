Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228816E0EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjDMNaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjDMNai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:30:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2639755;
        Thu, 13 Apr 2023 06:30:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l18so14198099wrb.9;
        Thu, 13 Apr 2023 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681392611; x=1683984611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7vuUepV4dAJ+nkaSvL/ErL7Y/nu4CyeJdvToecRq5Q8=;
        b=GO3KIgO1Au7XBl//B835y3fVl6xQs3EDJoDX72iO1VBi+gafdvC8Jrj47R96KSpGTR
         GEoA49VUWHWXW1k2k9/KzCWjymdqVctxdUGMl/3VyAbjiDSKzo5oJ59GtF4P+B0VTRF0
         +wrXtMVM1/gZGRKcgpZk0qdi6FiCwIlWFMqIQaMJIOAzq/MuBq0i+3pD6+t/gJ5VR/sE
         8Wf+o2wlWcDHTH7BwaJ9uyhpW713f+Bv7+4Pb5Nj4RcSIp57S3f6lt+eoGfR0+Jyh07/
         v7zR4U5vFg6burt5kbGfG6LUGMW6Jx0UIp7Mw033DPT6BAA1kuzuxQidFGdQZYHLWexj
         APtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392611; x=1683984611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vuUepV4dAJ+nkaSvL/ErL7Y/nu4CyeJdvToecRq5Q8=;
        b=bkN0Z4clxWELo9CEsLYoXeHlKhaDyNXRC4nIi7/NuEC6AH73Y/SxLIl2eWW2nJ37OX
         OS5lkGU9QbMXr2QKAVSTCi9Ctz9ER1AD9PytDSlJeEKzUWFdvcn3yQpwQ3gVBIgbPA1A
         Xi1tavayNFuTBpCvx7zN0LMncfNXmbeTHEDyiEv6NrshHiWxtjOZ4sJRfHCchcYeBur+
         LS0zh8oJJqBVKrNDCgt8dMxclMFyrxc8n9MxkWgBB2R17aiBsCT1fvfzkdfB+4UJayYG
         DtO5BlmNwpbd0OVDv7YN1xZdLEjMe4dtF0OkJLHdGZMKLEN0cslyjcg1C9w6/sawJFwU
         +9/Q==
X-Gm-Message-State: AAQBX9dW5Hij/YZUSx8ghoPI6Ij9VuXYwHc6S1hoZwVgwwphHb80FwbY
        Ojl3RpLGHq0QWVMdp5fNuZk=
X-Google-Smtp-Source: AKy350bLYbMF89ZC+MJVjwk3fnMTGMycUXZjXTHbi9DZpOpVl1PLukpxYkHqByWwrepviu7nhYpAnQ==
X-Received: by 2002:a05:6000:1365:b0:2c7:1e16:57cf with SMTP id q5-20020a056000136500b002c71e1657cfmr1500704wrz.67.1681392610996;
        Thu, 13 Apr 2023 06:30:10 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d4d8b000000b002c7066a6f77sm1315780wru.31.2023.04.13.06.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:30:10 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block, bfq: Fix division by zero error on zero wsum
Date:   Thu, 13 Apr 2023 14:30:09 +0100
Message-Id: <20230413133009.1605335-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the weighted sum is zero the calculation of limit causes
a division by zero error. Fix this by continuing to the next level.

This was discovered by running as root:

stress-ng --ioprio 0

Fixes divison by error oops:

[  521.450556] divide error: 0000 [#1] SMP NOPTI
[  521.450766] CPU: 2 PID: 2684464 Comm: stress-ng-iopri Not tainted 6.2.1-1280.native #1
[  521.451117] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[  521.451627] RIP: 0010:bfqq_request_over_limit+0x207/0x400
[  521.451875] Code: 01 48 8d 0c c8 74 0b 48 8b 82 98 00 00 00 48 8d 0c c8 8b 85 34 ff ff ff 48 89 ca 41 0f af 41 50 48 d1 ea 48 98 48 01 d0 31 d2 <48> f7 f1 41 39 41 48 89 85 34 ff ff ff 0f 8c 7b 01 00 00 49 8b 44
[  521.452699] RSP: 0018:ffffb1af84eb3948 EFLAGS: 00010046
[  521.452938] RAX: 000000000000003c RBX: 0000000000000000 RCX: 0000000000000000
[  521.453262] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffb1af84eb3978
[  521.453584] RBP: ffffb1af84eb3a30 R08: 0000000000000001 R09: ffff8f88ab8a4ba0
[  521.453905] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8f88ab8a4b18
[  521.454224] R13: ffff8f8699093000 R14: 0000000000000001 R15: ffffb1af84eb3970
[  521.454549] FS:  00005640b6b0b580(0000) GS:ffff8f88b3880000(0000) knlGS:0000000000000000
[  521.454912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  521.455170] CR2: 00007ffcbcae4e38 CR3: 00000002e46de001 CR4: 0000000000770ee0
[  521.455491] PKRU: 55555554
[  521.455619] Call Trace:
[  521.455736]  <TASK>
[  521.455837]  ? bfq_request_merge+0x3a/0xc0
[  521.456027]  ? elv_merge+0x115/0x140
[  521.456191]  bfq_limit_depth+0xc8/0x240
[  521.456366]  __blk_mq_alloc_requests+0x21a/0x2c0
[  521.456577]  blk_mq_submit_bio+0x23c/0x6c0
[  521.456766]  __submit_bio+0xb8/0x140
[  521.457236]  submit_bio_noacct_nocheck+0x212/0x300
[  521.457748]  submit_bio_noacct+0x1a6/0x580
[  521.458220]  submit_bio+0x43/0x80
[  521.458660]  ext4_io_submit+0x23/0x80
[  521.459116]  ext4_do_writepages+0x40a/0xd00
[  521.459596]  ext4_writepages+0x65/0x100
[  521.460050]  do_writepages+0xb7/0x1c0
[  521.460492]  __filemap_fdatawrite_range+0xa6/0x100
[  521.460979]  file_write_and_wait_range+0xbf/0x140
[  521.461452]  ext4_sync_file+0x105/0x340
[  521.461882]  __x64_sys_fsync+0x67/0x100
[  521.462305]  ? syscall_exit_to_user_mode+0x2c/0x1c0
[  521.462768]  do_syscall_64+0x3b/0xc0
[  521.463165]  entry_SYSCALL_64_after_hwframe+0x5a/0xc4
[  521.463621] RIP: 0033:0x5640b6c56590
[  521.464006] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d 71 70 0e 00 00 74 17 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 block/bfq-iosched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d9ed3108c17a..bac977da4eb5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -649,6 +649,8 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
 					sched_data->service_tree[i].wsum;
 			}
 		}
+		if (!wsum)
+			continue;
 		limit = DIV_ROUND_CLOSEST(limit * entity->weight, wsum);
 		if (entity->allocated >= limit) {
 			bfq_log_bfqq(bfqq->bfqd, bfqq,
-- 
2.30.2

