Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0840F719E4F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjFANcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjFANcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:32:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A8810DA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:32:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-25632c99eecso261708a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685626319; x=1688218319;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWt6V6FL8uiL8DaqLP59q0+kgyWrAbxTEuQv+TzGgyQ=;
        b=V1jLdqJlox6Dv/VNXEtx2l/Mpa5/1/YFPoc5rStWuHKzZDsqr1yvxY2Dmsg6P5XEnb
         o0z6yw83pmjrIgaPJrVEEUio9rA2qRvoLf+/B9FL6duQbQ6Bx6+gcTgLyt51l1kXe347
         /93c7sW2wDkFuqkYoQwEtbzdu6LN5HYm90sU15fVDE+3urBs0l4tInKGcN3i6vEZYPF0
         jH+hBEXUpfb9eBRBDDFn0aX7ekVuBlbWBiD1hK+Sz4cY+jNxg2izR3zcy8JyvEXIavAx
         qsc+nytlC44Jbb9C/h1VuT57BEgpJUIV6vMEU6dzVVPdFommPYDCF2frCfj9ZIIVm4n5
         +Dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685626319; x=1688218319;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWt6V6FL8uiL8DaqLP59q0+kgyWrAbxTEuQv+TzGgyQ=;
        b=QJaw9kJ3QuO+9ZvZJ8t6KoULEjEjGLYs61QZHFDVeDovexne6X5N3XXNBfhi9S2VCY
         O1VHd2wflVy8VySjtjre7VbHZjv9hG7QbXR2LR6CweOFZl4cj0TkIqSzFQViv/9jqsH1
         eAqb31oOX6AgZKxDnBi+AJkyzNmrxDn5MK0R7gXyXtUS9fFzsKR9yi6wodPSQmKRM78D
         IvlTWT8mh9Fvxyw+L5rkImMfsEinXNP1JhdiMtOzY+UqGNpOe2uqCHdfE9OvzoEd/PB9
         Y21KWJZrXHtyKAHTUqeZ8y4E9eWm8TvuoJNv5IgNryBtV6dh/U75RghQ18QgXSx7NTOt
         LUoQ==
X-Gm-Message-State: AC+VfDxyhEKuNU8ZGhVDN7ccJk8doa2WHMSKqMGwpNtGf0Id8IW6buFo
        36LRVwa+bpR4MesNqw4T7Dc=
X-Google-Smtp-Source: ACHHUZ7JzE2mYQ65u/T3auS7W3DM+NXmyHOMlubGTq+WtCrotoJOMtK1zyU7p6zbqg7go43RkwHKVA==
X-Received: by 2002:a17:90b:118:b0:250:8f09:75f2 with SMTP id p24-20020a17090b011800b002508f0975f2mr5757388pjz.22.1685626319448;
        Thu, 01 Jun 2023 06:31:59 -0700 (PDT)
Received: from localhost.localdomain ([58.246.67.170])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090a700500b0023d386e4806sm1441245pjk.57.2023.06.01.06.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 06:31:59 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
To:     rppt@kernel.org, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, anshuman.khandual@arm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yuwei Guan <ssawgyw@gmail.com>
Subject: [RESEND PATCH] memblock: Update nid info in memblock debugfs
Date:   Thu,  1 Jun 2023 21:31:49 +0800
Message-Id: <20230601133149.37160-1-ssawgyw@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node id for memblock reserved regions will be wrong,
so let's show 'x' for reg->nid == MAX_NUMNODES in debugfs to keep it align.

Suggested-by: Mike Rapoport (IBM) <rppt@kernel.org>
Co-developed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
---
 mm/memblock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 9ddd1ecb9af8..f50b418ccb11 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2160,17 +2160,21 @@ static int memblock_debug_show(struct seq_file *m, void *private)
 {
 	struct memblock_type *type = m->private;
 	struct memblock_region *reg;
-	int i, j;
+	int i, j, nid;
 	unsigned int count = ARRAY_SIZE(flagname);
 	phys_addr_t end;
 
 	for (i = 0; i < type->cnt; i++) {
 		reg = &type->regions[i];
 		end = reg->base + reg->size - 1;
+		nid = memblock_get_region_node(reg);
 
 		seq_printf(m, "%4d: ", i);
 		seq_printf(m, "%pa..%pa ", &reg->base, &end);
-		seq_printf(m, "%4d ", memblock_get_region_node(reg));
+		if (nid != MAX_NUMNODES)
+			seq_printf(m, "%4d ", nid);
+		else
+			seq_printf(m, "%4c ", 'x');
 		if (reg->flags) {
 			for (j = 0; j < count; j++) {
 				if (reg->flags & (1U << j)) {
-- 
2.17.1

