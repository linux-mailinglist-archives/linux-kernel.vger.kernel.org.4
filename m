Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3D86DFF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjDLT7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDLT7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:59:44 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E56AD3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:59:43 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id l11so14161244qtj.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1681329582; x=1683921582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dw+CWACRZsXFxLftto9WrsOlG3O76TJuQrKX+zvFATY=;
        b=YhLpdi3+0jUzIX1YuB+r9CraTavpImPkjyW8na7sQw8iNCJwZl8oL881pRmVX0cWm8
         yPW/G4zD+mb7ZWuLNbxaUHOvF6HRo9w4bxK1LwexUXFwpPGP4DNy3qbPBr9pj4mIJKYO
         vmapX99d5UskrdNAovMELRusPJkxLffPBgH8qK2zf5PeNE1rHGq7D6MTa8/C/WDz+6WT
         AnbhfZDe3k2Zju5D0ZIGweRTDGlnfgx3zKngCNOKBF6TdU9jziAok0yszwgEnatOfPoB
         veUNzaTSW2uto4cRdHotqCb/ek7Zl9+pVNDkRBUAtGXnIzC9wUjQ6MU2Zzm6xZ4nxcOL
         0/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681329582; x=1683921582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dw+CWACRZsXFxLftto9WrsOlG3O76TJuQrKX+zvFATY=;
        b=Bl0pKCfvXRISczDkKIaHns2OhDozBscZhR0UWidaBL0HYTDXAjCtaozVxZzOAUgGGv
         CFyDHPNoIeFjIZ/+UfxCP08utUVuKiJRauOP0eK23oW3RpvsLKt3MulMJvCjm0KdiWXs
         Vp/ksOnyiH1Ij7AzBV4JI0K8q1WAI2+Jn7lRPmkQtoVjo36dDvt4vgDAFSs+hB+y72ti
         9PQJ3mff4kKEHvVMCBRYyL8REBPx49wlLjoX/yp/19K2MhBckH//I1l7GAqSw+aK3vAI
         OYoAGKdCN9aP4kGsrKN2PZxZ4pxUuGzlbvdJs3rFjeA4GyUVFN5V4xZlqqMa98xtcGhL
         uXtw==
X-Gm-Message-State: AAQBX9cqNC6OkXJ4guKspcRQ6v4GZp+q2HqT+YvthFo2fHs2OltCOfFh
        y7EEL+GYN9No8FCBJWKzlqbTsw==
X-Google-Smtp-Source: AKy350ZBZ7+QxyO70G0a3OfH9O3pPgV5amEiB4UezT5PCbHingEGJ338rE0MSo148xObrYKclTI3qw==
X-Received: by 2002:a05:622a:1102:b0:3e2:3ae2:790e with SMTP id e2-20020a05622a110200b003e23ae2790emr24712205qty.32.1681329582240;
        Wed, 12 Apr 2023 12:59:42 -0700 (PDT)
Received: from soleen.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id do28-20020a05620a2b1c00b007484bc04a63sm4896504qkb.99.2023.04.12.12.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:59:41 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mhocko@suse.com, muchun.song@linux.dev,
        rientjes@google.com, souravpanda@google.com
Subject: [PATCH v2] mm: hugetlb_vmemmap: provide stronger vmemmap allocation guarantees
Date:   Wed, 12 Apr 2023 19:59:39 +0000
Message-Id: <20230412195939.1242462-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HugeTLB pages have a struct page optimizations where struct pages for tail
pages are freed. However, when HugeTLB pages are destroyed, the memory for
struct pages (vmemmap) need to be allocated again.

Currently, __GFP_NORETRY flag is used to allocate the memory for vmemmap,
but given that this flag makes very little effort to actually reclaim
memory the returning of huge pages back to the system can be problem. Lets
use __GFP_RETRY_MAYFAIL instead. This flag is also performs graceful
reclaim without causing ooms, but at least it may perform a few retries,
and will fail only when there is genuinely little amount of unused memory
in the system.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Suggested-by: David Rientjes <rientjes@google.com>
---
 mm/hugetlb_vmemmap.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Changelog:
v2
  - removed gfp_mask argument from alloc_vmemmap_page_list as suggested by
    David Rientjes.
  - Fixed spelling in the patch title.

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index a559037cce00..236647e4bfec 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -384,8 +384,9 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 }
 
 static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
-				   gfp_t gfp_mask, struct list_head *list)
+				   struct list_head *list)
 {
+	gfp_t gfp_mask = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_THISNODE;
 	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
 	int nid = page_to_nid((struct page *)start);
 	struct page *page, *next;
@@ -413,12 +414,11 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
- * @gfp_mask:	GFP flag for allocating vmemmap pages.
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
-			       unsigned long reuse, gfp_t gfp_mask)
+			       unsigned long reuse)
 {
 	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
@@ -430,7 +430,7 @@ static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 	/* See the comment in the vmemmap_remap_free(). */
 	BUG_ON(start - reuse != PAGE_SIZE);
 
-	if (alloc_vmemmap_page_list(start, end, gfp_mask, &vmemmap_pages))
+	if (alloc_vmemmap_page_list(start, end, &vmemmap_pages))
 		return -ENOMEM;
 
 	mmap_read_lock(&init_mm);
@@ -476,8 +476,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	 * When a HugeTLB page is freed to the buddy allocator, previously
 	 * discarded vmemmap pages must be allocated and remapping.
 	 */
-	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse,
-				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
+	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse);
 	if (!ret) {
 		ClearHPageVmemmapOptimized(head);
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
-- 
2.40.0.577.gac1e443424-goog

