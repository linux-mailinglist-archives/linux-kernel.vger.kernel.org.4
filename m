Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB666A1957
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjBXKBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBXKAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:00:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31FA41B53
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:00:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9D9CB60097;
        Fri, 24 Feb 2023 10:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677232842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Am3Z7D3PJEF75x3/HiQBrnXvVKIlV3/Qp4c3FogRta0=;
        b=p3ZE5uLwEtk/cg7EnX+HE43e+C5B6rCtvsUtSKn7CxdBPlUfloNsqfqkQFJ5WiO4rEiuzB
        CiB36BoqS/AxKRsf+8lfBJrCPJsWYiHD17DJ2nHjh2Thr9gF1vXZgckXkVNO2twWML+bU+
        lTrcHL3qGPcvWhSc4rpP5vsD4O3OOfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677232842;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Am3Z7D3PJEF75x3/HiQBrnXvVKIlV3/Qp4c3FogRta0=;
        b=exyNXp/OrTDQL6j9v3BOeWryfghFBfYZcF4TfoMJZypVOqnpw+z96xZJyOKkpRbJ2pT2R2
        zYGobN1KuemM3LAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8010B13A3C;
        Fri, 24 Feb 2023 10:00:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8O9WHsqK+GPeTgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 24 Feb 2023 10:00:42 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 11/11] mm/mremap: simplify vma expansion again
Date:   Fri, 24 Feb 2023 11:00:22 +0100
Message-Id: <20230224100022.11268-12-vbabka@suse.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224100022.11268-1-vbabka@suse.cz>
References: <20230224100022.11268-1-vbabka@suse.cz>
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

This effectively reverts d014cd7c1c35 ("mm, mremap: fix mremap()
expanding for vma's with vm_ops->close()"). After the recent changes,
vma_merge() is able to handle the expansion properly even when the vma
being expanded has a vm_ops->close operation, so we don't need to
special case it anymore.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 411a85682b58..65f5b545601e 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1040,23 +1040,11 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 			 * vma (expand operation itself) and possibly also with
 			 * the next vma if it becomes adjacent to the expanded
 			 * vma and  otherwise compatible.
-			 *
-			 * However, vma_merge() can currently fail due to
-			 * is_mergeable_vma() check for vm_ops->close (see the
-			 * comment there). Yet this should not prevent vma
-			 * expanding, so perform a simple expand for such vma.
-			 * Ideally the check for close op should be only done
-			 * when a vma would be actually removed due to a merge.
 			 */
-			if (!vma->vm_ops || !vma->vm_ops->close) {
-				vma = vma_merge(&vmi, mm, vma, extension_start,
-					extension_end, vma->vm_flags, vma->anon_vma,
-					vma->vm_file, extension_pgoff, vma_policy(vma),
-					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-			} else if (vma_expand(&vmi, vma, vma->vm_start,
-					addr + new_len, vma->vm_pgoff, NULL)) {
-				vma = NULL;
-			}
+			vma = vma_merge(&vmi, mm, vma, extension_start,
+				extension_end, vma->vm_flags, vma->anon_vma,
+				vma->vm_file, extension_pgoff, vma_policy(vma),
+				vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 			if (!vma) {
 				vm_unacct_memory(pages);
 				ret = -ENOMEM;
-- 
2.39.2

