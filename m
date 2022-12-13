Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F1E64BC27
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbiLMSgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbiLMSfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:35:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F26425289;
        Tue, 13 Dec 2022 10:35:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88B4F616D1;
        Tue, 13 Dec 2022 18:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34509C433F1;
        Tue, 13 Dec 2022 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670956550;
        bh=iyMWYw8QwA65vOGqJNqBD5pQyIoP0C216Ve7ERqMbKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZIw+ieQH9eUqCDx7a1A0RVho7mXVxIo8vFgNcKm7CnBOORxhuWpTWR9X/jQZhvOq7
         ZOrNQfJDtYODAEwbxMsXi6X+oEGXYUw94sc59zvn5qPg/fHOSS0Psa12wAcpfzlnDG
         9Gzqw+DDcKJIuT9SukGEFtJtDQuwO+I4Uf75onM1Pt22Lukw67l+QYw92d6k+9IiTz
         wIgDbNtVQn3TSPywWnziFudu4t8zh21521aqykMgOG+Bp6rDF/pgIyEde37GbEktV6
         9y3JUMV1I0pBqA2OzuzeQizcOz7ckQIBfwv9ngrrla3lxq7MDHOEd5K33r3jNFlI5l
         alCZcyTHvGUYA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 1/2] padata: Mark padata_work_init() as __ref
Date:   Tue, 13 Dec 2022 11:35:28 -0700
Message-Id: <20221213183529.766630-2-nathan@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213183529.766630-1-nathan@kernel.org>
References: <20221213183529.766630-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building arm64 allmodconfig + ThinLTO with clang and a proposed
modpost update to account for -ffuncton-sections, the following warning
appears:

  WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)
  WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)

LLVM has optimized padata_work_init() to include the address of
padata_mt_helper() directly because it inlined the other call to
padata_work_init() with padata_parallel_worker(), meaning the remaining
uses of padata_work_init() use padata_mt_helper() as the work_fn
argument. This optimization causes modpost to complain since
padata_work_init() is not __init, whereas padata_mt_helper() is.

Since padata_work_init() is only called from __init code when
padata_mt_helper() is passed as the work_fn argument, mark
padata_work_init() as __ref, which makes it clear to modpost that this
scenario is okay.

Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: linux-crypto@vger.kernel.org
---
 kernel/padata.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index e5819bb8bd1d..d175cc000453 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -83,8 +83,16 @@ static struct padata_work *padata_work_alloc(void)
 	return pw;
 }
 
-static void padata_work_init(struct padata_work *pw, work_func_t work_fn,
-			     void *data, int flags)
+/*
+ * This function is marked __ref because this function may be optimized in such
+ * a way that it directly refers to work_fn's address, which causes modpost to
+ * complain when work_fn is marked __init. This scenario was observed with clang
+ * LTO, where padata_work_init() was optimized to refer directly to
+ * padata_mt_helper() because the calls to padata_work_init() with other work_fn
+ * values were eliminated or inlined.
+ */
+static void __ref padata_work_init(struct padata_work *pw, work_func_t work_fn,
+				   void *data, int flags)
 {
 	if (flags & PADATA_WORK_ONSTACK)
 		INIT_WORK_ONSTACK(&pw->pw_work, work_fn);
-- 
2.39.0

