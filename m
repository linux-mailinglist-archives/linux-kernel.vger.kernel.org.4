Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3403F61551B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiKAWee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiKAWd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:33:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEECCFE9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:33:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso274308pjc.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQzGoj4PWhL+YVsgQJ5z9+/Kih3t/rfTwXU0TvQKFM8=;
        b=Kzs1G6hQ0kuz+t6Hyj2luEYUctJSzYNjr/RiQSddlkXMvlC8WZSqxbKBR2GxuqenLf
         OQUaP6LafEUW9QQSk2N1CHCFrlEna5vrjPlqMt/MY6K5NPsabM+UDg7xhMpyYJBvp/TB
         Qhr391tCSEJAxfKc6RXWCg9m4yKOpz8jet1NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQzGoj4PWhL+YVsgQJ5z9+/Kih3t/rfTwXU0TvQKFM8=;
        b=vfgK1wstPB3zdNZNC1PLsaOudxBIV9Hf+6I1s36/5tiG5jqliin2ekTUT/sEqBlL3Y
         QpvjFgOeFJZZmiy8I78pAXZVy7I5A3XOwwMl7oYbvl1CaG/tIurBQsYiPo1STTRmYIkm
         9qvA6xrxo/OkjssYcQ6KZRSK4DBlm0SoI2uUgUit8F0kBQUakvEvR51N1LJPHDkv9FRj
         KIZ/ON/nkrEP72jm1tdkGdXaJuJ2ElOiFy1RGI/oBee1HaImhbuipifyAV6dA1Uy5DrC
         QvTHf7j9NTpgGYIqAjad8XLBG/TP/6j/yv5GhyPLyWmODg88s7h1neW8TM8M87rL1IPg
         0aow==
X-Gm-Message-State: ACrzQf0FRLwKfTDG06hKm5vtwSlqLQ++tTHG4yQmA1XMavlnPAbNWOSP
        yet/oSTfp8clGAAXRy/6Fgr/Lf+8F/lBQA==
X-Google-Smtp-Source: AMsMyM7TjTXBopAgHEeLlCi6VSVxIf33KmWZT5LrXPEUzyU+oej4mwrStX0PEDyrKovQWQA34pT/Bg==
X-Received: by 2002:a17:90a:c38a:b0:213:119e:ebce with SMTP id h10-20020a17090ac38a00b00213119eebcemr22669388pjt.159.1667342004156;
        Tue, 01 Nov 2022 15:33:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g16-20020aa79dd0000000b0056cd54ac8a0sm6979590pfq.197.2022.11.01.15.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:33:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 4/6] string: Add __realloc_size hint to kmemdup()
Date:   Tue,  1 Nov 2022 15:33:12 -0700
Message-Id: <20221101223321.1326815-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101222520.never.109-kees@kernel.org>
References: <20221101222520.never.109-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; h=from:subject; bh=66bqcDCKUcRos1t3IlFIPskpfbQxNO3VtEaxc728EbA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjYZ6qbleitpvvOHVivxE2GM3C7WRtYicICVcezr+K bBy/ZYGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2GeqgAKCRCJcvTf3G3AJrxyD/ 0Sz5EBlX00TyOBKDue5S/TEPKu9FlK6tMshCI96Akt4QtwgM/FBaeIhUn5+WVlyWsSNnOkEiXOWNxf ymZEc2e4ip37GLLxvPOMgosfpIYt0RcwkaR7QQ9q+KHX2NzK3Nxk1DhkQAVNG7BC5wlkEBtUdWPK/b xdg34XDeb0ZVx1f1iL99s36MEkhWeztSoXoCLOVVT2v2r5dzGBa6j04E8oFt/2KV8VPZzsgvk59Wjo dZqvH0TOW5wKWLeN3AbHhRmhSArnFXiCvW7Gh7gwknSwVDGO6SQYWqUIvG8P26lPY504wXm6j7t08z xHujiAKshTjNBk4czRB5OEWIIZOquiBaCfcaWCKD3PPRU6YeAOv4RZ21DwgdjoVb9Pq9Dstq4lgy6W 9ue2fGR7chwod+xcu1qT4CUORf4DemZ2DfBaiUyrJZ2jq4pFoCJfLcfaRQO0iUCAuXWEc3ZC13q+oA kh0aDQbQMbsdRW2wcnl5gT8As3lVlFb7Sg7v/vbWHxtz5z9l3T035nWeFK0nf/PE1WY+gAfvSNGEX+ 5hcYyHvMmBj0lzQb2Ld+lBE9utZib3KNIy8hr+LNYpmVxxRpNJbcCr+SKpIbf2wSGg0ZZd0aGysEX0 L62xCGtjZMX4rSYWvhmXvBRca9taL7b603KSa7zEAwMFItsv7hzzN+y5tcyw==
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

Add __realloc_size() hint to kmemdup() so the compiler can reason about
the length of the returned buffer. (These must not use __alloc_size,
since those include __malloc which says the contents aren't defined[1]).

[1] https://lore.kernel.org/linux-hardening/d199c2af-06af-8a50-a6a1-00eefa0b67b4@prevas.dk/

Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 2 +-
 include/linux/string.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 9e2d96993c30..aa31f54f8b57 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -670,7 +670,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 }
 
 extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup)
-								    __alloc_size(2);
+								    __realloc_size(2);
 __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp)
 {
 	size_t p_size = __struct_size(p);
diff --git a/include/linux/string.h b/include/linux/string.h
index af1d69e5610e..db28802ab0a6 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -176,7 +176,7 @@ extern void kfree_const(const void *x);
 extern char *kstrdup(const char *s, gfp_t gfp) __malloc;
 extern const char *kstrdup_const(const char *s, gfp_t gfp);
 extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
-extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __alloc_size(2);
+extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
 extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
 
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
-- 
2.34.1

