Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB47872A6DA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjFIXtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjFIXtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:49:05 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA2E57
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 16:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1686354541;
        bh=bpuiYw7aOu1hTubouULzt77m8lYy98Ok47YzdGnD6Bk=;
        h=From:To:Cc:Subject:Date;
        b=LrZBIqi4Iw8xbGi0h8bClEjDjWbh2gC9VLEc2rEn30f81oU4blqyspuM92g32DMa2
         a8zjjAlhhl1OBH5HyNNJ43zody95bU9YvZBvMUySwnP5LaTTWBJYHb2n4OYUjAQnuk
         3l25ZP+YN1zfYNVHFQbMAjDyZAampB4kZ4vlHYRA=
Received: from localhost ([101.224.149.128])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id C3B3E632; Sat, 10 Jun 2023 07:48:59 +0800
X-QQ-mid: xmsmtpt1686354539tdu6ve0y0
Message-ID: <tencent_D656D683705F41324657ED3393C3384C7408@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9FKOmyCjEVaaztjBKmlj53eegGO13ZbfN/g5qTleK0aCa+9mAGG
         lCiXFH6NvrwMhkmrYUf7BZei8wn3boTZUALlplZs04v8yx5DEAn1qTU7OtKAw7AcsJTisDEU7SQh
         xkUkOWc4ExbmSL6iF8LuFHbHgBWk0jeweLFcdhrFEO+wDPHxeiJ5gpQo1fb+bxUdM/bu+IQIkbFy
         WFkucEHn8FuZ+v1RCPHZJEKxnlECu2z4dEQF86aLIcu8j+U74rn2EhEbYJGgNY5UxbVTOC6jno3q
         dncF3jGtn7jsT9UY91KrSF+UA90E83PIbxJ+0pKBOlhxbJyGiC+Emx2HofJgZWUu7fly2VkfNN/x
         SA/2MPNOoIXeazMGGYFu0fnzCxHdn6MvFr3sn7THWM5PPJ2uDoWv7IsQ0FFs6R5Mq1KsPHfZVQw0
         fVEG5PrA3PTdY+lQMZqzdOjINO9cPSB8BgODArwAlFCAR5Qa7uzhUSvWx94sXAGNzoeRbFf+SA11
         GjZXSfQJo2CUunj96ljRWtry06JqaOJU4nagMMDZ/jLIU/EwQEg+IP9B3Y6jO59aPXOrMdTRSbf5
         jDSJyErWvfet2tDPl+NNLrwTJUVQ+v47oacGmQ98t7BMs8J49d+to1vV8FLjjpZ83EyBKnyulN8s
         4f6tpT3XfbZHn4geo/H8JWLc/oo5NhOxJkqyVd5F4K0W4tHa42OZqQPKyEJ3NE0kteVQMuWWxern
         Q5zMV84tGZnpcYdd8ENvHOV6yE+4vvRk8Qc04vhkKjTdKlSziklGqmVS284aCuzz0biDC6xcgd1t
         X++GxwD8uqWqTgqu9Rq0RoBWY7ossa3+cVcVGKV98fer2MtqmZybdgfKdEhtAlLBrBZLtchy5iWG
         PEfdywNTlUSdonvQo2ZKd/pckfW2x96DZ12eU6I3/QVw2xItqnr2tMiAhuhJBtKq5f7G804TklTp
         p8vHohUZdB/xnGUayWhMqoQ8XCgwl3
From:   Woody Zhang <woodylab@foxmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Woody Zhang <woodylab@foxmail.com>
Subject: [PATCH] riscv: move memblock_allow_resize() after lm is ready
Date:   Sat, 10 Jun 2023 07:43:20 +0800
X-OQ-MSGID: <20230609234319.839760-1-woodylab@foxmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial memblock metadata is accessed from kernel image mapping. The
regions arrays need to "reallocated" from memblock and accessed through
linear mapping to cover more memblock regions. So the resizing should
not be allowed until linear mapping is ready. Note that there are
memblock allocations when building linear mapping.

Signed-off-by: Woody Zhang <woodylab@foxmail.com>
---
 arch/riscv/mm/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 9e9da69720ce..8a33ecbb4d0f 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -258,7 +258,6 @@ static void __init setup_bootmem(void)
 	dma_contiguous_reserve(dma32_phys_limit);
 	if (IS_ENABLED(CONFIG_64BIT))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
-	memblock_allow_resize();
 }
 
 #ifdef CONFIG_MMU
@@ -1250,6 +1249,9 @@ static void __init setup_vm_final(void)
 	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
 
+	/* Depend on that Linear Mapping is ready */
+	memblock_allow_resize();
+
 	pt_ops_set_late();
 }
 #else
-- 
2.39.2

