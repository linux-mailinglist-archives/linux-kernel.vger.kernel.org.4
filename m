Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F3974F28E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjGKOrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjGKOre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2931BB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:47:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A61D761514
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEE9C433C7;
        Tue, 11 Jul 2023 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689086853;
        bh=qBV6I50tibwO+beYLgSgw4jq5F7af4WgvkmDtfapht4=;
        h=Date:From:To:Cc:Subject:From;
        b=sQAQDpxi6isinTP0jyQt9e+DrIPTQ58bY8BJIKk5F25oNhPfc4fxJg3xRr19eqtqj
         H49vzBOmth34ezYt88Tjhhi3KQMzaBFRGEnTpiZ5Uc30aSu9hDuTn+HG/KeQHuERiA
         yPtjDuMOO8N/TNigb7DxFEdLF99eRLWAhk+Vrsy69hYmznz7NbDWaDdSJ+fFSAx8vd
         IVnDeasZKneyZrd8hPzPKiVimzvYOyqgDebGJjOTRZGssge58oCPOcdYpntzaPgixu
         O077iYe6OAeFrSOvCsTv1aGVsRGaxqEsYwX7fnSGKmbS+uCpE/x3Y5j/gYz4GRoV84
         yDLinxrvCBR6g==
Date:   Tue, 11 Jul 2023 23:47:28 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Li zeming <zeming@nfschina.com>,
        Masami Hiramatsu (Google) <mhiramat@kernel.org>,
        Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>,
        Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for 6.5-rc1
Message-Id: <20230711234728.e9f386a44657240b7e1cda49@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Probes fixes and clean ups for v6.5-rc1:

- Fix fprobe's rethook release timing issue(1). Release rethook after
  ftrace_ops is unregistered so that the rethook is not accessed after
  free.

- Fix fprobe's rethook access timing issue(2). Stop rethook before
  ftrace_ops is unregistered so that the rethook is NOT keep using
  after exiting the unregister_fprobe().

- Fix eprobe cleanup logic. If it attaches to multiple events and failes
  to enable one of them, rollback all enabled events correctly.

- Fix fprobe to unlock ftrace recursion lock correctly when it missed
  by another running kprobe.

- Cleanup kprobe to remove unnecessary NULL.

- Cleanup kprobe to remove unnecessary 0 initializations.


Please pull the latest probes-fixes-v6.5-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.5-rc1

Tag SHA1: 18caf0b93d8c36dbef8de1332b50ea3a6defd19f
Head SHA1: 195b9cb5b288fec1c871ef89f78cc9a7461aad3a


Jiri Olsa (1):
      fprobe: Release rethook after the ftrace_ops is unregistered

Li zeming (2):
      kprobes: Remove unnecessary ‘NULL’ values from correct_ret_addr
      kernel: kprobes: Remove unnecessary ‘0’ values

Masami Hiramatsu (Google) (1):
      fprobe: Ensure running fprobe_exit_handler() finished before calling rethook_free()

Tzvetomir Stoyanov (VMware) (1):
      kernel/trace: Fix cleanup logic of enable_trace_eprobe

Ze Gao (1):
      fprobe: add unlock to match a succeeded ftrace_test_recursion_trylock

----
 include/linux/rethook.h     |  1 +
 kernel/kprobes.c            |  8 ++++----
 kernel/trace/fprobe.c       | 15 +++++++--------
 kernel/trace/rethook.c      | 13 +++++++++++++
 kernel/trace/trace_eprobe.c | 18 ++++++++++++++++--
 5 files changed, 41 insertions(+), 14 deletions(-)


Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
