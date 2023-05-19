Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B96709FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjESTKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjESTKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:10:21 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC76E4D
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:09:48 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-42c38a6daf3so2289154137.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684523387; x=1687115387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oA7dMwlFmxPwFfHcKnUeZ7hJdv/AmQxUS93JuDL6gPU=;
        b=PCCuvdHXc4XusTKOuKnfHxqjmcKF33HedUvjSSIEB/LXCB8ftanEMvL27R617BEABE
         Y/SPIH6C+KoN5BEgulkLv5sqTuTF5fabGZNZo/HEVlSSY07Ygemgsus3/woEkmwUHdjS
         jaexiTko+LYiXNXWhDhnPmbUFhCF0ImXBUCV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684523387; x=1687115387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oA7dMwlFmxPwFfHcKnUeZ7hJdv/AmQxUS93JuDL6gPU=;
        b=O1+jRjyHwYa8vEMhCFauSsxljukPOC//0VmyxxybUy/695PgwmFP1n4i7kHtYDqjVO
         xImJzheVaTn2kMG58QLS44tU6u3F32PvBxaShjcBjBnSKMQaIgfGToxCJi68E7foTWt3
         e5H3l1sE58bAcBqozqRafz1ekkzuR2omb4XBfPLVyZmr49lTtwuPsR4Cwf+TMpSqKFjA
         0GcOQUL3hbJLur0juqBAuZPj/PjwPwLlcfk36G57PdQoqfIt66/CE7On8hFZR5Tff62u
         8+rboxCt3625KP/twjQU6QvqouI3gaW7cf3czXYq2Ww8rVJXig/e4F2iCUpJQWpyuJjv
         vxmg==
X-Gm-Message-State: AC+VfDxvBWtx8Bxs2J8CgDmqHsyhAcYuMGiHaq6fIMFQwxmHzoo0j9ZA
        NMtIyejYCQD40BV4EODXHslN0oZdEtlJvQ+nfgU=
X-Google-Smtp-Source: ACHHUZ5tNnkzlczdh01+L99WDBDunQiDAPpU6vp4udkIFHQy9fkqGeBYT8FDX47Do14GAQyh+6aSSA==
X-Received: by 2002:a05:6102:2ca:b0:436:2c6f:207f with SMTP id h10-20020a05610202ca00b004362c6f207fmr199261vsh.6.1684523386917;
        Fri, 19 May 2023 12:09:46 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id q20-20020ae9e414000000b0074e1ee30478sm1317611qkc.37.2023.05.19.12.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 12:09:46 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 1/4] mm/mremap: Optimize the start addresses in move_page_tables()
Date:   Fri, 19 May 2023 19:09:31 +0000
Message-ID: <20230519190934.339332-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519190934.339332-1-joel@joelfernandes.org>
References: <20230519190934.339332-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, we see reports [1] of a warning that triggers due to
move_page_tables() doing a downward and overlapping move on a
mutually-aligned offset within a PMD. By mutual alignment, I
mean the source and destination addresses of the mremap are at
the same offset within a PMD.

This mutual alignment along with the fact that the move is downward is
sufficient to cause a warning related to having an allocated PMD that
does not have PTEs in it.

This warning will only trigger when there is mutual alignment in the
move operation. A solution, as suggested by Linus Torvalds [2], is to
initiate the copy process at the PMD level whenever such alignment is
present. Implementing this approach will not only prevent the warning
from being triggered, but it will also optimize the operation as this
method should enhance the speed of the copy process whenever there's a
possibility to start copying at the PMD level.

Some more points:
a. The optimization can be done only when both the source and
destination of the mremap do not have anything mapped below it up to a
PMD boundary. I add support to detect that.

b. #1 is not a problem for the call to move_page_tables() from exec.c as
nothing is expected to be mapped below the source/destination. However,
for non-overlapping mutually aligned moves as triggered by mremap(2),
I added support for checking such cases.

c. I currently only optimize for PMD moves, in the future I/we can build
on this work and do PUD moves as well if there is a need for this. But I
want to take it one step at a time.

[1] https://lore.kernel.org/all/ZB2GTBD%2FLWTrkOiO@dhcp22.suse.cz/
[2] https://lore.kernel.org/all/CAHk-=whd7msp8reJPfeGNyt0LiySMT0egExx3TVZSX3Ok6X=9g@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/mremap.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 411a85682b58..be81eb3a80a8 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -478,6 +478,51 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
 	return moved;
 }
 
+/*
+ * A helper to check if a previous mapping exists. Required for
+ * move_page_tables() and realign_addr() to determine if a previous mapping
+ * exists before we can do realignment optimizations.
+ */
+static bool check_addr_in_prev(struct vm_area_struct *vma, unsigned long addr,
+			       unsigned long mask)
+{
+	int addr_masked = addr & mask;
+	struct vm_area_struct *prev = NULL, *cur = NULL;
+
+	/* If the masked address is within vma, there is no prev mapping of concern. */
+	if (vma->vm_start <= addr_masked)
+		return false;
+
+	/*
+	 * Attempt to find vma before prev that contains the address.
+	 * On any issue, assume the address is within a previous mapping.
+	 * @mmap write lock is held here, so the lookup is safe.
+	 */
+	cur = find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
+	if (!cur || cur != vma || !prev)
+		return true;
+
+	/* The masked address fell within a previous mapping. */
+	if (prev->vm_end > addr_masked)
+		return true;
+
+	return false;
+}
+
+/* Opportunistically realign to specified boundary for faster copy. */
+static void realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
+			 unsigned long *new_addr, struct vm_area_struct *new_vma,
+			 unsigned long mask)
+{
+	if ((*old_addr & ~mask) &&
+	    (*old_addr & ~mask) == (*new_addr & ~mask) &&
+	    !check_addr_in_prev(old_vma, *old_addr, mask) &&
+	    !check_addr_in_prev(new_vma, *new_addr, mask)) {
+		*old_addr = *old_addr & mask;
+		*new_addr = *new_addr & mask;
+	}
+}
+
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
@@ -493,6 +538,10 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
 	old_end = old_addr + len;
 
+	/* If possible, realign addresses to PMD boundary for faster copy. */
+	if (len >= PMD_SIZE - (old_addr & ~PMD_MASK))
+		realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
+
 	if (is_vm_hugetlb_page(vma))
 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
 						new_addr, len);
@@ -565,6 +614,13 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
 	mmu_notifier_invalidate_range_end(&range);
 
+	/*
+	 * Prevent negative return values when {old,new}_addr was realigned
+	 * but we broke out of the above loop for the first PMD itself.
+	 */
+	if (len + old_addr < old_end)
+		return 0;
+
 	return len + old_addr - old_end;	/* how much done */
 }
 
-- 
2.40.1.698.g37aff9b760-goog

