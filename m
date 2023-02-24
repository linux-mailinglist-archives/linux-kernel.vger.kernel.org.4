Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4AE6A1952
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjBXKA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjBXKAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:00:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4402F13522
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:00:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 00A3A5D557;
        Fri, 24 Feb 2023 10:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677232842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5q8VKPwKROzkXifx9I8bCKvnOQ0g3mM/tusCr5mero=;
        b=FkZbX3oM6Cbh3D9vF4OTlS4FEtmkzdsoP1fdhtB+vIWGIc+CTLYRlTKX8KbFw92wHRGZPk
        WRX3XrvuWQ3TQDnYUjAqrVH/yf8LuYVwYmGo8G/fpZtwL8+lMKXrD+HOS1lnD/3r9bkWXe
        hNJNx1Uv/Wl5YHbSfNRCm14Co1q1myQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677232842;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5q8VKPwKROzkXifx9I8bCKvnOQ0g3mM/tusCr5mero=;
        b=D1veafK8wyctiXKNfsLpv3h/IxiFkoGpNtuFUV49wvQf76mWBKOGpHONdPSxYiiIA9MSzq
        0iLisNPxtDRnFcDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBAD713246;
        Fri, 24 Feb 2023 10:00:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iFEFNcmK+GPeTgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 24 Feb 2023 10:00:41 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 06/11] mm/mmap/vma_merge: initialize mid and next in natural order
Date:   Fri, 24 Feb 2023 11:00:17 +0100
Message-Id: <20230224100022.11268-7-vbabka@suse.cz>
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

It is more intuitive to go from prev to mid and then next. No functional
change.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1e4be7174964..e7d497237f44 100644
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

