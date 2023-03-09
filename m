Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C276B227B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjCILRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjCILRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:17:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9265254C9A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:13:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 28AA521E8D;
        Thu,  9 Mar 2023 11:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678360392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Qu5xXTySwPTF8dLZgi/I8vkKzIjKqyV6OaDVaB++xA=;
        b=smy++lI06RTR8P0db6O40WjBYDL0CeoTsxIDL+R5wzE6TncyoEn05HoKhjDWqaGzli6JEI
        3GPGSrV0LDlKChKJhDhqhxVaooJcuqBjs0RN+6O6N1NHB8W9t1Iyg0t2hLpFQzhKeULqs2
        dgjXsXdgZiumNxXHEFV8o0dUFaFQGfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678360392;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Qu5xXTySwPTF8dLZgi/I8vkKzIjKqyV6OaDVaB++xA=;
        b=e4ZqfoNDC7qdrfkIKt0ip7rtx+nWJSRX54u1pQUZUHNLoo3srPoDVcEHGdEnh7PdXiVbw2
        e9byDlL3I6x1iZAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09FA513A73;
        Thu,  9 Mar 2023 11:13:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YLbTAUi/CWRiRwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Mar 2023 11:13:12 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 09/10] mm/mmap: start distinguishing if vma can be removed in mergeability test
Date:   Thu,  9 Mar 2023 12:12:57 +0100
Message-Id: <20230309111258.24079-10-vbabka@suse.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309111258.24079-1-vbabka@suse.cz>
References: <20230309111258.24079-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since pre-git times, is_mergeable_vma() returns false for a vma with
vm_ops->close, so that no owner assumptions are violated in case the vma
is removed as part of the merge.

This check is currently very conservative and can prevent merging even
situations where vma can't be removed, such as simple expansion of
previous vma, as evidenced by commit d014cd7c1c35 ("mm, mremap: fix
mremap() expanding for vma's with vm_ops->close()")

In order to allow more merging when appropriate and simplify the code
that was made more complex by commit d014cd7c1c35, start distinguishing
cases where the vma can be really removed, and allow merging with
vm_ops->close otherwise.

As a first step, add a may_remove_vma parameter to is_mergeable_vma().
can_vma_merge_before() sets it to true, because when called from
vma_merge(), a removal of the vma is possible.

In can_vma_merge_after(), pass the parameter as false, because no
removal can occur in each of its callers:
- vma_merge() calls it on the 'prev' vma, which is never removed
- mmap_region() and do_brk_flags() call it to determine if it can expand
  a vma, which is not removed

As a result, vma's with vm_ops->close may now merge with compatible
ranges in more situations than previously. We can also revert commit
d014cd7c1c35 as the next step to simplify mremap code again.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d20bbe9ec613..65503ea07f32 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -742,12 +742,13 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 /*
  * If the vma has a ->close operation then the driver probably needs to release
- * per-vma resources, so we don't attempt to merge those.
+ * per-vma resources, so we don't attempt to merge those in case the caller
+ * indicates the current vma may be removed as part of the merge.
  */
 static inline bool is_mergeable_vma(struct vm_area_struct *vma,
 		struct file *file, unsigned long vm_flags,
 		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name)
+		struct anon_vma_name *anon_name, bool may_remove_vma)
 {
 	/*
 	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
@@ -761,7 +762,7 @@ static inline bool is_mergeable_vma(struct vm_area_struct *vma,
 		return false;
 	if (vma->vm_file != file)
 		return false;
-	if (vma->vm_ops && vma->vm_ops->close)
+	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
 		return false;
 	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
 		return false;
@@ -793,6 +794,8 @@ static inline bool is_mergeable_anon_vma(struct anon_vma *anon_vma1,
  * We don't check here for the merged mmap wrapping around the end of pagecache
  * indices (16TB on ia32) because do_mmap() does not permit mmap's which
  * wrap, nor mmaps which cover the final page at index -1UL.
+ *
+ * We assume the vma may be removed as part of the merge.
  */
 static bool
 can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
@@ -800,7 +803,7 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
 		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
 		struct anon_vma_name *anon_name)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name) &&
+	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, true) &&
 	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
 		if (vma->vm_pgoff == vm_pgoff)
 			return true;
@@ -814,6 +817,8 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
  *
  * We cannot merge two vmas if they have differently assigned (non-NULL)
  * anon_vmas, nor if same anon_vma is assigned but offsets incompatible.
+ *
+ * We assume that vma is not removed as part of the merge.
  */
 static bool
 can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
@@ -821,7 +826,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
 		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
 		struct anon_vma_name *anon_name)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name) &&
+	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
 	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
 		pgoff_t vm_pglen;
 		vm_pglen = vma_pages(vma);
-- 
2.39.2

