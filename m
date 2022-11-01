Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B811615521
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiKAWfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiKAWdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:33:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708C7E14
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:33:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m6so14804427pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR4DpXpArHwTB3Q/Fu/HeOb4zcIBa/dUESXAom+m+r0=;
        b=XR/R95kGIa5eEkN76ZwYFuGmF701nv7uoFFFHP2TDaZ1ZmYYGsHVPdtxhWMxyL/WIi
         nCK6B5wZeapBAY98ZRSshrqH6a9cTH0OVkAfTMWjC1cvjhFcFP4YA0gCgsYYWTHaaWCN
         e1LQ8yAUTs+wD/EXihacl/voB7iSFt12/H44M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TR4DpXpArHwTB3Q/Fu/HeOb4zcIBa/dUESXAom+m+r0=;
        b=vEAanmQD0J9o5eeUYFX0nKu+QHS85wdUx7WJ1HOHFrZ8vM5Zn9p+17N2usOmpvxnZK
         ioygxbvSrKW6U1PNFsrjTkhF3/SAuwqrkrNaNSANBucVYOnUqBh74A/4IzNXX8hZLB9U
         YQgh13bNXnI/uAlC5AU3rvlRSG6yYPVDxpxfs0/L6Pm4abiIi7jn11zHB5NEWRX9SkEe
         9w6FjSKQpJJADrShvwZta/fxgYHIOp15fJ/XXlRmjTyArevHif5E8lQrIXCLO2voA1yJ
         XT23sQoaKeilaGQEKJ+q48VtunvPpJkA5s8mqbIXp0mOGXuS8P7nIREJP55SVrTf3pjd
         ELzw==
X-Gm-Message-State: ACrzQf1Vy9V1xtRJcoElfTsx/pHX3dS1FxfYWKHJo5pxzoh6TN2cJkZe
        Zg83P9ZB7pKWgWSZB2u9mjf0dQ==
X-Google-Smtp-Source: AMsMyM4g9RheqgMMXT+kdLVomwlfmHmSq5aYyTAxpX3GmEp3SjBAvxDOTWRc3EMBzPy3MDlV+aTaZw==
X-Received: by 2002:a63:ed58:0:b0:439:b3a:4f01 with SMTP id m24-20020a63ed58000000b004390b3a4f01mr18942728pgk.327.1667342002870;
        Tue, 01 Nov 2022 15:33:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x6-20020a626306000000b00565c8634e55sm7000554pfb.135.2022.11.01.15.33.22
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
Subject: [PATCH 1/6] slab: Clean up SLOB vs kmalloc() definition
Date:   Tue,  1 Nov 2022 15:33:09 -0700
Message-Id: <20221101223321.1326815-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101222520.never.109-kees@kernel.org>
References: <20221101222520.never.109-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2026; h=from:subject; bh=qLerDmEzne6lpaq4KVx5bE//rWAPpMJFdcLBFfnifO8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjYZ6pLIVN1gPOfxNyEH/PkysO24BYL1rHsOiqB1i7 kWFfzeSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2GeqQAKCRCJcvTf3G3AJrdeD/ 4sAhVz4+NctD5DHBg37o6IgG9K0ySMSyZK6zpStQkAyDq2iJBxfDehPUeOvWXCzi0t1pj4FcJKPKEm rmF3jK6fNN9l/YgIcfA2vsfbpcNlIPSz76g4AsJbeDB2h2+i26p17KgcqvewxqWVF4Q02iW0A0De+I 4oYzPaQ0m9NF1qhJPzxZB9e1GE6j8cUvXDSA9yLbZj0PnLyrlvlul4Tpx/08wQPiAy2Q86mQId55ff /tq9+XQQ5mebvYuakkhQ8FRzgDZNrrHrCvKLbkH5zqkJ3MoF80v8rTPNBDSZW3gaE/GUQPW6TfUgaC mfU+pPrGsMSsz0a89B6UBppmirX9+bt1FanpHkvJtGGLFO2CtoLnQQJKHQXiejPbzpvRidg5bO6kZg HH3p7tMaxy7agCjUaLN9ztuvyRTKe2+kZKOKUteAq4qnEeDqxU3aRvK1APufm4pmniPE0Qn4aJOFxT 76rbAfdpsYv6dmYqpt4eBnuZExBOP6tUTbZIiONbnqnfttx/IAtoqJ4N9LP509HXUoW963HfvoAle+ +DdkpOwzNyjyT+eMv3R7i1ltBDcWj+sUV13ARcRXfpT3ib9UpkLn69A88U3E1PXmlAx6rsGsfIv/Gd OI5HWzey0ZmhYUdvHowXft3iJ8J2zccRoZT2HYEYNpBvBi4hP8I/X6mDxy4Q==
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
index 90877fcde70b..e08fe7978b5c 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -559,15 +559,15 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
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
@@ -576,10 +576,18 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
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

