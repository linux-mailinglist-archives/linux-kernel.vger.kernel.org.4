Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399456E7070
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 02:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjDSA3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 20:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjDSA3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 20:29:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F00D448E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 17:29:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 85-20020a250d58000000b00b8f380b2bccso18107739ybn.14
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 17:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681864190; x=1684456190;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DXMIww6nzGIfx8TKuxq3pWj7AAxugyyLSIke1AXGaJU=;
        b=Fy4LccDIwokjGBpkorGNg6gynq5isS2TrZbTU4RKnJLgRfSnvBCdo5rTm/Q0To1dRc
         FXBaE+GnB4uXgKOFT/kJ3YAEy261z6F4JQIzVELP2z8nzhadDh2AfuhX2f/P2wSpQla7
         etrCc4pRpyZpVH8jhe7VQt97zLlN06By1Qqd9mwceOEUvhD7x15Y9IxPJcw5/Y2kKBqy
         3UBm2xtfsEMDp+svpI1bYzWAkdLHMVtOd4/6VdTcpuMT5EIh9nhHi65gOL/FAhOWnBY6
         ed1irfMkeo1pE0tSJnUjQ/8OjmEC9QHSuw3k+1OlsYi/o6Fj7Dw89WZGTKBxSawquHDw
         PsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681864190; x=1684456190;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXMIww6nzGIfx8TKuxq3pWj7AAxugyyLSIke1AXGaJU=;
        b=KdLOJ8WEPJaaJwuyrl68/MocC39XrpJTfiBz/Esvo73Qafd7VrPm2Y9wEecQIJUCcv
         PeM0jEqiAfJI97u8qH9jN5aSU2KT6z3rk0BphKcKQuG/qFDSGjHz+HgZ3mwjoAdXEQ+J
         G8RBTurxOn9N8LyBGPEOAU4MdY/koZOsjFMSoVWiyVa1HVBqxjCRjV1YIa7Wvpcz4Rr5
         qWbkpulHhZKLGlOPb5Z0UdpLoUre3gCD7lT+eSopLoTErCv4DWRBjCVCQY0D3/UkJfK4
         oyeqhwfSgnJLOszZfDy2TvY7YgoWLYOiMM47kgsyQhuSCZctkBYVGjIuwtT8PiavoSJ+
         br4Q==
X-Gm-Message-State: AAQBX9clb5iNRqfzxTOmU2Z5huiCkaSWkkibjGTdmzilfPeJr4h9OKvq
        ach6+4oWw3dvbXPxPzv1F/QNawg5
X-Google-Smtp-Source: AKy350ZbxEanOzLelMYuBzRaoNE/7rq4lqa79xBVUDl+qtYCt5mArMRq0SwNa1O1yikwSRiVQXNOUqJV
X-Received: from elsk.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:dbd])
 (user=elsk job=sendgmr) by 2002:a25:da43:0:b0:b8a:7b2d:6556 with SMTP id
 n64-20020a25da43000000b00b8a7b2d6556mr13464011ybf.8.1681864190664; Tue, 18
 Apr 2023 17:29:50 -0700 (PDT)
Date:   Wed, 19 Apr 2023 00:29:36 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230419002946.2566272-1-elsk@google.com>
Subject: [PATCH] kheaders: Follow symlinks to source files.
From:   Yifan Hong <elsk@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        "=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <linux@weissschuh.net>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Daniel Mentz <danielmentz@google.com>
Cc:     Yifan Hong <elsk@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
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
---
 kernel/gen_kheaders.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 1ef9a87511f5..183d9a44aa39 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -87,7 +87,7 @@ find $cpio_dir -type f -print0 |
 # pre-sorted, as --sort=name might not be available.
 find $cpio_dir -printf "./%P\n" | LC_ALL=C sort | \
     tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
-    --owner=0 --group=0 --numeric-owner --no-recursion \
+    --owner=0 --group=0 --numeric-owner --no-recursion -h \
     -I $XZ -cf $tarfile -C $cpio_dir/ -T - > /dev/null
 
 echo $headers_md5 > kernel/kheaders.md5
-- 
2.40.0.634.g4ca3ef3211-goog

