Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ACA627CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiKNLpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbiKNLpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:45:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C3823158
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A2946106E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE15C433C1;
        Mon, 14 Nov 2022 11:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426282;
        bh=EmZ2uX2gI3bbUDmWCTMpWHApcz7gKOlAwlCJ75sHcrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rXbgHJtsiDuv0sPyHOGdWkcq8w522U/y0OQB4TPexKtwC6oYufrIMP+/qxIDlYWk7
         y1TlsjFwRaS2LaJ+1uyhtVefA2TVGcMbApsz8lszDYncpAAkdGAAbGwc8xb0gYl+Hi
         XAgx5aC86ODFPR6LrCi/vGM9Ms8+wdHeOXhQNXiAvhaBBAeaz4yyONF2qErsOLFJZ8
         +PWMTtuOxKG/O09KLA3gBJS3DPdhq+ZmNLPI1wccXLRNAxJ/WfNa7F6pVV+DLIEM6m
         k/gXsKrOGrMh/KX68S47Z2mr1wnI/NN+epgXaNLFiUkewr5enPvFpD4TYT/dWcmP7i
         xITP5aobDF4Wg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <andi@firstfloor.org>, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 20/46] softirq, lto: Mark irq_enter/exit_rcu() as __visible
Date:   Mon, 14 Nov 2022 12:43:18 +0100
Message-Id: <20221114114344.18650-21-jirislaby@kernel.org>
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

From: Andi Kleen <andi@firstfloor.org>

Symbols referenced from assembler (either directly or e.f. from
DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
they could end up in a different object file than the assembler. This
can lead to linker errors without this patch.

So mark irq_enter_rcu() and irq_exit_rcu() as __visible.

Signed-off-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 kernel/softirq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index c8a6913c067d..9d62e09c9581 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -604,7 +604,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 /**
  * irq_enter_rcu - Enter an interrupt context with RCU watching
  */
-void irq_enter_rcu(void)
+__visible void irq_enter_rcu(void)
 {
 	__irq_enter_raw();
 
@@ -657,7 +657,7 @@ static inline void __irq_exit_rcu(void)
  *
  * Also processes softirqs if needed and possible.
  */
-void irq_exit_rcu(void)
+__visible void irq_exit_rcu(void)
 {
 	__irq_exit_rcu();
 	 /* must be last! */
-- 
2.38.1

