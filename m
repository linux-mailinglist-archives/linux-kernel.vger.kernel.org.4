Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA14B617BBC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiKCLik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKCLiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:38:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D4E12745
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:38:23 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N31rR3fD1zpWCM;
        Thu,  3 Nov 2022 19:34:47 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:38:21 +0800
Received: from huawei.com (10.67.174.191) by dggpeml500018.china.huawei.com
 (7.185.36.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 19:38:21 +0800
From:   Zhang Qiao <zhangqiao22@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <brauner@kernel.org>,
        <yusongping@huawei.com>, Zhang Qiao <zhangqiao22@huawei.com>
Subject: [PATCH v2 0/2] sched: sched_fork() optimizations
Date:   Thu, 3 Nov 2022 20:07:18 +0800
Message-ID: <20221103120720.39873-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_fork() use the current cpu init the new task's vruntime,
but the new task maybe not run on this cpu. so this patchset will
fix the problem.

Zhang Qiao (2):
  sched: Init new task's vruntime after select cpu
  sched: Fix sched_child_runs_first

 kernel/sched/core.c |  7 ++++++-
 kernel/sched/fair.c | 11 ++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.17.1

