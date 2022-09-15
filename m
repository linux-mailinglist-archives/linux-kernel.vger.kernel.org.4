Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF33A5B9684
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIOIkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiIOIjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:39:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8F417072
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:39:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0A2BA5BE25;
        Thu, 15 Sep 2022 08:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663231186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HVt4BOPE3fE7s0bXLMbHOkdxiGKbxOKgMrc/CZYuzgY=;
        b=dLG+eMrIelUr4qu3McoZ7ce3j253SI0fHwesCYVIeS/nO/cQIPsbxqQ9DLOzOBM7U4KvJU
        c1kKjUqSifCG7mvi16UBzFVy1ZwBCfKBecm84k7U06XTkyopFfg6R++02zKlFsj0NgRvEH
        tNRD+LL8YGDOSO2FbgkZvcvAoBZ3+Tc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D37AE139C8;
        Thu, 15 Sep 2022 08:39:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kddZMtHkImMaBQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 15 Sep 2022 08:39:45 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH] xen/privcmd: remove privcmd_ioctl_mmap()
Date:   Thu, 15 Sep 2022 10:39:44 +0200
Message-Id: <20220915083944.10097-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOCTL_PRIVCMD_MMAP isn't in use by Xen since at least Xen 4.0.

Remove it from the privcmd driver.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/privcmd.c      | 138 +------------------------------------
 include/uapi/xen/privcmd.h |   2 -
 include/xen/xen-ops.h      |  24 -------
 3 files changed, 1 insertion(+), 163 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index e88e8f6f0a33..5136644f3008 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -147,42 +147,7 @@ static int gather_array(struct list_head *pagelist,
 /*
  * Call function "fn" on each element of the array fragmented
  * over a list of pages.
- */
-static int traverse_pages(unsigned nelem, size_t size,
-			  struct list_head *pos,
-			  int (*fn)(void *data, void *state),
-			  void *state)
-{
-	void *pagedata;
-	unsigned pageidx;
-	int ret = 0;
-
-	BUG_ON(size > PAGE_SIZE);
-
-	pageidx = PAGE_SIZE;
-	pagedata = NULL;	/* hush, gcc */
-
-	while (nelem--) {
-		if (pageidx > PAGE_SIZE-size) {
-			struct page *page;
-			pos = pos->next;
-			page = list_entry(pos, struct page, lru);
-			pagedata = page_address(page);
-			pageidx = 0;
-		}
-
-		ret = (*fn)(pagedata + pageidx, state);
-		if (ret)
-			break;
-		pageidx += size;
-	}
-
-	return ret;
-}
-
-/*
- * Similar to traverse_pages, but use each page as a "block" of
- * data to be processed as one unit.
+ * Use each page as a "block" of data to be processed as one unit.
  */
 static int traverse_pages_block(unsigned nelem, size_t size,
 				struct list_head *pos,
@@ -211,103 +176,6 @@ static int traverse_pages_block(unsigned nelem, size_t size,
 	return ret;
 }
 
-struct mmap_gfn_state {
-	unsigned long va;
-	struct vm_area_struct *vma;
-	domid_t domain;
-};
-
-static int mmap_gfn_range(void *data, void *state)
-{
-	struct privcmd_mmap_entry *msg = data;
-	struct mmap_gfn_state *st = state;
-	struct vm_area_struct *vma = st->vma;
-	int rc;
-
-	/* Do not allow range to wrap the address space. */
-	if ((msg->npages > (LONG_MAX >> PAGE_SHIFT)) ||
-	    ((unsigned long)(msg->npages << PAGE_SHIFT) >= -st->va))
-		return -EINVAL;
-
-	/* Range chunks must be contiguous in va space. */
-	if ((msg->va != st->va) ||
-	    ((msg->va+(msg->npages<<PAGE_SHIFT)) > vma->vm_end))
-		return -EINVAL;
-
-	rc = xen_remap_domain_gfn_range(vma,
-					msg->va & PAGE_MASK,
-					msg->mfn, msg->npages,
-					vma->vm_page_prot,
-					st->domain, NULL);
-	if (rc < 0)
-		return rc;
-
-	st->va += msg->npages << PAGE_SHIFT;
-
-	return 0;
-}
-
-static long privcmd_ioctl_mmap(struct file *file, void __user *udata)
-{
-	struct privcmd_data *data = file->private_data;
-	struct privcmd_mmap mmapcmd;
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	int rc;
-	LIST_HEAD(pagelist);
-	struct mmap_gfn_state state;
-
-	/* We only support privcmd_ioctl_mmap_batch for non-auto-translated. */
-	if (xen_feature(XENFEAT_auto_translated_physmap))
-		return -ENOSYS;
-
-	if (copy_from_user(&mmapcmd, udata, sizeof(mmapcmd)))
-		return -EFAULT;
-
-	/* If restriction is in place, check the domid matches */
-	if (data->domid != DOMID_INVALID && data->domid != mmapcmd.dom)
-		return -EPERM;
-
-	rc = gather_array(&pagelist,
-			  mmapcmd.num, sizeof(struct privcmd_mmap_entry),
-			  mmapcmd.entry);
-
-	if (rc || list_empty(&pagelist))
-		goto out;
-
-	mmap_write_lock(mm);
-
-	{
-		struct page *page = list_first_entry(&pagelist,
-						     struct page, lru);
-		struct privcmd_mmap_entry *msg = page_address(page);
-
-		vma = find_vma(mm, msg->va);
-		rc = -EINVAL;
-
-		if (!vma || (msg->va != vma->vm_start) || vma->vm_private_data)
-			goto out_up;
-		vma->vm_private_data = PRIV_VMA_LOCKED;
-	}
-
-	state.va = vma->vm_start;
-	state.vma = vma;
-	state.domain = mmapcmd.dom;
-
-	rc = traverse_pages(mmapcmd.num, sizeof(struct privcmd_mmap_entry),
-			    &pagelist,
-			    mmap_gfn_range, &state);
-
-
-out_up:
-	mmap_write_unlock(mm);
-
-out:
-	free_page_list(&pagelist);
-
-	return rc;
-}
-
 struct mmap_batch_state {
 	domid_t domain;
 	unsigned long va;
@@ -844,10 +712,6 @@ static long privcmd_ioctl(struct file *file,
 		ret = privcmd_ioctl_hypercall(file, udata);
 		break;
 
-	case IOCTL_PRIVCMD_MMAP:
-		ret = privcmd_ioctl_mmap(file, udata);
-		break;
-
 	case IOCTL_PRIVCMD_MMAPBATCH:
 		ret = privcmd_ioctl_mmap_batch(file, udata, 1);
 		break;
diff --git a/include/uapi/xen/privcmd.h b/include/uapi/xen/privcmd.h
index d2029556083e..6101d1566238 100644
--- a/include/uapi/xen/privcmd.h
+++ b/include/uapi/xen/privcmd.h
@@ -113,8 +113,6 @@ struct privcmd_mmap_resource {
  */
 #define IOCTL_PRIVCMD_HYPERCALL					\
 	_IOC(_IOC_NONE, 'P', 0, sizeof(struct privcmd_hypercall))
-#define IOCTL_PRIVCMD_MMAP					\
-	_IOC(_IOC_NONE, 'P', 2, sizeof(struct privcmd_mmap))
 #define IOCTL_PRIVCMD_MMAPBATCH					\
 	_IOC(_IOC_NONE, 'P', 3, sizeof(struct privcmd_mmapbatch))
 #define IOCTL_PRIVCMD_MMAPBATCH_V2				\
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index dae0f350c678..a07e422be09a 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -159,30 +159,6 @@ static inline int xen_remap_domain_mfn_array(struct vm_area_struct *vma,
 			     true);
 }
 
-/* xen_remap_domain_gfn_range() - map a range of foreign frames
- * @vma:     VMA to map the pages into
- * @addr:    Address at which to map the pages
- * @gfn:     First GFN to map.
- * @nr:      Number frames to map
- * @prot:    page protection mask
- * @domid:   Domain owning the pages
- * @pages:   Array of pages if this domain has an auto-translated physmap
- *
- * Returns the number of successfully mapped frames, or a -ve error
- * code.
- */
-static inline int xen_remap_domain_gfn_range(struct vm_area_struct *vma,
-					     unsigned long addr,
-					     xen_pfn_t gfn, int nr,
-					     pgprot_t prot, unsigned int domid,
-					     struct page **pages)
-{
-	if (xen_feature(XENFEAT_auto_translated_physmap))
-		return -EOPNOTSUPP;
-
-	return xen_remap_pfn(vma, addr, &gfn, nr, NULL, prot, domid, false);
-}
-
 int xen_unmap_domain_gfn_range(struct vm_area_struct *vma,
 			       int numpgs, struct page **pages);
 
-- 
2.35.3

