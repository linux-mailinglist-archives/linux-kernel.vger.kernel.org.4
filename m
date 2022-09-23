Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC35E77BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiIWJ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiIWJzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:55:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B573EC55B;
        Fri, 23 Sep 2022 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663926950; x=1695462950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MPHqXwksq4J1qC76n9VZiNFGed5T6WrJ0pWiayAQgBA=;
  b=AZoGuL43eRQNuVRmtInqz/7ynD/PqIecdLIIij7qlI3Y4pZ9KYjzTCqU
   zQMEoXReLHWNbfzECV6TqTo+n7o80/8wamT3xDHwJClm3gIrVHKwHuz8N
   94Qwj1QwMtubHS1rxz4Gft2ol8BNryw/b732iDL4EQoqqzmKZzOZZdkLR
   vczSjqPLZspEXFglyfqoF/+lf2HHLhx82yrsMDpPhoRL9ylXwDdWgExmL
   hvPN0apmxYc7b5rhRBR1tPP3grChz7xTbsUqHO1P4Fw0uSVWzc+fak9QK
   RtiCRwTG8Q7LhBSuFVp0mREBd2PmbL9kBqaCdUrvYcbgnfTqRBvnAEP+3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="299278952"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="299278952"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 02:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="745741798"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Sep 2022 02:55:45 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obfPM-0005YO-0r;
        Fri, 23 Sep 2022 09:55:44 +0000
Date:   Fri, 23 Sep 2022 17:55:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v4 25/25] tracing/rseq: Add mm_vcpu_id field to
 rseq_update
Message-ID: <202209231723.5HqjA1Iy-lkp@intel.com>
References: <20220922105941.237830-26-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922105941.237830-26-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

I love your patch! Yet something to improve:

[auto build test ERROR on rostedt-trace/for-next]
[cannot apply to shuah-kselftest/next tip/sched/core kees/for-next/execve linus/master v6.0-rc6 next-20220921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Desnoyers/RSEQ-node-id-and-virtual-cpu-id-extensions/20220922-191315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220923/202209231723.5HqjA1Iy-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1e36316a4b14e773e904e677149f9f757057fd90
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mathieu-Desnoyers/RSEQ-node-id-and-virtual-cpu-id-extensions/20220922-191315
        git checkout 1e36316a4b14e773e904e677149f9f757057fd90
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/rseq.c:19:
   In file included from include/trace/events/rseq.h:62:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:419:
>> include/trace/events/rseq.h:26:28: error: no member named 'mm_vcpu' in 'struct task_struct'
                   __entry->mm_vcpu_id = t->mm_vcpu;
                                         ~  ^
   include/trace/stages/stage6_event_callback.h:112:33: note: expanded from macro 'TP_fast_assign'
   #define TP_fast_assign(args...) args
                                   ^~~~
   include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
                                PARAMS(assign),                   \
                                       ^~~~~~
   include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
   #define PARAMS(args...) args
                           ^~~~
   include/trace/trace_events.h:402:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
           { assign; }                                                     \
             ^~~~~~
   In file included from kernel/rseq.c:19:
   In file included from include/trace/events/rseq.h:62:
   In file included from include/trace/define_trace.h:103:
   In file included from include/trace/perf.h:113:
>> include/trace/events/rseq.h:26:28: error: no member named 'mm_vcpu' in 'struct task_struct'
                   __entry->mm_vcpu_id = t->mm_vcpu;
                                         ~  ^
   include/trace/stages/stage6_event_callback.h:112:33: note: expanded from macro 'TP_fast_assign'
   #define TP_fast_assign(args...) args
                                   ^~~~
   include/trace/trace_events.h:44:16: note: expanded from macro 'TRACE_EVENT'
                                PARAMS(assign),                   \
                                       ^~~~~~
   include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
   #define PARAMS(args...) args
                           ^~~~
   include/trace/perf.h:89:4: note: expanded from macro 'DECLARE_EVENT_CLASS'
           { assign; }                                                     \
             ^~~~~~
   2 errors generated.


vim +26 include/trace/events/rseq.h

    12	
    13		TP_PROTO(struct task_struct *t),
    14	
    15		TP_ARGS(t),
    16	
    17		TP_STRUCT__entry(
    18			__field(s32, cpu_id)
    19			__field(s32, node_id)
    20			__field(s32, mm_vcpu_id)
    21		),
    22	
    23		TP_fast_assign(
    24			__entry->cpu_id = raw_smp_processor_id();
    25			__entry->node_id = cpu_to_node(raw_smp_processor_id());
  > 26			__entry->mm_vcpu_id = t->mm_vcpu;
    27		),
    28	
    29		TP_printk("cpu_id=%d node_id=%d mm_vcpu_id=%d", __entry->cpu_id,
    30			  __entry->node_id, __entry->mm_vcpu_id)
    31	);
    32	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
