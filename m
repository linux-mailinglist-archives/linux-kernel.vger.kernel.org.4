Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE70C716ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjE3RWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjE3RVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E007F1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEF006312A
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3D7C433A7;
        Tue, 30 May 2023 17:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467295;
        bh=d0V+rEHElAyacw8AbdTR1mJCInv/LtANWszfGeTQmgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8yDNQfTKA9nvMlc46CPI5hnKobBApcx8UpbyQ1/1Jd06THr0c1Yrc29KuHgNJONw
         L92oBaxPY9PsXAmIEgotQuKIHrBkiBC5GVST6kWNDK0uY+8YBWNgPibY1j4B43ldNH
         562+wEDDcglgp32ZVVEowehtdTQbu8a8m+AzjLqnok5n0PNYOhfgNJfJFTbsJVEYk4
         QiWITQu8W4BiqW6AzlDvZkF4NvH7PLwWEkcDs4w0GFg2PXNyB24+4KOb8AAWss5c+W
         8FlrJpL2uKKklAZ58mASkOL3Kecc7GquZ+e9++L4rvpc0NfyWRlNGehVlJUYSokNeI
         QzUtIam/mbfug==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 09/22] objtool: Don't free memory in elf_close()
Date:   Tue, 30 May 2023 10:21:01 -0700
Message-Id: <74bdb3058b8f029db8d5b3b5175f2a200804196d.1685464332.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685464332.git.jpoimboe@kernel.org>
References: <cover.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not necessary, objtool's about to exit anyway.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 8d491b2d123e..8d53f18a9502 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1350,30 +1350,14 @@ int elf_write(struct elf *elf)
 
 void elf_close(struct elf *elf)
 {
-	struct section *sec, *tmpsec;
-	struct symbol *sym, *tmpsym;
-	struct reloc *reloc, *tmpreloc;
-
 	if (elf->elf)
 		elf_end(elf->elf);
 
 	if (elf->fd > 0)
 		close(elf->fd);
 
-	list_for_each_entry_safe(sec, tmpsec, &elf->sections, list) {
-		list_for_each_entry_safe(sym, tmpsym, &sec->symbol_list, list) {
-			list_del(&sym->list);
-			hash_del(&sym->hash);
-		}
-		list_for_each_entry_safe(reloc, tmpreloc, &sec->reloc_list, list) {
-			list_del(&reloc->list);
-			hash_del(&reloc->hash);
-		}
-		list_del(&sec->list);
-		free(sec->reloc_data);
-	}
-
-	free(elf->symbol_data);
-	free(elf->section_data);
-	free(elf);
+	/*
+	 * NOTE: All remaining allocations are leaked on purpose.  Objtool is
+	 * about to exit anyway.
+	 */
 }
-- 
2.40.1

