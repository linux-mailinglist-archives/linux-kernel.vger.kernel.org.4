Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB75656CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiL0QCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiL0QCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:02:48 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F92D73
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:02:46 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1672156964;
        bh=WygJ1LogaMt7MCTVMz5LRPbo5ugX1SmSSa6UqeJvw4g=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BoJrCV32q5+ZX9E7hByJLWwo7fCfvpmrC+NI8JWcOJ4OXoeUmNeiVkEBNdl97cP1C
         fJis5QnFfTipBbfr/kazHgOWmDYa959RnH3GmpbfKBFf9M6NczsoKxwpF+JPI0LJie
         WZVNrCY9ff0/sfMvuCOLEQSrVuANtVqmphzTycXY=
Date:   Tue, 27 Dec 2022 16:01:04 +0000
Subject: [PATCH v2 8/8] objtool: explicitly cleanup resources on success
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221216-objtool-memory-v2-8-17968f85a464@weissschuh.net>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
In-Reply-To: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672156865; l=618;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WygJ1LogaMt7MCTVMz5LRPbo5ugX1SmSSa6UqeJvw4g=;
 b=MRmJd1QRpDgL/iIJ/DCBZTdg4HCDjlAvrgtCTCrxDptY+z/uSoHWpLTa0PFHkm8zAL2huAiioeNH
 ElsMGfVWBLCXo8f9Z0XTYkwtKZVjIAmY8TzWcVqvEtLc+YOAf6Er
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

Previously the file was only closed and resources properly freed on
errors, not on normal exits.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/objtool/builtin-check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 7c175198d09f..e11c766b98ce 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -229,5 +229,7 @@ int objtool_run(int argc, const char **argv)
 	if (file->elf->changed)
 		return elf_write(file->elf);
 
+	elf_close(file->elf);
+
 	return 0;
 }

-- 
2.39.0
