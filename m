Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DF56CA9DA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjC0QBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjC0QBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6413A65A1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F34606136E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA57C4339B;
        Mon, 27 Mar 2023 16:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679932856;
        bh=q9Vpi9kjIy4hLyGLwLZZ/FrbCreS4bEtiQO84AJpizA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ce8fKwBD6Dw2NN7jzRcnIZfQhhi1c3/If+5JYNRxH8r9ImWozIW/nFAt3O5YlUHCM
         a/lkGW/n8x4sQc9a1cKMi78zWRO8e8aa8xolV3pvq+A0vsqTHaxoIPpPYuAGFNRiUg
         2Ncezskn9wnNWwDYTdX0D16z4PQ9REaLLcZyTm8Yb3d8z0+BspRNbBctgTCpKzaF5A
         Fb89O1bUAoxOvuLfQ4oyeY0R5+wALY4GC4Axz/L9uX7JDGfM/LPRXJqNTTQtA/CYAt
         UCxdhbKwY6t872sHXpD0DfyVBInkwKIqUUlODfvrQSElN6Py31W+Zrc+TanMf6N4ZV
         hwJLMXRYIg+fA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/5] objtool: Remove superfluous dead_end_function() check
Date:   Mon, 27 Mar 2023 09:00:46 -0700
Message-Id: <5e314b6d68090f3aa32e5e02551e6a8db62d6728.1679932620.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679932620.git.jpoimboe@kernel.org>
References: <cover.1679932620.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
index a652b9e5c805..73dd091c0075 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4140,8 +4140,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
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

