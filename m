Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2725D6D9CB2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbjDFPuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238941AbjDFPut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:50:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBE169ECB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:50:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92EE4169E;
        Thu,  6 Apr 2023 08:51:28 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C6C723F6C4;
        Thu,  6 Apr 2023 08:50:42 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] sched: Consider CPU contention in frequency & load-balance busiest CPU selection
Date:   Thu,  6 Apr 2023 17:50:29 +0200
Message-Id: <20230406155030.1989554-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the implementation of the idea to factor in root cfs_rq
runnable_avg as a way to consider CPU contention for CPU frequency and
`migrate_util` type load-balance busiest CPU selection.

Discussion happened under:
https://lkml.kernel.org/r/424e2c81-987d-f10e-106d-8b4c611768bc@arm.com

Dietmar Eggemann (1):
  sched: Consider CPU contention in frequency & load-balance busiest CPU
    selection

 kernel/sched/cpufreq_schedutil.c |  3 ++-
 kernel/sched/fair.c              |  2 +-
 kernel/sched/sched.h             | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.25.1

