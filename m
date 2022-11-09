Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC08622096
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKIAE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKIAEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:04:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFD75EFBF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 16:04:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37E78617E7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C6BC433C1;
        Wed,  9 Nov 2022 00:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667952293;
        bh=q6xWKkEfyPavV0D6lBApe8O7RpHUwHY2qmgNGpjeGok=;
        h=From:To:Cc:Subject:Date:From;
        b=MNBKSJZ1GVZ+AEDsNWUzAZOtiCepw859zd6bUVt+w6aHfUkpT2qt3h7g3eGpMqSQ/
         BtuSSaQDoFfkhnsqkXozmAoFKiFubILgXRNQsb4NcXMnZGToKaAS/ZGl5HOkkqfxlX
         5MlF0V9s0jFWcsZaDT8qyxiq6ij+h2dl8v3bp2Ty8foRXYEyxXRP56m75eJsvJqF2a
         uFL1+AvSTPbhWIPGdZBJEITmEWUFionWfBDKGPsVpFfEBRU6AfbLjDtSDPAMN4pRYX
         0odwF9WhIDe8fKxwlMCkdkH5ZBwxQ8MDwFIh4P9NkycLmGlzpQsDNL53G5sLq+JxM7
         3vxTlGMR/vlwQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] x86/vdso: Conditionally export __vdso_sgx_enter_enclave
Date:   Tue,  8 Nov 2022 17:03:07 -0700
Message-Id: <20221109000306.1407357-1-nathan@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Recently, ld.lld moved from '--undefined-version' to
'--no-undefined-version' as the default, which breaks building the vDSO
when CONFIG_X86_SGX is not set:

  ld.lld: error: version script assignment of 'LINUX_2.6' to symbol '__vdso_sgx_enter_enclave' failed: symbol not defined

__vdso_sgx_enter_enclave is only included in the vDSO when
CONFIG_X86_SGX is set. Only export it if it will be present in the final
object, which clears up the error.

Link: https://github.com/ClangBuiltLinux/linux/issues/1756
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

It would be nice if this could be picked up for an -rc release but I
won't argue otherwise.

Alternatively, we could add '--undefined-version' to the vDSO ldflags
but this does not seem unreasonable to me.

 arch/x86/entry/vdso/vdso.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index 4bf48462fca7..e8c60ae7a7c8 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -27,7 +27,9 @@ VERSION {
 		__vdso_time;
 		clock_getres;
 		__vdso_clock_getres;
+#ifdef CONFIG_X86_SGX
 		__vdso_sgx_enter_enclave;
+#endif
 	local: *;
 	};
 }

base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
-- 
2.38.1

