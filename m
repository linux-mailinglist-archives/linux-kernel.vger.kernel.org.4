Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24D66E8714
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 03:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjDTBBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 21:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDTBBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:01:11 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CDC40EC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:01:03 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2475e9ec1c5so159186a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681952463; x=1684544463;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vzYRpL4WJi/eShcS9gd/sUYIXOHDRvt6nqLLIza4/9g=;
        b=n30VHeviXyvVH8noJXAIyNIoAJdj26ToOenuxSOWx0ra21HI5zNP8KS7WRoIHAJEzS
         Av9ZM2bPfHyv1WLriLOHjXnbIiGcxrbTC/ab4oqqQUrLe5QV7ZqLujnydRyjQbFjuW8x
         4t0knhDecg9Ut9M2bPT0MGJLYPReeEz5pJVuKUIfL4mDpKdJmC9eHHoOAII9tBRtR2sn
         lzSoWx70zLyvUa3jsDcnMqQ+mwNEKWvmNm97FwXRUcvwCezNV0Wgi0EP9W6fiNeqHhdw
         BlXeIURWNsttod0aAHgzJdQT50npnF6ePxK50fUxPq6JwUzJkfZfHy4y1JWhNLDCvkr2
         ozfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681952463; x=1684544463;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vzYRpL4WJi/eShcS9gd/sUYIXOHDRvt6nqLLIza4/9g=;
        b=DDO1EQmdLgeyEiP/u0NPUJ9xRaJiNwFpTzq/9ayD3/6nnkZKE34K5Sqxy5ao/XPJrP
         +X3NFhaiRYgaZzfXjxfxnbbORVRGYMI60qZ8So5ZxUMvnUU8aLDpuAFrXqpQoY/dU0UM
         coA6Xlvf9acZQgInrXmgPjGgPmFmJ7TtFuvjW2V7+q95MkkLxEw7Fe9Y+NTD9ZlSz9MN
         1McfyhwYXM4HnwASgYgjvmsO84ESosfhwCSn/0RLimrWQoVvT5PeZr1dxCFBXh/LlWsP
         9rfw3sKIXhXYRKPeMi6Jc1RQRbFPvOR1MfjxsJVfT9FzhB85FEyXO8PPH6Ejv1T7vTb9
         4eSg==
X-Gm-Message-State: AAQBX9ft8ZzSZ8Q75ip1zBPjTaOrMmzoyV5CQAyKSsbmEp/qzu0qeA8Z
        Fpk7AkwOU+24gMnZNDhItAmmFrUd
X-Google-Smtp-Source: AKy350aybHAKhbT6+MclxbAQ0XIstpA6QdXqa2UK9JgzGSSAsPkGcVb2JWGcEth7N5N/V7FWCzOEdyFE
X-Received: from elsk.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:dbd])
 (user=elsk job=sendgmr) by 2002:a17:90a:b81:b0:247:8d04:81ba with SMTP id
 1-20020a17090a0b8100b002478d0481bamr1408654pjr.8.1681952463203; Wed, 19 Apr
 2023 18:01:03 -0700 (PDT)
Date:   Thu, 20 Apr 2023 01:00:19 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230420010029.2702543-1-elsk@google.com>
Subject: [PATCH v2] kheaders: Follow symlinks to source files.
From:   Yifan Hong <elsk@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <linux@weissschuh.net>,
        Matthias Maennich <maennich@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        Yifan Hong <elsk@google.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is built inside a sandbox container,
a forest of symlinks to the source files may be
created in the container. In this case, the generated
kheaders.tar.xz should follow these symlinks
to access the source files, instead of packing
the symlinks themselves.

Signed-off-by: Yifan Hong <elsk@google.com>
Reviewed-by: Matthias Maennich <maennich@google.com>
---
 kernel/gen_kheaders.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 1ef9a87511f5..70a75a9a7535 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -87,7 +87,7 @@ find $cpio_dir -type f -print0 |
 # pre-sorted, as --sort=name might not be available.
 find $cpio_dir -printf "./%P\n" | LC_ALL=C sort | \
     tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
-    --owner=0 --group=0 --numeric-owner --no-recursion \
+    --owner=0 --group=0 --numeric-owner --no-recursion --dereference \
     -I $XZ -cf $tarfile -C $cpio_dir/ -T - > /dev/null
 
 echo $headers_md5 > kernel/kheaders.md5
-- 
2.40.0.634.g4ca3ef3211-goog

