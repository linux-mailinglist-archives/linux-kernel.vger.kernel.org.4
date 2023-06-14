Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5101D7304FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjFNQdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjFNQdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:33:41 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D05361A3;
        Wed, 14 Jun 2023 09:33:40 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 26B3120FEA3D;
        Wed, 14 Jun 2023 09:33:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26B3120FEA3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686760420;
        bh=SiFmm2ES1OHrXqYC7FgeWMYoLEAUTGZzcnUadkZnZkg=;
        h=From:To:Cc:Subject:Date:From;
        b=rUHHiW/AhatcwMBOg3++AmFnhNrvMvpmvFdFjpi6E359IY8R/yKumI000dXEWiut2
         qdq19o59tM7PyVCCdv4bkEUb4J/dKzd3N1Di8IFV0UEx6UCkL+2tSDk3bJFO5PWVbH
         +R8iG7o1GIWhpngLTMUi/RwPZei2X4RQ6lSCvAiA=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH v3 0/6] tracing/user_events: Add auto cleanup and a flag to persist events
Date:   Wed, 14 Jun 2023 09:33:30 -0700
Message-Id: <20230614163336.5797-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URG_BIZ,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the discussions for user_events aligning to be used with eBPF
it became clear [1] we needed a way to delete events without having to rely
upon the delete IOCTL. Steven suggested that we simply have an owner
for the event, however, the event can be held by more than just the
first register FD, such as perf/ftrace or additional registers. In order
to handle all those cases, we must only delete after all references are
gone from both user and kernel space.

This series adds a internal register flag, USER_EVENT_REG_PERSIST, which
causes the event to not delete itself upon the last put reference. We
cannot fully drop the delete IOCTL, since we still want to enable events to
be registered early via dynamic_events and persist. Events that do not use
this new flag are auto-cleaned up upon no longer being used. This new flag
is not exposed to user processes yet while we work out the details, however,
the code is updated to accomodate it once it is ready.

1: https://lore.kernel.org/linux-trace-kernel/20230518093600.3f119d68@rorschach.local.home/

Change history

v3:
  Rebased to trace/urgent as requested by Steven

  Removed user-facing references to USER_EVENT_REG_PERSIST while we work out
  the details

  Added check for any flags, even from dynamic_events, will return -EINVAL

  Added clarifying comment about event_mutex protection of refcounts

  Updated selftests to work given the absence of persist events

  Updated documentation to not include /sys/kernel/tracing/dynamic_events since
  they cannot be used until persist flags exist and a note about auto-deletions

v2:
  Renamed series to "Add auto cleanup and a flag to persist events"

  Changed auto-delete to be default behavior, with new flag to persist events

Beau Belgrave (6):
  tracing/user_events: Store register flags on events
  tracing/user_events: Track refcount consistently via put/get
  tracing/user_events: Add auto cleanup and future persist flag
  selftests/user_events: Ensure auto cleanup works as expected
  selftests/user_events: Adapt dyn_test to non-persist events
  tracing/user_events: Document auto-cleanup and remove dyn_event refs

 Documentation/trace/user_events.rst           |   7 +-
 kernel/trace/trace_events_user.c              | 208 ++++++++++++++----
 .../testing/selftests/user_events/dyn_test.c  | 177 +++++++++++----
 .../selftests/user_events/ftrace_test.c       |  49 ++++-
 4 files changed, 346 insertions(+), 95 deletions(-)


base-commit: a8c5c6a5c87ea10189ec43483f44800a4ec97785
-- 
2.25.1

