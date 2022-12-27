Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83625656CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiL0QDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiL0QCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:02:51 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AC860DF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:02:49 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1672156966;
        bh=HMfXPM4QGrr46ln+5URVoZikc1BOiA+8cDROM3xuWNg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=EMe/icwpCrtDDLc2F9MA+Ztlf16gn5RUk7Yzc0xtAs8c0WQ9/mir7JknzUycNOhVY
         Go3Wkg3o0QiBbV0AFrqApoOHeNmo4L9Q+6aZU2svuuG6biaynAGmx5CUmT1C2Vn3Mk
         GUcU08WMe9YL8M5Pzvdh5qpd5BcA8M6H0J7cNFzk=
Date:   Tue, 27 Dec 2022 16:01:01 +0000
Subject: [PATCH v2 5/8] objtool: reduce memory usage of struct reloc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221216-objtool-memory-v2-5-17968f85a464@weissschuh.net>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
In-Reply-To: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672156865; l=1624;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=HMfXPM4QGrr46ln+5URVoZikc1BOiA+8cDROM3xuWNg=;
 b=aQ7IAbiGlCMxnLDaQjHg0BDIPnl012xb3SFB40A9z7vKTalZQK3yit84aV22CrH7wWZWCUoqz2Df
 A6uktE2gA3vVzsVDRuuuZxI3CCC+KycU/RoK1bmhpvzlMS/nRTjE
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a smaller type for the relocation type and move it to a location in
the structure where it avoids wasted padding bytes.

Technically ELF could use up to four bytes for the type.
But until now only types up to number 43 have been defined.

Reduce the size of struct reloc on x86_64 from 120 to 112 bytes.
This structure is allocated a lot and never freed.

This reduces maximum memory usage while processing vmlinux.o from
3035668 KB to 2919716 KB (-3.8%) on my notebooks "localmodconfig".

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/objtool/elf.c                 | 3 +++
 tools/objtool/include/objtool/elf.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index ee355beb0d82..182452adaa71 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1474,5 +1474,8 @@ void elf_close(struct elf *elf)
 
 void elf_reloc_set_type(struct reloc *reloc, int type)
 {
+	if (type >= (1U << (8 * sizeof(reloc->type))))
+		WARN("reloc->type out of range: %d", type);
+
 	reloc->type = type;
 }
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 33ec6cf72325..2b5becad5a0a 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -77,10 +77,10 @@ struct reloc {
 	struct symbol *sym;
 	struct list_head sym_reloc_entry;
 	unsigned long offset;
-	unsigned int type;
 	s64 addend;
 	int idx;
 	bool jump_table_start;
+	unsigned char type;
 };
 
 void elf_reloc_set_type(struct reloc *reloc, int type);

-- 
2.39.0
