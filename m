Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB1470433E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjEPCHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEPCHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:07:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9361119D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:07:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6434e65d808so14298060b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684202820; x=1686794820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3b3x92cRQSciqeDzNgNXsU0gyL4nwobJzXcCOoED950=;
        b=QT2DhAFl77VqGnOxxCpMJhJSSAyPb54gGpT1BAO6l59QXrAdD5fJu0Kt7OMSmihShr
         bJpgvvTCxFtB9e7iZ5BjAoOTLppRPT9xZ1YTH0Y6TZTYM53NXOAbDTshx0O+9Rb2KzQX
         z80YsumZ54nrPMDsXZ5jp14RqfE62divxQ2/Phg40dhSFspAB/FLKoONjo3ii3MqwKJF
         li4kI1P3JQBmxO10oKzdyVphqV1HcCMYy86yNjYus6YgCUwJBfKBX31yjas/0W4oFJ7K
         qob9ryOpeuGURc4/T2hu+oNEnLsCAaA78QHnTbZrgnuG2pHBbDfXl2OykftfnAnp3y20
         F+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684202820; x=1686794820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3b3x92cRQSciqeDzNgNXsU0gyL4nwobJzXcCOoED950=;
        b=C32JLBuLS0Y4MBNrCi05ICJQw99mEcHIJr/lxutizolD24sTobFba+Se/svX4/m3vy
         rRGTQVBh9bKpQgB8q20K5QAOEif8Hrb7XFlBO6vkhrkBKgVfcqzBhTr27C5Tuv/jYiMJ
         LkBv+mBrZUSSEgA1/F/M8e9TStRIuD8vo2ZKULnFWf8BbgpHUknn2g8IBIlcagkmtmZa
         7/fvr/DbLTR+lDOv5gsREhniH7R5XB3LJLQqrgusaLWuniCNawU5EjhsPHPvKx+gpJas
         IcHPwBy8eQDKBwWAQfeTrcacy6IKFYC2RmQ5ec3iJtXzPHZQ6kV+gsqhTBNgpfCXJ1h4
         x/eA==
X-Gm-Message-State: AC+VfDxaG0JGmrtPLxo/vdLjJkcJ2ckMuK66agLxF3ep0lbAWKgdJX6i
        fZreU6JuqpL1utDIrhXNW4c=
X-Google-Smtp-Source: ACHHUZ6uyp1wXv8kS0mHoGc0X/Ma5U1pCZ11zYHuIpGiuEM6/NkZqxUWO4GHvNuaALJdmgYbD90g9w==
X-Received: by 2002:a05:6a00:ccc:b0:643:9cc0:a3be with SMTP id b12-20020a056a000ccc00b006439cc0a3bemr44337342pfv.5.1684202820065;
        Mon, 15 May 2023 19:07:00 -0700 (PDT)
Received: from localhost.localdomain ([45.43.34.98])
        by smtp.gmail.com with ESMTPSA id p19-20020a63f453000000b005287b22ea8esm12318753pgk.88.2023.05.15.19.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 19:06:59 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yuwei Guan <ssawgyw@gmail.com>
Subject: [PATCH] memblock: Add flags and nid info in memblock debugfs
Date:   Tue, 16 May 2023 10:06:45 +0800
Message-Id: <20230516020645.160-1-ssawgyw@gmail.com>
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
the base and end of the reg. However, when the following scenario occurs,
the information in the existing debugfs cannot make it clear why the
address is not consecutive.

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
cnt     flags   base..end
0:      0x0     0x0000000080000000..0x00000000901fffff
1:      0x4     0x0000000090200000..0x00000000905fffff
2:      0x0     0x0000000090600000..0x0000000092ffffff
3:      0x4     0x0000000093000000..0x00000000973fffff
4:      0x0     0x0000000097400000..0x00000000b71fffff
5:      0x0     0x00000000c0000000..0x00000000dfffffff
6:      0x0     0x00000000e2500000..0x00000000f87fffff
7:      0x4     0x00000000f8800000..0x00000000fa7fffff
8:      0x0     0x00000000fa800000..0x00000000fd3effff
9:      0x4     0x00000000fd3f0000..0x00000000fd3fefff
10:     0x0     0x00000000fd3ff000..0x00000000fd7fffff
11:     0x4     0x00000000fd800000..0x00000000fd901fff
12:     0x0     0x00000000fd902000..0x00000000fd909fff
13:     0x4     0x00000000fd90a000..0x00000000fd90bfff
14:     0x0     0x00000000fd90c000..0x00000000ffffffff
15:     0x0     0x0000000880000000..0x0000000affffffff

Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
---
 mm/memblock.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 45f198750be9..34230b258e21 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2045,11 +2045,21 @@ static int memblock_debug_show(struct seq_file *m, void *private)
 	int i;
 	phys_addr_t end;
 
+#ifdef CONFIG_NUMA
+	seq_puts(m, "cnt\tflags\tnid\tbase..end\n");
+#else
+	seq_puts(m, "cnt\tflags\tbase..end\n");
+#endif
+
 	for (i = 0; i < type->cnt; i++) {
 		reg = &type->regions[i];
 		end = reg->base + reg->size - 1;
 
-		seq_printf(m, "%4d: ", i);
+		seq_printf(m, "%d:\t", i);
+		seq_printf(m, "0x%x\t", reg->flags);
+#ifdef CONFIG_NUMA
+		seq_printf(m, "0x%x\t", reg->nid);
+#endif
 		seq_printf(m, "%pa..%pa\n", &reg->base, &end);
 	}
 	return 0;
-- 
2.34.1

