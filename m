Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCAB69FFD1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 00:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjBVX7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 18:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjBVX7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 18:59:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987C0193F6;
        Wed, 22 Feb 2023 15:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677110378; x=1708646378;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dzn8kdgfc75h4WU/vsEQnFls4iq/wpJtVzCqyEFGffQ=;
  b=TTLTqDlm0bQ9krFyq5PNwikUJSxx0JXJH+SzroiIOgJh9QJU6ADn2Jfy
   T56M0vKz+nrUIouHgEOkYgCUcDZjyrKu7SV+/zjsHtuDc82j4Sfn0paXb
   ljID/yqD68xNSIJJBnuU4FHX93zav58D7VMWiYWRU4NWLsmKVaiyM+nqT
   TeNLw9vsEWagvIhT+cc+GMqHRanKJcKW48XQkPeS+0OMKi5JkWdMTya90
   MtkQV9CKD9SpAlE2wzgDm9i3sgvLezOyXlFLl41f+1Cg34x8k59HvNWb/
   b17XviimZDGh/UW15mbCJdc4XEHpm3YW1qPS75hzysmb1wptowNr+UT6L
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419297070"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="419297070"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 15:59:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="672259748"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="672259748"
Received: from bpindjur-mobl1.amr.corp.intel.com (HELO [10.209.84.109]) ([10.209.84.109])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 15:59:24 -0800
Message-ID: <9485dc39-ab09-b929-9f22-ebc6a5b01a43@intel.com>
Date:   Wed, 22 Feb 2023 15:59:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/7] platform/x86/intel/ifs: Implement Array BIST test
Content-Language: en-US
To:     "Joseph, Jithu" <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230214234426.344960-5-jithu.joseph@intel.com>
 <a24c65f8-978d-8968-7874-6b83e14b01ba@intel.com>
 <d9d18954-8434-4c85-88b8-8e1d99cd6a4b@intel.com>
 <dd501d6a-e7e9-be82-24fb-33b18fb6192b@intel.com>
 <b67d2125-4075-4eac-4cad-8e315b866144@intel.com>
 <5d57f42a-1bfc-5e6a-bb49-556ecb7402af@intel.com>
 <9c55a34b-c17e-2a62-9989-902ce940dde5@intel.com>
 <42ac85ea-0ffe-55fc-57c2-6f4555e8dc5b@intel.com>
 <8fb5ebbf-d468-169d-5603-b267e7b42516@intel.com>
 <82a6f9b2-bb17-babd-fbe0-c4a5bec1203b@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <82a6f9b2-bb17-babd-fbe0-c4a5bec1203b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 15:32, Joseph, Jithu wrote:
> On 2/22/2023 2:28 PM, Dave Hansen wrote:
>> On 2/22/23 14:07, Joseph, Jithu wrote:
>>> Since the trace has to be explicitly enabled (I thought it is okay to
>>> add a more convenient custom one only to be enabled for detailed
>>> analysis when required).
>> 	man perf-script
>>
>> You should be able to write one to do exactly what you need in about 10
>> minutes.  No new tracepoints, no new kernel code to maintain.  Knock
> Thanks for the pointers. I gather that user level tools might be able to format the
> msr trace output in a more convenient way (perhaps as generated by the custom driver trace)
> 
> There is still the other convenience of not having to look-up the
> MSRs addresses corresponding to all the individual tests and setting the filter on them to
> analyze IFS test activity (rather than enabling it via echo 1 > /sys/kernel/debug/tracing/events/intel_ifs/enable)

Jithu, the perf-script tooling that I suggested wraps can abstract away
the sysfs interface.  I suspect you might also have discovered this in
the process of exploring my (and others') suggestions.

Please go invest some time there.  Feel free to come back to this thread
if you get stuck or have done your due diligence exhausted the
userspace-only path.


