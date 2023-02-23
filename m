Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875A96A0155
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 03:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjBWC7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 21:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjBWC7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 21:59:32 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB5843470;
        Wed, 22 Feb 2023 18:59:31 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id t22so10229371oiw.12;
        Wed, 22 Feb 2023 18:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4bDaQlm4IekB9ci5Y7wuWrWJVAV12yieyIsNsT+hgOM=;
        b=YGPJA+i7UZLAPFXwYzlNCPMqISThunBnbc5pTH7YX1EDEmfx/4Y1SoNXZ3LxKf+Zqp
         uLUywXXUMojb6MaaRk1ZQfYa1pys+gtDmzOg8Zxz6dGRZ8BalIDPJEKcZQRCMYn2ULDO
         OGCM6WnMg3Oc5nHzuiiVjIqyCazTcJgMz+2nptTn9RSgGYNaJkePYFAmF+FsAQje8vTC
         xK+1SS4mxHnilTLH1Sv78hzC/8HbXsAd+H3TvtB0i6yF8n/fnWdBSbybIpUqmHNVvDTf
         DIG5H4YBp4ZDLZCgjZhQVqf7ySSJPGfjx7j9/OCqYYo9dvRueMeA9JrIOW6webJFS41C
         MXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bDaQlm4IekB9ci5Y7wuWrWJVAV12yieyIsNsT+hgOM=;
        b=yNL3HOsKsycyEfuo4LTaq4u2OMDGgFV1TjDygriCABKcohuQ6ceIj4234xl9qrOZc9
         FMi018EgoQz7Kpana1MLAF0Rlg/SEEPe8zGTscl1FVQTC7c8ffcXxJa60oZgKMrJ1g6X
         RRaPJQ4VjE43YzozVlQX3P/dnJc/NnvOZ8566ldsOoNGa/ZshhPxmaM/2EGEltu+qH4h
         OxbXohpitzppl52zhMH4dxcU+gJz4DZ+ZwdkKel17zKM1kA3JlPKPJqQmMZ5TRS+/mkg
         XXx7OP+hM1j9ZrR97J5JbVYd8TMDuzsdfGI/Wh2AIj4t/yz7uGudVL9SVt3jwf4nS57H
         +Arw==
X-Gm-Message-State: AO0yUKXlFAiT13InhJNVnaf9c8o4xQYi1ujknTrQniFgaAqdrzN5JUkm
        EXB4vqP3ShQLsHuGn+O5nhy8KZmGL2k=
X-Google-Smtp-Source: AK7set86T9sQySQYGe/f9RSGkaegNimz6qVa/PdrC/55qa3kx3bg2Yl+X0leE+6JadfF8HY9wn9jMQ==
X-Received: by 2002:a05:6808:3a8:b0:378:920b:73f6 with SMTP id n8-20020a05680803a800b00378920b73f6mr1847221oie.46.1677121169983;
        Wed, 22 Feb 2023 18:59:29 -0800 (PST)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id b2-20020aca2202000000b003646062e83bsm2149403oic.29.2023.02.22.18.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 18:59:29 -0800 (PST)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH] scripts: read cfgs from Makefile for rust-analyzer
Date:   Wed, 22 Feb 2023 23:59:24 -0300
Message-Id: <20230223025924.526200-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Both `core` and `alloc` had their `cfgs` missing in `rust-project.json`,
to remedy this `generate_rust_analyzer.py` scans the Makefile from
inside the `rust` directory for them to be added to a dictionary that
each key corresponds to a crate and each value, to an array of `cfgs`.

Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 scripts/generate_rust_analyzer.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index ecc7ea9a4dcf..8bfadd688ebc 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -9,6 +9,24 @@ import logging
 import pathlib
 import sys
 
+def makefile_crate_cfgs(makefile):
+    # Get configurations from a Makefile.
+    cfgs = {}
+    with open(makefile) as fd:
+        for line in fd:
+            if line.endswith("-cfgs = \\\n"):
+                crate = line.replace("-cfgs = \\\n", "")
+                cfg = []
+                for l in map(lambda l: l.strip(), fd):
+                    if not l:
+                        cfgs[crate] = cfg
+                        break
+                    l = l.replace("--cfg ", "")
+                    l = l.replace(" \\", "")
+                    cfg.append(l)
+
+    return cfgs
+
 def generate_crates(srctree, objtree, sysroot_src):
     # Generate the configuration list.
     cfg = []
@@ -24,6 +42,8 @@ def generate_crates(srctree, objtree, sysroot_src):
     crates = []
     crates_indexes = {}
 
+    makefile_cfgs = makefile_crate_cfgs(srctree / "rust" / "Makefile")
+
     def append_crate(display_name, root_module, deps, cfg=[], is_workspace_member=True, is_proc_macro=False):
         crates_indexes[display_name] = len(crates)
         crates.append({
@@ -44,6 +64,7 @@ def generate_crates(srctree, objtree, sysroot_src):
         "core",
         sysroot_src / "core" / "src" / "lib.rs",
         [],
+        cfg=makefile_cfgs.get("core", []),
         is_workspace_member=False,
     )
 
@@ -57,6 +78,7 @@ def generate_crates(srctree, objtree, sysroot_src):
         "alloc",
         srctree / "rust" / "alloc" / "lib.rs",
         ["core", "compiler_builtins"],
+        cfg=makefile_cfgs.get("alloc", []),
     )
 
     append_crate(
-- 
2.39.2

