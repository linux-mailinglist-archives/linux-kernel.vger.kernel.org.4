Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BE46009E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJQJHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJQJHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:07:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B44ECC8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:07:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2882C1042;
        Mon, 17 Oct 2022 02:07:57 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49EB23F792;
        Mon, 17 Oct 2022 02:07:50 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, mhiramat@kernel.org, rostedt@goodmis.org
Subject: [PATCH] tracing: fix dynevent test requirements
Date:   Mon, 17 Oct 2022 10:07:41 +0100
Message-Id: <20221017090741.2881918-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a couple of dynevent tests will always report UNSUPPORTED and
not run, even when support is actually present.

In commit:

  95c104c378dc7d4c ("tracing: Auto generate event name when creating a group of events")

The README text for synthetic events was changed from:

  "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]\n"

To:

  "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]\n"

... but the dynevent selftests were not updated accodingly, and still
search for the old text in their "requires" lines. Consequently, they
fail to match the new text, and the tests report the feature is
UNSUPPORTED.

For example:

| # ./ftracetest -vv test.d/dynevent/test_duplicates.tc
| === Ftrace unit tests ===
| [1] Generic dynamic event - check if duplicate events are caughtRequired feature pattern "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]" is not in README.
|         [UNSUPPORTED]
|
|
| # of passed:  0
| # of failed:  0
| # of unresolved:  0
| # of untested:  0
| # of unsupported:  1
| # of xfailed:  0
| # of undefined(test bug):  0

Update the patterns to match, allowing the tests to run:

| # ./ftracetest -vv test.d/dynevent/test_duplicates.tc
| === Ftrace unit tests ===
| [1] Generic dynamic event - check if duplicate events are caught
|         [PASS]
|
|
| # of passed:  1
| # of failed:  0
| # of unresolved:  0
| # of untested:  0
| # of unsupported:  0
| # of xfailed:  0
| # of undefined(test bug):  0

Fixes: 95c104c378dc7d4c ("tracing: Auto generate event name when creating a group of events")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 .../testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc | 2 +-
 .../test.d/trigger/inter-event/trigger-synthetic-eprobe.tc      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
index db522577ff78..d3a79da215c8 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - check if duplicate events are caught
-# requires: dynamic_events "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]":README
+# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README
 
 echo 0 > events/enable
 
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc
index 914fe2e5d030..6461c375694f 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger eprobe on synthetic event
-# requires: dynamic_events synthetic_events events/syscalls/sys_enter_openat/hist "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]":README
+# requires: dynamic_events synthetic_events events/syscalls/sys_enter_openat/hist "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README
 
 echo 0 > events/enable
 
-- 
2.30.2

