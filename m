Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705F7615511
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiKAWeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKAWd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:33:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED2AFD7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:33:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso283570pjc.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87RNyMS5uX8ym9d4i08lSZonwWmXQDb7t+1Mtox/7yY=;
        b=KPuYVSv0nSM3xzmtsA2iZPi4FbNUt2u+J40XlA1k1oQQpVJTS9b6QN9F44Up65E+Dy
         ZEZDhFfCcAcXwoR6dC2i7yVaDmDWk5ahJKFXf7F78lPa3a9PuAhXHM1Bu7aJ4wvSpABe
         tdFQi2tLp11aSMFI3sSj0s/g/VSKZK5PRes3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87RNyMS5uX8ym9d4i08lSZonwWmXQDb7t+1Mtox/7yY=;
        b=l4xhxTc3fUVn7r4f6b+ht4ZgqAh9V8lnpQrQkxyLS8GMs6+Y643QgexcXeGVf7cyyf
         W1GtnYAs2RvVmQRSxG7jL7JMTj54h0tSyEHCWGEP2mwEA+SLycz5FX0NVSusc4Lya2B7
         L7hSWH2iyEXXyKbzzUFhRz/0u/fiWR5Vfnckdf7Ec+tm4crStfYsT/52MMv4CPTaus5n
         wnA7BTnZNv3cOy9qzOE+1TV7ouNckZ3PNopOxdAsWpoqAbDLqOP3y0LR1Gp8rWkDvdi4
         Z1Bd920HBUdq2U4SFT1RvIJU1A06CfQfR/jJ0uUWqm3l3jmTXtcfC6w/kFC3vy6MAXdx
         D0hQ==
X-Gm-Message-State: ACrzQf2kQ5+4mTBFdSHAhmfUl8AWOI7SgmWQSKFiudgk2Dg+n5QNDk1+
        Az5jTNPFzGt/QR0B6JTWj1908g==
X-Google-Smtp-Source: AMsMyM5nrJHbUGPB6olYPQsGSIKe4o16+BOFvZoWcvoBMUjk7mAVQmawGuJrbP4nRhkPmubegbnSrQ==
X-Received: by 2002:a17:903:1205:b0:178:ac4e:70b8 with SMTP id l5-20020a170903120500b00178ac4e70b8mr21525995plh.52.1667342003962;
        Tue, 01 Nov 2022 15:33:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 11-20020a63134b000000b0043ae1797e2bsm6253514pgt.63.2022.11.01.15.33.22
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
Subject: [PATCH 3/6] slab: Provide functional __alloc_size() hints to kmalloc_trace*()
Date:   Tue,  1 Nov 2022 15:33:11 -0700
Message-Id: <20221101223321.1326815-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101222520.never.109-kees@kernel.org>
References: <20221101222520.never.109-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3777; h=from:subject; bh=7/m3dEaCfyTXz7DjZgXoExKzu8Xq2Kk2B9qgNF6RcGY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjYZ6qEP2c2SjseVkvdeN6bkMUPKJVGJtbp1au+Zyw YWPCnLGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2GeqgAKCRCJcvTf3G3AJrNyD/ 9AyySkd0dVZRcUAxeWk0ceyiENXBqnciPCjbF1LZnBp23ob+33YYuxYUgP9m4No9Ikisn0wDrMq0rJ c3TyrMW705BCcJ+9lbBCofVn9TIGFD7JhKd++KHwtef8oUTAG58EXkQbcVgVGvq1Jv4jNH+bpQlXOl uhQqH4GyghPppdIGRLTh1XjesN55zxz/jurH9h15oDDr+zxCyO6mVUIBQSriDgMRoDv1kCZL3G+URj gG83q7qxiVIu+QrRxph18SMAuz602+/uLDZZr8TnMuK89nUA4/MFj4l+ZbgRbK7ga+R9WVW8sVB3Wb JVOqkhmQtmMSEJLIoQGtkbobICmQcGtzzqUBlQ9VZuRc69Kw2bHAXxHsveb2DqRFUKWNYmfX13BVGn sJNfVCUb1x+Rv0TBIhjBTPgjNaQ7giL7KrbW5RgEfRIKNhi355QFPy6JI+EKjjucq/lT2r3cBQJZXE +7xvDIp6xphk+A+FKr9nyUA2O7eS5Ub0fd1g52rt2noSmGeymkatG8uhCVgENOxps0Gv42yGAByoKX 1WQu19FknjYAvQTr7LZdPpNkfdUfDNRGZNlMEjknJITtCJ4ztqyuKCnD6Lkm6RvZRLxVyacyW5cfRY F4Ls0x39ONT774Syx5nmWvPH8iYaMN8Ri5QDo8evxuWgJv8khtAVCf5MbUqA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since GCC cannot apply the __alloc_size attributes to inlines[1], all
allocator inlines need to explicitly call into extern functions that
contain a size argument. Provide these wrappers that end up just
ignoring the size argument for the actual allocation.

This allows CONFIG_FORTIFY_SOURCE=y to see all various dynamic allocation
sizes under GCC 12+ and all supported Clang versions.

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
 include/linux/slab.h |  8 ++++++--
 mm/slab_common.c     | 14 ++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 970e9504949e..051d86ca31a8 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -442,6 +442,8 @@ static_assert(PAGE_SHIFT <= 20);
 
 void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
 void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
+void *kmem_cache_alloc_sized(struct kmem_cache *s, gfp_t flags, size_t size)
+			     __assume_slab_alignment __alloc_size(3);
 void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 			   gfp_t gfpflags) __assume_slab_alignment __malloc;
 void kmem_cache_free(struct kmem_cache *s, void *objp);
@@ -469,6 +471,8 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignm
 							 __alloc_size(1);
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
 									 __malloc;
+void *kmem_cache_alloc_node_sized(struct kmem_cache *s, gfp_t flags, int node, size_t size)
+				  __assume_slab_alignment __alloc_size(4);
 
 #ifdef CONFIG_TRACING
 void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
@@ -482,7 +486,7 @@ void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
 static __always_inline __alloc_size(3)
 void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
 {
-	void *ret = kmem_cache_alloc(s, flags);
+	void *ret = kmem_cache_alloc_sized(s, flags, size);
 
 	ret = kasan_kmalloc(s, ret, size, flags);
 	return ret;
@@ -492,7 +496,7 @@ static __always_inline __alloc_size(4)
 void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
 			 int node, size_t size)
 {
-	void *ret = kmem_cache_alloc_node(s, gfpflags, node);
+	void *ret = kmem_cache_alloc_node_sized(s, gfpflags, node, size);
 
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 33b1886b06eb..5fa547539a6a 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1457,6 +1457,20 @@ size_t ksize(const void *objp)
 }
 EXPORT_SYMBOL(ksize);
 
+/* Wrapper so __alloc_size() can see the actual allocation size. */
+void *kmem_cache_alloc_sized(struct kmem_cache *s, gfp_t flags, size_t size)
+{
+	return kmem_cache_alloc(s, flags);
+}
+EXPORT_SYMBOL(kmem_cache_alloc_sized);
+
+/* Wrapper so __alloc_size() can see the actual allocation size. */
+void *kmem_cache_alloc_node_sized(struct kmem_cache *s, gfp_t flags, int node, size_t size)
+{
+	return kmem_cache_alloc_node(s, flags, node);
+}
+EXPORT_SYMBOL(kmem_cache_alloc_node_sized);
+
 /* Tracepoints definitions. */
 EXPORT_TRACEPOINT_SYMBOL(kmalloc);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
-- 
2.34.1

