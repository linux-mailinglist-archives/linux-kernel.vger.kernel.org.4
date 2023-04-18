Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833846E6613
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjDRNgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDRNgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:36:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41C8119;
        Tue, 18 Apr 2023 06:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681825008; x=1713361008;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=LnHhmuXGI0CClqpjUThEBNxCWaVO/ww+TLeqkhOZt5M=;
  b=ZnwbFSvbONA3RTOvKIG6cVXEWje0vZ1g96zFp+E+lRGuRaezphSOjJir
   EaizJ/609K0xDF1FaFIS8yrabXAOEPWecLVgwrAXOJQAvibKFaSNkJ1mx
   WSgBsqe5sWEtNDUfV1u3HIK0Y3hnBEBB5CENNoP8kORuMxHoSfm2zbP/r
   hoKLHS+exiCkmYiFd9sR3e4D/VLchChAQ7+XK/n2pQ1DAx1n+XLftyDR2
   5B7LHB/yCZRjEoFa/AhsUozIk6YrxHk+bcekBCzuaMPkZhzXg75dyb2lM
   C1sO1BXXOZ9JfbJiCGmapZgpxB0Efv9YodTshkL7odN8KDl0JLDsz2KGK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="347018434"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="347018434"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 06:36:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="691089280"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="691089280"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.90])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 06:36:20 -0700
Message-ID: <d7d6cbc8-1f5f-d0f4-6656-f0cc8ab3a118@intel.com>
Date:   Tue, 18 Apr 2023 16:36:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 0/5] perf: Add ioctl to emit sideband events
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230414082300.34798-1-adrian.hunter@intel.com>
 <20230417110221.GH83892@hirez.programming.kicks-ass.net>
 <89733d35-0b71-615f-4fb8-55183585c67a@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <89733d35-0b71-615f-4fb8-55183585c67a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/23 09:18, Adrian Hunter wrote:
> On 17/04/23 14:02, Peter Zijlstra wrote:
>> On Fri, Apr 14, 2023 at 11:22:55AM +0300, Adrian Hunter wrote:
>>> Hi
>>>
>>> Here is a stab at adding an ioctl for sideband events.
>>>
>>> This is to overcome races when reading the same information
>>> from /proc.
>>
>> What races? Are you talking about reading old state in /proc the kernel
>> delivering a sideband event for the new state, and then you writing the
>> old state out?
>>
>> Surely that's something perf tool can fix without kernel changes?
> 
> Yes, and it was a bit of a brain fart not to realise that.
> 
> There may still be corner cases, where different kinds of events are
> interdependent, perhaps NAMESPACES events vs MMAP events could
> have ordering issues.
> 
> Putting that aside, the ioctl may be quicker than reading from
> /proc.  I could get some numbers and see what people think.
> 

Here's a result with a quick hack to use the ioctl but without
handling the buffer becoming full (hence the -m4M)

# ps -e | wc -l
1171
# perf.old stat -- perf.old record -o old.data --namespaces -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.095 MB old.data (100 samples) ]

 Performance counter stats for 'perf.old record -o old.data --namespaces -a true':

            498.15 msec task-clock                       #    0.987 CPUs utilized             
               126      context-switches                 #  252.935 /sec                      
                64      cpu-migrations                   #  128.475 /sec                      
              4396      page-faults                      #    8.825 K/sec                     
        1927096347      cycles                           #    3.868 GHz                       
        4563059399      instructions                     #    2.37  insn per cycle            
         914232559      branches                         #    1.835 G/sec                     
           6618052      branch-misses                    #    0.72% of all branches           
        9633787105      slots                            #   19.339 G/sec                     
        4394300990      topdown-retiring                 #     38.8% Retiring                 
        3693815286      topdown-bad-spec                 #     32.6% Bad Speculation          
        1692356927      topdown-fe-bound                 #     14.9% Frontend Bound           
        1544151518      topdown-be-bound                 #     13.6% Backend Bound            

       0.504636742 seconds time elapsed

       0.158237000 seconds user
       0.340625000 seconds sys

# perf.old stat -- perf.new record -o new.data -m4M --namespaces -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.095 MB new.data (103 samples) ]

 Performance counter stats for 'perf.new record -o new.data -m4M --namespaces -a true':

            386.61 msec task-clock                       #    0.988 CPUs utilized             
               100      context-switches                 #  258.658 /sec                      
                65      cpu-migrations                   #  168.128 /sec                      
              4935      page-faults                      #   12.765 K/sec                     
        1495905137      cycles                           #    3.869 GHz                       
        3647660473      instructions                     #    2.44  insn per cycle            
         735822370      branches                         #    1.903 G/sec                     
           5765668      branch-misses                    #    0.78% of all branches           
        7477722620      slots                            #   19.342 G/sec                     
        3415835954      topdown-retiring                 #     39.5% Retiring                 
        2748625759      topdown-bad-spec                 #     31.8% Bad Speculation          
        1221594670      topdown-fe-bound                 #     14.1% Frontend Bound           
        1256150733      topdown-be-bound                 #     14.5% Backend Bound            

       0.391472763 seconds time elapsed

       0.141207000 seconds user
       0.246277000 seconds sys

# ls -lh old.data
-rw------- 1 root root 1.2M Apr 18 13:19 old.data
# ls -lh new.data
-rw------- 1 root root 1.2M Apr 18 13:19 new.data
# 

