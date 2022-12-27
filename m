Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE20656CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiL0QDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiL0QCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:02:52 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB755B4A5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:02:49 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1672156966;
        bh=QPm4tnLN0YjuqSH/PP3qCzyHZ3iKBL4Z+lxmjKe0ykc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=amxlfhy+MP1y275Npt9ETo36B6ozZo8wrqf3cLIUnRWnh5aU4+3JgCtVUlz67HbJc
         SNMfURiS7WvPlC4nycAu3l22IokTv+O3AeITA8BEBO5hKm0VlTtZdtAA+lpgiGBNjS
         ymwTaCVLjDuYhA3OCbOkN+74MIr1ZjKSFL4BFLrs=
Date:   Tue, 27 Dec 2022 16:01:03 +0000
Subject: [PATCH v2 7/8] objtool: optimize layout of struct special_alt
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221216-objtool-memory-v2-7-17968f85a464@weissschuh.net>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
In-Reply-To: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672156865; l=856;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QPm4tnLN0YjuqSH/PP3qCzyHZ3iKBL4Z+lxmjKe0ykc=;
 b=AEnINnK17XKm+Yujt5K8r+9bzPJKBLA6p9hkW6Q/8EnBpM7k5dpJo+bkSc5LsyKIE0kdzZvneyiA
 y/LDhEoHCEvGfbsR9r1Dv9TtGYQ0LApDEQh27/oX4l9zpodXWlkb
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

Reduce the size of struct special_alt from 72 to 64 bytes.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/objtool/include/objtool/special.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index dc4721e19002..86d4af9c5aa9 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -19,6 +19,7 @@ struct special_alt {
 	bool skip_orig;
 	bool skip_alt;
 	bool jump_or_nop;
+	u8 key_addend;
 
 	struct section *orig_sec;
 	unsigned long orig_off;
@@ -27,7 +28,6 @@ struct special_alt {
 	unsigned long new_off;
 
 	unsigned int orig_len, new_len; /* group only */
-	u8 key_addend;
 };
 
 int special_get_alts(struct elf *elf, struct list_head *alts);

-- 
2.39.0
