Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF39F6AB4DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 04:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCFDDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 22:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCFDDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 22:03:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C904A24B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 19:03:42 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id oj5so8370532pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 19:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678071822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOC/FNu2kgiTh2xy+eQd0EULhBRFBbwS09u1PSCaics=;
        b=NaKYVckZLYfiEuAigzcP2ETDA+KCnwCeEG6JErjf5qgu7EvyJy413kzlsIjrrmFzwB
         TIMrVi28isX3LNq1vvN8kZtZv772oFypAlZ7V2rmarNnARWhk/O32RHBNeAY38G4pjLf
         mfogJfCiYVCDZ6szaAOYjF/PBNoCcpkYyCRiPwbqyGxeNhjak22jX5BYnpyFrg9F966K
         eVFGlYDCvp/OlbnBgWUGbnn9L+jhQpxcHWsL0Wew/SDtoNrqBHZMlGn906K6whpqUEGd
         8annz1k4T1diofzyCnJvehBAZY1p1l+QOSiPrVJq6BtFBmT0AtmiHJR3WssGA6z4qWeZ
         2hgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678071822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOC/FNu2kgiTh2xy+eQd0EULhBRFBbwS09u1PSCaics=;
        b=0oP7CwJVaLt5i6UGspEfrJYDYbCglO26B4pwJb6bka6OcdF8ouBdH476XUfBhLvw30
         cmbOxSWTGAPLdTsjFgGYk5Gty7auUgMKaMGe5EUDGHLhyfWyQgHpMz/p3JMa8ija4eBw
         MMSJRavlv9TZYrbdVRsKMicp+DYy8id3d14dZoyBgm+e6AAiTnV/TjAfE+bSXYEheh3f
         DGeYKPTg2jOZw2PAWybyvqgyhUva237hmsatjEsu4cy4MlEc7Yla6ffkHg/kOvNFVRXr
         NOBHepSVtmbk6i203aurZ49Oj3QtPuKB1XlRwrwM2OZvNfjtuQmB+wTB9iA8uWDxQ6LO
         u/Hg==
X-Gm-Message-State: AO0yUKXVHx+1uMHZeEJUTWjtAgrxuPtSb/LAcPvZH/cOb0W54Jt2S43Y
        FeO+I+j09zmUEs+scwQSFM6+byy8yw==
X-Google-Smtp-Source: AK7set9pFHfjgHVn9nJVc+fD+gdveI9XYNbDTQrxdQyJRmLKk2YuM3aJ0xZd+cpaGIwqbkF6D36UKQ==
X-Received: by 2002:a17:902:c40a:b0:19a:5958:15e7 with SMTP id k10-20020a170902c40a00b0019a595815e7mr10254558plk.15.1678071822090;
        Sun, 05 Mar 2023 19:03:42 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jy16-20020a17090342d000b0019719f752c5sm5410439plb.59.2023.03.05.19.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 19:03:41 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, kexec@lists.infradead.org
Subject: [PATCH 4/6] lib/decompress: Keep decompress routines based on selection
Date:   Mon,  6 Mar 2023 11:03:03 +0800
Message-Id: <20230306030305.15595-5-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306030305.15595-1-kernelfans@gmail.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, many decompressing routines in lib/decompress*.c are in
__section(".init.text"). But they are required to decompress the kernel
image when kexec file load compressed kernel.

To solve this issue, define 'INIT' conditional based on the macro
CONFIG_HAVE_KEXEC_DECOMPRESS. Also make lib/decompress.c adopt this way.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 include/linux/decompress/mm.h | 9 ++++++++-
 lib/decompress.c              | 5 +++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
index 9192986b1a73..33d8fd13a5c6 100644
--- a/include/linux/decompress/mm.h
+++ b/include/linux/decompress/mm.h
@@ -92,11 +92,18 @@ MALLOC_VISIBLE void free(void *where)
 #define large_malloc(a) vmalloc(a)
 #define large_free(a) vfree(a)
 
-#define INIT __init
 #define STATIC
 
 #include <linux/init.h>
 
+#ifndef CONFIG_HAVE_KEXEC_DECOMPRESS
+#define INIT __init
+#else
+#define INIT
+#undef __initconst
+#define __initconst
+#endif
+
 #endif /* STATIC */
 
 #endif /* DECOMPR_MM_H */
diff --git a/lib/decompress.c b/lib/decompress.c
index 8dd6f87e885f..33f097fe4b51 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/decompress/generic.h>
+#include <linux/decompress/mm.h>
 
 #include <linux/decompress/bunzip2.h>
 #include <linux/decompress/unlzma.h>
@@ -60,7 +61,7 @@ static const struct compress_format compressed_formats[] __initconst = {
 	{ {0, 0}, NULL, NULL }
 };
 
-decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
+decompress_fn INIT decompress_method(const unsigned char *inbuf, long len,
 				const char **name)
 {
 	const struct compress_format *cf;
@@ -83,7 +84,7 @@ decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
 	return cf->decompressor;
 }
 
-decompress_fn __init decompress_method_by_name(const unsigned char *name)
+decompress_fn INIT decompress_method_by_name(const unsigned char *name)
 {
 	const struct compress_format *cf;
 
-- 
2.31.1

