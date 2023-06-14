Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CA7730437
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244910AbjFNPw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244853AbjFNPwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:52:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDEB170E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:52:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E15E643FD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A84C433CC;
        Wed, 14 Jun 2023 15:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686757971;
        bh=A8TF2ckDAIr4008OG16ynqI8vPNCnEPAU4BPRdH58lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKuxnUbj/uowyKcgmYurVBwnX5CC+yfvHstHH3hviyfohLiqu0HWzZC4jKpThsgik
         +uYpg9wgh9e107P8gTDVX7mulbhtow0NmULW10beniC4op0IhoG204ZtTZzWAAn9xj
         Z6XAcTFhbpBAQCq4B9FfYrY1dFdsrt50HURIgQSuWgsgSWwE3wmo2jxGSAyLkzdvnt
         E7PsSlVy2SlwzWQ+L+GhRppjXKD9MQ1Da/aboYWbxLXQk5PYHAXaUbjB/kIVFMbP5l
         eC9z2EgXobSvIxNufUd0Z4ztDzaOHHcLw4F1XxU07ctryWe4kP5Lwn4Ir6pSeujQio
         NfhS4eaAMR9Xg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86/mm/KASLR: Store pud_page_tramp into entry rather than page
Date:   Wed, 14 Jun 2023 16:52:10 +0100
Message-ID: <20230614155223.905222-2-lee@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230614155223.905222-1-lee@kernel.org>
References: <20230614155223.905222-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 arch/x86/mm/kaslr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 557f0fe25dff4..ee6f22f3385b6 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -175,7 +175,7 @@ void __meminit init_trampoline_kaslr(void)
 		set_pgd(&trampoline_pgd_entry,
 			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
 	} else {
-		set_pgd(&trampoline_pgd_entry,
-			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
+		trampoline_pgd_entry =
+			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
 	}
 }
-- 
2.41.0.162.gfafddb0af9-goog

