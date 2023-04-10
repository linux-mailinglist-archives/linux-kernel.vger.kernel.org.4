Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F99F6DC2FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 05:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDJDiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 23:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDJDiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 23:38:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F126269D;
        Sun,  9 Apr 2023 20:38:11 -0700 (PDT)
Received: from kwepemm600006.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pvvj35wCYzSrPg;
        Mon, 10 Apr 2023 11:34:15 +0800 (CST)
Received: from [10.174.177.30] (10.174.177.30) by
 kwepemm600006.china.huawei.com (7.193.23.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 11:38:07 +0800
Message-ID: <edec17ee-2a10-bdb1-a021-180831bbc57c@huawei.com>
Date:   Mon, 10 Apr 2023 11:38:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] perf top: expand the range of multithreaded phase
To:     Hangliang Lai <laihangliang1@huawei.com>, <namhyung@kernel.org>
CC:     <acme@kernel.org>, <adrian.hunter@intel.com>,
        <alexander.shishkin@linux.intel.com>, <brauner@kernel.org>,
        <hewenliang4@huawei.com>, <irogers@google.com>, <jolsa@kernel.org>,
        <linfeilong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <mark.rutland@arm.com>,
        <mingo@redhat.com>, <yeyunfeng@huawei.com>
References: <CAM9d7cgK-P5KuDy7hkAR4j7oB4ydE6Mw3KexqgwPPhJF6MKtXQ@mail.gmail.com>
 <20230410025808.2008-1-laihangliang1@huawei.com>
From:   "Wenyu Liu(D)" <liuwenyu7@huawei.com>
In-Reply-To: <20230410025808.2008-1-laihangliang1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.30]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600006.china.huawei.com (7.193.23.105)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello，I think Namhyung means only make it multi-threaded unconditionally after the synthesize

a patch like this:

---
 tools/perf/builtin-top.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d4b5b02bab73..60d00975b881 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1273,8 +1273,7 @@ static int __cmd_top(struct perf_top *top)
                                    top->evlist->core.threads, true, false,
                                    top->nr_threads_synthesize);

-       if (top->nr_threads_synthesize > 1)
-               perf_set_singlethreaded();
+       perf_set_multithreaded();

        if (perf_hpp_list.socket) {
                ret = perf_env__read_cpu_topology_map(&perf_env);
--

Right?

Thanks,
Wenyu

在 2023/4/10 10:58, Hangliang Lai 写道:
> Thanks for your reply Kim ,
> 
> 
> 
> On 2023-04-07 21:21   you  wrote:
> 
> 
> 
>>  Not always, the synthesis can run in a single thread.
> 
> 
> 
> But I think in machine__synthesize_threads, there are thread_nr threads will be created to do synthesize_threads_worker(tools/perf/util/synthetic-events.c:970)
> 
> 
> 
> It’s not a single thread part. So we're supposed to call perf_set_multithreaded() before synthesize?
> 
> 
> 
> Thanks,
> 
> Hangliang Lai
> 
> 
> 
