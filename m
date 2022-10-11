Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17355FBCE6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJKV1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJKV05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:26:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C101F9F8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:26:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 952E3B80749
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 21:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5889DC433C1;
        Tue, 11 Oct 2022 21:26:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oiMmE-003PwC-03;
        Tue, 11 Oct 2022 17:27:02 -0400
Message-ID: <20221011212501.773319898@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 11 Oct 2022 17:25:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] tracing: Fix synthetic event bug
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The follow commands caused a crash:

  # cd /sys/kernel/tracing
  # echo 's:open char file[]' > dynamic_events
  # echo 'hist:keys=common_pid:file=filename:onchange($file).trace(open,$file)' > events/syscalls/sys_enter_openat/trigger'
  # echo 1 > events/synthetic/open/enable

BOOM!

The problem is that the synthetic event field "char file[]" will read
the value given to it as a string without any memory checks to make sure
the address is valid. The above example will pass in the user space
address and the sythetic event code will happily call strlen() on it
and then strscpy() where either one will cause an oops when accessing
user space addresses.


Steven Rostedt (Google) (2):
      tracing: Move duplicate code of trace_kprobe/eprobe.c into header
      tracing: Fix reading strings from synthetic events

----
 kernel/trace/trace_eprobe.c       | 60 ++----------------------
 kernel/trace/trace_events_synth.c | 28 +++++++++---
 kernel/trace/trace_kprobe.c       | 60 ++----------------------
 kernel/trace/trace_probe_kernel.h | 96 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+), 117 deletions(-)
 create mode 100644 kernel/trace/trace_probe_kernel.h
