Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA696B228B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjCILSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjCILRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:17:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417ED521F3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:13:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9EADF20037;
        Thu,  9 Mar 2023 11:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678360391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSk6Q5fXV5lgNPoon595PuYz0dxCHrt88iESPc6EpdI=;
        b=lF0QP81+QKvoOQpeTgIS8OuYXUwgoPjaJ5K5ZuviX/M/vhmhbbatmHhloTBMPt7pUSLB32
        /+yCTqzD2huaZPmtnyXRtujsZXWpG3bYItFfpYYmsPHXpawLsT5fwHVTyI+MkMTpj5EOcT
        I5QmCvc+sLG68EuiMAJ0C84/1DmeuQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678360391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSk6Q5fXV5lgNPoon595PuYz0dxCHrt88iESPc6EpdI=;
        b=yKYa9OI8nzeEPmzRVx1GveVD6Yxc49Mh1tRy3l6C/KWuUi/LdCH1RQG0V03rxZhqphs1Fs
        HDCjKEqqNgJt48CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D5AE13A73;
        Thu,  9 Mar 2023 11:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YAsDHke/CWRiRwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Mar 2023 11:13:11 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 05/10] mm/mmap/vma_merge: initialize mid and next in natural order
Date:   Thu,  9 Mar 2023 12:12:53 +0100
Message-Id: <20230309111258.24079-6-vbabka@suse.cz>
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

It is more intuitive to go from prev to mid and then next. No functional
change.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 420d6847c94c..be60b344e4b1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -912,10 +912,11 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
-	next = find_vma(mm, prev ? prev->vm_end : 0);
-	mid = next;
-	if (next && next->vm_end == end)		/* cases 6, 7, 8 */
-		next = find_vma(mm, next->vm_end);
+	mid = find_vma(mm, prev ? prev->vm_end : 0);
+	if (mid && mid->vm_end == end)			/* cases 6, 7, 8 */
+		next = find_vma(mm, mid->vm_end);
+	else
+		next = mid;
 
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
-- 
2.39.2

