Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C756C6191EB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiKDH1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiKDH1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:27:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B86D2792D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 00:27:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5DDD71F88E;
        Fri,  4 Nov 2022 07:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667546835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mK6Yb+HDZYey+MdThM5vOztF2LsAJko2NCXxRRCzJLc=;
        b=t3mgxfquxmqCHwEFGv0Srb4QFx+nwnJALEZtwSkmnIZa5QyQvTvP3kpfqv/K5cOhfote+p
        /6XtoH9b9jQ7QKZsswIc2w6HhjyjLmX6LHGnp8tZNaIvJHApg+HmnQoo5vQOu1OIrl4uXc
        ChvpghyJuz4ckYNeOxBRjHbbqoKGEKA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 141161346F;
        Fri,  4 Nov 2022 07:27:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g8RvA9O+ZGPxQAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 04 Nov 2022 07:27:15 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 2/5] x86: remove unneeded 64-bit dependency in arch_enter_from_user_mode()
Date:   Fri,  4 Nov 2022 08:26:58 +0100
Message-Id: <20221104072701.20283-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221104072701.20283-1-jgross@suse.com>
References: <20221104072701.20283-1-jgross@suse.com>
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

