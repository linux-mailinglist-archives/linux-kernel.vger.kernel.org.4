Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A91467D56D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjAZTiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjAZTiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:38:04 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F242A2D51
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:38:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y66-20020a253245000000b007cb4f1e3e57so2941532yby.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7f+nWaJs+UY1hAFqCQPugwXAUkaJjblKaIiT0PAHag=;
        b=FW4bnh2DtF5SN3S+ptflTidC3AwPB8hrKnXJfdusod4jzvXR1Q3bgv6S2FnIbbr/1k
         kJaCqO4VxuyGKMdYHqVT8hWkVv8xNy02JRI3nNYqz01mL8SL7V6Po3J4OaEcUTdV8T6d
         U8bwK2pvUhNc4ZsP459X8uhyyARwEseFOldN8jMmy9goPH8eegJ1oz/nmy4A87viAEed
         K1sFh2Ag5W16Q+oAksyomuvnpJ/IlE09ePBZTWNlxXbxGwhIaOL4Mw2hapKtgyiO9CrJ
         c0Zt54OumFKZIa1lT5MaZ/SF4EVN57QK9Y/mYR+xXLnWjhZNPHDb8wMQuopuM5SuNw1J
         FF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7f+nWaJs+UY1hAFqCQPugwXAUkaJjblKaIiT0PAHag=;
        b=uIBp34s4dAQTUo/mK7nOPXxY0xJ05+jQ/UpLKOMYseIgCbUdyZ/RQsTDRF3C70iAY4
         wT/AGnH9Zfl9ntjWqKEMtPqB5QnVloKQXA6rejQiaWqsKvZ59+ZXP2HJ0hMlimTFvLV3
         raE08OI2/rN5ExtQZp8uUrRwJJN5XS5YRD0vXrodpWeOySLCsc2OccNDMc9BvFhq4FJZ
         fvpXtwvV/a7iHZy+sSzPxNV5L2/Jzu25Jd6Kwcw645DI6gjB6sGnpL7l+RL60pR2nplL
         iuRObJu7XFrauF1Odv3ziMkwMOqMSLJC2tJkgcrz4X/QG1ajbUXj38vU46D5TXct40Ja
         OINw==
X-Gm-Message-State: AFqh2koP+7Qewr6ISSE2Wik5EYsyHsnOqODHWoUzwlTF07BJsQC+tbBE
        uf9AhbEE4M2iUA1iNL9xdVT8ci98OXU=
X-Google-Smtp-Source: AMrXdXuUQZvJuxuPHIjcp5S1LAlHZTJ1MRrC82bz6slpJcdsTdAd3IG1wthp4gNFz/h3B6xbzxEKZLVeMx4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:d774:88af:bab3:648d])
 (user=surenb job=sendgmr) by 2002:a25:1fd4:0:b0:7d4:712e:2852 with SMTP id
 f203-20020a251fd4000000b007d4712e2852mr3883476ybf.628.1674761881114; Thu, 26
 Jan 2023 11:38:01 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:37:47 -0800
In-Reply-To: <20230126193752.297968-1-surenb@google.com>
Mime-Version: 1.0
References: <20230126193752.297968-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126193752.297968-3-surenb@google.com>
Subject: [PATCH v4 2/7] mm: introduce vma->vm_flags wrapper functions
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vm_flags are among VMA attributes which affect decisions like VMA merging
and splitting. Therefore all vm_flags modifications are performed after
taking exclusive mmap_lock to prevent vm_flags updates racing with such
operations. Introduce modifier functions for vm_flags to be used whenever
flags are updated. This way we can better check and control correct
locking behavior during these updates.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mm.h       | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h | 10 +++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8d636e895ee9..abb31103d060 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -627,6 +627,46 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 }
 
+/* Use when VMA is not part of the VMA tree and needs no locking */
+static inline void vm_flags_init(struct vm_area_struct *vma,
+				 vm_flags_t flags)
+{
+	ACCESS_PRIVATE(vma, __vm_flags) = flags;
+}
+
+/* Use when VMA is part of the VMA tree and modifications need coordination */
+static inline void vm_flags_reset(struct vm_area_struct *vma,
+				  vm_flags_t flags)
+{
+	mmap_assert_write_locked(vma->vm_mm);
+	vm_flags_init(vma, flags);
+}
+
+static inline void vm_flags_set(struct vm_area_struct *vma,
+				vm_flags_t flags)
+{
+	mmap_assert_write_locked(vma->vm_mm);
+	ACCESS_PRIVATE(vma, __vm_flags) |= flags;
+}
+
+static inline void vm_flags_clear(struct vm_area_struct *vma,
+				  vm_flags_t flags)
+{
+	mmap_assert_write_locked(vma->vm_mm);
+	ACCESS_PRIVATE(vma, __vm_flags) &= ~flags;
+}
+
+/*
+ * Use only when the order of set/clear operations is unimportant, otherwise
+ * use vm_flags_{set|clear} explicitly.
+ */
+static inline void vm_flags_mod(struct vm_area_struct *vma,
+				vm_flags_t set, vm_flags_t clear)
+{
+	mmap_assert_write_locked(vma->vm_mm);
+	vm_flags_init(vma, (vma->vm_flags | set) & ~clear);
+}
+
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
 {
 	vma->vm_ops = NULL;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2d6d790d9bed..da983aedb741 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -491,7 +491,15 @@ struct vm_area_struct {
 	 * See vmf_insert_mixed_prot() for discussion.
 	 */
 	pgprot_t vm_page_prot;
-	unsigned long vm_flags;		/* Flags, see mm.h. */
+
+	/*
+	 * Flags, see mm.h.
+	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
+	 */
+	union {
+		const vm_flags_t vm_flags;
+		vm_flags_t __private __vm_flags;
+	};
 
 	/*
 	 * For areas with an address space and backing store,
-- 
2.39.1

