Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B26617BB6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKCLhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiKCLg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:36:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDCF12082
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:36:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 64E041F385;
        Thu,  3 Nov 2022 11:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667475416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mK6Yb+HDZYey+MdThM5vOztF2LsAJko2NCXxRRCzJLc=;
        b=kXqfwiKMdh9juEVxLq/XwrPXmX7SB2cxef3a31IZCdP9dQWBaNfSqFJxrMjZHT4Z9ML6rG
        pVIF8wHcHue8M1//i+/XCN0IhieNQ20fbVOJsCKv5zlarDyZcQQnAH0zAxIADInsArD5tT
        8T43gbRaTSNsxxlmazfgdFihOv9Swfw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2225213480;
        Thu,  3 Nov 2022 11:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5ETtBtinY2MEHwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 03 Nov 2022 11:36:56 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/4] x86: remove unneeded 64-bit dependency in arch_enter_from_user_mode()
Date:   Thu,  3 Nov 2022 12:36:34 +0100
Message-Id: <20221103113636.25543-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221103113636.25543-1-jgross@suse.com>
References: <20221103113636.25543-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for 64-bit mode when testing X86_FEATURE_XENPV isn't needed,
as Xen PV guests are no longer supported in 32-bit mode.

While at it switch from boot_cpu_has() to cpu_feature_enabled().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/entry-common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 674ed46d3ced..117903881fe4 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -24,8 +24,8 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
 		/*
 		 * For !SMAP hardware we patch out CLAC on entry.
 		 */
-		if (boot_cpu_has(X86_FEATURE_SMAP) ||
-		    (IS_ENABLED(CONFIG_64BIT) && boot_cpu_has(X86_FEATURE_XENPV)))
+		if (cpu_feature_enabled(X86_FEATURE_SMAP) ||
+		    cpu_feature_enabled(X86_FEATURE_XENPV))
 			mask |= X86_EFLAGS_AC;
 
 		WARN_ON_ONCE(flags & mask);
-- 
2.35.3

