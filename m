Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F756C3C23
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjCUUqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCUUq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:46:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8DF53D9C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:46:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o7so15041704wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679431583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+P4r5ohjfdtTt/Mfa4qHdLtxtbZQxPh6y+eJBbFwbQ=;
        b=Z7Gjn1KMJVHvSI9APFNDg5uxS4keAM8LnCBQVHmEJD6yDXb22mgga2nC+Rwzpa3IcL
         RxnTpVHSK77c6WZjwYzcArWUEA11ZTfmBWGOCiHBjlXCKMRLXbs81gxYbP0IC48tal5g
         WRJExwimKVuHKEA3MMDUsaZEbLPRcUotIfTZpvdQWzQTIqaBDRVsGhmIY5eQjn/HmVY+
         XB0ATW0xXz0JuaP839CKl/ExxesBCdeUyAjy45Hh+FiqMp4s1wi7/fmRN5+bjFdvP5ZS
         rvnko07nNRULJxK6AZtA4g7ZSCwxAA7z/iW+KMHwVR1NYBWCtfQtc4ZIRSNP4n/KeGhS
         c2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679431583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+P4r5ohjfdtTt/Mfa4qHdLtxtbZQxPh6y+eJBbFwbQ=;
        b=XCqocn1SzgWCULom/C8J6PkWlTi4GzzKWBPOt5IfuBYcVB0fTBjGosiM2fc4lrxGSK
         HI7fOM+Cx5orhTCUC0/XRZO6iIOLy05bB5dqgxrh/gnW9W4fcBZIc11D3uDr1O4d5IoD
         RhcdOvaLNAIGdD7w3rDFhOmFlmh1yEEe1Do0nIcft8moqqblt/GE8tkica1oI9r3DsnG
         uTlQ2Vcf8GAu7GtigfrW2k/vup/BHwd09PC4vAt5jHoaGKy+W2uFXsyr8hfO94N5iTAh
         fk052SYamCOj30ofZauewmBnxkJxeLJN7hCSTZM+z8u6+7SyVv28HHYDFXOLC4mc00NR
         +aLA==
X-Gm-Message-State: AO0yUKXxNLuJIcEgGr/+dUraEKARTib1n8Yrd55Gi4pQvbzqt5LqfOzo
        wrV5r/84e/oeXOEfQOXR+Go=
X-Google-Smtp-Source: AK7set9qKf2MHVF0+P2hb8JkRBr8OZ1hgZ3RUsK5mnnQG8b6+tURR09MpVh1Xlja767sSCFdhoOAuA==
X-Received: by 2002:adf:e242:0:b0:2ce:ad40:7705 with SMTP id bl2-20020adfe242000000b002cead407705mr3296806wrb.25.1679431582801;
        Tue, 21 Mar 2023 13:46:22 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id a4-20020adffb84000000b002d322b9a7f5sm12142491wrr.88.2023.03.21.13.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:46:21 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 2/4] mm/mmap/vma_merge: set next to NULL if not applicable
Date:   Tue, 21 Mar 2023 20:45:56 +0000
Message-Id: <3506997a8146a287ec13ee7a53cf916707537bf8.1679431180.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679431180.git.lstoakes@gmail.com>
References: <cover.1679431180.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are only interested in next if end == next->vm_start (in which case we
check to see if we can set merge_next), so perform this check alongside
checking whether curr should be set.

This groups all of the simple range checks together and establishes the
invariant that, if prev, curr or next are non-NULL then their positions are
as expected.

This has no functional impact.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c9834364ac98..6361baf75601 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -930,15 +930,15 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
-	curr = find_vma(mm, prev ? prev->vm_end : 0);
-	if (curr && curr->vm_end == end)		/* cases 6, 7, 8 */
-		next = find_vma(mm, curr->vm_end);
-	else
-		next = curr;
+	/* Does the input range span an existing VMA? (cases 5 - 8) */
+	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
 
-	/* In cases 1 - 4 there's no CCCC vma */
-	if (curr && end <= curr->vm_start)
-		curr = NULL;
+	if (curr && end == curr->vm_end)
+		/* Is there is a VMA immediately adjacent (cases 6 - 8)? */
+		next = vma_lookup(mm, curr->vm_end);
+	else if (!curr)
+		/* Is there a VMA next to a hole (case 1 - 3) or prev (4)? */
+		next = vma_lookup(mm, end);
 
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
@@ -959,11 +959,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		}
 	}
 	/* Can we merge the successor? */
-	if (next && end == next->vm_start &&
-			mpol_equal(policy, vma_policy(next)) &&
-			can_vma_merge_before(next, vm_flags,
-					     anon_vma, file, pgoff+pglen,
-					     vm_userfaultfd_ctx, anon_name)) {
+	if (next && mpol_equal(policy, vma_policy(next)) &&
+	    can_vma_merge_before(next, vm_flags,
+				 anon_vma, file, pgoff+pglen,
+				 vm_userfaultfd_ctx, anon_name)) {
 		merge_next = true;
 	}
 
-- 
2.39.2

