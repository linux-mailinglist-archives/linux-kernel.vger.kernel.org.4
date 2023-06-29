Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BE37423E2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjF2KVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjF2KU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:20:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FB8A2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:20:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D8D081F8AA;
        Thu, 29 Jun 2023 10:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688034056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc;
        bh=LECm0m+o+ZGRGygtSk68YR+QZWIj672OOurGXfyr1cw=;
        b=lCOfNeyf5kzJv7YTXv9OeKNWsYWCcZv6BbYgs8PIYnowiGyZY4qoVr0OMwpL3XEnV2M2Do
        Vvm+TzgEAtfOUkwy67XkUKn5TB7kUZ4hnRAdQPh8wSyoTAVoP/kaU20oZcT2VsfC0ebnZ7
        o+2cLO2G/48Me5nG7gO9LzJWKIiqMYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688034056;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc;
        bh=LECm0m+o+ZGRGygtSk68YR+QZWIj672OOurGXfyr1cw=;
        b=KVx3ER4ncZWVE1Igx2AfojNi3NgSNVipgG3+blOuTMWIUoIwRxL0mNRWXrPVmd1Nsce1sF
        c6mORTabMiAZHxAA==
Received: from lion.mk-sys.cz (unknown [10.163.44.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C63DB2C141;
        Thu, 29 Jun 2023 10:20:56 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 42E8360467; Thu, 29 Jun 2023 12:20:51 +0200 (CEST)
From:   Michal Kubecek <mkubecek@suse.cz>
Date:   Thu, 29 Jun 2023 12:05:05 +0200
Subject: [PATCH] objtool: initialize all of struct elf
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Message-Id: <20230629102051.42E8360467@lion.mk-sys.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function elf_open_read() only zero initializes the initial part of
allocated struct elf; num_relocs member was recently added outside the
zeroed part so that it was left uninitialized, resulting in build failures
on some systems.

The partial initialization is a relic of times when struct elf had large
hash tables embedded. This is no longer the case so remove the trap and
initialize the whole structure instead.

Fixes: eb0481bbc4ce ("objtool: Fix reloc_hash size")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d420b5d2e2b6..081befa4674b 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1005,7 +1005,7 @@ struct elf *elf_open_read(const char *name, int flags)
 		perror("malloc");
 		return NULL;
 	}
-	memset(elf, 0, offsetof(struct elf, sections));
+	memset(elf, 0, sizeof(*elf));
 
 	INIT_LIST_HEAD(&elf->sections);
 
-- 
2.41.0

