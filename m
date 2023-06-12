Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D600672BF5D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbjFLKmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjFLKmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:42:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0228231;
        Mon, 12 Jun 2023 03:26:27 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qfnrk72zNzTl2n;
        Mon, 12 Jun 2023 18:25:42 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 18:26:10 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
Subject: [RFC] Adding support for setting the affinity of the recording
 process
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Yang Jihong <yangjihong1@huawei.com>
Message-ID: <159de73b-fdd6-6df8-4f77-73c628fe641f@huawei.com>
Date:   Mon, 12 Jun 2023 18:26:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Currently, perf-record supports profiling an existing process, thread, 
or a specified command.

Sometimes we may need to set CPU affinity of the target process before 
recording:

   # taskset -pc <cpus> <pid>
   # perf record -p <pid> -- sleep 10

or:

   # perf record -- `taskset -c <cpus> COMMAND`

I'm thinking about getting perf to support setting the affinity of the 
recording process, for example:

1. set the CPU affinity of the <pid1> process to <cpus1>, <pid2> process 
to <cpus2>,  and record:

   # perf record -p <pid1>/<cpus1>:<pid2>/<cpus2> -- sleep 10

and

2. set CPU affinity of the COMMAND and record:

   # perf record --taskset-command <cpus> COMMAND

In doing so, perf, as an observer, actually changes some of the 
properties of the target process, which may be contrary to the purpose 
of perf tool.


Will we consider accepting this approach?

Thanks,
Yang.
