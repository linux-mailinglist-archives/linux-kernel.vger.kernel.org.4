Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCC06F341F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjEAQ5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 12:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjEAQ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:56:29 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115A7198D
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 09:55:34 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-51b67183546so1424163a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960133; x=1685552133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AxHF9zQp9trScXtaAl0tt4NG3XQrBAxJQ/ayq1tkXak=;
        b=tJm7WR8AdSF6O5qWHaKU1D/ysKeRzFc3FiZT54ezTvTsHezyhXNB2hdIvEgmyHbI2P
         coE7FK11G2KLLdp82iDrBRtaK1XJdqiYBBu7Bzgc0CjbScOB1xMrdceY1iUR8li4Lunu
         QxqPry7kkIxD8xjnoCiSp2i1c6RgrlFShVMk73jBCUlai0Pj6tzx2wQKCiGt42ycRlUY
         Q6iiOWoraxytw320styP6cKZ8CPR54fhZHUXwBTe18PxhhkTB2K2EgrVvGyA9dqorw8v
         3z+UXLp0f4HuyIt3egDvW6I8g1tJRbXw06CphA32uVzlUNPHB3VM7B/5KkyjlKHh6bO/
         vApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960133; x=1685552133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxHF9zQp9trScXtaAl0tt4NG3XQrBAxJQ/ayq1tkXak=;
        b=fgrBAVSsm6osIpA9UDlyfD0xwO/MLG/rlP8js5Fg5cf3UkgvFD9RObVozMhlySDRxb
         cnd6IcxNj9IU4A60tZGxdixL9Wd5PLYm3vOo4iVF8Hf6cWIm5jN7etZY6g0SAOg5HvSz
         yWfd0L80hL8BWGXpDEPH4SgBqIv2Ccfu9ic8H1BBO5U64/jgyzJYp7eCkFXjBvQppNs4
         95G2j1Ao+t4rD4IeifSilWR/yQPsbxbPmvkKGJZIz+u2huyAvYuPCotWGT2jcixlUQ48
         gX4pTK+7bXt7/iIRfzRcHqEsr6b2aJDCvf+Vp2ndDF/TTIpCbWbc6Ut9XraMz5CNWAad
         J6gw==
X-Gm-Message-State: AC+VfDzCQxrC1hpTbOfw4oUPKQPVxYSLHGglgVTSmNh9+yZuzCZzkrVm
        NA8fI+dhrHYjPxm/kyyY0FyoRHZ0/c8=
X-Google-Smtp-Source: ACHHUZ40vYgpSBKgnsqUKG4z7dBiWLR/NY4OPgzSeG2TkOgPzabfXY1XoiHkCzsuVnUnxnzRXGzvUa1mMg8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a17:902:ecc5:b0:1a6:6bdb:b542 with SMTP id
 a5-20020a170902ecc500b001a66bdbb542mr4742101plh.9.1682960133566; Mon, 01 May
 2023 09:55:33 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:21 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-12-surenb@google.com>
Subject: [PATCH 11/40] mm: prevent slabobj_ext allocations for slabobj_ext and
 kmem_cache objects
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __GFP_NO_OBJ_EXT to prevent recursions when allocating slabobj_ext
objects. Also prevent slabobj_ext allocations for kmem_cache objects.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slab.h        | 6 ++++++
 mm/slab_common.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index 25d14b3a7280..b1c22dc87047 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -450,6 +450,12 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 	if (!need_slab_obj_ext())
 		return NULL;
 
+	if (s->flags & SLAB_NO_OBJ_EXT)
+		return NULL;
+
+	if (flags & __GFP_NO_OBJ_EXT)
+		return NULL;
+
 	slab = virt_to_slab(p);
 	if (!slab_obj_exts(slab) &&
 	    WARN(alloc_slab_obj_exts(slab, s, flags, false),
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f11cc072b01e..42777d66d0e3 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -220,6 +220,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
+	/* Prevent recursive extension vector allocation */
+	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec)
-- 
2.40.1.495.gc816e09b53d-goog

