Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AF5716AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjE3RWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjE3RVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3404106
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BABE8616AF
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BA8C43321;
        Tue, 30 May 2023 17:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467299;
        bh=KD8Lf36i8S8fkl9e26OJy++ossCBPSeuvsfaXWI90DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tmRnWW51kF+qVvCNHgNioj2opxfXrWksnpanZ9AMj5ePvZzpzLlj6ClrgoIwJTh21
         T1cong5ST2Vg2+GZOlz51ko9EoC3dcuhJTdH9w9ZDdFgEqRUA0A/vPt69/8HtrmWqc
         uihOUcYaaHj6pgnhWPpHUn3yyYVt/rzddmfsdy9o0/QATGQ/2sh+qpE/RYszwCNWg0
         TmTYiWG82Ew/7mw63L+7sLqjuDN+TMMQDK/20/GvyFImWRb3fYgBFws8cJNIZtcidg
         DU3k13QPvoxpCdMwH0cXLaBnwxijXLb9PEnZt53gSLFPeGQ+wkbdQaEQbYIKoxr92+
         ve+u+jFFg65TA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 22/22] objtool: Skip reading DWARF section data
Date:   Tue, 30 May 2023 10:21:14 -0700
Message-Id: <52a9698835861dd35f2ec35c49f96d0bb39fb177.1685464332.git.jpoimboe@kernel.org>
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

Objtool doesn't use DWARF at all, and the DWARF sections' data take up a
lot of memory.  Skip reading them.

Note this only skips the DWARF base sections, not the rela sections.
The relas are needed because their symbol references may need to be
reindexed if any local symbols get added by elf_create_symbol().

Also note the DWARF data will eventually be read by libelf anyway, when
writing the object file.  But that's fine, the goal here is to reduce
*peak* memory usage, and the previous patch (which freed insn memory)
gave some breathing room.  So the allocation gets shifted to a later
time, resulting in lower peak memory usage.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 29.93G
- After:  peak heap memory consumption: 25.47G

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 54d182ddc4bb..d420b5d2e2b6 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -300,6 +300,11 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
 	return find_reloc_by_dest_range(elf, sec, offset, 1);
 }
 
+static bool is_dwarf_section(struct section *sec)
+{
+	return !strncmp(sec->name, ".debug_", 7);
+}
+
 static int read_sections(struct elf *elf)
 {
 	Elf_Scn *s = NULL;
@@ -350,7 +355,7 @@ static int read_sections(struct elf *elf)
 			return -1;
 		}
 
-		if (sec->sh.sh_size != 0) {
+		if (sec->sh.sh_size != 0 && !is_dwarf_section(sec)) {
 			sec->data = elf_getdata(s, NULL);
 			if (!sec->data) {
 				WARN_ELF("elf_getdata");
-- 
2.40.1

