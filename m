Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814A8708544
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjERPrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjERPrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:47:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA79FB
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:47:04 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f423ac6e2dso14731395e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684424823; x=1687016823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ymkh61skTg1zPEDqswzbYNZ5qZ7vCuKjURUbxRjnrR4=;
        b=Zl19tS8KTowE+6PyugbQz3d+LqX6WWctHiadQ+HtWAmvSLgBd/Ahff1iTm/M8wuNOC
         Mwv7mqEcBwGYBnJd3yhxNI7OI6uaWSu9POQPlHErxYKjCBVsSmBXDG9ELloXSJSSLRbM
         F1QETn0xVEPlj1YZLOc9vb9vi3it52xTGItQx7NVGruS5P9eqm8+li7IetKsuTDgz1Zc
         KG2Pybtx34uxG35OD/dALu2xI4VsFXHyfbgb9HiFfV83wqu3NlyS+SLDe/ixqbP5kYu8
         vuO1GMbvQ5CpoqLk8IFC4aoi4EjOTeHoGnBkEgvOu8p2oGZZSzrrSmwF7bz/BT9pE82U
         yJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684424823; x=1687016823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ymkh61skTg1zPEDqswzbYNZ5qZ7vCuKjURUbxRjnrR4=;
        b=SgaUwjq+VlVnXfxitzqdVobv3r67VxCDreIcC1dTlSI+wpibiPnwNZJpiod2VYUWHX
         r+uC5B3Vv9v28UNQ0ES8qgAlWXsY1MSoqI8OELbWx7golF+7DQXoL6cC9EO4U5TNXHO9
         0zVeGiub/HNxTn/HiIrFNXBwqxFjfP/+AVzqxJ2/hTHzHqkY34DIYGmadptxbD8AVD1O
         0WQNDgS8+cmcOiJSY5IwLV4aQ5WKwAIjAd0f1di3pOSc4o8eesHNylodfA8KGokdHnLL
         LZymeM4L8UeXzOqjQ9ltCzWOZM2djxkKqOafPWwEK11avFFnE21Fv6XWKLgEw5tUCzZv
         jEzg==
X-Gm-Message-State: AC+VfDxTI4P30cbI0eTvNcrk+lN12GIhJOn37+cEF0dlFr6c1zxUpCox
        pFBwCZdyYI5SjQESrLigTQ==
X-Google-Smtp-Source: ACHHUZ5NEN01uLw38HTG60bVP6CFot9CpU5K+73tZInZX3ej0M6uFNn+hq8ww8pFkeuOn28OzRM0Eg==
X-Received: by 2002:a05:600c:210e:b0:3f5:39:240c with SMTP id u14-20020a05600c210e00b003f50039240cmr1755001wml.27.1684424822916;
        Thu, 18 May 2023 08:47:02 -0700 (PDT)
Received: from p183.Dlink ([46.53.250.37])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003f421979398sm5671769wmb.26.2023.05.18.08.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 08:47:02 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 1/8] auto, kbuild: flatten KBUILD_CFLAGS
Date:   Thu, 18 May 2023 18:46:42 +0300
Message-Id: <20230518154648.581643-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it slightly easier to see what compiler options are added and
removed (and not worry about column limit too!)

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 Makefile | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index f836936fb4d8..10fcc64fcd1f 100644
--- a/Makefile
+++ b/Makefile
@@ -554,11 +554,23 @@ LINUXINCLUDE    := \
 		$(USERINCLUDE)
 
 KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
-KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
-		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
-		   -Werror=implicit-function-declaration -Werror=implicit-int \
-		   -Werror=return-type -Wno-format-security -funsigned-char \
-		   -std=gnu11
+
+KBUILD_CFLAGS :=
+KBUILD_CFLAGS += -std=gnu11
+KBUILD_CFLAGS += -fshort-wchar
+KBUILD_CFLAGS += -funsigned-char
+KBUILD_CFLAGS += -fno-common
+KBUILD_CFLAGS += -fno-PIE
+KBUILD_CFLAGS += -fno-strict-aliasing
+KBUILD_CFLAGS += -Wall
+KBUILD_CFLAGS += -Wundef
+KBUILD_CFLAGS += -Werror=implicit-function-declaration
+KBUILD_CFLAGS += -Werror=implicit-int
+KBUILD_CFLAGS += -Werror=return-type
+KBUILD_CFLAGS += -Werror=strict-prototypes
+KBUILD_CFLAGS += -Wno-format-security
+KBUILD_CFLAGS += -Wno-trigraphs
+
 KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_RUSTFLAGS := $(rust_common_flags) \
 		    --target=$(objtree)/scripts/target.json \
-- 
2.40.1

