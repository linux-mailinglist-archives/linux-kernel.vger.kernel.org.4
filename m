Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2134A6E18B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDNAMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjDNAMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:12:03 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD63335A1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:12:02 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id p2-20020a170902e74200b001a64b5976a5so5975594plf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681431122; x=1684023122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BkEj6q2IVKaYOP6wiiRLnj5ts2mBBZa+OIxL/GSTf98=;
        b=hEKe7KJhnbtB7HOx0Et2GGRR4tPoUqzTdWnfUxGGsyi9EoTWrZhVqGnrZvvHuOndFb
         TZMGSQ8vslsUBzDoxn9iNYO9LNL12Zs3VwW97btbxF/u5m0XCRPh93bGl4sbvEzqxT6/
         vZR2E4QR8bsqooC9JFGEbUD4GNGVdkQWEnhHWe0gty7hNJfMUG+x6qUJrqOv1s31GKD5
         /0uqMrvUHdk6drQi8pnb3EXthHB7+IGInrY92tJ9ElhNKYIt+IMYZonjXRQ9OCvmz8n+
         DadYc4CMCAJvwcgOviymbXY411dscM1zCutEA5OdbSJuHP8nTNCFxIaU7gllAACoSnWm
         TMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681431122; x=1684023122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkEj6q2IVKaYOP6wiiRLnj5ts2mBBZa+OIxL/GSTf98=;
        b=gLPNk7PszY5tfkK8JvTH8mqzHhmLm/xcXmQKTHSLlI7focxV+gwVfbvhW4GUX1SPPk
         4UVoxRaLrWqfMR1femdLulyi8kQWCIJo6mWqLueKcACdLERZsYtFttiNDrhXUdkHlFA+
         ag6FUWq5NbXsMxi+/FvLZFVnbTQlxMkhm8EnBImZQdKflhrk9UNXJNs/UnOGBIFtXCid
         69CJiEnGtERtjn3iQ+dzT1oA8tUyLdsNANVY7ANJmhJRhG65SURtCcAKMvIsgisp5euu
         MyaZSNVCwa/O88L1+QUKcXiYwFfBXfdP7UztO02v8acAU//Ev/4k+d2nbm3WVhAd233L
         S0BQ==
X-Gm-Message-State: AAQBX9fSaIv2wFOR5hIiWO6bdtkw6z7jFOF5Vkra7rpAGdby88Lp8LJ1
        rwjsx/FteOYsRxQ75cBCFx3mQUs8sB3j0c0lMw==
X-Google-Smtp-Source: AKy350avtllPlWwvIfTF15qlG1lqqPqwu/NAHA4tctgmwlguwviMhGUhrJ6084VLBRdQnA8mKuN5Lp3jk9IuHlWLyQ==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a63:1c09:0:b0:507:3e33:43e3 with SMTP
 id c9-20020a631c09000000b005073e3343e3mr240709pgc.7.1681431122125; Thu, 13
 Apr 2023 17:12:02 -0700 (PDT)
Date:   Fri, 14 Apr 2023 00:11:51 +0000
In-Reply-To: <cover.1681430907.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1681430907.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <cf43d4daa5e8dba22d2416cf46f586afcff0a33e.1681430907.git.ackerleytng@google.com>
Subject: [RFC PATCH 2/6] mm: mempolicy: Refactor out mpol_init_from_nodemask
From:   Ackerley Tng <ackerleytng@google.com>
To:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de,
        chao.p.peng@linux.intel.com, corbet@lwn.net, dave.hansen@intel.com,
        david@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        hpa@zytor.com, hughd@google.com, jlayton@kernel.org,
        jmattson@google.com, joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com,
        muchun.song@linux.dev, feng.tang@intel.com, brgerst@gmail.com,
        rdunlap@infradead.org, masahiroy@kernel.org,
        mailhol.vincent@wanadoo.fr, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor out mpol_init_from_nodemask() to simplify logic in do_mbind().

mpol_init_from_nodemask() will be used to perform similar
functionality in do_memfd_restricted_bind() in a later patch.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/mempolicy.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a256a241fd1d..a2655b626731 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1254,6 +1254,25 @@ static struct page *new_page(struct page *page, unsigned long start)
 }
 #endif
 
+static long mpol_init_from_nodemask(struct mempolicy *mpol, const nodemask_t *nmask,
+				    bool always_unlock)
+{
+	long err;
+	NODEMASK_SCRATCH(scratch);
+
+	if (!scratch)
+		return -ENOMEM;
+
+	/* Cannot take lock before allocating in NODEMASK_SCRATCH */
+	mmap_write_lock(current->mm);
+	err = mpol_set_nodemask(mpol, nmask, scratch);
+	if (always_unlock || err)
+		mmap_write_unlock(current->mm);
+
+	NODEMASK_SCRATCH_FREE(scratch);
+	return err;
+}
+
 static long do_mbind(unsigned long start, unsigned long len,
 		     unsigned short mode, unsigned short mode_flags,
 		     nodemask_t *nmask, unsigned long flags)
@@ -1306,17 +1325,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 
 		lru_cache_disable();
 	}
-	{
-		NODEMASK_SCRATCH(scratch);
-		if (scratch) {
-			mmap_write_lock(mm);
-			err = mpol_set_nodemask(new, nmask, scratch);
-			if (err)
-				mmap_write_unlock(mm);
-		} else
-			err = -ENOMEM;
-		NODEMASK_SCRATCH_FREE(scratch);
-	}
+
+	err = mpol_init_from_nodemask(new, nmask, false);
 	if (err)
 		goto mpol_out;
 
-- 
2.40.0.634.g4ca3ef3211-goog

