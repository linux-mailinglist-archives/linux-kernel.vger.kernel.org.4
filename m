Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CFA6105DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiJ0WkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbiJ0WkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:40:17 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAD8D5B116;
        Thu, 27 Oct 2022 15:40:15 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7DE03210DD47;
        Thu, 27 Oct 2022 15:40:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7DE03210DD47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666910414;
        bh=D2RlgsI3bqXn1gR+DmTQa4Lc/lUwksa1OAu9iCgD4uI=;
        h=From:To:Cc:Subject:Date:From;
        b=Q/gKcrNrerr5vo9imqtDDP6m1pWvmalFGmS6kG0R+1mJoyHzyL+3zUHVPtLyNfQm/
         tUpiqtZzywZ2QdjoCkAHb0uMv4F/6XrMYZHCr2JbRVsvZkde0SZHpBBRLHBQ/qICW4
         uNcNyOolDF/Z4tsMh9aYt8yBAuti+TjM8wVbqcLs=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] tracing/user_events: Remote write ABI
Date:   Thu, 27 Oct 2022 15:40:09 -0700
Message-Id: <20221027224011.2075-1-beaub@linux.microsoft.com>
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

As part of the discussions for user_events aligned with user space
tracers, it was determined that user programs should register a 32-bit
value to set or clear a bit when an event becomes enabled. Currently a
shared page is being used that requires mmap().

In this new model during the event registration from user programs 2 new
values are specified. The first is the address to update when the event
is either enabled or disabled. The second is the bit to set/clear to
reflect the event being enabled. This allows for a local 32-bit value in
user programs to support both kernel and user tracers. As an example,
setting bit 31 for kernel tracers when the event becomes enabled allows
for user tracers to use the other bits for ref counts or other flags.
The kernel side updates the bit atomically, user programs need to also
update these values atomically.

User provided addresses must be aligned on a 32-bit boundary, this
allows for single page checking and prevents odd behaviors such as a
32-bit value straddling 2 pages instead of a single page.

When page faults are encountered they are done asyncly via a workqueue.
If the page faults back in, the write update is attempted again. If the
page cannot fault-in, then we log and wait until the next time the event
is enabled/disabled. This is to prevent possible infinite loops resulting
from bad user processes unmapping or changing protection values after
registering the address.

NOTE:
User programs that wish to have the enable bit shared across forks
either need to use a MAP_SHARED allocated address or register a new
address and file descriptor. If MAP_SHARED cannot be used or new
registrations cannot be done, then it's allowable to use MAP_PRIVATE
as long as the forked children never update the page themselves. Once
the page has been updated, the page from the parent will be copied over
to the child. This new copy-on-write page will not receive updates from
the kernel until another registration has been performed with this new
address.

Beau Belgrave (2):
  tracing/user_events: Use remote writes for event enablement
  tracing/user_events: Fixup enable faults asyncly

 include/linux/user_events.h      |  10 +-
 kernel/trace/trace_events_user.c | 396 ++++++++++++++++++++-----------
 2 files changed, 270 insertions(+), 136 deletions(-)


base-commit: 23758867219c8d84c8363316e6dd2f9fd7ae3049
-- 
2.25.1

