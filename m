Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207A862EC7E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 04:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbiKRDwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 22:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKRDwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 22:52:03 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE918F3F1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 19:52:02 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id b62so3997378pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 19:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl2HCmuKXCRtuCV8keQkppjI9HHVusIDw26V+KNW/hE=;
        b=TvL+I/WOxW0UWgdWvgJ0gvY2Fk0cjOtxylk/v1UA6dttCvpI1kE/XpZJv57lTN1ZSQ
         9zfsGIldon1ArmWFGGhT0hzWaukocjI+WLMq+JWyItCq99MGxbLnN/hq2lmyIomVrFrf
         KpZuajZ/wA7ltdKsh4/x05FY/9udPWBqve9qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kl2HCmuKXCRtuCV8keQkppjI9HHVusIDw26V+KNW/hE=;
        b=JZ0J0IokYi4hG8jvWGCEK5WcouDvp6xMj4XlvekJ9UGu+zu21IHu89ivbRgey2NMqW
         ooO4s9Zp1yCZXz+XHNFmiYYDBaVn0usqPFCa6H5Nxs1C7WR3JO7aIYinhXaJBBr3YQGt
         EJPv2zRh8AIF3yh9nYjdPlqgk3V/7PiWmgTpOaiHSDjjH5s5jc4MG7tw17YWFLgUYYJo
         +GWlIxJvVJjjYrCQCixDep+sMaOW7qPOHoy24A/0+FTsBriMZiA3Bf29hEagwMI2ePUK
         LvTL1S5mBy/0MJxS525p9UsTQY8CTsYqvPHDJ7QJNiyanN0XGBCs3Jz/NyVKVcV9GhR7
         2uTQ==
X-Gm-Message-State: ANoB5pnA45H4oI2h14ooVV+O3bJFhw8L/sWtYNZ7l4K5KbY1n0KtqJIi
        7/7a3f5wFBz5SSMfu8dpgLk0IQ==
X-Google-Smtp-Source: AA0mqf7HS6tS+6S6c48a5+nH45KT6BsUA5aJzuSM7l/pjNwX3dKMq7yLshBvt6nVve0qTN8OxxufbA==
X-Received: by 2002:a63:42c5:0:b0:460:9fe9:d325 with SMTP id p188-20020a6342c5000000b004609fe9d325mr4873891pga.608.1668743522250;
        Thu, 17 Nov 2022 19:52:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b00186e2b3e12fsm2254854plg.261.2022.11.17.19.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 19:52:01 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2] slab: Clean up SLOB vs kmalloc() definition
Date:   Thu, 17 Nov 2022 19:51:58 -0800
Message-Id: <20221118035200.1269184-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221118034713.gonna.754-kees@kernel.org>
References: <20221118034713.gonna.754-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2026; h=from:subject; bh=XCqnPjfv4o/NKArWFRHDgYWfDTlT2kWs5IGt+A3wTyQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjdwFfTA7j/LHUkXVUp6HAaWlDXQgvh/IdCZT/aouq MnYGyIOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3cBXwAKCRCJcvTf3G3AJp8VEA CnjcKb2iCpqmX0eLs3YrJn7gR2VmSD2hbc20QVLE5MxIZJBJgcap3GTy5i1qgCFw2KASeJLxX0fboz KIcE1Mw81hfNEkXWK6vKZ5xFg/pYKmvV6RV7AyQC947FQXvZIi0BaGFsNkS1H1zkCCkAeVMfN80mI0 1dX8ervJ42PpR9KAL7ySYtqYc5nKiffXK78XUMp0GBTZPg5qaurwfYUORKYh3QgkS5uq37EH6B5l0T uHDTLHL8dx2eDshTmfH5c+aw49XVD8zMUwoFc1A1jeD4exIqQHuOahoU0ZSyyjQW1LRXIQTuCzVJC/ o+tEaCPzfAVUa/qfEBHzHbRQW7rMwSguwAz0QAb+bdJLKrN7MR/LtheapmaVMGQjpjJU3Z3DPEt/wi Aq0IbtyxN6RooERZkVULRpRfS9DRzUv6YnmAXOhC0nXVnSVkHSGjOHyjnRfRDxizmrGvl2J0ZORyGE ehH2e6SDBf8yXy3C2gujb+9Xemv/Z2BxHV4BzI46EpD2x9xHZdgIoffQYFanYzr3R8BADb8voGurr+ PSgtL/PqvYl1cj6TsrtAgXAMpDc4VyT7rSMYo6rpO9XUYPhy9iH8YvnGWQ/R5/YwaqcOYjZ2Qq5KpN h6BaSq7PorQjdZiIwkoCEbhD9KEgyIBjAavfzOHXAo+MmXKGPmUKxMabAB2w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As already done for kmalloc_node(), clean up the #ifdef usage in the
definition of kmalloc() so that the SLOB-only version is an entirely
separate and much more readable function.

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
 include/linux/slab.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 1c670c16c737..9033937c758e 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -558,15 +558,15 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
  *	Try really hard to succeed the allocation but fail
  *	eventually.
  */
+#ifndef CONFIG_SLOB
 static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 {
 	if (__builtin_constant_p(size)) {
-#ifndef CONFIG_SLOB
 		unsigned int index;
-#endif
+
 		if (size > KMALLOC_MAX_CACHE_SIZE)
 			return kmalloc_large(size, flags);
-#ifndef CONFIG_SLOB
+
 		index = kmalloc_index(size);
 
 		if (!index)
@@ -575,10 +575,18 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 		return kmalloc_trace(
 				kmalloc_caches[kmalloc_type(flags)][index],
 				flags, size);
-#endif
 	}
 	return __kmalloc(size, flags);
 }
+#else
+static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
+{
+	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
+		return kmalloc_large(size, flags);
+
+	return __kmalloc(size, flags);
+}
+#endif
 
 #ifndef CONFIG_SLOB
 static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
-- 
2.34.1

