Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7905737489
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjFTStu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFTSts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:49:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12FA10D2;
        Tue, 20 Jun 2023 11:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687286987; x=1718822987;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=2VTUK7nm4L86J0ChS5nWzO/TEZA/KQ39NLw+1gGs1S8=;
  b=Uk1yLA447flbE+FWUm+30E2UmM6nWDEMdKv4psn9G7huv6hU2fuZ/Xh5
   UnbJyIGa1NKxs5Hv22LaSDob4eQwX8DJj9AcqT+/JffK0wimXgrBMp7bS
   jGt2HcGMx/53iLjFFv7BIcmW1XFXFaiYNdijTphLM2pFx07Cj9kXjLo16
   PbAhWXLn2kLnul6xofzwQfEjOppBV5IWgZE8950sM95yufEkxaOJ0AZH/
   /bYXaIu3EyjbD0lqn0MBPF3KDJCfQHTvKgnlT/hB5Ky0s6RDrsz/JNHch
   vhd2LixVwyRwtyZtuDrSnsLUWodM11TdWAyeQnD2DGa6PLASlTfxeelfk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="389287361"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="389287361"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 11:49:24 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="748247051"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="748247051"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.49])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 11:49:19 -0700
Message-ID: <f5b4e1e4-9966-c22a-1628-b3df37523841@intel.com>
Date:   Tue, 20 Jun 2023 21:49:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] perf/core: deliver PERF_RECORD_COMM and
 PERF_RECORD_MMAP side-band events to all online cpus
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230620155515.101222-1-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230620155515.101222-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/23 18:55, Yang Jihong wrote:
> Tasks are migrated between cores due to scheduling.
> If perf samples specified CPUs, PERF_RECORD_COMM and PERF_RECORD_MMAP
> events need be deliver to all cores to avoids the problem that the comm
> and symbols cannot be parsed due to task migration to the target core.
> 
> The specific scenarios are as follows:
> 
>          CPU0                                 CPU1
>   perf record -C 0 start
>                               taskA starts to be created and executed
>                                 -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>                                    events only deliver to CPU1
>                               ......
>                                 |
>                           migrate to CPU0
>                                 |
>   Running on CPU0    <----------/
>   ...
> 
>   perf record -C 0 stop
> 
> Now perf samples the PC of taskA. However, perf does not record the
> PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
> Therefore, the comm and symbols of taskA cannot be parsed.

perf record deals with this for PERF_RECORD_TEXT_POKE, by opening
the corresponding "dummy" event on each CPU irrespective of whether
the main events are on selected CPUs.  Refer
evlist__add_dummy_on_all_cpus().

So this could be handled by perf record.

> 
> Yang Jihong (2):
>   perf/core: perf_iterate_sb_cpu() supports to receive side-band events
>     for all oneline cpus
>   perf/core: deliver PERF_RECORD_COMM and PERF_RECORD_MMAP side-band
>     events to all online cpus
> 
>  kernel/events/core.c | 58 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 17 deletions(-)
> 

