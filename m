Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCDF62EC7F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 04:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbiKRDwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 22:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiKRDwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 22:52:03 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFB18F3EE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 19:52:02 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d192so3768997pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 19:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13POlA7CELUjT6ZjE2YlVT7xlxRT3lU0xqTeymXfKuQ=;
        b=mln/mgTD/8ZiYnrfEL5sJdItSGA3CsUZXe0Rbw9VmgWwP7++319wUWFlXAOZhmdkE+
         Q1A8F59QiRmh/VDbUqCYA2L/XIIyIXNDrRkekGA+mdDaZnqnT7Iacfw8H/f5UlHKWNFL
         zWFpNrCeB4pUtxOC9D7mAQUfGrSn4vB3tbBI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13POlA7CELUjT6ZjE2YlVT7xlxRT3lU0xqTeymXfKuQ=;
        b=okP1ymhQgVbTesONxX8v7QJTc6pnvHJ2mYC6ZcSrD9Hb3SeEE/akWCRkxnVqUP+h3Q
         ADzLXu09kuQsDkIhzjRLEn3a/Vq9NANXbf+jjN0GqBXIS6U9S6v0AgZbrIwmdw27dk9u
         U+zW6yo6+/5fL7nJ1Ar8n9uR3+4UIh5fdJ1pQUeJjjQ51PwUMFqLhI+VMD8mfT269dNz
         M79FZ41cwfqR/mcdK/5bU2N8WpTulCf99qnTwnpCecIHaAQnDFaxZNAzD6N4eNkuCORO
         075y46QEM7rQljbHdOAuhLA3++tNkdiZVvVzSrddpNDrQTtYS6315/xwVNwnu4V1cMDe
         D0lQ==
X-Gm-Message-State: ANoB5pl1cYT5JRn0bObd+oz/p1GCAV4/5KL/FXBNf6osSjOxVwv3O0KE
        AQPXDcNQ+ykGcPOSp0oxMUpbbQ==
X-Google-Smtp-Source: AA0mqf6N+OlYszLxbtmqYFwWBrZKb2ySfrwYomT8syL2s6d6kloyN/S01vclXkdw4lKt9+nfwwJ+dw==
X-Received: by 2002:a65:6847:0:b0:476:f43e:a86 with SMTP id q7-20020a656847000000b00476f43e0a86mr4988332pgt.363.1668743522032;
        Thu, 17 Nov 2022 19:52:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e5d200b00186748fe6ccsm2276693plf.214.2022.11.17.19.52.01
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
Subject: [PATCH v2 2/2] slab: Remove special-casing of const 0 size allocations
Date:   Thu, 17 Nov 2022 19:51:59 -0800
Message-Id: <20221118035200.1269184-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221118034713.gonna.754-kees@kernel.org>
References: <20221118034713.gonna.754-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2371; h=from:subject; bh=roYcJKurZ1Ad0yqcM7lIDF6nN9ThBNp448RHSIPN1YQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjdwFfZxDK7dz/ZV+GaTBVSw8vUtlA5Z9lYg4dYZxh Ty2FDZaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3cBXwAKCRCJcvTf3G3AJqB3D/ 92I8BImb3l8xp7T7C/K708vzPl/8cg+RmpOK6O8J9tqppE4B5M+SHEFIwWoiPjeSunOrFQ1DwDx9iZ u69XcPWH0rvSq6XgAS4hKKx3hUEvm7SfHhU/tMqqLMduePCXfFRifcSHXyzlATJyq8Wouii8HIaWo4 wpwfW8/jeErjZCLwxoOQFfOGSdrPISOLAvnII7IHQyoHd/w0i9HLKgRHtB8xe4z9u/B0X33zioYBJN J62lW7fZXdQJey/y170LtBc8LAW/Tw7fwE8hxD0AsbzzOxgYShr8FnHhwwcu0EC4j4GnYBuTey8frV EySb8ats1/DK6YD0YCsS5AQB+/IUERCstiwsPOzLUZgZd8bdSusAxZhGH4iBRRof6wHWXGNrjAVwhn 3Snjp2O9GaBhJWiCAuNsthWjbSRE5KabMfNcSbunYrPfQXvBCXcdsUNxPVAILnJG2RgVexDJXdP1+S 95JSp0z6rrSxXhOefnmqdca5dura/qA18ttumMHL/6w2vykG0fx4VLfMizyQgi3/yTu9ykaTsw77+6 /VGws3PmhsMC0P+WacnTRQRezboPQxcBN65EO5en1ch1MUhYl6E+/yKf9e6POwUMv6e8aO56MI3us9 C/kaUdRHt4xCbf/FUTiy6plT2ZYVnNHudbi4m84b46NIo/ancm1AFn8JpH1A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 9033937c758e..84be05208418 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -561,17 +561,13 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
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
@@ -591,17 +587,13 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
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

