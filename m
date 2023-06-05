Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F377233B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjFEXjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjFEXjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:39:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BF4EEC;
        Mon,  5 Jun 2023 16:39:06 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 805D920BCFCC;
        Mon,  5 Jun 2023 16:39:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 805D920BCFCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686008345;
        bh=XzX7ITQkM5lWu0oiVxpi9qKnO2wt1KN1RLZR3+vQCBE=;
        h=From:To:Cc:Subject:Date:From;
        b=cogwOR14b8hXXIbEZpXxHcFvlr5T3j3pGMnzlfrb6PPpKbKRvSY4bmJwvaGq9HBtr
         SRG2hymw2RwFrZEZ73P1mrVt286Niz6a8Nji9YRJe6omdCLP1ieOrx4UHUW5ngRmRZ
         CboSKcovydaXyjYuHPQnfftQato3yM9l5gGjLrXM=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH v2 0/5] tracing/user_events: Add auto cleanup and a flag to persist events
Date:   Mon,  5 Jun 2023 16:38:55 -0700
Message-Id: <20230605233900.2838-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
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

This series adds a new register flag, USER_EVENT_REG_PERSIST, which
causes the event to not delete itself upon the last put reference. We
cannot fully drop the delete IOCTL, since we still want to enable events to
be registered early via dynamic_events and persist. Events that do not use
this new flag are auto-cleaned up upon no longer being used.

NOTE: I'll need to merge this work once we take these [2] [3] patches
into for-next. I'm happy to do so once they land there.

1: https://lore.kernel.org/linux-trace-kernel/20230518093600.3f119d68@rorschach.local.home/
2: https://lore.kernel.org/linux-trace-kernel/20230529032100.286534-1-sunliming@kylinos.cn/
3: https://lore.kernel.org/linux-trace-kernel/20230519230741.669-1-beaub@linux.microsoft.com/

Change history

v2:
  Renamed series to "Add auto cleanup and a flag to persist events"
  Changed auto-delete to be default behavior, with new flag to persist events

Beau Belgrave (5):
  tracing/user_events: Store register flags on events
  tracing/user_events: Track refcount consistently via put/get
  tracing/user_events: Add auto cleanup and a flag to persist events
  tracing/user_events: Add self-test for persist flag
  tracing/user_events: Add persist flag documentation

 Documentation/trace/user_events.rst           |  21 +-
 include/uapi/linux/user_events.h              |  10 +-
 kernel/trace/trace_events_user.c              | 184 ++++++++++++++----
 .../testing/selftests/user_events/abi_test.c  | 144 +++++++++++++-
 .../selftests/user_events/ftrace_test.c       |   1 +
 5 files changed, 309 insertions(+), 51 deletions(-)


base-commit: 3862f86c1529fa0016de6344eb974877b4cd3838
-- 
2.25.1

