Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388E463F303
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiLAOjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLAOjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:39:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B23A6040
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:38:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BAD9B81F65
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0151AC433D6;
        Thu,  1 Dec 2022 14:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669905536;
        bh=zjg9hqyT/cvW+xoLTuMA96NteGmgZ6jPNBUY+Kiab1s=;
        h=From:To:Cc:Subject:Date:From;
        b=LptiEmZWEYpFEm+OjQAbOIb9Nkdoc9xQrQqR0Xmc42JD7Ql2j0ejidB+Ri1/jWPSM
         XvU3HdECIe2WbTuIibMcmo5hDFiwCipgyyemKBTjjSVBhxelQPMZgimOqtNdPcVJed
         U+RT2jOTRKFaWHnw2Z/SwFz2xr29Wc+8Tx8K9FN/fFqmjLfPX3IW0L63y7CDU9Qr3N
         PCw8V2be87+djYeRst4QZ6LZlOr0qFO7zPoftndI2IsFAKoQ9oeVBh89GRbj2FdxpW
         8QeqGBmrnxCQ41sT6lh6npE89dI04VmDE4EsZeQIPyne0vR3NC8T85pfeDlpK2FusG
         b6JLucNxahpbQ==
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
Subject: [PATCH 0/3] arm64: kprobes: Fix bugs in kprobes for arm64
Date:   Thu,  1 Dec 2022 23:38:52 +0900
Message-Id: <166990553243.253128.13594802750635478633.stgit@devnote3>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
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

I found some bugs in kprobes for arm64. One is a critical issue, which
will cause a kernel crach easily with lockdep[1/3]. Others are minor
issues and rare cases. [2/3] let do_page_fault() fixup the page fault
in kprobes user handler, and [3/3] is more like code cleanup and
returns DBG_HOOK_ERROR if it can not handle kprobe's BRK (but that
should not happen.)

Thank you,

---

Masami Hiramatsu (Google) (3):
      arm64: Prohibit probing on arch_stack_walk()
      arm64: kprobes: Let arch do_page_fault() fix up page fault in user handler
      arm64: kprobes: Return DBG_HOOK_ERROR if kprobes can not handle a BRK


 arch/arm64/kernel/probes/kprobes.c |   87 +++++++++++++++---------------------
 arch/arm64/kernel/stacktrace.c     |    7 ++-
 2 files changed, 41 insertions(+), 53 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
