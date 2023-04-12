Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EEE6DEB0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDLF1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDLF1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:27:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B341FFB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 22:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2A3962850
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02501C4339B;
        Wed, 12 Apr 2023 05:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681277267;
        bh=tsY94+SaiX/e8ko70Tn8wqv+vZcRg8YGlwY3hPDLiBg=;
        h=From:To:Cc:Subject:Date:From;
        b=DoLDDgJ0fF/g8j6U256vDg1Nt+eW3kaR9Pijz2+GADuZxDVrzWXENwjLkl5UqBNsA
         /1qC92O6JwZzY7+FfvZyVWqbxNA8Hv5AXDUSkVQ+FJwbjY+qIQb9JqCP7CH5o9CfBX
         6bPQRsqoSII6KQsdmA/RrzIz+UHQeg/ERlEAkVMW7kGjVqp38eMG+N2iVYvRz0W8A4
         f6ZewWzsloN6j7DMcLMu9vDwDx+wQEI4VS9ma0HnRKCqIqEmIEd7g5FYE7XE6AStnX
         r9/Qh6gtXT+sXBbs24BvuhkCnUpsSYO23tUJlz33unJ1BqtfXayS35u/XHDGhwny6l
         Ja0Ai8slg2DnQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] sched/core: Make sched_dynamic_mutex static
Date:   Tue, 11 Apr 2023 22:26:41 -0700
Message-Id: <016987c1ec4649b74973a000e81c35e48ba6072e.1681277194.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sched_dynamic_mutex is only used within the file.  Make it static.

Fixes: e3ff7c609f39 ("livepatch,sched: Add livepatch task switching to cond_resched()")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304062335.tNuUjgsl-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b9616f153946..d861db8aa7ab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8674,7 +8674,7 @@ int sched_dynamic_mode(const char *str)
 #error "Unsupported PREEMPT_DYNAMIC mechanism"
 #endif
 
-DEFINE_MUTEX(sched_dynamic_mutex);
+static DEFINE_MUTEX(sched_dynamic_mutex);
 static bool klp_override;
 
 static void __sched_dynamic_update(int mode)
-- 
2.39.2

