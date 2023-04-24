Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C908D6DE64A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDKVRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDKVRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:17:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91CFF3594;
        Tue, 11 Apr 2023 14:17:15 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id C741921779A1;
        Tue, 11 Apr 2023 14:17:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C741921779A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681247834;
        bh=oBm7UAgWYx2ikyJKWEAABOUG7UTL+PiB3Yh06pGj3g4=;
        h=From:To:Cc:Subject:Date:From;
        b=Z1at4qah8WLFhkDhgppqXLfGtmJesTfcpCqNdRs5uL5vtv/r8RSyI0GKqfIvr2IM+
         RZiEH9lth5WwyGRJaJ5ISnlyjQw5e8CTtosRcPVUqH8MIPC/g0V9CpadyRFfnvEke+
         TLuscezLrkws+N7xej1QA+SxPkUXprULy2b1C0zk=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/3] tracing/user_events: Fixes and improvements for 6.4
Date:   Tue, 11 Apr 2023 14:17:06 -0700
Message-Id: <20230411211709.15018-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that user_events is in for-next we broadened our integration of
user_events. During this integration we found a few things that can
help prevent the debugging of issues for user_events when user
processes use the ABI directly.

The most important thing found is an out of bounds fix with the
write index. If it is negative, an out of bounds access is attempted.
This bug was introduced on one of the very first user_events patches
and remained unseen for a long time. Apologies for not catching that
sooner.

We think users will expect the kernel to always clear the registered
bit when events are unregistered, even if the event is still enabled
in a kernel tracer. The user process could do this after unregistering,
but it seems appropriate for the kernel side to attempt this. We also
discussed if it makes sense for the kernel to allow user processes
to tie multiple events to the same value and bit. While this doesn't
cause any issues on the kernel side, it leads to very undefined
behavior for the user process. Depending on which event gets enabled
when, the bit will vary.

Beau Belgrave (3):
  tracing/user_events: Ensure write index cannot be negative
  tracing/user_events: Ensure bit is cleared on unregister
  tracing/user_events: Prevent same address and bit per process

 kernel/trace/trace_events_user.c              | 77 +++++++++++++++++++
 .../testing/selftests/user_events/abi_test.c  |  9 ++-
 .../selftests/user_events/ftrace_test.c       | 14 +++-
 3 files changed, 96 insertions(+), 4 deletions(-)


base-commit: 88fe1ec75fcb296579e05eaf3807da3ee83137e4
-- 
2.25.1

