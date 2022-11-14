Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88FB627CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiKNLsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbiKNLsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:48:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82785264A1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:45:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E906B80E73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E621C433D7;
        Mon, 14 Nov 2022 11:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426331;
        bh=Sb5J4tc+210hDjMm1S+r84/cDdsYNhaQnAubcresp6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4TWAOiOCRKCQ583UsRVJqRZL9TXgqtsh/kO2P2iM6H8yG5Vh3zIcUtnXgB+CtT9k
         J4XFfzRxV3rxNMJhERy4YISkzY63w1sJyGO8MmNJwcUGpHNICYvpOcWBW1bIVhpMqX
         I0XtivbOaI3ZGnEjeKPoBGT9ms+3RpXtDlYVCDCUUiNpVY0Um3Jm3BFJxQOED54X6u
         a5eQXUFEsjQneKC2G/orT8iFJCgVDFhpouGKGHs7MkvEX8FcluGPe5edNdTidV6wE7
         25em7LPdg8CaXJKaN5/BjOqWfRDXnS3llMOvj0NWlr8sZNXaIh7lvcsE0r0qvFJbFF
         3GgUWrZWjWF9w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 39/46] x86, lto: Disable relative init pointers with gcc LTO
Date:   Mon, 14 Nov 2022 12:43:37 +0100
Message-Id: <20221114114344.18650-40-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
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

From: Andi Kleen <ak@linux.intel.com>

Relative init pointers are implemented using custom top-level assembler
that references the init function. With LTO, the top-level assembler
statement can end up in other assembler files than the init function,
which then causes linker errors if the init function was static.

This could be fixed by making all the init functions global, but that
would be a very intrusive change all over the tree.

Instead, disable relative init pointers for gcc LTO.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/x86/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ceab0db..6455d843d559 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -176,7 +176,9 @@ config X86
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
 	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
-	select HAVE_ARCH_PREL32_RELOCATIONS
+	# LTO can move assembler to different files, so all
+	# the init functions would need to be global for this to work
+	select HAVE_ARCH_PREL32_RELOCATIONS	if !LTO_GCC
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_STACKLEAK
-- 
2.38.1

