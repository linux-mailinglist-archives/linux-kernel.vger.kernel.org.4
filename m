Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A58E730528
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjFNQje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjFNQjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:39:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F4C199
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:39:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAF7C64450
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CCEC433BB;
        Wed, 14 Jun 2023 16:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686760769;
        bh=CiaATWA3DUiAf96JCsvwKvujvWjgKxROvf/tLbnTMT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5eEFKOn/oJfksLkjOkh0XikxN/2rxRKsth1fo3Humda0sRF+XcIdTsOZHltbnEke
         r0uXSJB7JvDMGlTDGHZZ5A4YvieVJlgRBk7kMIQ0r6yalVxy77ojfomI4lnjrWNFh9
         YLFBZ22E+kL4iw076ctEAqgZmHczLccQpVW0eheI1eKqiy8Ln5kVI1RicBtxeYoXcW
         F5r0mILjCM+2solcJ8PvMXSY1hWIfAo1sKCqHSCvQkYEKHc21zWwvfXPp2BH9vz9bH
         HuNCLANCAbHcbtzKuPurXHPvhkuBnB57YIqPQLa/MvGZlCkxEuWnuW8IH6JihQ8R7G
         QLGqaIQ8dvEyA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] x86/mm/KASLR: Store pud_page_tramp into entry rather than page
Date:   Wed, 14 Jun 2023 17:38:54 +0100
Message-ID: <20230614163859.924309-2-lee@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230614163859.924309-1-lee@kernel.org>
References: <20230614163859.924309-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_pgd() expects to be passed whole pages to operate on, whereas
trampoline_pgd_entry is, as the name suggests, an entry.  The
ramifications for using set_pgd() here are that the following thread of
execution will not only place the suggested value into the
trampoline_pgd_entry (8-Byte globally stored [.bss]) variable, PTI will
also attempt to replicate that value into the non-existent neighboring
user page (located +4k away), leading to the corruption of other global
[.bss] stored variables.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 arch/x86/mm/kaslr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 557f0fe25dff4..37db264866b64 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -172,10 +172,10 @@ void __meminit init_trampoline_kaslr(void)
 		set_p4d(p4d_tramp,
 			__p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
 
-		set_pgd(&trampoline_pgd_entry,
-			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
+		trampoline_pgd_entry =
+			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp));
 	} else {
-		set_pgd(&trampoline_pgd_entry,
-			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
+		trampoline_pgd_entry =
+			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
 	}
 }
-- 
2.41.0.162.gfafddb0af9-goog

