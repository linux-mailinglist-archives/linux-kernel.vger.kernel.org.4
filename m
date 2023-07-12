Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E218C750B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjGLOat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjGLOao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:30:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405AD1BDB;
        Wed, 12 Jul 2023 07:30:40 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R1Krp66GCz1JCXD;
        Wed, 12 Jul 2023 22:30:02 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 22:30:37 +0800
Subject: Re: [PATCH 1/5] perf evlist: Export perf_evlist__propagate_maps()
To:     Adrian Hunter <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <kan.liang@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <20230704074217.240939-1-yangjihong1@huawei.com>
 <20230704074217.240939-2-yangjihong1@huawei.com>
 <180925f8-57f3-c97a-15c4-db2c73abe4a2@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <a7480404-c6ad-8892-b9d2-d2458c2e686b@huawei.com>
Date:   Wed, 12 Jul 2023 22:30:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <180925f8-57f3-c97a-15c4-db2c73abe4a2@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/7/11 21:12, Adrian Hunter wrote:
> On 4/07/23 10:42, Yang Jihong wrote:
>> For dummy events that keep tracking, we may need to modify its cpu_maps.
>> For example, change the cpu_maps to track side-band events for all CPUS.
>> Export perf_evlist__propagate_maps () to support this scenario.
> 
> __perf_evlist__propagate_maps() is quite low-level so it would be better
> to avoid exporting it.
> 
> 
Or can we export it via internal/evlist.h?
Because as mentioned in patch 2:

void perf_evsel__go_system_wide(struct perf_evlist *evlist, struct 
perf_evsel *evsel)
{
if (!evsel->system_wide) {
evsel->system_wide = true;
if (evlist->needs_map_propagation)
__perf_evlist__propagate_maps(evlist, evsel);
}
}
This interface needs to invoke __perf_evlist__propagate_maps.

Thanks,
Yang
