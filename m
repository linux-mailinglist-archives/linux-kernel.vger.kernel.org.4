Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB0615512
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiKAWd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiKAWd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:33:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CDCEBC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:33:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k7so5168811pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nltp5RJKJpJiy+lN1fjyj0tni6FBvjdhxkkPgl9tDbA=;
        b=gm5F1w4iALvkaMLVUfNT4doyFvvcUHI/RRJNOKifZ5C24lG0VjpTlUZ7Fq6t8XkpKj
         gqS+JLFVnIHH0zNQaQwjuoWbwEGtfO/BQaKn66WNxlVOE0VfuMNfQg95e/c9emk+sjhk
         T1jjHDpxnS5pxHyY/PoOzerTiEwjNzlYj77FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nltp5RJKJpJiy+lN1fjyj0tni6FBvjdhxkkPgl9tDbA=;
        b=6NK1ZLzEGwVz5BXkmzRbic0JqGqSsrt4rryq8DmWMulCBMq8XI7gho29ZOyuMmM+0f
         rCr1hNtXBIwcbIoc8N9xZvRPGqVbQARb+/GOLUrR8+FD8Nb+so6KslUYD4+Ygs0ixSxy
         nHNFZAJydrEMxeuIbbHpMfATj8eonUoN7/pQterohi1k2sK/L7towdPCqv9PjwgLveq3
         c2epWqoXLdt5uR0j7DYm8uTNUSPFaFTOSEPq8adEnC3DXJlzl9iZUBmfYQUWFPVUPl4Z
         Acv/1cGbU0da1usINF5bm+R1zWSmOfMaPnmT4hTQ70DgvHNafn2tbag9Pya+aJ35n6Pc
         Zk3w==
X-Gm-Message-State: ACrzQf3D6ZSyGe3rNtKwtEynhDcKLuUecTFA0c3CTyupehZovgF+xHKA
        4z2U14ED13IfJfhjCM5MciwdNw==
X-Google-Smtp-Source: AMsMyM7QCr77GngdG52tbkpTWR+ry5SrJoyzn5pEPMgQfu1HqHVFuUzm4y7P9gFfLfMKQ/X0910S2g==
X-Received: by 2002:a17:902:ef51:b0:180:7922:ce40 with SMTP id e17-20020a170902ef5100b001807922ce40mr21648024plx.8.1667342003248;
        Tue, 01 Nov 2022 15:33:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902780e00b00186b280a441sm6818215pll.239.2022.11.01.15.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:33:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        David Gow <davidgow@google.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 2/6] slab: Remove special-casing of const 0 size allocations
Date:   Tue,  1 Nov 2022 15:33:10 -0700
Message-Id: <20221101223321.1326815-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101222520.never.109-kees@kernel.org>
References: <20221101222520.never.109-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2371; h=from:subject; bh=Orq7dTL01awncjfej5/kmy0rhx2Dkjzjknkna6lKTxc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjYZ6pSkAAJZnxJQ9xGB8j+DBQxCAiERH1Mj1nwMYm gw5gZNWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2GeqQAKCRCJcvTf3G3AJsm8D/ 0eLG4a2rjG7cnYY/B7BTI50H9t73pU5m3LGv6pIt6e1lw/3d+bA90FWRTEqFL6JQAqkpvbYMuLXnR5 P/4+X17Z9FLSyFqaVh5xQZw5HU2YoCy3Y2BYqBdXjPeUZDvoCyEhSj5A4Szpd5DhuU9/zxCpXpl21t G4M1fsuAQyC2PbBc0Gumphp8cMjF1+ZcskuaCZqEVBmgJYOSJTYql7Fg1GMnzYCvJ2woEGQ1IsIv8Y 2+NhAWv1nGvEOSzs3ry2w7jDcZvh4HFJMcjbg1FyXsvOBYfhkjpotYs6fB4J3yhksLZH8n15AeMiEO idAblEEIBtUfvgvz9o/5jxVbr/sR+eoz+L65byXBdzj8kGsOwlfKVCbT683coTpAMK+qms3pMrZ6cl WTyFGJwXytQH27WOq3c6NVsi3XCgtykkzfzW0jiaue05uaty3VzGTYe1VA+NpcqhWvvzBT2DyVBXT1 XuX+XpkfACWcL9gn4VXOjWKb+tfbxT+nle17naSGPO5cqt9JGNaOh5O0QVGt1rGVVguRP7lmHtMs/m VqSCQ5b6/Bfs5+3A8q1bqWGuFUVBpS7q5DtFAkpB5G8Wke3+wv/l4GTzoGgqIlD4r8FkL9H0fsgjp6 jahyLYHwgVUoupO2TQwC4V4TUtmKK/sQ1F1ChE/7Kn7fKxG5pgQeCOaBPMFQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing a constant-0 size allocation into kmalloc() or kmalloc_node()
does not need to be a fast-path operation, so the static return value
can be removed entirely. This is in preparation for making sure that
all paths through the inlines result in a full extern function call,
where __alloc_size() hints will actually be seen[1] by GCC. (A constant
return value of 0 means the "0" allocation size won't be propagated by
the inline.)

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96503

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/slab.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index e08fe7978b5c..970e9504949e 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -562,17 +562,13 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
 #ifndef CONFIG_SLOB
 static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 {
-	if (__builtin_constant_p(size)) {
+	if (__builtin_constant_p(size) && size) {
 		unsigned int index;
 
 		if (size > KMALLOC_MAX_CACHE_SIZE)
 			return kmalloc_large(size, flags);
 
 		index = kmalloc_index(size);
-
-		if (!index)
-			return ZERO_SIZE_PTR;
-
 		return kmalloc_trace(
 				kmalloc_caches[kmalloc_type(flags)][index],
 				flags, size);
@@ -592,17 +588,13 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 #ifndef CONFIG_SLOB
 static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
-	if (__builtin_constant_p(size)) {
+	if (__builtin_constant_p(size) && size) {
 		unsigned int index;
 
 		if (size > KMALLOC_MAX_CACHE_SIZE)
 			return kmalloc_large_node(size, flags, node);
 
 		index = kmalloc_index(size);
-
-		if (!index)
-			return ZERO_SIZE_PTR;
-
 		return kmalloc_node_trace(
 				kmalloc_caches[kmalloc_type(flags)][index],
 				flags, node, size);
-- 
2.34.1

