Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E5473AE52
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 03:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjFWBdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 21:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjFWBdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 21:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB151FE6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 18:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7B8D6192B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BD7C433C0;
        Fri, 23 Jun 2023 01:33:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qCVg7-002M6a-32;
        Thu, 22 Jun 2023 21:33:35 -0400
Message-ID: <20230623013152.037225511@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Jun 2023 21:31:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: Final updates for 6.4
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before user events become an ABI, fix the return value of the write
operation when tracing is disabled. It should not return an error, but
simply report it wrote zero bytes. Just like any other write operation
that doesn't write but does not "fail".

This also includes test cases for this use case.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 131966049074b8025a8cba0e99d3745311fcef5b


sunliming (3):
      tracing/user_events: Fix incorrect return value for writing operation when events are disabled
      selftests/user_events: Enable the event before write_fault test in ftrace self-test
      selftests/user_events: Add test cases when event is disabled

----
 kernel/trace/trace_events_user.c                  | 3 ++-
 tools/testing/selftests/user_events/ftrace_test.c | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)
