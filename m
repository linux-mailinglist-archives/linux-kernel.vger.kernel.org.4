Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74373617BA9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiKCLhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiKCLgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:36:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E091209D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:36:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B5D0921D0A;
        Thu,  3 Nov 2022 11:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667475410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7CU5Zv+MxpH9Viqrq9cuAJbtGqlqKE19LW/YuoUb07c=;
        b=EoOrn3NQCcelDwLrz6uRb8Qdpe2LcmeDtFqRskvTLgiYp1OIbmEUexGEbMyEIOYJ42dKu/
        12zWG8reRqNsGvcRjBnqFgs8u2C5XKriMxPc4fnl1Yc+FvgUrhX7K0Dl2C6TbloaatAyqV
        ljzr7Loq/CVmv4IC7XuZaPSEWg0URFU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72B7713480;
        Thu,  3 Nov 2022 11:36:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sJJtGtKnY2P4HgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 03 Nov 2022 11:36:50 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/4] x86: add X86_FEATURE_XENPV to disabled-features.h
Date:   Thu,  3 Nov 2022 12:36:33 +0100
Message-Id: <20221103113636.25543-2-jgross@suse.com>
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

Add X86_FEATURE_XENPV to the features handled specially in
disabled-features.h.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 33d2cd04d254..c862552d7d6d 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -81,6 +81,12 @@
 # define DISABLE_SGX	(1 << (X86_FEATURE_SGX & 31))
 #endif
 
+#ifdef CONFIG_XEN_PV
+# define DISABLE_XENPV		0
+#else
+# define DISABLE_XENPV		(1 << (X86_FEATURE_XENPV & 31))
+#endif
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 # define DISABLE_TDX_GUEST	0
 #else
@@ -98,7 +104,7 @@
 #define DISABLED_MASK5	0
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
-#define DISABLED_MASK8	(DISABLE_TDX_GUEST)
+#define DISABLED_MASK8	(DISABLE_XENPV|DISABLE_TDX_GUEST)
 #define DISABLED_MASK9	(DISABLE_SGX)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET)
-- 
2.35.3

