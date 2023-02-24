Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311046A195A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjBXKBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjBXKAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:00:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0763565AF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:00:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 531353438B;
        Fri, 24 Feb 2023 10:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677232842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0wR3jwDHdRrK2cxRZw/xy12wIZu3wsnwhuoBXj0MMQ=;
        b=KWXyMuNXAW1CBLQTUubfz3ZaB4JYVNhcclgO1jGZo5VjK6IDmNbuyTJUDOInBfy+/ZGReA
        Y+HFC5k0Wq59VWumMLMp6pHq3RbsWuvQGG0vn2V82+czWBpqRgGUMY2x503sc+riFul2hW
        56TNM/afvXjy39C5sTvBMDTsk9V5GCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677232842;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0wR3jwDHdRrK2cxRZw/xy12wIZu3wsnwhuoBXj0MMQ=;
        b=f0IpufU3BmvceE+pCst74byvq0uqDgv/mlVa6jatNSqcFHEa2tIXy68JhhykiA7j/U+YuX
        DMu+EH3Z7aJfuQDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3820713A3C;
        Fri, 24 Feb 2023 10:00:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eN3yDMqK+GPeTgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 24 Feb 2023 10:00:42 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 09/11] mm/mmap/vma_merge: convert mergeability checks to return bool
Date:   Fri, 24 Feb 2023 11:00:20 +0100
Message-Id: <20230224100022.11268-10-vbabka@suse.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224100022.11268-1-vbabka@suse.cz>
References: <20230224100022.11268-1-vbabka@suse.cz>
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

The comments already mention returning 'true' so make the code match
them.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8c2bdf9e3f94..6e439806d4ac 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -744,10 +744,10 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * If the vma has a ->close operation then the driver probably needs to release
  * per-vma resources, so we don't attempt to merge those.
  */
-static inline int is_mergeable_vma(struct vm_area_struct *vma,
-				   struct file *file, unsigned long vm_flags,
-				   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-				   struct anon_vma_name *anon_name)
+static inline bool is_mergeable_vma(struct vm_area_struct *vma,
+				    struct file *file, unsigned long vm_flags,
+				    struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+				    struct anon_vma_name *anon_name)
 {
 	/*
 	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
@@ -758,21 +758,21 @@ static inline int is_mergeable_vma(struct vm_area_struct *vma,
 	 * extended instead.
 	 */
 	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
-		return 0;
+		return false;
 	if (vma->vm_file != file)
-		return 0;
+		return false;
 	if (vma->vm_ops && vma->vm_ops->close)
-		return 0;
+		return false;
 	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
-		return 0;
+		return false;
 	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
-		return 0;
-	return 1;
+		return false;
+	return true;
 }
 
-static inline int is_mergeable_anon_vma(struct anon_vma *anon_vma1,
-					struct anon_vma *anon_vma2,
-					struct vm_area_struct *vma)
+static inline bool is_mergeable_anon_vma(struct anon_vma *anon_vma1,
+					 struct anon_vma *anon_vma2,
+					 struct vm_area_struct *vma)
 {
 	/*
 	 * The list_is_singular() test is to avoid merging VMA cloned from
@@ -780,7 +780,7 @@ static inline int is_mergeable_anon_vma(struct anon_vma *anon_vma1,
 	 */
 	if ((!anon_vma1 || !anon_vma2) && (!vma ||
 		list_is_singular(&vma->anon_vma_chain)))
-		return 1;
+		return true;
 	return anon_vma1 == anon_vma2;
 }
 
@@ -795,7 +795,7 @@ static inline int is_mergeable_anon_vma(struct anon_vma *anon_vma1,
  * indices (16TB on ia32) because do_mmap() does not permit mmap's which
  * wrap, nor mmaps which cover the final page at index -1UL.
  */
-static int
+static bool
 can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
 		     struct anon_vma *anon_vma, struct file *file,
 		     pgoff_t vm_pgoff,
@@ -805,9 +805,9 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
 	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name) &&
 	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
 		if (vma->vm_pgoff == vm_pgoff)
-			return 1;
+			return true;
 	}
-	return 0;
+	return false;
 }
 
 /*
@@ -817,7 +817,7 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
  * We cannot merge two vmas if they have differently assigned (non-NULL)
  * anon_vmas, nor if same anon_vma is assigned but offsets incompatible.
  */
-static int
+static bool
 can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
 		    struct anon_vma *anon_vma, struct file *file,
 		    pgoff_t vm_pgoff,
@@ -829,9 +829,9 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
 		pgoff_t vm_pglen;
 		vm_pglen = vma_pages(vma);
 		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
-			return 1;
+			return true;
 	}
-	return 0;
+	return false;
 }
 
 /*
-- 
2.39.2

