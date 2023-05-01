Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D016F3B0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 01:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjEAXee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 19:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjEAXec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 19:34:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25261FCC;
        Mon,  1 May 2023 16:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682984071; x=1714520071;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q5lAfm4ntOimWR0yBsZWpkkaD5go1ON+6b95VO5UqNA=;
  b=KvRzz3A4zrEL8OIc8AIyF9JU6JaaKhtAa7LI8Yy+yEx5+e8YoZjAoH11
   HTnZEYhGuw9bcoeetaCb3TVo2q5kuJxfeqllRpTQh5pdGWkbd1POPkosr
   sGlZx05L0oWt9Nk/W61kiAmSyH+99cYuPxsx2O337EmCogPaiVf38OBTL
   3AyV3NecCdnKkEiPsi0ZByWr5n89umXMcrXAsSjx6UNc3hbpIRPckg7y/
   nbWQPUK8rkcLxeFaetT+vyEguh3/5pzkneG4i/K5f3tsBmszgcFmEnsP5
   mbH5vpRLvx3aHDHWBjmihdBip8VhC4Nr/y/QFBCq7sd4S1WbefH2y8y6P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="376319224"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="376319224"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 16:34:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="695961196"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="695961196"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 01 May 2023 16:34:30 -0700
Received: from [10.209.15.48] (kliang2-mobl1.ccr.corp.intel.com [10.209.15.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 38328580B0E;
        Mon,  1 May 2023 16:34:27 -0700 (PDT)
Message-ID: <e05361bd-ecb3-9a65-93d5-352b37c3f9bf@linux.intel.com>
Date:   Mon, 1 May 2023 19:34:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 03/46] perf stat: Introduce skippable evsels
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230429053506.1962559-1-irogers@google.com>
 <20230429053506.1962559-4-irogers@google.com>
 <d6784858-2a5f-7920-f1ac-d7ec9ed89605@linux.intel.com>
 <CAP-5=fUtgEvgburjhE6HpazDh9dtn=DiSOwHaVnoE3N7sBynEw@mail.gmail.com>
 <a7020f11-3915-58e9-9d9e-792672ecbd61@linux.intel.com>
 <CAP-5=fV326=0PLb+SZF3nFwQhXpdtMtk6KV+zZNEcs1erW9i1Q@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fV326=0PLb+SZF3nFwQhXpdtMtk6KV+zZNEcs1erW9i1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-01 4:48 p.m., Ian Rogers wrote:
> On Mon, May 1, 2023 at 1:25 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>> On 2023-05-01 11:29 a.m., Ian Rogers wrote:
>>> The events are displayed twice as there are 2 groups of events. This
>>> is changed by:
>>> https://lore.kernel.org/lkml/20230429053506.1962559-5-irogers@google.com/
>>> where the events are no longer grouped.
>> The trick seems don't work on a hybrid machine. I still got the
>> duplicate Topdown events on e-core.
> For hybrid the rest of the patch series is necessary, ie the patches
> beyond what's for 6.4, which I take from the output (ie not a crash)
> you are looking at. As multiple groups are in play then it looks like
> the atom events are on >1 PMU which can happen as the x86 code special
> cases events with topdown in their name. Some fixes in the series for
> this are:
> https://lore.kernel.org/lkml/20230429053506.1962559-6-irogers@google.com/
> https://lore.kernel.org/lkml/20230429053506.1962559-40-irogers@google.com/
> and related:
> https://lore.kernel.org/lkml/20230429053506.1962559-19-irogers@google.com/
> and so fixing this requires some detective work.
>

I applied all the patches of the series when I did the test on hybrid.
The above patches don't help.


> I don't think it should be a requirement for the series that all
> hybrid bugs are fixed - especially given the complaints against the
> length of the series as-is.

I agree especially considering the metrics have been broken on the
hybrid for a while.

I just want to do a complete test and understand what is going to fixed
and what hasn't.

Thanks,
Kan
