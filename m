Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E066D7F64
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbjDEO1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbjDEO1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:27:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DC64EDB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B4F962755
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA546C433EF;
        Wed,  5 Apr 2023 14:26:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pk46A-000qie-1t;
        Wed, 05 Apr 2023 10:26:54 -0400
Message-ID: <20230405135813.735507007@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 05 Apr 2023 09:58:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: More fixes for 6.3
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


- Fix boot up snapshot code:

  Boot snapshots were triggering when not even asked for on the
  kernel command line. This was caused by two bugs.

  1) It would trigger a snapshot on any instance if one was created
     from the kernel command line.

  2) The error handling would only affect the top level instance.
     So the fact that a snapshot was done on a instance that didn't
     allocate a buffer triggered a warning written into the top level
     buffer, and worse yet, disabled the top level buffer.

- Fix memory leak that was caused when an error was logged in a
  trace buffer instance, and then the buffer instance was removed.
  The allocated error log messages still need to be freed.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 3357c6e429643231e60447b52ffbb7ac895aca22


Steven Rostedt (Google) (3):
      tracing: Have tracing_snapshot_instance_cond() write errors to the appropriate instance
      tracing: Fix ftrace_boot_snapshot command line logic
      tracing: Free error logs of tracing instances

----
 kernel/trace/trace.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)
