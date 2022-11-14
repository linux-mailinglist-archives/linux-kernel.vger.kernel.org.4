Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B532F627CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbiKNLph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiKNLo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960352252F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CEFC61087
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2887C43155;
        Mon, 14 Nov 2022 11:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426279;
        bh=dn0CND4Yb3GYabpLwzhF9lVAnJEjbiM0Q87kR0Hih+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fX5j1IWzLpzENINvT3ouVKWBX6XghYPlk3DDKxppfVzJOeJKkj9hg/0dXdZ1JXhl/
         6u8gVzw0+qpl9nTA+F0Wt/w3eTvJi6P6IL+qO9DlwcCJv2eGvC/uLIuuzI69nDjDCv
         ZfuhOlM+1zxGUc6onbmKi5kozBR4rBaQF0hz4b3GgFA3tp7tSGTxLWmmRDzXjgdmy4
         3nO+cg2W9QbHDLphFVrRcX/SHX7LM2zIMdUAwQr5xp3adR7HRkQ0/jyMSFUizPz5d/
         KiBtPoGntlu7Pugnuo3qZbej8+X1fuBGoHIJSlbdFAuzn3GBOA5tf5K1edamffE2PV
         LIqXgGwCvi10A==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 18/46] entry, lto: Mark raw_irqentry_exit_cond_resched() as __visible
Date:   Mon, 14 Nov 2022 12:43:16 +0100
Message-Id: <20221114114344.18650-19-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
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

From: Andi Kleen <ak@linux.intel.com>

Symbols referenced from assembler (either directly or e.f. from
DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
they could end up in a different object file than the assembler. This
can lead to linker errors without this patch.

So mark raw_irqentry_exit_cond_resched() as __visible.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 kernel/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 846add8394c4..13c1a7a0e8ce 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -378,7 +378,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	return ret;
 }
 
-void raw_irqentry_exit_cond_resched(void)
+__visible void raw_irqentry_exit_cond_resched(void)
 {
 	if (!preempt_count()) {
 		/* Sanity check RCU and thread stack */
-- 
2.38.1

