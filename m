Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E697705D95
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjEQC6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjEQC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:58:02 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E96D49CE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:57:59 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-530638a60e1so163544a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684292279; x=1686884279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nfqadfuEw0ilEHiRhO6KvOWnkDKYSpST+spUfnDMNuc=;
        b=Elx9D7mfksOMb2sxsMzzbkNS1QqvaDXWs05bEm0E5xYbYYxbRcVaoZLpYXBSPWv12U
         ZgsdCqkYyzKDJ/8bzjY40a4NJPQ361NVpgATYgrcn2V25b30XBTOVDgGGcioCxtGANCZ
         gLShFCc7dBCFKqvL5X8rOyY5q3dOxjiCqty6Co1KJLKn+iAS6CwvHwI4gO6QPcA6LmRO
         5Jh7e4I0Yoqd1kfmqoyxcRv9oJPHxbYvqG2wdHEI3xsHd22ZFoQ5UEAk2F3CUk7mnCgT
         fCykOoOCipmc+CteII4H6JkzOy34KAoBsE6zBwAdaQMb/L8IkkETJWEsoMwiRzD60Nh4
         jAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684292279; x=1686884279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfqadfuEw0ilEHiRhO6KvOWnkDKYSpST+spUfnDMNuc=;
        b=dzqbL924z2Okyv7f1q0Mfq+E6MpHnPjtAssivHG5mVIkbZUpOf2bA655BWjUThjSHK
         Ps6sNBcRpeK3iny5o5rGp0M9BoOohL6dcnYROu0Ny6bnYxCSEy4TreGYExMjewtRaj3N
         QZMR/Rg4py3/KejhjPdO5oQOEJn0HjWxLsgvSaAc+DIs5f3MMiUa+UxvP7zNOVwFWegM
         slCqOj861JDi1DGv5/9KlggRLKoumihEHMx5CAhweg5J6mUSmSliMXsyGNvDh8Ue/iBW
         dBYdsHUK+RspZVARWUG0/CYKggcv3kHcHvRaLwOvEV+hPqirb8e0deDJeiCIlqMdiOYn
         AK+A==
X-Gm-Message-State: AC+VfDz5yw78J8eIusjQiEeEzScyZldS7Bj6+dS2N3m9Uj5MesPWvgPV
        8lOgSaFRtKIN85ORaSKX4VY=
X-Google-Smtp-Source: ACHHUZ7MdnHrEDZqQGdsWENHJBVnVpMTlniQPGiz1nbLE6ALJlCwei1k6asJyqV17kwkWcKRRgo2rw==
X-Received: by 2002:a17:902:ecca:b0:1ae:3a5d:f9e0 with SMTP id a10-20020a170902ecca00b001ae3a5df9e0mr3726355plh.55.1684292278885;
        Tue, 16 May 2023 19:57:58 -0700 (PDT)
Received: from localhost.localdomain ([45.43.34.98])
        by smtp.gmail.com with ESMTPSA id iw9-20020a170903044900b001ac2f98e953sm454489plb.216.2023.05.16.19.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 19:57:58 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
To:     rppt@kernel.org, akpm@linux-foundation.org, tsahu@linux.ibm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yuwei Guan <ssawgyw@gmail.com>
Subject: [PATCH v2] memblock: Add flags and nid info in memblock debugfs
Date:   Wed, 17 May 2023 10:57:47 +0800
Message-Id: <20230517025747.230-1-ssawgyw@gmail.com>
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
cnt     base..end       flags   nid
0:      0x0000000080000000..0x00000000901fffff  0x0     0x0
1:      0x0000000090200000..0x00000000905fffff  0x4     0x0
2:      0x0000000090600000..0x0000000092ffffff  0x0     0x0
3:      0x0000000093000000..0x00000000973fffff  0x4     0x0
4:      0x0000000097400000..0x00000000b71fffff  0x0     0x0
5:      0x00000000c0000000..0x00000000dfffffff  0x0     0x0
6:      0x00000000e2500000..0x00000000f87fffff  0x0     0x0
7:      0x00000000f8800000..0x00000000fa7fffff  0x4     0x0
8:      0x00000000fa800000..0x00000000fd3effff  0x0     0x0
9:      0x00000000fd3f0000..0x00000000fd3fefff  0x4     0x0
10:     0x00000000fd3ff000..0x00000000fd7fffff  0x0     0x0
11:     0x00000000fd800000..0x00000000fd901fff  0x4     0x0
12:     0x00000000fd902000..0x00000000fd909fff  0x0     0x0
13:     0x00000000fd90a000..0x00000000fd90bfff  0x4     0x0
14:     0x00000000fd90c000..0x00000000ffffffff  0x0     0x0
15:     0x0000000880000000..0x0000000affffffff  0x0     0x0

Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
Reviewed-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 mm/memblock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 511d4783dcf1..b36fb6b31e0f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2144,12 +2144,16 @@ static int memblock_debug_show(struct seq_file *m, void *private)
 	int i;
 	phys_addr_t end;
 
+	seq_puts(m, "cnt\tbase..end\tflags\tnid\n");
+
 	for (i = 0; i < type->cnt; i++) {
 		reg = &type->regions[i];
 		end = reg->base + reg->size - 1;
 
-		seq_printf(m, "%4d: ", i);
-		seq_printf(m, "%pa..%pa\n", &reg->base, &end);
+		seq_printf(m, "%d:\t", i);
+		seq_printf(m, "%pa..%pa\t", &reg->base, &end);
+		seq_printf(m, "0x%x\t", reg->flags);
+		seq_printf(m, "0x%x\n", memblock_get_region_node(reg));
 	}
 	return 0;
 }
-- 
2.34.1

