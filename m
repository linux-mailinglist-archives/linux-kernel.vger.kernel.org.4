Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6666E6B02AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCHJR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjCHJRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:17:06 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BA4B7D9E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:16:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso675762wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 01:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678267001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=liB9aB3NK5n17GyBBPLJHRRdcoy0y6Tf5rj8JWtRSYQ=;
        b=W5dooLnyl2qvbmUafT2jzA3rg9tIsR7j9HZI0bh5ahvKgnSYv5mla4EBBIoQLlwdcf
         khu2e8oYl/+WjPq0xwBD+iruIeRbIfCpC+Jos2BQ0cOJ87jMLLqqfPN6975+jGv4ZYCa
         /faefg7nsUF+AHNz/lQKy3TAHA1c2LdgNLF/DShPw6ZNUjyrVWjtjg9VskpBdxrE2OKs
         3CJJWNNlGk+3ZdrReUEUYcklXjWFhW8VK1bxE6xs5WqpHOFs5ahh3pFJkxqHZDusQ5Y1
         ZuQSI3eWUk7EiAdoZqXiWQS+2WMCtJSOTbXYzKbQjR4Le+trHkVLN5gEnqyl58fKnPHH
         4l/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678267001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liB9aB3NK5n17GyBBPLJHRRdcoy0y6Tf5rj8JWtRSYQ=;
        b=b3bH0Jdvi4XmV1ZjkuKPOQgAFeDNdx34yUDs41M5gdGA3UTW5szqPTKDdmgZQrsSJZ
         0uW+QI39s2Yf4Xo+26neWqlSynay04Agt/BTVM0bXh/FdXEvElohF1L0UBQXKnywtBXr
         sMlwTdr7Kw7x+EofsdPHlzSAJ9BbwXZTs4TQg92qY9JmrWS2i2klTtTK2t03TTaWZr5C
         UF7Qyks3X35SPOI1O+J4TLrlUbdg1oWqstti6IHO17bLhiLFU4r+aEHCxYWNKq8IVKbN
         MG6Ex9VJZ5vE0RJ5DykdLCEolQ0KQlz2OH6QEZhYEkzq7oEurvtxk4HD3XIB3qNvf/uN
         siwg==
X-Gm-Message-State: AO0yUKWIELsLCjYaiHFarBbX4H9wL6nVNG9XuBzP3kYDXeoJxOlSc3t6
        8Tb1mHov6nF7axOkKsV9oSrC5A6nIKC0quajoYE=
X-Google-Smtp-Source: AK7set/BvX90rLXtSS2Shjqm++szAOMejq6ZMcYNo6CgS2Lj3r2lB7UNZnQPIHmPsrrJOXOqIHFXDA==
X-Received: by 2002:a05:600c:4746:b0:3eb:36fa:b791 with SMTP id w6-20020a05600c474600b003eb36fab791mr15273966wmo.31.1678267001122;
        Wed, 08 Mar 2023 01:16:41 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c16c500b003e20fa01a86sm14941624wmn.13.2023.03.08.01.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:16:40 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Chathura Rajapaksha <chathura.abeyrathne.lk@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] riscv: Use READ_ONCE_NOCHECK in imprecise unwinding stack mode
Date:   Wed,  8 Mar 2023 10:16:39 +0100
Message-Id: <20230308091639.602024-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_FRAME_POINTER is unset, the stack unwinding function
walk_stackframe randomly reads the stack and then, when KASAN is enabled,
it can lead to the following backtrace:

[    0.000000] ==================================================================
[    0.000000] BUG: KASAN: stack-out-of-bounds in walk_stackframe+0xa6/0x11a
[    0.000000] Read of size 8 at addr ffffffff81807c40 by task swapper/0
[    0.000000]
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.2.0-12919-g24203e6db61f #43
[    0.000000] Hardware name: riscv-virtio,qemu (DT)
[    0.000000] Call Trace:
[    0.000000] [<ffffffff80007ba8>] walk_stackframe+0x0/0x11a
[    0.000000] [<ffffffff80099ecc>] init_param_lock+0x26/0x2a
[    0.000000] [<ffffffff80007c4a>] walk_stackframe+0xa2/0x11a
[    0.000000] [<ffffffff80c49c80>] dump_stack_lvl+0x22/0x36
[    0.000000] [<ffffffff80c3783e>] print_report+0x198/0x4a8
[    0.000000] [<ffffffff80099ecc>] init_param_lock+0x26/0x2a
[    0.000000] [<ffffffff80007c4a>] walk_stackframe+0xa2/0x11a
[    0.000000] [<ffffffff8015f68a>] kasan_report+0x9a/0xc8
[    0.000000] [<ffffffff80007c4a>] walk_stackframe+0xa2/0x11a
[    0.000000] [<ffffffff80007c4a>] walk_stackframe+0xa2/0x11a
[    0.000000] [<ffffffff8006e99c>] desc_make_final+0x80/0x84
[    0.000000] [<ffffffff8009a04e>] stack_trace_save+0x88/0xa6
[    0.000000] [<ffffffff80099fc2>] filter_irq_stacks+0x72/0x76
[    0.000000] [<ffffffff8006b95e>] devkmsg_read+0x32a/0x32e
[    0.000000] [<ffffffff8015ec16>] kasan_save_stack+0x28/0x52
[    0.000000] [<ffffffff8006e998>] desc_make_final+0x7c/0x84
[    0.000000] [<ffffffff8009a04a>] stack_trace_save+0x84/0xa6
[    0.000000] [<ffffffff8015ec52>] kasan_set_track+0x12/0x20
[    0.000000] [<ffffffff8015f22e>] __kasan_slab_alloc+0x58/0x5e
[    0.000000] [<ffffffff8015e7ea>] __kmem_cache_create+0x21e/0x39a
[    0.000000] [<ffffffff80e133ac>] create_boot_cache+0x70/0x9c
[    0.000000] [<ffffffff80e17ab2>] kmem_cache_init+0x6c/0x11e
[    0.000000] [<ffffffff80e00fd6>] mm_init+0xd8/0xfe
[    0.000000] [<ffffffff80e011d8>] start_kernel+0x190/0x3ca
[    0.000000]
[    0.000000] The buggy address belongs to stack of task swapper/0
[    0.000000]  and is located at offset 0 in frame:
[    0.000000]  stack_trace_save+0x0/0xa6
[    0.000000]
[    0.000000] This frame has 1 object:
[    0.000000]  [32, 56) 'c'
[    0.000000]
[    0.000000] The buggy address belongs to the physical page:
[    0.000000] page:(____ptrval____) refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x81a07
[    0.000000] flags: 0x1000(reserved|zone=0)
[    0.000000] raw: 0000000000001000 ff600003f1e3d150 ff600003f1e3d150 0000000000000000
[    0.000000] raw: 0000000000000000 0000000000000000 00000001ffffffff
[    0.000000] page dumped because: kasan: bad access detected
[    0.000000]
[    0.000000] Memory state around the buggy address:
[    0.000000]  ffffffff81807b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000]  ffffffff81807b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] >ffffffff81807c00: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 f3
[    0.000000]                                            ^
[    0.000000]  ffffffff81807c80: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000]  ffffffff81807d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] ==================================================================

Fix that by using READ_ONCE_NOCHECK when reading the stack in imprecise
mode.

Fixes: 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
Reported-by: Chathura Rajapaksha <chathura.abeyrathne.lk@gmail.com>
Link: https://lore.kernel.org/all/CAD7mqryDQCYyJ1gAmtMm8SASMWAQ4i103ptTb0f6Oda=tPY2=A@mail.gmail.com/
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index f9a5a7c90ff0..64a9c093aef9 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -101,7 +101,7 @@ void notrace walk_stackframe(struct task_struct *task,
 	while (!kstack_end(ksp)) {
 		if (__kernel_text_address(pc) && unlikely(!fn(arg, pc)))
 			break;
-		pc = (*ksp++) - 0x4;
+		pc = READ_ONCE_NOCHECK(*ksp++) - 0x4;
 	}
 }
 
-- 
2.37.2

