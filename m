Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5888266296E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjAIPJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjAIPJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:09:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586B32DD4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:09:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF9EF34300;
        Mon,  9 Jan 2023 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673276963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bvld8zPnYDTnQIG1YqFCYb/KZpQyo3ITt9siNGCo5AU=;
        b=vFJ4c9PD8hUN1mARIMwxWF3d/NZ/pc8pC3MQlSRQRs0Sikg/ojs58lhAE4+cVRT9SEL5Lt
        UqCOuBfA+OZ0KtIVPDjs94DZnYPv5X6A8k7wQ1G8tbRh3i+f1FV1MsMlcHcXUyFptlc1T+
        M4AJqrOad/ZUJ+3AhGSlF0oacbYL6LM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 788C2134AD;
        Mon,  9 Jan 2023 15:09:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id diIQHCMuvGORRQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 09 Jan 2023 15:09:23 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/mm: fix poking_init() for Xen PV guests
Date:   Mon,  9 Jan 2023 16:09:22 +0100
Message-Id: <20230109150922.10578-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
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

Commit 3f4c8211d982 ("x86/mm: Use mm_alloc() in poking_init()") broke
the kernel for running as Xen PV guest.

It seems as if the new address space is never activated before being
used, resulting in Xen rejecting to accept the new CR3 value (the PGD
isn't pinned).

Fix that by adding the now missing call of paravirt_arch_dup_mmap() to
poking_init(). That call was previously done by dup_mm()->dup_mmap() and
it is a NOP for all cases but for Xen PV, where it is just doing the
pinning of the PGD.

Fixes: 3f4c8211d982 ("x86/mm: Use mm_alloc() in poking_init()")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/mm/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index d3987359d441..5f8ba537d9d3 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -804,6 +804,9 @@ void __init poking_init(void)
 	poking_mm = mm_alloc();
 	BUG_ON(!poking_mm);
 
+	/* Xen PV guests need the PGD to be pinned. */
+	paravirt_arch_dup_mmap(NULL, poking_mm);
+
 	/*
 	 * Randomize the poking address, but make sure that the following page
 	 * will be mapped at the same PMD. We need 2 pages, so find space for 3,
-- 
2.35.3

