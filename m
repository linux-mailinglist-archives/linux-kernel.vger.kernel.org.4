Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C877644611
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiLFOtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiLFOs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:48:58 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513791C905;
        Tue,  6 Dec 2022 06:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670338083; x=1701874083;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KreZWgqbUXWkBrewyIR53/0zjeTOrsKtsjVNswAQ4+M=;
  b=gewnhYgIjmkvaMQV/SOg+23XSDCu5yey/MzBSE73obvQcqdHjO9+aoRy
   SKIQsFIiBEEalOEU47Vlx91n2GlqwIanwlFcyEF87JiNJQPNeW89BZvhG
   qEwgdFGJSDjmoArwZc9x81jCf0qd5nSxxfsxjgQ0SiqXYFxm7Ugn4EgZD
   7UxO2FzP2VZtb9Wirn7K4HMaAhDHWrETRek2ygENz+DZ+aC71vKAixXsv
   CMt/HhO9OkMLtI04wib934uXKg+c61R9MPTpP7gwSnRJRgI23WlFBfqhL
   Ib470PXDu3CQ286i1sLNeaczXVsRkV/W1bTFym7kIUkZDzfAxyAvadnUb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="296329735"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="296329735"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 06:48:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="639897403"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="639897403"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 06 Dec 2022 06:48:02 -0800
Received: from [10.252.209.31] (kliang2-mobl1.ccr.corp.intel.com [10.252.209.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8BF40580D54;
        Tue,  6 Dec 2022 06:47:59 -0800 (PST)
Message-ID: <529367b6-e96a-d030-b8a2-bb4ad3d37d90@linux.intel.com>
Date:   Tue, 6 Dec 2022 09:47:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 0/2] perf test: Add event group test
Content-Language: en-US
To:     Ravi Bangoria <ravi.bangoria@amd.com>, acme@kernel.org
Cc:     irogers@google.com, jolsa@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        carsten.haitzler@arm.com, leo.yan@linaro.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        tmricht@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
References: <20221206043237.12159-1-ravi.bangoria@amd.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20221206043237.12159-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-12-05 11:32 p.m., Ravi Bangoria wrote:
> Multiple events in a group can belong to one or more pmus, however
> there are some limitations to it. One of the limitation is, perf
> doesn't allow creating a group of events from different hw pmus.
> Write a simple test to create various combinations of hw, sw and
> uncore pmu events and verify group creation succeeds or fails as
> expected.
> 
> v2: https://lore.kernel.org/r/20221129111946.409-1-ravi.bangoria@amd.com
> v2->v3:
>  - Define a set of uncore pmus that supports more than 3 events. This
>    will prevent false negative results by not picking random uncore
>    pmu. Test will be skipped if no uncore pmu found.
> 
> Ravi Bangoria (2):
>   perf tool: Move pmus list variable to new a file

a new file

Other than the above typo, the patch series looks good to me.

Acked-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

>   perf test: Add event group test
> 
>  tools/perf/tests/Build          |   1 +
>  tools/perf/tests/builtin-test.c |   1 +
>  tools/perf/tests/event_groups.c | 127 ++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h        |   1 +
>  tools/perf/util/Build           |   1 +
>  tools/perf/util/pmu.c           |   2 +-
>  tools/perf/util/pmus.c          |   5 ++
>  tools/perf/util/pmus.h          |   9 +++
>  8 files changed, 146 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/tests/event_groups.c
>  create mode 100644 tools/perf/util/pmus.c
>  create mode 100644 tools/perf/util/pmus.h
> 
