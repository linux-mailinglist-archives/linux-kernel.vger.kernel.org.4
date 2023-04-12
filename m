Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B54E6DFE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjDLTEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDLTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:03:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75616E69
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04D7263879
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 19:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA5AC4339E;
        Wed, 12 Apr 2023 19:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681326227;
        bh=ZbdbfriA0hOhgUPH3GEXbKxjxz1wYETUQssT8P5Kvmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QTa6Mq9HtuH6HEOc6xiuWAnaIPbHGzYHuN2rthxwa9ieVHkamL+uFKhhJXoh2tZrg
         FBHVARFe/1m1NhUwTrVGYYbz0bcFUkbLZVF3C56YvsNjpCXRZWehFOrodfpfWWHa6P
         Rn33Y0PoL38yPxatStxYNMnLpCQfI3Zds/9YaNH8vXb5Xw/1LtEMJUfMbbig473iWF
         xrqYOO8S66mFYjZw8P//3mGEQzQ+upg8x9aQThS2bBoiwryJNxYWQ5tnem/swE4WlG
         1X5cE576yBV6X3CcCDidtBre0k+O24vhjlvswqMTAAKo2SbLgTY891phXTAg6yPuVK
         aCDqC0zZ8idAg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 7/9] objtool: Remove superfluous dead_end_function() check
Date:   Wed, 12 Apr 2023 12:03:22 -0700
Message-Id: <5d603a301e9a8b1036b61503385907e154867ace.1681325924.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681325924.git.jpoimboe@kernel.org>
References: <cover.1681325924.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

annotate_call_site() already sets 'insn->dead_end' for calls to dead end
functions.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b9e5e0e9c1ee..5e7d3c62fb9d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4081,8 +4081,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	 * It may also insert a UD2 after calling a __noreturn function.
 	 */
 	prev_insn = prev_insn_same_sec(file, insn);
-	if ((prev_insn->dead_end ||
-	     dead_end_function(file, insn_call_dest(prev_insn))) &&
+	if (prev_insn->dead_end &&
 	    (insn->type == INSN_BUG ||
 	     (insn->type == INSN_JUMP_UNCONDITIONAL &&
 	      insn->jump_dest && insn->jump_dest->type == INSN_BUG)))
-- 
2.39.2

