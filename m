Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0526F61EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 01:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjECXPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 19:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjECXPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 19:15:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C487D87
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 16:15:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7986463085
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43D9C433D2;
        Wed,  3 May 2023 23:15:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1puLgr-000LJk-15;
        Wed, 03 May 2023 19:15:17 -0400
Message-ID: <20230503231446.234385640@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 May 2023 19:14:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: Minor updates for 6.4
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Minor updates:

- Make buffer_percent read/write. The buffer_percent file is how users can
  state how long to block on the tracing buffer depending on how much
  is in the buffer. When it hits the "buffer_percent" it will wake the
  task waiting on the buffer. For some reason it was set to read-only.
  This was not noticed because testing was done as root without SELinux,
  but with SELinux it will prevent even root to write to it without having
  CAP_DAC_OVERRIDE.

- The "touched_functions" was added this merge window, but one of the
  reasons for adding it was not implemented. That was to show what functions
  were not only touched, but had either a direct trampoline attached to
  it, or a kprobe or live kernel patching that can "hijack" the function
  to can a different function. The point is to know if there's functions
  in the kernel that may not be behaving as kernel code shows. This can
  be used for debugging. TODO: Add this information to kernel oops too.

Ondrej Mosnacek (1):
      tracing: Fix permissions for the buffer_percent file

Steven Rostedt (Google) (1):
      ftrace: Add MODIFIED flag to show if IPMODIFY or direct was attached

----
 Documentation/trace/ftrace.rst | 25 +++++++++++++++++++++++++
 include/linux/ftrace.h         |  4 +++-
 kernel/trace/ftrace.c          | 12 +++++++++---
 kernel/trace/trace.c           |  2 +-
 4 files changed, 38 insertions(+), 5 deletions(-)
