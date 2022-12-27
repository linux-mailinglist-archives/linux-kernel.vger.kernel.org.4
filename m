Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE060656CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiL0QCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiL0QCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:02:48 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3104EA9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:02:46 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1672156964;
        bh=kT8j13gOnAKWYlSV+YMQw4TiVnvJKl0cCOa21YM32M0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NryKx8/WX4EttN2Wi7A01V/T+QeFOxPEcOYewudl8K5pU06HrP1jzw1Q1U/9g/UnF
         BaS2e9pdkU0JrXbUgolwwWI9nN4ODSobyrqO+IQk5DABU29VMAviScn9H34JGMgyX1
         B3iiNyzM33rdyzepT8vFzQdaHGMxvMGu6CH7arxU=
Date:   Tue, 27 Dec 2022 16:00:57 +0000
Subject: [PATCH v2 1/8] objtool: make struct entries[] static and const
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221216-objtool-memory-v2-1-17968f85a464@weissschuh.net>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
In-Reply-To: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672156865; l=1357;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kT8j13gOnAKWYlSV+YMQw4TiVnvJKl0cCOa21YM32M0=;
 b=KVBj9VZ9YQSV25Jq2t8yb7ci7FBwnt5YjyakqphuIDIRCP6beV5l2wrS/0h8KA8/9ibZai5PYDGO
 8HfVrMblAEPjhqpksBwKtiEl3VZG0yIzdaDrrLGbQJkoy4ZiEGjG
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

This data is not modified and not used outside of special.c.

Also adapt its users to the constness.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/objtool/special.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 9c8d827f69af..baa85c31526b 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -26,7 +26,7 @@ struct special_entry {
 	unsigned char key; /* jump_label key */
 };
 
-struct special_entry entries[] = {
+static const struct special_entry entries[] = {
 	{
 		.sec = ".altinstructions",
 		.group = true,
@@ -65,7 +65,7 @@ static void reloc_to_sec_off(struct reloc *reloc, struct section **sec,
 	*off = reloc->sym->offset + reloc->addend;
 }
 
-static int get_alt_entry(struct elf *elf, struct special_entry *entry,
+static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 			 struct section *sec, int idx,
 			 struct special_alt *alt)
 {
@@ -139,7 +139,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
  */
 int special_get_alts(struct elf *elf, struct list_head *alts)
 {
-	struct special_entry *entry;
+	const struct special_entry *entry;
 	struct section *sec;
 	unsigned int nr_entries;
 	struct special_alt *alt;

-- 
2.39.0
