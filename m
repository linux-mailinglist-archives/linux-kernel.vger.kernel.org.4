Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D6F6EAED2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjDUQLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjDUQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:11:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27FD19B6;
        Fri, 21 Apr 2023 09:11:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E101651A6;
        Fri, 21 Apr 2023 16:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B592C4339C;
        Fri, 21 Apr 2023 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682093499;
        bh=LKw0Pn9lBD2DCIzai5WyIYRUcO+iKilOzXysD1jWFnw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=M1QAI+j6kCXfF4HV8PVD038aj6XudABKUP/GI5x12TwIWcEXImBQvAhju/JvD0Bg6
         qecWPNLjCdrfFU5iGRR6XiMxmmbXy9COzw7y+mBBH7XWOePBqZISWKhTTaGDuTirPt
         elgG0in8lmb0GmuRwQjo/FLSi0uIEctBa9UxSpiZ6XLQTUef8Bh49HhV0BFzouJh0l
         r1fdCNcrFScBxFk2Q9iwPD+Aw0DTlEUBjIw6eBKRIp+mAOJcTCjMEz/TgYMuXqLzoQ
         p1IDfVK4KIcnXedXttcT4HC6DRVnUcUDbSo2K1+IbX+4uE9R+fU/recctTchXDZ2Jx
         5/cthDp87QZrw==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Fri, 21 Apr 2023 09:11:26 -0700
Subject: [PATCH v2 1/2] MIPS: Mark check_bugs() as __init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-mips-check_bugs-init-attribute-v2-1-60a7ee65d4bf@kernel.org>
References: <20230419-mips-check_bugs-init-attribute-v2-0-60a7ee65d4bf@kernel.org>
In-Reply-To: <20230419-mips-check_bugs-init-attribute-v2-0-60a7ee65d4bf@kernel.org>
To:     tsbogend@alpha.franken.de
Cc:     ndesaulniers@google.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1464; i=nathan@kernel.org;
 h=from:subject:message-id; bh=LKw0Pn9lBD2DCIzai5WyIYRUcO+iKilOzXysD1jWFnw=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDClOW3f1RW3IzLh8gct04/8uSxWNmm0TDG5riPjsWdrtE
 J3M1WjeUcrCIMbBICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACbyVoDhf2bJclmGk27SvX7t
 H++sWmz6yEpDsX177JOCnYlF/m0i/xkZvthLWR4u4vXgCD/r5JHZu7FAf6+FdNMfI8/6p2cv8+e
 zAgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
forcibly"), a compiler may choose not to inline a function marked with
just 'inline'. If check_bugs() is not inlined into start_kernel(), which
occurs when building with clang after commit 9ea7e6b62c2b ("init: Mark
[arch_call_]rest_init() __noreturn"), modpost complains with:

  WARNING: modpost: vmlinux.o: section mismatch in reference: check_bugs (section: .text) -> check_bugs32 (section: .init.text)

check_bugs() is only called from start_kernel(), which itself is marked
__init, so there would not be any issues at run time. Make it obvious to
modpost that this call chain is safe by marking check_bugs() as __init,
which fixes the warning.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Link: https://lore.kernel.org/CA+G9fYt+4e57Gdy6cix=LeNK6XqWoui8du=mZWu=cf8vPYocKw@mail.gmail.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/mips/include/asm/bugs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/bugs.h b/arch/mips/include/asm/bugs.h
index d72dc6e1cf3c..047e14227c45 100644
--- a/arch/mips/include/asm/bugs.h
+++ b/arch/mips/include/asm/bugs.h
@@ -30,7 +30,7 @@ static inline void check_bugs_early(void)
 		check_bugs64_early();
 }
 
-static inline void check_bugs(void)
+static inline void __init check_bugs(void)
 {
 	unsigned int cpu = smp_processor_id();
 

-- 
2.40.0

