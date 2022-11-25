Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251F763901F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 20:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiKYTAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 14:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKYTAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 14:00:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3A6220FD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 10:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669402741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RV0U9RdGRZiYinfHu3agKBivQwemACMiM9oHLAnMCi4=;
        b=YGGLQ7vHJaug7c+Ng5OPL3dIaWYx4lEzNl2fMLYDIKkVSLqhAu4MdUHou3GwMhQW0eKmjO
        lDAec9tWuOWM6QDjEq8kgzqQ+2SqTgasMJGkvxyn4yxdeW8NTywpf3GzrP6khBsK27bBl7
        Is8jIDMU6CYdx60cpRLgT8vLbxpRM10=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-531-4Eh_jEeLMGyW2neeExgn-g-1; Fri, 25 Nov 2022 13:59:00 -0500
X-MC-Unique: 4Eh_jEeLMGyW2neeExgn-g-1
Received: by mail-qt1-f199.google.com with SMTP id ff5-20020a05622a4d8500b003a526107477so4778683qtb.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 10:59:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RV0U9RdGRZiYinfHu3agKBivQwemACMiM9oHLAnMCi4=;
        b=Iha0Lq+XTa6zCY+znWPCv/0E0a88muHBAwljvoSuq9HTZz22Va2p4CnFWSv0lj7g0z
         zTppX/Z3QB1isFW2WC95+aOKALwlfwIvUrasFbwETMshHQByfC2zPjUwXR5fIGxlMwG7
         xy/xSoK6kA4LEKgcAsFgiOz+EBNIJ2OYzFn97drhMvPjuLgVW3zdp17WTEm7FZVyA7DX
         /uZ3O/XiFEZpsncpdyCvSAPTRS3NEb50sUzjc+Kz5oDohUYvrrPOwP66u6qB5QfF10Qo
         uBl27KEvc6g3tG1cGjPcpkHgyiIrprW0v6a08jUy9+zSEygO+FH6wFOzGoukLUmtkK+G
         6Grg==
X-Gm-Message-State: ANoB5pk1pVlcysNogtyuwoyGGhCrKy1rzaejkXm2KXbGp4QOz9Z4dl8f
        1BxXaikUYZPQpjryHA5lsVEgmFRx9Bbtd5AyxqRgwR7Qy8mfWTXxjPLTQdiyVtjS++2dJqArKuT
        4D/Z9MV/aA+EjRXRUlqgURYp5
X-Received: by 2002:ac8:6899:0:b0:3a5:122:fbe4 with SMTP id m25-20020ac86899000000b003a50122fbe4mr37645210qtq.493.1669402739622;
        Fri, 25 Nov 2022 10:58:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4KEAfKu/z8lqhOzgWKnhgNda71vMnpJjEyBHAW1nvQf+e3GI5Il1jaIu6a2nqtJB01FG5a8g==
X-Received: by 2002:ac8:6899:0:b0:3a5:122:fbe4 with SMTP id m25-20020ac86899000000b003a50122fbe4mr37645194qtq.493.1669402739381;
        Fri, 25 Nov 2022 10:58:59 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bq38-20020a05620a46a600b006fc40dafaa2sm3212729qkb.8.2022.11.25.10.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 10:58:58 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Anatoly Pugachev <matorola@gmail.com>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>, Hev <r@hev.cc>
Subject: [PATCH] mm/thp: Re-apply mkdirty for small pages after split
Date:   Fri, 25 Nov 2022 13:58:57 -0500
Message-Id: <20221125185857.3110155-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to have 624a2c94f5b7 fixing the regression reported here by Anatoly
Pugachev on sparc64:

https://lore.kernel.org/r/20221021160603.GA23307@u164.east.ru

Where we temporarily ignored the dirty bit for small pages.

Then, Hev <r@hev.cc> also reported similar issue on loongarch:

(the original mail was private, but Anatoly copied the list here)
https://lore.kernel.org/r/CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com

Hev pointed out that the issue is having HW write bit set within the
pte_mkdirty() so the split pte can be written after split even if e.g. they
were shared by more than one processes, causing data corrupt.

Hev also tried to explain why loongarch set HW write bit in mkdirty:

https://lore.kernel.org/r/CAHirt9itKO_K_HPboXh5AyJtt16Zf0cD73PtHvM=na39u_ztxA@mail.gmail.com

One way to fix it is as what Huacai proposed here for loongarch (then we
can re-apply the dirty bit in thp split):

https://lore.kernel.org/r/20221117042532.4064448-1-chenhuacai@loongson.cnn

We may need similar thing for sparc64, though.

For now since we've found the root cause of the dirty bit issue the simpler
solution (which won't lose the dirty bit for small) that will work for both
is we wr-protect after pte_mkdirty(), so the HW write bit can be persistent
after thp split.

Add a comment for wrprotect, so we will not mess up the ordering later.

With 624a2c94f5b7 this is not a fix anymore, but just brings back the dirty
bit for thp split safely, so we re-apply the optimization but in safe way.

Provide a T-B credit to Hev too (not the exact same patch but the same
outcome) for loongarch.

Cc: Anatoly Pugachev <matorola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Raghavendra K T <raghavendra.kt@amd.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Tested-by: Hev <r@hev.cc> # loongarch
Signed-off-by: Peter Xu <peterx@redhat.com>
---

PS: Anatoly, feel free to try this too on sparc64.  Applicable to either
branch (Linus's, or akpm's) as long as latest.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ae1e2d80bb6e..5f93ba064323 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2192,16 +2192,18 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			entry = maybe_mkwrite(entry, vma);
 			if (anon_exclusive)
 				SetPageAnonExclusive(page + i);
-			if (!write)
-				entry = pte_wrprotect(entry);
 			if (!young)
 				entry = pte_mkold(entry);
+			/* NOTE: this may set soft-dirty too on some archs */
+			if (dirty)
+				entry = pte_mkdirty(entry);
 			/*
-			 * NOTE: we don't do pte_mkdirty when dirty==true
-			 * because it breaks sparc64 which can sigsegv
-			 * random process.  Need to revisit when we figure
-			 * out what is special with sparc64.
+			 * NOTE: this needs to happen after pte_mkdirty,
+			 * because some archs (sparc64, loongarch) could
+			 * set hw write bit when mkdirty.
 			 */
+			if (!write)
+				entry = pte_wrprotect(entry);
 			if (soft_dirty)
 				entry = pte_mksoft_dirty(entry);
 			if (uffd_wp)
-- 
2.37.3

