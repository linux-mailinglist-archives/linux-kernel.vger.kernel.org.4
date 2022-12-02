Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5463FE12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiLBCSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiLBCSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:18:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F17C936F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 18:18:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AF2CB81F90
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBF3C433D6;
        Fri,  2 Dec 2022 02:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669947508;
        bh=DHydDKMUem27kZ5bOGft5Frx5rmLAw4LuANPUEyn8V4=;
        h=From:To:Cc:Subject:Date:From;
        b=mJ7MQ6NapnVDpWe6ZcULZ7fHqlUe0RSULl2YIeysqqXwbVMdlqH7ERovHrYIQDfaU
         VTRkfs9WdrtGCd24XuRYGlUoqJtIacqVLsI8NxuxH1Po0qDGUORH/G3OII5kaopfl9
         sl3iyETWDq2HcCXd5JiWp2vKl7wLdF90WNogS73nl06xeS//d+yAhJ8axnOuggc0Tl
         XP+HhKXBxqWYGv8ugQTVhErs24a31HLmy+nVN4Ld4AopgmnkH/fdyK8vaf/NjRqkwE
         tS4iDO+hA/mol8a2OZc1gbs6CD5X16D+5msDVJ3KFzlhakt/1MhV12MIz9cmoAZNMA
         IBGOIRKdCLw/w==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
Subject: [PATCH v2 0/3] arm64: kprobes: Fix bugs in kprobes for arm64
Date:   Fri,  2 Dec 2022 11:18:23 +0900
Message-Id: <166994750386.439920.1754385804350980158.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 2nd version of the kprobe bugfixes on arm64. The previous
series is here;

https://lore.kernel.org/all/166990553243.253128.13594802750635478633.stgit@devnote3/T/#u

The first one is a critical issue, which will cause a kernel crach
easily with lockdep[1/3]. Others are minor issues and rare cases.
The [2/3] let do_page_fault() fixup the page fault in kprobes user
handler, and [3/3] is more like code cleanup and returns
DBG_HOOK_ERROR if it can not handle kprobe's BRK (but that
should not happen.)

In this version I update to use noinstr and __always_inline [1/3]
and update comments[3/3]. Also add Mark's Ack (Thanks!)

Thank you,

---

Masami Hiramatsu (Google) (3):
      arm64: Prohibit instrumentation on arch_stack_walk()
      arm64: kprobes: Let arch do_page_fault() fix up page fault in user handler
      arm64: kprobes: Return DBG_HOOK_ERROR if kprobes can not handle a BRK


 arch/arm64/kernel/probes/kprobes.c |   86 +++++++++++++++---------------------
 arch/arm64/kernel/stacktrace.c     |   10 ++--
 2 files changed, 41 insertions(+), 55 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
