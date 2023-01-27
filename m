Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E7467E84F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjA0OcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjA0Ob6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:31:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2A8582400;
        Fri, 27 Jan 2023 06:31:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 680962B;
        Fri, 27 Jan 2023 06:32:35 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC4E73F5A1;
        Fri, 27 Jan 2023 06:31:51 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, peterz@infradead.org,
        ravi.bangoria@amd.com
Cc:     James Clark <james.clark@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] perf: Fix warning from concurrent read/write of perf_event_pmu_context
Date:   Fri, 27 Jan 2023 14:31:40 +0000
Message-Id: <20230127143141.1782804-1-james.clark@arm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Ravi,

I came across this issue, and I also found there was a syzbot report
for it and linked it on the commit. I have one question about the fix,
where I had to remove the if (epc->ctx) from put_pmu_ctx(). I assume
this was added for a reason, but I can't see where it's not ever set?
Unless it's removed, the function got a lot more complicated to take
the lock before the reference decrement.

Also now I think the atomic type for epc->refcount is redundant,
because everything is always done with the lock held. Except for
get_pmu_ctx(), but that is just a read for a warning. So unless you
think the scope of my extra locking can be reduced, I would probably
also send a commit to remove that as well.

Thanks
James

James Clark (1):
  perf: Fix warning from concurrent read/write of perf_event_pmu_context

 kernel/events/core.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)


base-commit: 5912e15f25d6d584f3b8449e0b6a244a0f4f0903
-- 
2.39.1

