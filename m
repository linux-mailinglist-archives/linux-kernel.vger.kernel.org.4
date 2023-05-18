Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A5E707C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjERJPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjERJPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:15:01 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0F81FDC
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:15:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae454844edso13732955ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684401300; x=1686993300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AEruk6lgv2UDdUrR3IRiS7raiUqRukdhzsBT0y7QWd8=;
        b=ncwIvPQ3tpE5ajVR5XQ9ZcmF3F9Lx43OHj/zr3p2G6dINoM6/uTDxjVkP3ILiSxU3s
         m5kzXXYADsCz5VHt+Z0yAi/YqcTYSC7gHPof3iAv8cwJCEcHtxo+w90JmhmvxjFY+W80
         7RXmwGKpYjyCodNhLI4k6IsugXMbIrX9+iP9V4+sggfWyjPHclN3cT46Lkm69qI9F2Ry
         l3tAHFHXJ/k4hHqcv8+YzkpFuiddRQFlikw11Jlg1wJQ6Wrvlq6PdRDnOiDBgqYLlVvn
         6rkChuhF85AgL3WgKUgnQT/Cn87I7mY0bHgeR6WqLnQm6n/CT7/X96L0yi3qQausmjV9
         3ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684401300; x=1686993300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEruk6lgv2UDdUrR3IRiS7raiUqRukdhzsBT0y7QWd8=;
        b=g8/ajyCTSTtc2RbjXDNxl016GsENgjEPP9SyNs4oixZee3CBbR+OhJnRgWbVf+nlrz
         320fiB3jwTx0ZCqcEXskbvBPZo3yoc32OY5RgAON4a6JWtMNE8mVbx0v2M2FqV2gZ0Tp
         exAgSzWklojqtLzNZSC7rgNafVVt4B5j6KIb9RwQb7MRgC4GZOG7o+7XfoL1m/G7XUTn
         SHHDN70FDAyqSf+6CXPpCwkrNmJId9l/Rl2/1MmSHlgLAuC/dIIHOUIJUKs2J+KYIzm3
         Z/Ev32T9lehcmXf/qkS3ZUIxrLT+jDx+jsow56kArO9dTksdqztXqUTTn0SMz/fmcpa3
         8Fww==
X-Gm-Message-State: AC+VfDz7Gwtt8bP3a8u663gjIszI+7yToFN7VIXr5b1Zg0Z8b5bn0xlu
        azPpKIwPgmLpAsnbmULkEWsP2V2vkf4=
X-Google-Smtp-Source: ACHHUZ64T69OZGxvcLDXuWD9MHO2gQBxdaNNrGFsoDTvXmb5t5tX/2op+M9sjq47xxxrxPO1JHzvag==
X-Received: by 2002:a17:902:ced1:b0:1ad:e099:fbf9 with SMTP id d17-20020a170902ced100b001ade099fbf9mr1805522plg.42.1684401300135;
        Thu, 18 May 2023 02:15:00 -0700 (PDT)
Received: from localhost.localdomain ([45.43.34.98])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c14c00b001ae4c498d29sm862165plj.265.2023.05.18.02.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 02:14:59 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
To:     rppt@kernel.org, akpm@linux-foundation.org, tsahu@linux.ibm.com,
        anshuman.khandual@arm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yuwei Guan <ssawgyw@gmail.com>
Subject: [PATCH v3] memblock: Add flags and nid info in memblock debugfs
Date:   Thu, 18 May 2023 17:14:31 +0800
Message-Id: <20230518091431.299-1-ssawgyw@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Currently, the memblock debugfs can display the count of memblock_type and
the base and end of the reg. However, when memblock_mark_*() or
memblock_set_node() is executed on some range, the information in the
existing debugfs cannot make it clear why the address is not consecutive.

For example,
cat /sys/kernel/debug/memblock/memory
   0: 0x0000000080000000..0x00000000901fffff
   1: 0x0000000090200000..0x00000000905fffff
   2: 0x0000000090600000..0x0000000092ffffff
   3: 0x0000000093000000..0x00000000973fffff
   4: 0x0000000097400000..0x00000000b71fffff
   5: 0x00000000c0000000..0x00000000dfffffff
   6: 0x00000000e2500000..0x00000000f87fffff
   7: 0x00000000f8800000..0x00000000fa7fffff
   8: 0x00000000fa800000..0x00000000fd3effff
   9: 0x00000000fd3f0000..0x00000000fd3fefff
  10: 0x00000000fd3ff000..0x00000000fd7fffff
  11: 0x00000000fd800000..0x00000000fd901fff
  12: 0x00000000fd902000..0x00000000fd909fff
  13: 0x00000000fd90a000..0x00000000fd90bfff
  14: 0x00000000fd90c000..0x00000000ffffffff
  15: 0x0000000880000000..0x0000000affffffff

So we can add flags and nid to this debugfs.

For example,
cat /sys/kernel/debug/memblock/memory
   0: 0x0000000080000000..0x00000000901fffff     NONE    0
   1: 0x0000000090200000..0x00000000905fffff    NOMAP    0
   2: 0x0000000090600000..0x0000000092ffffff     NONE    0
   3: 0x0000000093000000..0x00000000973fffff    NOMAP    0
   4: 0x0000000097400000..0x00000000b71fffff     NONE    0
   5: 0x00000000c0000000..0x00000000dfffffff     NONE    0
   6: 0x00000000e2500000..0x00000000f87fffff     NONE    0
   7: 0x00000000f8800000..0x00000000fa7fffff    NOMAP    0
   8: 0x00000000fa800000..0x00000000fd3effff     NONE    0
   9: 0x00000000fd3f0000..0x00000000fd3fefff    NOMAP    0
  10: 0x00000000fd3ff000..0x00000000fd7fffff     NONE    0
  11: 0x00000000fd800000..0x00000000fd901fff    NOMAP    0
  12: 0x00000000fd902000..0x00000000fd909fff     NONE    0
  13: 0x00000000fd90a000..0x00000000fd90bfff    NOMAP    0
  14: 0x00000000fd90c000..0x00000000ffffffff     NONE    0
  15: 0x0000000880000000..0x0000000affffffff     NONE    0

Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
---
v3:
- show string value for each memblock flag
---
 mm/memblock.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 511d4783dcf1..5fba53f98b2d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2143,13 +2143,23 @@ static int memblock_debug_show(struct seq_file *m, void *private)
 	struct memblock_region *reg;
 	int i;
 	phys_addr_t end;
+	static const char flagname[BITS_PER_LONG][8] = {
+		[0 ... (BITS_PER_LONG-1)] = "?",
+
+		[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
+		[ilog2(MEMBLOCK_MIRROR)] = "MIRROR",
+		[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
+		[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
+	};
 
 	for (i = 0; i < type->cnt; i++) {
 		reg = &type->regions[i];
 		end = reg->base + reg->size - 1;
 
 		seq_printf(m, "%4d: ", i);
-		seq_printf(m, "%pa..%pa\n", &reg->base, &end);
+		seq_printf(m, "%pa..%pa ", &reg->base, &end);
+		seq_printf(m, "%8s ", reg->flags ? flagname[ilog2(reg->flags)] : "NONE");
+		seq_printf(m, "%4d\n", memblock_get_region_node(reg));
 	}
 	return 0;
 }
-- 
2.34.1

