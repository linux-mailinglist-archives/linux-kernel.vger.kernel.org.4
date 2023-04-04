Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D6F6D6FF6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbjDDWOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDDWOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:14:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116BC40D9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 15:14:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-93df929479cso2753166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 15:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680646459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tWU46z+LxAZ1Ey10aQVV7RoKLINUb1ekhfE7aBIl2Ps=;
        b=L4+wRj6/x0iKLAqOjXV0y7hMh4azCyZamBDr8njWOhWQzudWScUkVwh8IAF52vxcI8
         xyD9bv3a+6FFcxWPNXclggxwjVIkovF06vPQPlmN9KCyWnq+8R/ZnrzySv/Oldq9ydo0
         QbUpQlg3y9orqTjrxODR/IkZNAo0ZQzQTwwCtKfhWBKj2fpodF6FbDYMuB5yR4lfnkPU
         uSJ/ZnXvMyh7O7T1k9oe5FnM0ZuKfl0PjidDkFmVdZTF1y50l1NY5cXiR1+HiUuZOrDi
         dSQc43O7veEpkQzrs+DxCdHp5dx9gQTprT7xkjQ2lc1T2EaNqo4JnL5Mtu6WArVz/7kH
         WIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680646459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWU46z+LxAZ1Ey10aQVV7RoKLINUb1ekhfE7aBIl2Ps=;
        b=Xqq/HXzNSvrGGvsuKoCoE2SHqDA3vgi3AXZ2vDVFy8ABBcZvItDJrT23TNVjWbpGUQ
         Q5Ls90Qhr0i3JFhBJ81BFDLK0J/J4SL4LCX9FCNR3iIK1/rQNqnwhJtIsIZWqbfyAkY1
         cykX2S+kdiX7S9Kt7g/LoIKYxQwPxLLO3tBNWHpIxMpQz2l/oeUAfDsNgKdJ6Uk7Mncj
         TJAgLKmFZDzRNFc84W2vzdI52qKdAFFP50hruJJeZir31uA48c7mJ2+GHhGHjThdIpyP
         y3K4k46D5ifjtgx6JnztJyUA+LGGXDmmokXgNLg1UTumynD5zieQPLCrv5FJCO77fIly
         G9VQ==
X-Gm-Message-State: AAQBX9ctyqXM3KYzCH/0t1BzJN1SC7uxM57TqkZfy+mIRwP9Wa+WDwmR
        YVC76tzP9h2PECEDZBOzj/787TZi6+4=
X-Google-Smtp-Source: AKy350bvVO6MrW64LZ9jDBgS+4RnuM/Y3HVt0DwAgjbfv9AMuqLzhJxib25vlMyWVfLmEtZXgWW/0w==
X-Received: by 2002:aa7:d8da:0:b0:4ac:b69a:2f06 with SMTP id k26-20020aa7d8da000000b004acb69a2f06mr197334eds.0.1680646459228;
        Tue, 04 Apr 2023 15:14:19 -0700 (PDT)
Received: from noahgold-desk.intel.com ([192.55.54.55])
        by smtp.gmail.com with ESMTPSA id t20-20020a50d714000000b005021d17d896sm6428256edi.21.2023.04.04.15.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 15:14:18 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     goldstein.w.n@gmail.com, walken@google.com,
        akpm@linux-foundation.org
Subject: [PATCH v1] lib/rbtree: Use '+' instead of '|' for setting color.
Date:   Tue,  4 Apr 2023 17:13:51 -0500
Message-Id: <20230404221350.3806566-1-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has a slight benefit for x86 and has no effect on other targets.

The benefit to x86 is it change the codegen for setting a node to
block from `mov %r0, %r1; or $RB_BLACK, %r1` to `lea RB_BLACK(%r0),
%r1` which saves an instructions.

In all other cases it just replace ALU with ALU (or -> and) which
perform the same on all machines I am aware of.

Total instructions in rbtree.o:
    Before  - 802
    After   - 782

so it saves about 20 `mov` instructions.

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
---
 include/linux/rbtree_augmented.h | 4 ++--
 lib/rbtree.c                     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index d1c53e9d8c75..7ee7ed5de722 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -156,13 +156,13 @@ RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,					      \
 
 static inline void rb_set_parent(struct rb_node *rb, struct rb_node *p)
 {
-	rb->__rb_parent_color = rb_color(rb) | (unsigned long)p;
+	rb->__rb_parent_color = rb_color(rb) + (unsigned long)p;
 }
 
 static inline void rb_set_parent_color(struct rb_node *rb,
 				       struct rb_node *p, int color)
 {
-	rb->__rb_parent_color = (unsigned long)p | color;
+	rb->__rb_parent_color = (unsigned long)p + color;
 }
 
 static inline void
diff --git a/lib/rbtree.c b/lib/rbtree.c
index c4ac5c2421f2..5114eda6309c 100644
--- a/lib/rbtree.c
+++ b/lib/rbtree.c
@@ -58,7 +58,7 @@
 
 static inline void rb_set_black(struct rb_node *rb)
 {
-	rb->__rb_parent_color |= RB_BLACK;
+	rb->__rb_parent_color += RB_BLACK;
 }
 
 static inline struct rb_node *rb_red_parent(struct rb_node *red)
-- 
2.34.1

