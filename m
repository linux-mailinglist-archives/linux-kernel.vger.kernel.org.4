Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161746A194E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjBXKAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjBXKAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:00:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAE065AF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:00:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3470733FFB;
        Fri, 24 Feb 2023 10:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677232841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQMJWpenP6OEu3AR0STwSIwzPSjq3AkhCnZCUwU4em4=;
        b=eOJS6frdV5UgXb66LQirAS9ZQ/sN6R7VVfUyUQO93GuJ7YDYy+gCcVKQpNK3ME6ofsbj+u
        qNoA75ZP+SCcWx6iNzv+kDslqOfh6KioPYBLkFW6Vm5wsP0uKlXfxMhG+f33PGKL2I+nON
        vlLQQ7NCxHTEb09vqsuUXAqKdYuwsts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677232841;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQMJWpenP6OEu3AR0STwSIwzPSjq3AkhCnZCUwU4em4=;
        b=8uSvZSyN2Kf6MO7A0WVXIqBZpcPjWwSrokqUDvePSMNZCMXdTvp4Mz2BcsSD0D1/fRbS9I
        yWrCVUnAmFfSuECg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B8B213A3C;
        Fri, 24 Feb 2023 10:00:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qEYfBsmK+GPeTgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 24 Feb 2023 10:00:41 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 01/11] mm/mremap: fix dup_anon_vma() in vma_merge() case 4
Date:   Fri, 24 Feb 2023 11:00:12 +0100
Message-Id: <20230224100022.11268-2-vbabka@suse.cz>
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

In case 4, we are shrinking 'prev' (PPPP in the comment) and expanding
'mid' (NNNN). So we need to make sure 'mid' clones the anon_vma from
'prev', if it doesn't have any. After commit 0503ea8f5ba7 ("mm/mmap:
remove __vma_adjust()") we can fail to do that due to wrong parameters
for dup_anon_vma(). The call is a no-op because res == next, adjust ==
mid and mid == next. Fix it.

Fixes: 0503ea8f5ba7 ("mm/mmap: remove __vma_adjust()")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 20f21f0949dd..740b54be3ed4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -973,7 +973,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_end = addr;
 			adjust = mid;
 			adj_next = -(vma->vm_end - addr);
-			err = dup_anon_vma(res, adjust);
+			err = dup_anon_vma(adjust, prev);
 		} else {
 			vma = next;			/* case 3 */
 			vma_start = addr;
-- 
2.39.2

