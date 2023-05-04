Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE606F73AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjEDTpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEDTno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:43:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CE58A5A;
        Thu,  4 May 2023 12:43:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F256D63743;
        Thu,  4 May 2023 19:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37141C4339B;
        Thu,  4 May 2023 19:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229388;
        bh=4SRlXZrf8V/j6TItl/KMXth4dkdIfwm+T3fjZe+1fcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e1PDCVxgCD8BQa98yK6MJh5JmUoLKlIcKQ/FEWw1W6EFwet7kM83SI6xqei/zjXx8
         hbqgqEUNnumFzggEcRWDUYflYzBuMj8UvqZIeYH9q8i3PcpGtCPh7rkj0ISWls4SS9
         DoVv7jCn1lzpL6QbMzDqJb/UmAwIBthGM/m2PvT4LQpSDD6vf6JHRsUy0p/KrJ1UUX
         cJRzqd6pk24VH4IXOADkLpCIrIitmpdTij89xiDK4TZywTrt1H3zL0PN2RWMMeqxQ3
         NnFkj4p7o6Sl+UHd3CmkYC6EkO7HpnSfv9mhyz439Qdt2QXn1tHAd70T3VqGyRbr91
         vA4tVs9EyfEeQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yafang <laoar.shao@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 32/59] bpf: Add preempt_count_{sub,add} into btf id deny list
Date:   Thu,  4 May 2023 15:41:15 -0400
Message-Id: <20230504194142.3805425-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194142.3805425-1-sashal@kernel.org>
References: <20230504194142.3805425-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang <laoar.shao@gmail.com>

[ Upstream commit c11bd046485d7bf1ca200db0e7d0bdc4bafdd395 ]

The recursion check in __bpf_prog_enter* and __bpf_prog_exit*
leave preempt_count_{sub,add} unprotected. When attaching trampoline to
them we get panic as follows,

[  867.843050] BUG: TASK stack guard page was hit at 0000000009d325cf (stack is 0000000046a46a15..00000000537e7b28)
[  867.843064] stack guard page: 0000 [#1] PREEMPT SMP NOPTI
[  867.843067] CPU: 8 PID: 11009 Comm: trace Kdump: loaded Not tainted 6.2.0+ #4
[  867.843100] Call Trace:
[  867.843101]  <TASK>
[  867.843104]  asm_exc_int3+0x3a/0x40
[  867.843108] RIP: 0010:preempt_count_sub+0x1/0xa0
[  867.843135]  __bpf_prog_enter_recur+0x17/0x90
[  867.843148]  bpf_trampoline_6442468108_0+0x2e/0x1000
[  867.843154]  ? preempt_count_sub+0x1/0xa0
[  867.843157]  preempt_count_sub+0x5/0xa0
[  867.843159]  ? migrate_enable+0xac/0xf0
[  867.843164]  __bpf_prog_exit_recur+0x2d/0x40
[  867.843168]  bpf_trampoline_6442468108_0+0x55/0x1000
...
[  867.843788]  preempt_count_sub+0x5/0xa0
[  867.843793]  ? migrate_enable+0xac/0xf0
[  867.843829]  __bpf_prog_exit_recur+0x2d/0x40
[  867.843837] BUG: IRQ stack guard page was hit at 0000000099bd8228 (stack is 00000000b23e2bc4..000000006d95af35)
[  867.843841] BUG: IRQ stack guard page was hit at 000000005ae07924 (stack is 00000000ffd69623..0000000014eb594c)
[  867.843843] BUG: IRQ stack guard page was hit at 00000000028320f0 (stack is 00000000034b6438..0000000078d1bcec)
[  867.843842]  bpf_trampoline_6442468108_0+0x55/0x1000
...

That is because in __bpf_prog_exit_recur, the preempt_count_{sub,add} are
called after prog->active is decreased.

Fixing this by adding these two functions into btf ids deny list.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Yafang <laoar.shao@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>
Acked-by: Hao Luo <haoluo@google.com>
Link: https://lore.kernel.org/r/20230413025248.79764-1-laoar.shao@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 767e8930b0bd5..d8a01180ddf76 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17551,6 +17551,10 @@ BTF_ID(func, migrate_enable)
 #if !defined CONFIG_PREEMPT_RCU && !defined CONFIG_TINY_RCU
 BTF_ID(func, rcu_read_unlock_strict)
 #endif
+#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
+BTF_ID(func, preempt_count_add)
+BTF_ID(func, preempt_count_sub)
+#endif
 BTF_SET_END(btf_id_deny)
 
 static bool can_be_sleepable(struct bpf_prog *prog)
-- 
2.39.2

