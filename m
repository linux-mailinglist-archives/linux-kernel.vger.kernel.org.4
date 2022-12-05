Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5946642EC9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiLERaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiLERaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:30:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1762321E25
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:30:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4A936125C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 17:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4164FC433C1;
        Mon,  5 Dec 2022 17:30:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="b4iFPk8e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670261419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4ElxRnkIjBHzAgajGGzltaINjdTXoXoQxedqqUtDsyc=;
        b=b4iFPk8etq9IanUvVfBSGkntQ1u628JEicMhdNYhLAXe4xoQX9QqOt+w8W+UPp9nMeggkY
        ik0sKiYjM+5vAAldQUgD65ea0IFl1koO5WOWbrMxOpw00C4D6zPFrfD1iD/Z/zoBDXazxy
        xc8VLIMrtPAZxy2wAEPQHsPSXs65nbI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b44d0242 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 5 Dec 2022 17:30:19 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric B Munson <emunson@akamai.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm: do not show ?? for VM_LOCKONFAULT pages
Date:   Mon,  5 Dec 2022 18:30:07 +0100
Message-Id: <20221205173007.580210-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When VM_LOCKONFAULT was added, /proc/PID/smaps wasn't hooked up to it,
so looking at /proc/PID/smaps, it shows '??' instead of something
intelligable. This can be reached by userspace by simply calling
`mlock2(..., MLOCK_ONFAULT);`.

Fix this by adding "lf" to denote VM_LOCKONFAULT.

Cc: Eric B Munson <emunson@akamai.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: de60f5f10c58 ("mm: introduce VM_LOCKONFAULT")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/proc/task_mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8a74cdcc9af0..60851e96530b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -667,6 +667,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_RAND_READ)]	= "rr",
 		[ilog2(VM_DONTCOPY)]	= "dc",
 		[ilog2(VM_DONTEXPAND)]	= "de",
+		[ilog2(VM_LOCKONFAULT)]	= "lf",
 		[ilog2(VM_ACCOUNT)]	= "ac",
 		[ilog2(VM_NORESERVE)]	= "nr",
 		[ilog2(VM_HUGETLB)]	= "ht",
-- 
2.38.1

