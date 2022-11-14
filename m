Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF09F627CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiKNLro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbiKNLqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:46:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E49921E1E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:45:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0312DB80E26
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D5EC433D6;
        Mon, 14 Nov 2022 11:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426315;
        bh=BN2cuMa0qT4NjbFa7HZu9zQS7wMchMYkFG7N3eApFaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRPR2qJUqvtgJqU06ijIqi67atB7yH6+KzSJyCIMY6hbV8UbrOECAeVPHSluPpjpm
         53lo9872wtWJDBnzIiZmtn1iDQ0s83j2xSD3tI7FjqbppRIBlWiFLtxaNhsIwxs7L7
         aulrGm29nAYAKIhlNdpKIwk792S9Gq+2sr4TGvD20ejRReMx6CK8uw+tFFUwy4jrgr
         oVCBitd5daCKQmboVuubgmYdtsrSn/PLQPlhoBNrpyhjszYl/G3Taf9mIr0R7VquxD
         r3tWqO5aEdQJVaCRCvaRciRqzKH6LsfAAb14LIJCyVc0ZexAQNS+2krwBzcXHb3oqH
         0LyoyzcLFpcGA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 32/46] x86/realmode, lto: Disable gcc LTO for real mode code
Date:   Mon, 14 Nov 2022 12:43:30 +0100
Message-Id: <20221114114344.18650-33-jirislaby@kernel.org>
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

The early real mode bootup code makes various assumptions that break
with LTO. For example it assumes that top level assembler statements
don't get reordered. Disable LTO for the real mode code.

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
 arch/x86/realmode/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/realmode/Makefile b/arch/x86/realmode/Makefile
index a0b491ae2de8..47b8b500cf15 100644
--- a/arch/x86/realmode/Makefile
+++ b/arch/x86/realmode/Makefile
@@ -10,6 +10,7 @@
 # Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
+KBUILD_CFLAGS			+= $(DISABLE_LTO_GCC)
 
 subdir- := rm
 
-- 
2.38.1

