Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD8A698F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBPJSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjBPJSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:18:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59F82068A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:18:01 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B6820660219B;
        Thu, 16 Feb 2023 09:17:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676539080;
        bh=eN35qv1LQnqiL94LOpdwsRPxsfQxNRRB3+34BVt+3/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hXppeNF6RgBlcVGgaFAGBHmpAy9Zonunn8zH1SUsH0SbgvHwyDQ6xVh8Q/nxGdKFs
         495IqxX+srlyIzYUvEvCyQortt7XmNpJJD/9gIdbyZ9xQi17ioi30ymeUajEeWYC83
         4NxxHC/EeJnyJ4XK54d7AW+2IbrnTU/NcELTXRrHUQhgFQDztv+lMzZJTkp6yUQXhI
         vhoIewxGXKTkkD1izP+GxMFpAbSmMDPfm3RIoIdfZEQDsAFclK60r940C6p4XqQx8T
         cVTO2CKICrClksWOIx5b2asP1noUwXIORO3Y9rYczrtt8n9apz+wXM8QatF6yS+gI3
         AIGihfHZqYJfg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     peterx@redhat.com, david@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] mm/userfaultfd: add VM_WARN_ONCE()
Date:   Thu, 16 Feb 2023 14:16:56 +0500
Message-Id: <20230216091656.2045471-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216091656.2045471-1-usama.anjum@collabora.com>
References: <20230216091656.2045471-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VM_WARN_ONCE() to uffd_wp_range() to detect range (start, len) abuse.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 mm/userfaultfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 77c5839e591c..d89ed44d2668 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -717,6 +717,8 @@ long uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
 	struct mmu_gather tlb;
 	long ret;
 
+	VM_WARN_ONCE(start < dst_vma->vm_start || start + len > dst_vma->vm_end,
+		     "The address range exceeds VMA boundary.\n");
 	if (enable_wp)
 		mm_cp_flags = MM_CP_UFFD_WP;
 	else
-- 
2.39.1

