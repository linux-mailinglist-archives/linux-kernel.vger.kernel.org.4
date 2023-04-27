Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B809C6F0715
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243563AbjD0OQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243284AbjD0OP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:15:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C717E2120;
        Thu, 27 Apr 2023 07:15:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 866531FE3F;
        Thu, 27 Apr 2023 14:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682604954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Il+yD+2lfaLcjR30nIENVgJ22FZJ2MalcSOfRbNauAQ=;
        b=lUVjqm3Yguq+EVReYw6PKR5y5UazXbk4fNyWxP/8DO1B81BNhuJnCykepn7ZRjNjmnKe00
        S3+pJDrzmH9//ugqGmT/j5kY8jnNF2nn4W/7SyEZaFr4zTmOPmIa+Bd8ABIVOriR3NPaSU
        F/3t6lZyZjfX3meojUl5UQ2muc/jb54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682604954;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Il+yD+2lfaLcjR30nIENVgJ22FZJ2MalcSOfRbNauAQ=;
        b=NqcuF5KJZVx5kpXGiXxv5BAd7l20u/IWqEXqhHAM7SMK8f41dygb3hYuElQqbTgH4rfN1t
        6jnfB6yxorXmgYDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58ADB13910;
        Thu, 27 Apr 2023 14:15:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7YEUFZqDSmR+EwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 27 Apr 2023 14:15:54 +0000
Message-ID: <d193613d-150d-bdaa-da7a-62bc088fae5e@suse.cz>
Date:   Thu, 27 Apr 2023 16:15:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH for v6.3 regression] mm/mremap: fix vm_pgoff in
 vma_merge() case 3
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, lstoakes@gmail.com,
        regressions@lists.linux.dev, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Fabian Vogt <fvogt@suse.com>, stable@vger.kernel.org
References: <20230427140959.27655-1-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230427140959.27655-1-vbabka@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 16:09, Vlastimil Babka wrote:
> |later. Alternatively it could be added to mm/mm-stable and upcoming 6.4
> pull request, but then the stable backport would need adjustment. It's up to
> Linus and Andrew. |

This version applies on mm/mm-stable. Paragraph about case 8 is removed
as that case sets vma_pgoff explicitly itself.

----8<----
From dea6d87bdad1fbb21f987dba96c55195fb88e7b4 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 27 Apr 2023 15:28:41 +0200
Subject: [PATCH] mm/mremap: fix vm_pgoff in vma_merge() case 3

After upgrading build guests to v6.3, rpm started segfaulting for
specific packages, which was bisected to commit 0503ea8f5ba7 ("mm/mmap:
remove __vma_adjust()"). rpm is doing many mremap() operations with file
mappings of its db. The problem is that in vma_merge() case 3 (we merge
with the next vma, expanding it downwards) vm_pgoff is not adjusted as
it should when vm_start changes. As a result the rpm process most likely
sees data from the wrong offset of the file. Fix the vm_pgoff
calculation.

Reported-and-bisected-by: Jiri Slaby <jirislaby@kernel.org>
Reported-and-tested-by: Fabian Vogt <fvogt@suse.com>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1210903
Fixes: 0503ea8f5ba7 ("mm/mmap: remove __vma_adjust()")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 536bbb8fa0ae..5522130ae606 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1008,7 +1008,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma = next;			/* case 3 */
 			vma_start = addr;
 			vma_end = next->vm_end;
-			vma_pgoff = next->vm_pgoff;
+			vma_pgoff = next->vm_pgoff - pglen;
 			if (curr) {			/* case 8 */
 				vma_pgoff = curr->vm_pgoff;
 				remove = curr;
-- 
2.40.0


