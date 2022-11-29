Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A33063C7BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiK2TCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbiK2TCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:02:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D14B264B;
        Tue, 29 Nov 2022 11:02:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC83EB81694;
        Tue, 29 Nov 2022 19:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D609FC433C1;
        Tue, 29 Nov 2022 19:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669748529;
        bh=icUPTneL5f1Z7UulRvoGlaLeHjICq2eYhqZB8eYbGic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i4YSH7NeClOesE8D8rV5nxohfSynZkIckFPjvpv8pDdRPKTKYTfFjgBYJ0M+Vukig
         Dnjvge287Rm06ZlLUNLgnk/q07kS98rSLcMLAjmLTh4ihAbojhnICMF44VA4NEU4dU
         TgAa3KDMY5ZhU7Z3YiRoZadR7HW/nPvRvjsBeImLCIn+1ssTErq7r3oCRuyja6iwd3
         +sJJJ2S8IsDD7GSzgh6L4GfOmlDiX22NgE6XJ9gpM76BkXfq7dQyDf/eRj9NaUOSSC
         ZtJsRwwnNw8eLlBqsVg18VBoRzb7UPNJtH2f3n4+YF9JzMgxSCpiGNmdc1/GKvcsEZ
         iWW7UOOi+TkHw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/2] modpost: Include '.text.*' in TEXT_SECTIONS
Date:   Tue, 29 Nov 2022 12:01:23 -0700
Message-Id: <20221129190123.872394-3-nathan@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129190123.872394-1-nathan@kernel.org>
References: <20221129190123.872394-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6c730bfc894f ("modpost: handle -ffunction-sections") added
".text.*" to the OTHER_TEXT_SECTIONS macro to fix certain section
mismatch warnings. Unfortunately, this makes it impossible for modpost
to warn about section mismatchs with LTO, which implies
'-ffunction-sections', as all functions are put in their own
'.text.<func_name>' sections, which may still reference functions in
sections they are not supposed to, such as __init.

Fix this by moving ".text.*" into TEXT_SECTIONS, so that configurations
with '-ffunction-sections' will see warnings about mismatched sections.

Link: https://lore.kernel.org/Y39kI3MOtVI5BAnV@google.com/
Reported-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/mod/modpost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2c80da0220c3..c861beabc128 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -823,10 +823,10 @@ static void check_section(const char *modname, struct elf_info *elf,
 #define ALL_EXIT_SECTIONS EXIT_SECTIONS, ALL_XXXEXIT_SECTIONS
 
 #define DATA_SECTIONS ".data", ".data.rel"
-#define TEXT_SECTIONS ".text", ".text.unlikely", ".sched.text", \
+#define TEXT_SECTIONS ".text", ".text.*", ".sched.text", \
 		".kprobes.text", ".cpuidle.text", ".noinstr.text"
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
-		".fixup", ".entry.text", ".exception.text", ".text.*", \
+		".fixup", ".entry.text", ".exception.text", \
 		".coldtext", ".softirqentry.text"
 
 #define INIT_SECTIONS      ".init.*"
-- 
2.38.1

