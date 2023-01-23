Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4496F678290
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjAWRFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjAWRFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:05:38 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A531A4A1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:25 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id v17so10910339oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8f88CXcixnrI/0j1gGMVDwRYunITviumj406DJ1Inns=;
        b=ObJDc3GJ8VcmrPLtvbGBaEyaJOUaLxXFD5DlwgYRAYb107fIdWq3sp37PFvexXW2O+
         qDy5o60fDjYQGPlMWnhZRjjcK9Nf24oENVbFcVPE2xui9vzipy98GDJRKGTtB8KxuRx7
         HGO2p7RRACpczYh8QIoQQyD/XbATvL1WU4jKphVHo7JWbxpYvN2oWQ56MnXuhmiXuYq3
         1t1fQtsqvb5JgpF9ihIrEzFkntjB3E3tWbiMlTsoY9QQ+juCR38vimxgbRVFQBtxduwy
         fVw5bRmcm9HN+wjVYzvVr+L/2VKYKQ4KvMPsaJPjlehXxzkTbFY8dnG4VMlByzqj0y/h
         ACSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8f88CXcixnrI/0j1gGMVDwRYunITviumj406DJ1Inns=;
        b=PDpJUIjGPqUeL69BYU9pvVFtff+pBqfcxsPpYfps94pMIQAaq6tWgPlr+5fZtI7LVF
         2SN7r8DwKOfUG8nuQGQ6v195evl6/nHIpc0Oy+rBKXAs95tNUGQitJm+Z/X9VgGsAF+6
         mJJOCxZjG55Rx/mRLZg3cBExFB1KFG06ajs8KtuMc3pE61feRzt82TsXUD+Graty7yzB
         vH4MVezHUA8wrOyW23o34ZlDVMiQxA4WNo5mNJu4Dv9AQvy89MlBQYG1fnypdXUPT33k
         Lvkpg0QM8dn1katXiULvNxCSX2VI2GROjS4EjzfdOmFt+4YEB2DMOveUCFKeweWiIlXc
         l0Ug==
X-Gm-Message-State: AFqh2koJiCbPCB2o/QIogGq0NdXu6THhvgSFmkCebFg8VHaMaEx7jqAF
        fJx2urK826LqgCmzUi1LBnELM5Keyw8IWR9RNsassbGw0iDB0ExjnHY5qUuNTSuxDY4pySOWrga
        OGxsxzTB0BZ7MNocN8aHK8yTEzPKHT4zBdi5Pcwi/HfvhZRArIBynRXzFJ0L/K22SpaBt0gTSQy
        npAX3cM6WsgQ==
X-Google-Smtp-Source: AMrXdXsg6f/N8/NWAWLTaBNp5bBEClmYxq8/0OQjAJX+T5+d9whQAFDyY71xO+WqBPcWrsx5a5Kx7A==
X-Received: by 2002:a05:6808:120a:b0:364:cc8c:1870 with SMTP id a10-20020a056808120a00b00364cc8c1870mr14930650oil.41.1674493524876;
        Mon, 23 Jan 2023 09:05:24 -0800 (PST)
Received: from DESKTOP-B7RB26P.localdomain (cpe-70-114-202-97.austin.res.rr.com. [70.114.202.97])
        by smtp.gmail.com with ESMTPSA id 2-20020aca0502000000b0035ec1384c9esm23160163oif.23.2023.01.23.09.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:05:24 -0800 (PST)
From:   George Prekas <george@enfabrica.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        George Prekas <george@enfabrica.net>
Subject: [PATCH 9/9] mm: kmemleak: fix undetected leaks for page aligned objects
Date:   Mon, 23 Jan 2023 11:04:19 -0600
Message-Id: <20230123170419.7292-10-george@enfabrica.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123170419.7292-1-george@enfabrica.net>
References: <20230123170419.7292-1-george@enfabrica.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kmalloc returns a page aligned object, then the object has 2
references: the pointer returned by kmalloc and page->s_mem of the first
page of the object. Account for this extra reference, so that kmemleak
can correctly detect leaks for page aligned objects.

Signed-off-by: George Prekas <george@enfabrica.net>
---
 mm/slab.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index 7cc432969945..76341c7c048e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -734,6 +734,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 					unsigned int orig_size)
 {
 	unsigned int zero_size = s->object_size;
+	int min_count;
 	size_t i;
 
 	flags &= gfp_allowed_mask;
@@ -761,7 +762,11 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 		p[i] = kasan_slab_alloc(s, p[i], flags, init);
 		if (p[i] && init && !kasan_has_integrated_init())
 			memset(p[i], 0, zero_size);
-		kmemleak_alloc_recursive(p[i], s->object_size, 1,
+		min_count = 1;
+		/* If p[i] is page aligned, then a page->s_mem refers to it. */
+		if (((uintptr_t)p[i] & ~PAGE_MASK) == 0)
+			min_count++;
+		kmemleak_alloc_recursive(p[i], s->object_size, min_count,
 					 s->flags, flags);
 		kmsan_slab_alloc(s, p[i], flags);
 	}
-- 
2.37.1

