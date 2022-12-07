Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B95264618D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLGTRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiLGTRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:17:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2F81EC5B;
        Wed,  7 Dec 2022 11:17:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57663B81F86;
        Wed,  7 Dec 2022 19:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B73C43470;
        Wed,  7 Dec 2022 19:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670440656;
        bh=2rBYuZvHrFw6BWvRwxpqptxIjzeWHSbg9PrlE7+shJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgFIJOn4hiE1wEMjtsEnFpM8zBYMzwcNdWpjKMMULtwhe4EhKmj/Bfaai+EVvK/lG
         3FeotmzeFmqcn3LZRZ/c1uT7FNas3lXagpaFpGY9aLvE2ow14CJaSN+fzkkF0ysw3o
         /b9ov/yP28e0preCaDu2ArZSptJi2gWIPUFb601dRRS1cYrytE3xL0Bp/lFZ0Syz7M
         wwiimOzaCE0rbZVWDy7A3XTP0c3iWKD3wLkRi/H7Q2re8oDHb5uiceBSmIAXvgWjtZ
         uVKQl0U3KZrvzp8BTwTsoXcLaX+OE21OnT0BYSp1RF3lhHHGYehVHqkN1is13+T/nW
         naXUY4WV/BfBQ==
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
Subject: [PATCH v2 1/2] padata: Mark padata_work_init() as __ref
Date:   Wed,  7 Dec 2022 12:16:56 -0700
Message-Id: <20221207191657.2852229-2-nathan@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207191657.2852229-1-nathan@kernel.org>
References: <20221207191657.2852229-1-nathan@kernel.org>
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
padata_mt_helper() directly, which causes modpost to complain since
padata_work_init() is not __init, whereas padata_mt_helper() is. In
reality, padata_work_init() is only called with padata_mt_helper() as
the work_fn argument in code that is __init, so this warning will not
result in any problems. Silence it with __ref, which makes it clear to
modpost that padata_work_init() can only use padata_mt_helper() in
__init code.

Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: linux-crypto@vger.kernel.org
---
 kernel/padata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index e5819bb8bd1d..4c3137fe8449 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -83,8 +83,8 @@ static struct padata_work *padata_work_alloc(void)
 	return pw;
 }
 
-static void padata_work_init(struct padata_work *pw, work_func_t work_fn,
-			     void *data, int flags)
+static __ref void padata_work_init(struct padata_work *pw, work_func_t work_fn,
+				   void *data, int flags)
 {
 	if (flags & PADATA_WORK_ONSTACK)
 		INIT_WORK_ONSTACK(&pw->pw_work, work_fn);

base-commit: 76dcd734eca23168cb008912c0f69ff408905235
-- 
2.38.1

