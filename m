Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170B370830D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjERNpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjERNon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:44:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4F1212B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:44:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B98A618D5
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2081C4339B;
        Thu, 18 May 2023 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684417453;
        bh=cUkMOxBEzxZhyYUFXL/piJ1d9rBpjwxzC2sG2pI0Nn4=;
        h=Date:From:To:Cc:Subject:From;
        b=Fak5EoBY5WJ0EgPIcKeVWyVMyOfdOAL9slaQUi2V27ZeN8FkqTfiawEHju7ajbUE1
         ntgJ9NyL0PSTw7osmfQs1T11aO2jcuPEKP7ZyZwWNsYtBUT9D6pl7JS+TMBpnjJqNR
         vtc0+3SWore5a99Xub9C9lZlcKj9yUmoI7OjCfWGClDTJcuYED/plJisa/AdV0WPEN
         VWLVk0wlCd5iB5goryljKaRbtosRxIkzAxCVvRLhHE+kqCLu+AJK53Lkg6q5sbJPZA
         V67w1jKxLVJoBb0OW4OukCuDAm0gCC7swGlmK3itC7rx2xbXCMzRxhdHXy6TQUMH++
         wR7hicw54Nktg==
Date:   Thu, 18 May 2023 22:44:09 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masami Hiramatsu (Google) <mhiramat@kernel.org>,
        Ze Gao <zegao2021@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] probes: Fixes for 6.4-rc1
Message-Id: <20230518224409.62cf8ccef515cbccf07f0e13@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Probes fixes for 6.4-rc1:

- Initialize 'ret' local variables on fprobe_handler() to fix the smatch
  warning. With this, fprobe function exit handler is not working
  randomly.

- Fix to use preempt_enable/disable_notrace for rethook handler to
  prevent recursive call of fprobe exit handler (which is based on
  rethook)

- Fix recursive call issue on fprobe_kprobe_handler().

- Fix to detect recursive call on fprobe_exit_handler().

- Fix to make all arch-dependent rethook code notrace.
  (the arch-independent code is already notrace)


Please pull the latest probes-fixes-v6.4-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.4-rc1

Tag SHA1: edaa9b59161d819661ea96a97850d9aaf6d43bdc
Head SHA1: 571a2a50a8fc546145ffd3bf673547e9fe128ed2


Masami Hiramatsu (Google) (1):
      tracing: fprobe: Initialize ret valiable to fix smatch error

Ze Gao (4):
      rethook: use preempt_{disable, enable}_notrace in rethook_trampoline_handler
      fprobe: make fprobe_kprobe_handler recursion free
      fprobe: add recursion detection in fprobe_exit_handler
      rethook, fprobe: do not trace rethook related functions

----
 arch/riscv/kernel/probes/Makefile |  2 ++
 arch/s390/kernel/Makefile         |  1 +
 arch/x86/kernel/Makefile          |  1 +
 kernel/trace/fprobe.c             | 73 +++++++++++++++++++++++++++++++--------
 kernel/trace/rethook.c            |  4 +--
 5 files changed, 64 insertions(+), 17 deletions(-)


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
