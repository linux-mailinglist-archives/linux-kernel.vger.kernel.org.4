Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1911E7486C3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjGEOql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjGEOqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:46:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D26DCE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F2E0615CD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7A5C433C7;
        Wed,  5 Jul 2023 14:46:33 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qH3m3-003PgH-2k;
        Wed, 05 Jul 2023 10:46:31 -0400
Message-ID: <20230705144031.702796304@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 05 Jul 2023 10:40:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: A few fixes for 6.5
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tracing fixes for 6.5:

- Fix bad git merge of #endif in arm64 code
  A merge of the arm64 tree caused #endif to go into the wrong place

- Fix crash on lseek of write access to tracefs/error_log
  Opening error_log as write only, and then doing an lseek() causes
  a kernel panic, because the lseek() handle expects a "seq_file"
  to exist (which is not done on write only opens). Use tracing_lseek()
  that tests for this instead of calling the default seq lseek handler.

- Check for negative instead of -E2BIG for error on strscpy() returns
  Instead of testing for -E2BIG from strscpy(), to be more robust,
  check for less than zero, which will make sure it catches any error
  that strscpy() may someday return.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/core

Head SHA1: fddca7db4a4c17f7333793dfb5308d80c76d2896


Arnd Bergmann (1):
      arm64: ftrace: fix build error with CONFIG_FUNCTION_GRAPH_TRACER=n

Mateusz Stachyra (1):
      tracing: Fix null pointer dereference in tracing_err_log_open()

Steven Rostedt (Google) (1):
      tracing/boot: Test strscpy() against less than zero for error

----
 arch/arm64/kernel/asm-offsets.c | 2 +-
 kernel/trace/trace.c            | 2 +-
 kernel/trace/trace_boot.c       | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)
