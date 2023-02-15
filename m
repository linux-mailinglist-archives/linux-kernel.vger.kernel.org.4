Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850D369839D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBOSm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBOSm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:42:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1953CE34
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:42:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D45061D25
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0242FC4339C;
        Wed, 15 Feb 2023 18:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676486487;
        bh=S6yVv++b65cKUFiT1cYYAPG0IYVYL9tj+zjmVfJD+Zk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rB+kfF+dhz5w+QmVPHcrcLgFtFDbFuOvzN5aFHsok+4YXPR81oIL98QzjGhCaDx+z
         jsMJd454lmfvgl2tVn2unZm4mIe0ZKy2HYLarBHPynIQ2D5jQ3evdZLKjHTA+HcSkF
         XszqP60J6FJLAA+qsnrXWjk2Nsgs4bcDlnv1Q7+3YsXhYq+C/FqQGAAM9bVz7qzHj9
         +PCU4KMRpS4omZtleXio5oJuF6sCjrm7N+qZzPJjP0DEUnoeBiaVVj1hp21O6g9TRs
         SzGT/2ocPlPSkKk5QGERq+bp4yOPGfs1Ezj3BqY9yqApWfU1ejjuK9lxRAQKh9Hlko
         3Up+9Ry2UadyA==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Wed, 15 Feb 2023 11:41:16 -0700
Subject: [PATCH 2/3] powerpc: Fix use of '-mabi=elfv2' with clang
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230118-ppc64-elfv2-llvm-v1-2-b9e2ec9da11d@kernel.org>
References: <20230118-ppc64-elfv2-llvm-v1-0-b9e2ec9da11d@kernel.org>
In-Reply-To: <20230118-ppc64-elfv2-llvm-v1-0-b9e2ec9da11d@kernel.org>
To:     mpe@ellerman.id.au
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        erhard_f@mailbox.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880; i=nathan@kernel.org;
 h=from:subject:message-id; bh=S6yVv++b65cKUFiT1cYYAPG0IYVYL9tj+zjmVfJD+Zk=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDMlv1UO17k02Z26YoWbpfXPSBdset27J7m8R3792T95zS
 EF07em8jlIWBjEOBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRgDmMDNNCvnlsi9+lmndg
 rvuu3TtCdhnJKjQePpzldulZ1cV63VCGfxovmz0WvVB+zXBiVhXPesEydy/bG14tDZMOzcq2bVv
 7nBEA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'-mabi=elfv2' is not added to clang's invocations when
CONFIG_PPC64_ELF_ABI_V2 is enabled, resulting in the generation of elfv1
code, as evidenced by the orphan section warnings/errors:

  ld.lld: error: vmlinux.a(arch/powerpc/kernel/prom_init.o):(.opd) is being placed in '.opd'
  ld.lld: error: vmlinux.a(init/main.o):(.opd) is being placed in '.opd'
  ld.lld: error: vmlinux.a(init/version.o):(.opd) is being placed in '.opd'

To resolve this, add '-mabi=elfv2' to CFLAGS with clang. This uncovers
an issue in the 32-bit vDSO:

  error: unknown target ABI 'elfv2'

The ELFv2 ABI cannot be used when building code for a 32-bit target. To
resolve this, just remove the '-mabi' flags from the assembler flags, as
it was only needed for preprocessing (the _CALL_ELF macro) but this was
cleaned up in commit 5b89492c03e5 ("powerpc: Finalise cleanup around ABI
use").

Tested-by: "Erhard F." <erhard_f@mailbox.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index dc4cbf0a5ca9..3f2dd930e3cd 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -123,14 +123,12 @@ endif
 endif
 
 CFLAGS-$(CONFIG_PPC64)	:= $(call cc-option,-mtraceback=no)
-ifndef CONFIG_CC_IS_CLANG
 ifdef CONFIG_PPC64_ELF_ABI_V2
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2,$(call cc-option,-mcall-aixdesc))
-AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2)
 else
+ifndef CONFIG_CC_IS_CLANG
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcall-aixdesc)
-AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
 endif
 endif
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))

-- 
2.39.2

