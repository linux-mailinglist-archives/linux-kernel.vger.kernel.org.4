Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDBA6EE908
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjDYU26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjDYU24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:28:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF802D32E;
        Tue, 25 Apr 2023 13:28:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2f87c5b4635so5650596f8f.1;
        Tue, 25 Apr 2023 13:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682454533; x=1685046533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3DoJzuoAqhNjvSUCYmCLbH+X+jsvgK0x4ldD98bDkU=;
        b=kYLBOIZlJqw0U+oVS3BBAqthHyzo2Pox3BNqe26Or2d9A0cq/xtk1zz4dpqZ840v/X
         za/nkpFq40GvgK+ysqYcBSWXAososJPuaGrQiD+APEKvJi3L/WRKQnWmWwr8dPSCUkwr
         l+kGRF38XY1aczDSom+ydwAYCs3p8YhJpfZlBXdhyJe57jPp/k8E7BwmghnGgkR8npM5
         KyKD+yk1p3u2Rs1cQpuRe5sJf/KUrshxkx2uXFOT960j7bs6y85QdCOA/I5N0xHmKWUg
         x/1pcyz0tl9Tkhs0+xkuua67GjY1ABru80Z1V572dC4gSwq7UscM5OEBtFMvXlH3EmIE
         SxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682454533; x=1685046533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3DoJzuoAqhNjvSUCYmCLbH+X+jsvgK0x4ldD98bDkU=;
        b=TKBlHm7qTI2Wt3WEeP+IHVRstR10IZk7gtJbUyGnfyNgvWNghqQQg3KLWd3vNFfBOt
         G5Y+MwL2D1wcGohIQ5GTbAdOS6fZibmmjgWxnY8PJfJcQTzUnfQEiJCxAXd+zWGWUyT7
         tRc9emJQIwn8YqeAmxSJ7bC6pAoBT2EBDxVIFcUXFuY3+31+aVKT9WoDukkXfvun8Vd/
         lOQPnen3dMs7dAMBMP3VvEQc6Bs7KC/izXDaa/hw8+9moAcosVuXY6ANhga/6LXxOAVG
         /x7sXXLaS/WMnFxAIvW+VjZARUO+0g5MlFuy4Z19g3shYzcCx+D9OBJZZCsf7neJKCEe
         /vNw==
X-Gm-Message-State: AAQBX9dLj23PKG2jNg4i3+tBg3xERBl+rB1j+Pvm/BB1d+9W3hW4OqYu
        rhNi8rGM+Ktk1LacBVK8YBy8o70FLUrNYA==
X-Google-Smtp-Source: AKy350avUsK0YErj5DEfepD4jutOZ3V2aIOx3oyFKD7KwQRuKOb4H3ntrx/co0bZ1dbFzIgat+wtbA==
X-Received: by 2002:adf:e952:0:b0:2cf:e74f:2957 with SMTP id m18-20020adfe952000000b002cfe74f2957mr13495464wrn.33.1682454532774;
        Tue, 25 Apr 2023 13:28:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2f0e:c07:300:175c:44ef:f037:8f88])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d6246000000b002feea065cc9sm13795739wrv.111.2023.04.25.13.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 13:28:52 -0700 (PDT)
From:   Ariel Miculas <ariel.miculas@gmail.com>
X-Google-Original-From: Ariel Miculas <amiculas@cisco.com>
To:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        benno.lossin@proton.me
Cc:     Ariel Miculas <amiculas@cisco.com>
Subject: [PATCH] rust: Sort rust/helpers.c's #include directives
Date:   Tue, 25 Apr 2023 23:28:48 +0300
Message-Id: <20230425202848.261139-1-amiculas@cisco.com>
X-Mailer: git-send-email 2.40.0
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

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1003
Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/helpers.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index 81e80261d597..59a23b1647fb 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -18,13 +18,17 @@
  * accidentally exposed.
  */
 
+/*
+ * Sorted alphabetically.
+ */
+
 #include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/err.h>
-#include <linux/refcount.h>
 #include <linux/mutex.h>
-#include <linux/spinlock.h>
+#include <linux/refcount.h>
 #include <linux/sched/signal.h>
+#include <linux/spinlock.h>
 #include <linux/wait.h>
 
 __noreturn void rust_helper_BUG(void)
-- 
2.40.0

