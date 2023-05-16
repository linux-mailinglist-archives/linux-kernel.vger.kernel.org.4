Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D289A70545A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjEPQuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjEPQuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:50:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FF27EDD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:50:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3063afa2372so13479664f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684255804; x=1686847804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ymkh61skTg1zPEDqswzbYNZ5qZ7vCuKjURUbxRjnrR4=;
        b=ElKZq1RJUUT2igAem4p7PmeZBkTjTsbvdeOoELOpBMcWqwOZ+oLhbap2ZW7TjHpqMc
         7A1+O9Sc4YLPymT5ntAfve35sGXsPYr6Wo5NuHFrsLEteQNVRcb8GgCUryvdnUDofBvP
         3YFjq1aNTTm24hyHmxde09b2MJQN4E1jhT/C4PqOWaHev/+C7eE6aQZKDkt9Y8jn8pbA
         utMp+SzxP8lyJrifT5jnrKlngyHZl/MPwnpM/uAYaVe9XAofnTzv/+4nBZxhHDfD1Pvl
         tGKDzjqd+8nYka/EtLFWizailLRSimeF9I8yMZqGLC7Ycdf8CFaZAy0xfXJaxrGRZn6A
         SKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255804; x=1686847804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ymkh61skTg1zPEDqswzbYNZ5qZ7vCuKjURUbxRjnrR4=;
        b=SxPxp/4E6kMEJL9fXWesDx94ET5buKR0ue75bvmCcwdhaHjNDcFEMgIBdK/hKqyqmN
         rZhKyxifV0gCy+y7a0kqrDea7si8ukzawzefWMtuWFYIndUTqpyRbHlOnD41AyNcCW01
         SC3WqLohmKm1KArl1ZarQhsO6SsEiHUMg8NxSjI/7H8XzHZapHQbM3sI+bNOMgKu3AUL
         yhIldsqWN3xeE7x9xyR/zMrcsen2FdHK7R5/OjFsU7U8QI1tzgqjZctnf0Ua9H7IeSlx
         50kksCPTV1NkrRIsqzmNQET1WpCz3Zlbv1c9Wjvz/3CUQhn4//nnYDb2uFkM5dQ4r9Dt
         1Ajg==
X-Gm-Message-State: AC+VfDyWXHu1CTu7pO2jCV919MGlLL24AG4uD4YS8cmfoXitXzzblmOX
        KHoqQFdwggvQzniVJFTw8w==
X-Google-Smtp-Source: ACHHUZ5oq2fE7ik2im4xYdYszNGmlUWBwpYghVQVHQfe3G4KUn2bxkJoavGEAMQOn3lb4tt5Ehv/5Q==
X-Received: by 2002:a5d:628e:0:b0:306:342c:50c2 with SMTP id k14-20020a5d628e000000b00306342c50c2mr32095502wru.53.1684255804063;
        Tue, 16 May 2023 09:50:04 -0700 (PDT)
Received: from localhost.localdomain ([46.53.250.37])
        by smtp.gmail.com with ESMTPSA id d10-20020adffd8a000000b002f22c44e974sm3094789wrr.102.2023.05.16.09.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 09:50:03 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 1/3] auto, kbuild: flatten KBUILD_CFLAGS
Date:   Tue, 16 May 2023 19:49:45 +0300
Message-Id: <20230516164947.86543-1-adobriyan@gmail.com>
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

