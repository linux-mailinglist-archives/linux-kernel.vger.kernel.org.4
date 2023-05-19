Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB54E70956E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjESKxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjESKxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:53:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A40E45
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:53:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a516fb6523so29540905ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684493615; x=1687085615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5ls3SeTHm3utb0beJFgdvQLna8e8DUOYvcEbBp6374=;
        b=oJdmOAayLhOyGpjHGxPM+kbykuT92LlGd7nhK+9Q3b+2FvumgN8yMgwlNYjsZvULzh
         tcBiIUZPO619L5N4ZFJ9YPruJxdA0exCv0dj3CfZQqzSS4Vvth48xTv7ZMh4QyFP0gRx
         MaaAeD8/nGIqyawaqNvBBPIJBtvbF5DzYuOQNB5XQSNbiD173ZZlmpxM3b0exgYWn1bZ
         7o248jYzFx57MnvwE5G+MkB/kNf+0+E5NRJ6+28qMsv/4gfb4b3jKRN5lU67IfSgKWcZ
         w3eNbkv3giDA5nbMhDIzXYVI/EpNBEidp1OnuGw9lvrbz52Joo5XzlK/UA9y8dXlBq4q
         ji9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684493615; x=1687085615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5ls3SeTHm3utb0beJFgdvQLna8e8DUOYvcEbBp6374=;
        b=DBtC179cIpL2nDJ3hKnJUIca+KrTbrh/W1YVT0VRKznPE9QV6p/v+zTuPEAjuzwLoG
         PBR4gL6LVDK39PTfMI0VHPmtubvG45vBljuXOsNyfPHJPNQa7tzQqbTfXdMaxlUCdI/T
         DKvHX6KEOQEX7kQnhYQOvbRkLVR2ijCMyBpw9flUIaaYtEBFd8BDIvPg6cidB4nKuzMz
         +tT6yEpzAH+TrletnGufDGe2LJV1VOAU14Dvxpdig2ayzd26gqnEENsBY4jEMvV2/S+J
         Uc8wj3wL+7tDfofKnaJINZ6/SElyNEoDc/xMMSBk7v2s1jcCICuCZKBOIX6t2GRCo+KT
         +PqQ==
X-Gm-Message-State: AC+VfDxoyjFjZtUZs+FqyyFnl7aqMCKVKbkXGaWEDE+KIG4WYxGo9H+9
        LBGPCsIswEchk+FRJErQdqU=
X-Google-Smtp-Source: ACHHUZ6uhILkqWsWS28g+auP15fNJuRo3OqpQ18EaSOLqLvMn6TxfHzVhz6TCHoDvD7WO2IpBJ5nRA==
X-Received: by 2002:a17:902:f7c2:b0:1ae:4c2d:94a2 with SMTP id h2-20020a170902f7c200b001ae4c2d94a2mr1622005plw.65.1684493613204;
        Fri, 19 May 2023 03:53:33 -0700 (PDT)
Received: from localhost.localdomain ([45.43.34.98])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902ecd000b001ac38343438sm3152478plh.176.2023.05.19.03.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 03:53:32 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
To:     rppt@kernel.org, akpm@linux-foundation.org, tsahu@linux.ibm.com,
        anshuman.khandual@arm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yuwei Guan <ssawgyw@gmail.com>
Subject: [PATCH v4] memblock: Add flags and nid info in memblock debugfs
Date:   Fri, 19 May 2023 18:53:21 +0800
Message-Id: <20230519105321.333-1-ssawgyw@gmail.com>
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
   0: 0x0000000080000000..0x00000000901fffff    0 NONE
   1: 0x0000000090200000..0x00000000905fffff    0 NOMAP
   2: 0x0000000090600000..0x0000000092ffffff    0 NONE
   3: 0x0000000093000000..0x00000000973fffff    0 NOMAP
   4: 0x0000000097400000..0x00000000b71fffff    0 NONE
   5: 0x00000000c0000000..0x00000000dfffffff    0 NONE
   6: 0x00000000e2500000..0x00000000f87fffff    0 NONE
   7: 0x00000000f8800000..0x00000000fa7fffff    0 NOMAP
   8: 0x00000000fa800000..0x00000000fd3effff    0 NONE
   9: 0x00000000fd3f0000..0x00000000fd3fefff    0 NOMAP
  10: 0x00000000fd3ff000..0x00000000fd7fffff    0 NONE
  11: 0x00000000fd800000..0x00000000fd901fff    0 NOMAP
  12: 0x00000000fd902000..0x00000000fd909fff    0 NONE
  13: 0x00000000fd90a000..0x00000000fd90bfff    0 NOMAP
  14: 0x00000000fd90c000..0x00000000ffffffff    0 NONE
  15: 0x0000000880000000..0x0000000affffffff    0 NONE

Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
---
v4:
- show string value for each memblock flag
---
 mm/memblock.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 511d4783dcf1..10d0ddbeebc1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2136,12 +2136,19 @@ void __init memblock_free_all(void)
 }
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
+static const char * const flagname[] = {
+	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
+	[ilog2(MEMBLOCK_MIRROR)] = "MIRROR",
+	[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
+	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
+};
 
 static int memblock_debug_show(struct seq_file *m, void *private)
 {
 	struct memblock_type *type = m->private;
 	struct memblock_region *reg;
-	int i;
+	int i, j;
+	unsigned int count = ARRAY_SIZE(flagname);
 	phys_addr_t end;
 
 	for (i = 0; i < type->cnt; i++) {
@@ -2149,7 +2156,20 @@ static int memblock_debug_show(struct seq_file *m, void *private)
 		end = reg->base + reg->size - 1;
 
 		seq_printf(m, "%4d: ", i);
-		seq_printf(m, "%pa..%pa\n", &reg->base, &end);
+		seq_printf(m, "%pa..%pa ", &reg->base, &end);
+		seq_printf(m, "%4d ", memblock_get_region_node(reg));
+		if (reg->flags) {
+			for (j = 0; j < count; j++) {
+				if (reg->flags & (1U << j)) {
+					seq_printf(m, "%s\n", flagname[j]);
+					break;
+				}
+			}
+			if (j == count)
+				seq_printf(m, "%s\n", "UNKNOWN");
+		} else {
+			seq_printf(m, "%s\n", "NONE");
+		}
 	}
 	return 0;
 }
-- 
2.34.1

