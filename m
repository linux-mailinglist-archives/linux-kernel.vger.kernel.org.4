Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16E86B2281
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjCILRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjCILRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:17:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BA852F43
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:13:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CE9821E8C;
        Thu,  9 Mar 2023 11:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678360391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wE1al//pCc1to1HvUyvkZo2jQrSNJIISu5e3jqOmb4s=;
        b=veUZEMzEMFoFQBSMkP7TVCeLql/YYD/acm4DYFiB8bth7DfTCzjmSL7zWAGRSKNsFvCzPv
        80vdMoqx0HTQ4/7N9cFLCg8kRPqV7ipaRyEJY3x42qSIis4ntpoOTThU2WXvVT+g36j1KN
        RtXw5mM+Lk132MHltILMEq5ZhGqMj0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678360391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wE1al//pCc1to1HvUyvkZo2jQrSNJIISu5e3jqOmb4s=;
        b=uNtMsgjSDTk/7Nv8XNxPldzlzzfl+cS/tPmooh3HejHqR7vHiuhfcC3t1a+EIzZdoeipTI
        HFfyME6YvqFto0Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DE691391B;
        Thu,  9 Mar 2023 11:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qHtIFke/CWRiRwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Mar 2023 11:13:11 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 04/10] mm/mmap/vma_merge: use the proper vma pointer in case 4
Date:   Thu,  9 Mar 2023 12:12:52 +0100
Message-Id: <20230309111258.24079-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309111258.24079-1-vbabka@suse.cz>
References: <20230309111258.24079-1-vbabka@suse.cz>
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

Almost all cases now use the 'next' pointer for the vma following
the merged area, and the cases diagram shows it as XXXX. Case 4 is
different as it uses 'mid' and NNNN, so change it for consistency. No
functional change.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c33237b283c9..420d6847c94c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -851,9 +851,9 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
  * vma, PPPPPP is the prev vma specified, and NNNNNN the next vma after:
  *
  *     AAAA             AAAA                   AAAA
- *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPNNNNNN
+ *    PPPPPPNNNNNN    PPPPPPXXXXXX       PPPPPPNNNNNN
  *    cannot merge    might become       might become
- *                    PPNNNNNNNNNN       PPPPPPPPPPNN
+ *                    PPXXXXXXXXXX       PPPPPPPPPPNN
  *    mmap, brk or    case 4 below       case 5 below
  *    mremap move:
  *                        AAAA               AAAA
@@ -972,9 +972,9 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		res = next;
 		if (prev && addr < prev->vm_end) {	/* case 4 */
 			vma_end = addr;
-			adjust = mid;
+			adjust = next;
 			adj_next = -(prev->vm_end - addr);
-			err = dup_anon_vma(mid, prev);
+			err = dup_anon_vma(next, prev);
 		} else {
 			vma = next;			/* case 3 */
 			vma_start = addr;
-- 
2.39.2

