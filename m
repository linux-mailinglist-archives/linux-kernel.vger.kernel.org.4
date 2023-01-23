Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3769467828E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjAWRFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjAWRFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:05:33 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A44FF38
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:21 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id f5-20020a9d5f05000000b00684c0c2eb3fso7679808oti.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ru6CLB0URVzEwIi8l9mzpkjbwVXFEWjh4LnzIwtBgg=;
        b=eRHkK9RSp5RdUPbYzc2ONDyMk1JVlFNsVwUGHf/NxgfjQtB2EguW9rSon5vUJDEQcR
         csImBlv1J/8eJb0qw56nUOkalGbV3a9x7Y+1iaTyUJQzHKwhtDEC6PfRxanAeXV8m/hK
         nTV9ZRDqUFiBL5abS70FxjIdsRGoYa90GQtfcK5xG7MVLKvFuzLiCfhSXpOsVNqfGowy
         yaZpYooq8OyDfvz1AP5wzOv1luRGdwp9M89VSrRpL+BaQ2XkmmKQ86jTzfYdyjLqmp4z
         KGg5dcZYHnUHIh/GT9M4dDHpW67G6ZesHaPm+nvGRaQp/gfK7aqKufdBPwIZeV8GR0OF
         sltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ru6CLB0URVzEwIi8l9mzpkjbwVXFEWjh4LnzIwtBgg=;
        b=qyFn0cokiwG6tnsbWW3wGmeY5v1fakQKLz8w4U87uNQp0L7L0l1446b+MUa7jEM0o3
         w4PND+o8UnpaxOpLb50WTUrq1JlQ3ti7zt/bR1NPX6a1QKEGygZt1PvqPQ96gD1saEOM
         Uud2iJwi6kW4in/8ENZZu6WUTJjeT5bCWYAIVVVo4ydbdWEjhM0prC3cqR2OPQy44yxe
         +PBvNLAqsAt+Shjn5mqQMgY4oBrE/oeT8OGbToHTSnGrfFLZi42A0RSAd/l6XchH/w8q
         /WRd+ddqfEdivxEhB15znBeimfVaFo2V4t6LhUjOvEqKHWH1Qk+Oh7yRT0w1pJWPrhzk
         3KSg==
X-Gm-Message-State: AFqh2kpJVlm/2+qsvD8VQUXgmwVEVpeAXY+dcK1RsLNxl2qs0Jz8kzcR
        LzzlbDM435IpUQ/a41MNcksXbQ3s4aQZfwZGVnLlfff3IlvS7evw2tXPvqTCv9+gN/bH2Lpm6sI
        txfCyYvs7hbKUjlQVIGMRnLmsmPjWhCO1LLKEiZhxxx5IAw9B15xOKnLE9E9ZxrRdU6n6GO1f1f
        XIxfIn77Zrxg==
X-Google-Smtp-Source: AMrXdXvByCWK7YSdHMdSB0mW02MoC6pySSXn6CG8IdG7KukUbpOeHf13LuBKC6y/KYQF7TZq9bxuGw==
X-Received: by 2002:a05:6830:1358:b0:670:9f08:2c48 with SMTP id r24-20020a056830135800b006709f082c48mr12522432otq.9.1674493520590;
        Mon, 23 Jan 2023 09:05:20 -0800 (PST)
Received: from DESKTOP-B7RB26P.localdomain (cpe-70-114-202-97.austin.res.rr.com. [70.114.202.97])
        by smtp.gmail.com with ESMTPSA id 2-20020aca0502000000b0035ec1384c9esm23160163oif.23.2023.01.23.09.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:05:20 -0800 (PST)
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
Subject: [PATCH 7/9] mm: kmemleak: erase page->s_mem in slab_destroy
Date:   Mon, 23 Jan 2023 11:04:17 -0600
Message-Id: <20230123170419.7292-8-george@enfabrica.net>
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

The field s_mem of struct page is initialized with the virtual address
of the page in function alloc_slabmgmt. If kmalloc allocates an object
that starts on this page, then kmemleak knows that this object has 2
references. On slab_destroy, s_mem should not continue referring to any
allocated object in the future.

Specifically, assume that initially the 4KB cache uses page[5] and its
s_mem = 0x5000. Then assume that this cache releases page[5] and the 8KB
cache allocates page[4] and page[5]. Subsequently, kmalloc returns an
8KB object at address 0x4000 which will have 3 references: the returned
pointer from kmalloc, page[4].s_mem = 0x4000, and page[5].s_mem. This
object can leak without detection.

Signed-off-by: George Prekas <george@enfabrica.net>
---
 mm/slab.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index a927e1a285d1..aa5eb725ee9c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1611,6 +1611,9 @@ static void slab_destroy(struct kmem_cache *cachep, struct slab *slab)
 {
 	void *freelist;
 
+	/* Erase the page's virtual address from s_mem */
+	kmemleak_erase(&slab->s_mem);
+
 	freelist = slab->freelist;
 	slab_destroy_debugcheck(cachep, slab);
 	if (unlikely(cachep->flags & SLAB_TYPESAFE_BY_RCU))
-- 
2.37.1

