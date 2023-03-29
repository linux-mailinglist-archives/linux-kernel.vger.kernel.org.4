Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714F06CCED6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 02:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjC2Aff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 20:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC2Afd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 20:35:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192FD1BCA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 17:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680050132; x=1711586132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j26AOijIMhdyBYYxEn0cgdPK8sTTQok3Z5F0i4RtAqU=;
  b=PtcImknaBxdIfVPU/7DdWviZZLTsz766OcnqQi5J/QxdBHWPaBk6kV5e
   9dn7Ixa+xK0RKMf0HA6y8CRW+3iAaOFwlEmEn3F0TQbx5mEF+L6oOx5dt
   Gfoyq6Lk0M1CcEBqSIAB1YbEqZ7iz71sM2vMlvKJS3i1y0N/WgmJ2A7Wo
   +cEWfmk8e1UIlxH1No6kWkDiF5XlzyFliUHLdZezzdGKufqZHFyMi13HR
   xSxbQv+n9YLIpQzxnExe12kbch9EB+0m43lN8L0bFO7Qk04Cijh+qY9NF
   QNp9jf+VqX5/r9RVG7W8w+sXZd6yV/gpBLvVuLpUOxnnbPuQYokDjUfWb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="338238183"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="338238183"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 17:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="677568396"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="677568396"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2023 17:35:27 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phJmh-000J0x-0S;
        Wed, 29 Mar 2023 00:35:27 +0000
Date:   Wed, 29 Mar 2023 08:34:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     kan.liang@linux.intel.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, ak@linux.intel.com,
        eranian@google.com, Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH 2/2] perf/x86/intel/ds: Use the size from each PEBS record
Message-ID: <202303290854.CQhdHZDG-lkp@intel.com>
References: <20230328222735.1367829-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328222735.1367829-2-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/perf/core]
[also build test WARNING on acme/perf/core linus/master v6.3-rc4 next-20230328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/kan-liang-linux-intel-com/perf-x86-intel-ds-Use-the-size-from-each-PEBS-record/20230329-064258
patch link:    https://lore.kernel.org/r/20230328222735.1367829-2-kan.liang%40linux.intel.com
patch subject: [PATCH 2/2] perf/x86/intel/ds: Use the size from each PEBS record
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230329/202303290854.CQhdHZDG-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/a5988003cfa30fb0c88507d2d124eb551d42e1a6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review kan-liang-linux-intel-com/perf-x86-intel-ds-Use-the-size-from-each-PEBS-record/20230329-064258
        git checkout a5988003cfa30fb0c88507d2d124eb551d42e1a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303290854.CQhdHZDG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/events/intel/ds.c: In function '__intel_pmu_pebs_event':
>> arch/x86/events/intel/ds.c:2042:31: warning: unused variable 'cpuc' [-Wunused-variable]
    2042 |         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
         |                               ^~~~


vim +/cpuc +2042 arch/x86/events/intel/ds.c

d31fc13fdcb20e arch/x86/events/intel/ds.c                Kan Liang      2018-02-12  2029  
9dfa9a5c9bae34 arch/x86/events/intel/ds.c                Peter Zijlstra 2020-10-30  2030  static __always_inline void
9dfa9a5c9bae34 arch/x86/events/intel/ds.c                Peter Zijlstra 2020-10-30  2031  __intel_pmu_pebs_event(struct perf_event *event,
21509084f999d7 arch/x86/kernel/cpu/perf_event_intel_ds.c Yan, Zheng     2015-05-06  2032  		       struct pt_regs *iregs,
9dfa9a5c9bae34 arch/x86/events/intel/ds.c                Peter Zijlstra 2020-10-30  2033  		       struct perf_sample_data *data,
21509084f999d7 arch/x86/kernel/cpu/perf_event_intel_ds.c Yan, Zheng     2015-05-06  2034  		       void *base, void *top,
c22497f5838c23 arch/x86/events/intel/ds.c                Kan Liang      2019-04-02  2035  		       int bit, int count,
c22497f5838c23 arch/x86/events/intel/ds.c                Kan Liang      2019-04-02  2036  		       void (*setup_sample)(struct perf_event *,
c22497f5838c23 arch/x86/events/intel/ds.c                Kan Liang      2019-04-02  2037  					    struct pt_regs *,
c22497f5838c23 arch/x86/events/intel/ds.c                Kan Liang      2019-04-02  2038  					    void *,
c22497f5838c23 arch/x86/events/intel/ds.c                Kan Liang      2019-04-02  2039  					    struct perf_sample_data *,
c22497f5838c23 arch/x86/events/intel/ds.c                Kan Liang      2019-04-02  2040  					    struct pt_regs *))
43cf76312faefe arch/x86/kernel/cpu/perf_event_intel_ds.c Yan, Zheng     2015-05-06  2041  {
c22497f5838c23 arch/x86/events/intel/ds.c                Kan Liang      2019-04-02 @2042  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
d31fc13fdcb20e arch/x86/events/intel/ds.c                Kan Liang      2018-02-12  2043  	struct hw_perf_event *hwc = &event->hw;
c22497f5838c23 arch/x86/events/intel/ds.c                Kan Liang      2019-04-02  2044  	struct x86_perf_regs perf_regs;
c22497f5838c23 arch/x86/events/intel/ds.c                Kan Liang      2019-04-02  2045  	struct pt_regs *regs = &perf_regs.regs;
21509084f999d7 arch/x86/kernel/cpu/perf_event_intel_ds.c Yan, Zheng     2015-05-06  2046  	void *at = get_next_pebs_record_by_bit(base, top, bit);
e506d1dac0edb2 arch/x86/events/intel/ds.c                Peter Zijlstra 2020-10-30  2047  	static struct pt_regs dummy_iregs;
43cf76312faefe arch/x86/kernel/cpu/perf_event_intel_ds.c Yan, Zheng     2015-05-06  2048  
d31fc13fdcb20e arch/x86/events/intel/ds.c                Kan Liang      2018-02-12  2049  	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
d31fc13fdcb20e arch/x86/events/intel/ds.c                Kan Liang      2018-02-12  2050  		/*
d31fc13fdcb20e arch/x86/events/intel/ds.c                Kan Liang      2018-02-12  2051  		 * Now, auto-reload is only enabled in fixed period mode.
d31fc13fdcb20e arch/x86/events/intel/ds.c                Kan Liang      2018-02-12  2052  		 * The reload value is always hwc->sample_period.
d31fc13fdcb20e arch/x86/events/intel/ds.c                Kan Liang      2018-02-12  2053  		 * May need to change it, if auto-reload is enabled in
d31fc13fdcb20e arch/x86/events/intel/ds.c                Kan Liang      2018-02-12  2054  		 * freq mode later.
d31fc13fdcb20e arch/x86/events/intel/ds.c                Kan Liang      2018-02-12  2055  		 */
d31fc13fdcb20e arch/x86/events/intel/ds.c                Kan Liang      2018-02-12  2056  		intel_pmu_save_and_restart_reload(event, count);
d31fc13fdcb20e arch/x86/events/intel/ds.c                Kan Liang      2018-02-12  2057  	} else if (!intel_pmu_save_and_restart(event))
43cf76312faefe arch/x86/kernel/cpu/perf_event_intel_ds.c Yan, Zheng     2015-05-06  2058  		return;
43cf76312faefe arch/x86/kernel/cpu/perf_event_intel_ds.c Yan, Zheng     2015-05-06  2059  
35d1ce6bec1336 arch/x86/events/intel/ds.c                Kan Liang      2020-09-02  2060  	if (!iregs)
35d1ce6bec1336 arch/x86/events/intel/ds.c                Kan Liang      2020-09-02  2061  		iregs = &dummy_iregs;
35d1ce6bec1336 arch/x86/events/intel/ds.c                Kan Liang      2020-09-02  2062  
a3d86542de8850 arch/x86/kernel/cpu/perf_event_intel_ds.c Peter Zijlstra 2015-05-12  2063  	while (count > 1) {
9dfa9a5c9bae34 arch/x86/events/intel/ds.c                Peter Zijlstra 2020-10-30  2064  		setup_sample(event, iregs, at, data, regs);
9dfa9a5c9bae34 arch/x86/events/intel/ds.c                Peter Zijlstra 2020-10-30  2065  		perf_event_output(event, data, regs);
a5988003cfa30f arch/x86/events/intel/ds.c                Kan Liang      2023-03-28  2066  		at += get_pebs_size(at);
21509084f999d7 arch/x86/kernel/cpu/perf_event_intel_ds.c Yan, Zheng     2015-05-06  2067  		at = get_next_pebs_record_by_bit(at, top, bit);
a3d86542de8850 arch/x86/kernel/cpu/perf_event_intel_ds.c Peter Zijlstra 2015-05-12  2068  		count--;
21509084f999d7 arch/x86/kernel/cpu/perf_event_intel_ds.c Yan, Zheng     2015-05-06  2069  	}
21509084f999d7 arch/x86/kernel/cpu/perf_event_intel_ds.c Yan, Zheng     2015-05-06  2070  
9dfa9a5c9bae34 arch/x86/events/intel/ds.c                Peter Zijlstra 2020-10-30  2071  	setup_sample(event, iregs, at, data, regs);
35d1ce6bec1336 arch/x86/events/intel/ds.c                Kan Liang      2020-09-02  2072  	if (iregs == &dummy_iregs) {
35d1ce6bec1336 arch/x86/events/intel/ds.c                Kan Liang      2020-09-02  2073  		/*
35d1ce6bec1336 arch/x86/events/intel/ds.c                Kan Liang      2020-09-02  2074  		 * The PEBS records may be drained in the non-overflow context,
35d1ce6bec1336 arch/x86/events/intel/ds.c                Kan Liang      2020-09-02  2075  		 * e.g., large PEBS + context switch. Perf should treat the
35d1ce6bec1336 arch/x86/events/intel/ds.c                Kan Liang      2020-09-02  2076  		 * last record the same as other PEBS records, and doesn't
35d1ce6bec1336 arch/x86/events/intel/ds.c                Kan Liang      2020-09-02  2077  		 * invoke the generic overflow handler.
35d1ce6bec1336 arch/x86/events/intel/ds.c                Kan Liang      2020-09-02  2078  		 */
9dfa9a5c9bae34 arch/x86/events/intel/ds.c                Peter Zijlstra 2020-10-30  2079  		perf_event_output(event, data, regs);
35d1ce6bec1336 arch/x86/events/intel/ds.c                Kan Liang      2020-09-02  2080  	} else {
21509084f999d7 arch/x86/kernel/cpu/perf_event_intel_ds.c Yan, Zheng     2015-05-06  2081  		/*
21509084f999d7 arch/x86/kernel/cpu/perf_event_intel_ds.c Yan, Zheng     2015-05-06  2082  		 * All but the last records are processed.
21509084f999d7 arch/x86/kernel/cpu/perf_event_intel_ds.c Yan, Zheng     2015-05-06  2083  		 * The last one is left to be able to call the overflow handler.
21509084f999d7 arch/x86/kernel/cpu/perf_event_intel_ds.c Yan, Zheng     2015-05-06  2084  		 */
9dfa9a5c9bae34 arch/x86/events/intel/ds.c                Peter Zijlstra 2020-10-30  2085  		if (perf_event_overflow(event, data, regs))
a4eaf7f14675cb arch/x86/kernel/cpu/perf_event_intel_ds.c Peter Zijlstra 2010-06-16  2086  			x86_pmu_stop(event, 0);
21509084f999d7 arch/x86/kernel/cpu/perf_event_intel_ds.c Yan, Zheng     2015-05-06  2087  	}
2b0b5c6fe9b383 arch/x86/kernel/cpu/perf_event_intel_ds.c Peter Zijlstra 2010-04-08  2088  }
2b0b5c6fe9b383 arch/x86/kernel/cpu/perf_event_intel_ds.c Peter Zijlstra 2010-04-08  2089  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
