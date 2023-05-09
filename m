Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1BA6FC62F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjEIMW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjEIMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:22:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8B1F40DB;
        Tue,  9 May 2023 05:22:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9919FEC;
        Tue,  9 May 2023 05:23:39 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 948BE3F67D;
        Tue,  9 May 2023 05:22:52 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, lukasz.luba@arm.com,
        qyousef@google.com, qyousef@layalina.io
Subject: [PATCH v2 0/3] Add basic tracing for uclamp and schedutil
Date:   Tue,  9 May 2023 13:22:43 +0100
Message-Id: <20230509122246.1702397-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The task scheduler feature: Uclamp, begins to take off. To better understand
the dynamics in the task scheduler and CPU frequency requests we need some
better tracing.
In schedutil (cpufreq governor) we allow to enter the scheduler
and make the frequency change. Although, there is some limit in regards to how
often this can happen. That min period is provided by the cpufreq driver.
Thus, some of the cpufreq requests might be filter out and the frequency won't
be changed (hopefuly will be set a bit later). We would like to know about
those situations, especially in context of the user-space hints made via
Uclamp for particular tasks.
This patch set aims to add base for our toolkits and post-processing trace
analyzes.

Changelog:
v2:
- solved the issue from CI build warning, dropped schedutil.h and re-used
  the sched.h which is available in build_utility.c where cpufreq_schedutil.c
  is included
- added tag for the last patch 3/3 for the CI robot helping hend 
- re-based on top of v6.4-rc1
v1:
- implementation can be found here [1]


Regards,
Lukasz Luba

[1] https://lore.kernel.org/lkml/20230322151843.14390-1-lukasz.luba@arm.com/

Lukasz Luba (3):
  sched/tp: Add new tracepoint to track uclamp set from user-space
  cpufreq: schedutil: Refactor sugov_update_shared() internals
  schedutil: trace: Add tracing to capture filter out requests

 include/trace/events/sched.h     |  8 ++++++++
 kernel/sched/core.c              |  5 +++++
 kernel/sched/cpufreq_schedutil.c | 28 ++++++++++++++++++----------
 3 files changed, 31 insertions(+), 10 deletions(-)

-- 
2.25.1

