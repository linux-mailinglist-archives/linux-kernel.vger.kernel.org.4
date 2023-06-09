Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062DB729180
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbjFIHrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239057AbjFIHrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A330E210C;
        Fri,  9 Jun 2023 00:47:27 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XKXAJiFZP7kJhI5XxgiKn7QvSsgCXvIR5vJXfnzrnPs=;
        b=zbjX7AwTsFo8+wHkJmSw6meWbjSR90bi6HPQlkb2RgN4cEIbr+xvedvQg/uXz90xXJtEMy
        73O+U4onrh0EDgqu21nsv2yRnx7DUEOM6ZON5KuwcyLFQvoDZlKGjxu9AXXL9Ev5MIpkbw
        W158X4kkpNsqcN8DvJZ5fVLsip8+cd4cbo39mK0Q0UOU1eER3kV6HlFEff4wRrSdnW3qsg
        jFwlXKiw+WSHaiatpIuJKyVjT6UPOUcpE8VPGhGgPKfDl7SV9p+n1uES6KwpvOqthCl2Fh
        yAqVUx1aK+Xo3tcAMt3fMeLOoboL3FkWnW97SEu531kPTQhUL4YxkOs+7DJKnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XKXAJiFZP7kJhI5XxgiKn7QvSsgCXvIR5vJXfnzrnPs=;
        b=fxec4OyE71Fk4/LsExSH3RmUGfo4lHfe13lhOYKl97i8zaqOLikGlgZ5FjIacPH1Yhh2Wp
        kEe7Oysmb+3oBOAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Skip reading DWARF section data
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <52a9698835861dd35f2ec35c49f96d0bb39fb177.1685464332.git.jpoimboe@kernel.org>
References: <52a9698835861dd35f2ec35c49f96d0bb39fb177.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629684573.404.10722273485724895229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b4c96ef0add5b701eb37be9830a98610e1d9b4a3
Gitweb:        https://git.kernel.org/tip/b4c96ef0add5b701eb37be9830a98610e1d9b4a3
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:21:14 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:27 -07:00

objtool: Skip reading DWARF section data

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

Link: https://lore.kernel.org/r/52a9698835861dd35f2ec35c49f96d0bb39fb177.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 54d182d..d420b5d 100644
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
