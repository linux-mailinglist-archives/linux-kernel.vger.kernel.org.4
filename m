Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB55706989
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjEQNSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjEQNSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:18:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC7D5580;
        Wed, 17 May 2023 06:18:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6918D646FD;
        Wed, 17 May 2023 13:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B14C433EF;
        Wed, 17 May 2023 13:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329505;
        bh=fFaBhSlTcMJjI8CnUH0C+qCZq/vTg7EvCm12mEBrjAY=;
        h=From:To:Cc:Subject:Date:From;
        b=n8MkuYef3+BHDNckeyaUgqc5b2L54WprOPLVQQ4Sy4FSWFX6SVa5c0IHQ4TQsUlML
         skyxSOiOqHcGbBXeq8XDDfC1ndeivE0CMdm39/hkih5011ohB7MwoFrlrE9K3lWJkN
         XVXX+kbld2p7EDaALZ4k9CNEqSVAtlHqpN79T1qINQaqtL3dQEDrUsBp4b3aLlzY1W
         6MQ0W2X26bJugHIdCkulIrHOKky5rd5p2Wx9tk8vx+MwHrkhPyILNSReZ7Ae/4m7uG
         a6rCdMuQXCYEWMRE3aOKtzcRtWIFTiR467gshJtgOEn/NOcIrbA8zr6pT1rs2gK5Ay
         SkX0gSRUcPgBQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] kallsyms: remove unused arch_get_kallsym() helper
Date:   Wed, 17 May 2023 15:18:07 +0200
Message-Id: <20230517131820.936553-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The arch_get_kallsym() function was introduced so that x86 could override
it, but that override was removed in bf904d2762ee ("x86/pti/64: Remove
the SYSCALL64 entry trampoline"), so now this does nothing except causing
a warning about a missing prototype:

kernel/kallsyms.c:662:12: error: no previous prototype for 'arch_get_kallsym' [-Werror=missing-prototypes]
  662 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,

Restore the old behavior before d83212d5dd67 ("kallsyms, x86: Export
addresses of PTI entry trampolines") to simplify the code and avoid
the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/kallsyms.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index e01c435595f9..dac13659601f 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -646,7 +646,6 @@ int sprint_backtrace_build_id(char *buffer, unsigned long address)
 /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
 struct kallsym_iter {
 	loff_t pos;
-	loff_t pos_arch_end;
 	loff_t pos_mod_end;
 	loff_t pos_ftrace_mod_end;
 	loff_t pos_bpf_end;
@@ -659,29 +658,9 @@ struct kallsym_iter {
 	int show_value;
 };
 
-int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
-			    char *type, char *name)
-{
-	return -EINVAL;
-}
-
-static int get_ksymbol_arch(struct kallsym_iter *iter)
-{
-	int ret = arch_get_kallsym(iter->pos - kallsyms_num_syms,
-				   &iter->value, &iter->type,
-				   iter->name);
-
-	if (ret < 0) {
-		iter->pos_arch_end = iter->pos;
-		return 0;
-	}
-
-	return 1;
-}
-
 static int get_ksymbol_mod(struct kallsym_iter *iter)
 {
-	int ret = module_get_kallsym(iter->pos - iter->pos_arch_end,
+	int ret = module_get_kallsym(iter->pos - kallsyms_num_syms,
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
 				     &iter->exported);
@@ -764,7 +743,6 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
 	iter->nameoff = get_symbol_offset(new_pos);
 	iter->pos = new_pos;
 	if (new_pos == 0) {
-		iter->pos_arch_end = 0;
 		iter->pos_mod_end = 0;
 		iter->pos_ftrace_mod_end = 0;
 		iter->pos_bpf_end = 0;
@@ -780,10 +758,6 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 {
 	iter->pos = pos;
 
-	if ((!iter->pos_arch_end || iter->pos_arch_end > pos) &&
-	    get_ksymbol_arch(iter))
-		return 1;
-
 	if ((!iter->pos_mod_end || iter->pos_mod_end > pos) &&
 	    get_ksymbol_mod(iter))
 		return 1;
-- 
2.39.2

