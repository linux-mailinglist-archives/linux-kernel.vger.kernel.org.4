Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF9C6ADE4D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjCGMII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjCGMIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:08:05 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A018B37F28
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:08:03 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id az36so7611939wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 04:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1678190882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N8+KuBNUOvMkQ5tG78D1gymPnKoB/geR+L27cmc6zCU=;
        b=JZiHCHIFrKxIz+YAYok47ojhjGpd5HwreP81Bh/lztS9vQDw3MXjwvGiui7nRTyoaQ
         PRCXJJ2z/aVQNYI+CoywYgwTyaUqJY1EX433/qaD0v6YMv0OzGDgneR3iiLpl3zWZltx
         S5EWYYG6935vjVpUmlqFRQwVVtx3wvWt+dXqrm50NxWKMSp5GKqKQtwjDA2Sbuc2aqyZ
         AO7mUNqW3+gBhC1eNajMLFKpMMW+TN1wNX9uruW+dxJrI+sTQ41XnkCgmmaDtxINXnE/
         4SWn6tOI3YOiJb8NRC3tKMAMgJH6khkfYce0wUmpT9PF0zqjG6DW9fzEJKwSSnQRN2XU
         bI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678190882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8+KuBNUOvMkQ5tG78D1gymPnKoB/geR+L27cmc6zCU=;
        b=vuNgYmUmwG7udQ/YI2Unrd+aNhHjx4s+XFMX1v+Aaz9QaJnYFzbywiCGxznGZ/Rtzp
         hAZ9IAfNUvLlCYrcx+uKApUBBzqhHkayz/9jOqTJAt6h2t1iZSVWPgJgf37rRWwmAylj
         PJAbSEnVXPBDJsa+7CfSv8kTepv8EWOEQv6a0CH/Pf2PGmrVr0tfHtLJAHmG5tBf3nw8
         qEqeO5Gni4ZSbiU6pXLGFzGDgSx2ZTucRfCEByRr8hjNDUilOq8sSJTcH3cdnhVZVKP8
         eCmk0+KLfIQz5u8rbTTzi5WzNrz7YzKVEj86azNUziqhEcZfHKtr4Rb5IsEH88FD43Dr
         ybig==
X-Gm-Message-State: AO0yUKUSYFHPok4w1iB4wlwHgX2tuFAbNxjuiRoIcnYAVWxhMIJ0rYeY
        HX1geY+lw+clAW/1fOgE0fwmMg==
X-Google-Smtp-Source: AK7set+hqMq9rWHSQEMhQN2UPXAK02r9tnlaaJ7BbiWNYsYRBLpLGNjeQ7ZwOvU5GAKeikPMdf5DBw==
X-Received: by 2002:a05:600c:4688:b0:3eb:42fc:fb30 with SMTP id p8-20020a05600c468800b003eb42fcfb30mr12992036wmo.32.1678190882157;
        Tue, 07 Mar 2023 04:08:02 -0800 (PST)
Received: from localhost ([147.161.155.97])
        by smtp.gmail.com with ESMTPSA id v38-20020a05600c4da600b003eb68bb61c8sm12351014wmp.3.2023.03.07.04.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 04:08:01 -0800 (PST)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     rust-for-linux@vger.kernel.org
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scripts: rust-analyzer: Skip crate module directories
Date:   Tue,  7 Mar 2023 13:07:36 +0100
Message-Id: <20230307120736.75492-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When generating rust-analyzer configuration, skip module directories. This fixes
an issue that occur if we have

 - drivers/block/driver.rs
 - drivers/block/driver_mod/mod.rs

If `driver_mod` is a module of the crate `driver`, the directory `driver_mod`
may not contain `Makefile`, and `generate_rust_analyzer.py` will fail.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 scripts/generate_rust_analyzer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index ecc7ea9a4dcf..e8c643fb2488 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -104,7 +104,7 @@ def generate_crates(srctree, objtree, sysroot_src):
             name = path.name.replace(".rs", "")
 
             # Skip those that are not crate roots.
-            if f"{name}.o" not in open(path.parent / "Makefile").read():
+            if not (path.parent / "Makefile").is_file() or f"{name}.o" not in open(path.parent / "Makefile").read():
                 continue
 
             logging.info("Adding %s", name)

base-commit: 8c20eb7e6a27b2c493b0bbb435e75cae7135634f
-- 
2.39.2

