Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244BA6E0F00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjDMNkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjDMNkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:40:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71F2B449;
        Thu, 13 Apr 2023 06:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681393049; x=1712929049;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0t90pzuQrjO2+T87L2ET36icPQMGNoD4iJaHuJhNMFs=;
  b=Lr4i9VEScYDusijg8IJSvNfqz98QijV6TWY5leSIp2GSCcBQi1HTkU/M
   uz/FE7jJv6iniUoWzzf0uzIKJ9ZyaVjKhGXmLTcuYT82a8I+1tdICMGe+
   wuuUgfQxYpylzjU2BH57S8MMw57uJSWi3F2E6sQRuNOMl4dH0HAGgHzs3
   kI20mxiG/+1F8y9Te9p0qXYQQGTKwu5V3NUdtauQCNWGUKH3H4EwaLe1r
   wXQGXQyfHhtxlBEDgbX/S4wiYwdcV1AYgAguXuvjZfXbImLp0YZSRbXBi
   N8HRuOElt10SwY4JKDQLD1TI55jClBbCrZcrwrbt2oav1K5LwrRqHtu9u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="407029602"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="407029602"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 06:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="753998249"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="753998249"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2023 06:15:08 -0700
Received: from [10.209.83.224] (kliang2-mobl1.ccr.corp.intel.com [10.209.83.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DC0785804FA;
        Thu, 13 Apr 2023 06:15:06 -0700 (PDT)
Message-ID: <2a6f6cf3-3de1-33e4-3b51-8c702c270bda@linux.intel.com>
Date:   Thu, 13 Apr 2023 09:15:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1] perf stat: Introduce skippable evsels
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230411205622.3266490-1-irogers@google.com>
 <aaa41580-e30a-5a3a-7917-042ddaffe9cf@linux.intel.com>
 <CAP-5=fUnqi3KCEzu8qC8qG+g__qTmCVzc9skNb5yFzz=Fa02QQ@mail.gmail.com>
 <87eb928a-9c66-f821-0f20-22d21c96b7a5@linux.intel.com>
 <CAP-5=fUELu6nT8sGjkPvzKOX2qxH-w9q5mJgsjLBoYwAQ5bP6Q@mail.gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUELu6nT8sGjkPvzKOX2qxH-w9q5mJgsjLBoYwAQ5bP6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-12 2:01 p.m., Ian Rogers wrote:
>> - We shouldn't only rely on the event list file. We need to do runtime
>> check on the availability of events. Either perf_event_open() or
>> /sys/devices/cpu/events/ is fine (althourh personally I prefer sys way,
>> since I think it's easier).
> Using perf_event_open is the status quo and the sysfs approach is
> impractical imo. I think the only thing that is needed in v2 is for
> <not counted> to be displayed for skippable evsels.

Using perf_event_open is good to check features. If the feature is not
supported by the kernel, it will be explicitly rejected.
But I'm not sure about the availability of events. The kernel doesn't
check every events. For example, on ICL and later platform, we have
event=0x00,umask=0x8X for all the topdown metrics events. If we open
them on SKL, the perf_event_open will also success, but return 0 value.

Thanks,
Kan
