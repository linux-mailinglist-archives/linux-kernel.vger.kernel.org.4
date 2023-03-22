Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8F96C4F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjCVPUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjCVPUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:20:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEAAA5A900;
        Wed, 22 Mar 2023 08:20:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 820C84B3;
        Wed, 22 Mar 2023 08:20:55 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.18.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D02B43F71E;
        Wed, 22 Mar 2023 08:20:08 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, lukasz.luba@arm.com,
        qyousef@google.com
Subject: [PATCH 0/3] Add basic tracing for uclamp and schedutil
Date:   Wed, 22 Mar 2023 15:18:40 +0000
Message-Id: <20230322151843.14390-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Regards,
Lukasz Luba

Lukasz Luba (3):
  sched/tp: Add new tracepoint to track uclamp set from user-space
  cpufreq: schedutil: Refactor sugov_update_shared() internals
  schedutil: trace: Add tracing to capture filter out requests

 include/trace/events/sched.h     |  4 ++++
 include/trace/events/schedutil.h | 17 +++++++++++++++++
 kernel/sched/core.c              |  5 +++++
 kernel/sched/cpufreq_schedutil.c | 32 ++++++++++++++++++++++----------
 4 files changed, 48 insertions(+), 10 deletions(-)
 create mode 100644 include/trace/events/schedutil.h

-- 
2.17.1

