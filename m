Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD276B38F0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCJIk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjCJIju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:39:50 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF40E10A13E;
        Fri, 10 Mar 2023 00:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678437483; x=1709973483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QtZvbYRePTNq2hQ0hWKhD/pks5jqsVWhwxiA5aU7K0Y=;
  b=A+PJH0chdbn829RGWrRVIBZn9jcctoc4ZGvs3hw+Wp9ASTKLZervrEjw
   RbBbHDqyAinXhzvqeXM9T7tq6DDt9Y/w8Y1m40YqXk93K553pVMOsJGeM
   Eket3htCQUgWe+e90UiFFW0B1BspSXLAxWYxXWTyKH8zLogZl24xkF+Ji
   0fBG4L/hDg5dZrAdpZJmyTx/PmDla/DpEiSeQ3ecgo0hVg2gvXxD4H13/
   wxORKjRPJlL5XoRzr4Bte69i3yHHcbMfzBzKtt5geRYBrwPeX0WMjoSlx
   CoKJHhvorJydTi2nbo9HVc0XxrFRulopQ3lRkuTKRtRJmZEeW1HrB+ZZW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="422946941"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="422946941"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 00:37:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="851831733"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="851831733"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2023 00:37:10 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paYFS-0003fh-0W;
        Fri, 10 Mar 2023 08:37:10 +0000
Date:   Fri, 10 Mar 2023 16:37:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Douglas RAILLARD <douglas.raillard@arm.com>
Subject: Re: [PATCH] tracing: Error if a trace event has an array for a
 __field()
Message-ID: <202303101645.28bnQoH2-lkp@intel.com>
References: <20230309221302.642e82d9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309221302.642e82d9@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.3-rc1]
[cannot apply to next-20230310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Error-if-a-trace-event-has-an-array-for-a-__field/20230310-111456
patch link:    https://lore.kernel.org/r/20230309221302.642e82d9%40gandalf.local.home
patch subject: [PATCH] tracing: Error if a trace event has an array for a __field()
config: x86_64-randconfig-a006 (https://download.01.org/0day-ci/archive/20230310/202303101645.28bnQoH2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/4828e98216144ead91bbb26298aae865dac9f837
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Steven-Rostedt/tracing-Error-if-a-trace-event-has-an-array-for-a-__field/20230310-111456
        git checkout 4828e98216144ead91bbb26298aae865dac9f837
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/rcu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303101645.28bnQoH2-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from include/trace/events/rcu.h:839,
                    from kernel/rcu/rcu.h:13,
                    from kernel/rcu/update.c:49:
   include/trace/events/rcu.h: In function 'trace_event_get_offsets_rcu_torture_read':
>> include/trace/stages/stage5_get_offsets.h:23:53: error: expected ')' before '*' token
      23 |         { (void)sizeof(struct _test_no_array_##item *); }
         |                       ~                             ^
   include/trace/trace_events.h:263:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
     263 |         tstruct;                                                        \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   include/trace/events/rcu.h:11:25: note: in expansion of macro 'TRACE_EVENT'
      11 | #define TRACE_EVENT_RCU TRACE_EVENT
         |                         ^~~~~~~~~~~
   include/trace/events/rcu.h:770:9: note: in expansion of macro 'TP_STRUCT__entry'
     770 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   include/trace/events/rcu.h:771:17: note: in expansion of macro '__field'
     771 |                 __field(char, rcutorturename[RCUTORTURENAME_LEN])
         |                 ^~~~~~~
>> include/trace/events/rcu.h:771:45: error: array type has incomplete element type 'struct _test_no_array_rcutorturename'
     771 |                 __field(char, rcutorturename[RCUTORTURENAME_LEN])
         |                                             ^
   include/trace/trace_events.h:263:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
     263 |         tstruct;                                                        \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   include/trace/events/rcu.h:11:25: note: in expansion of macro 'TRACE_EVENT'
      11 | #define TRACE_EVENT_RCU TRACE_EVENT
         |                         ^~~~~~~~~~~
   include/trace/events/rcu.h:770:9: note: in expansion of macro 'TP_STRUCT__entry'
     770 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   include/trace/events/rcu.h:771:17: note: in expansion of macro '__field'
     771 |                 __field(char, rcutorturename[RCUTORTURENAME_LEN])
         |                 ^~~~~~~


vim +23 include/trace/stages/stage5_get_offsets.h

    11	
    12	/*
    13	 * Fields should never declare an array: i.e. __field(int, arr[5])
    14	 * If they do, it will cause issues in parsing and possibly corrupt the
    15	 * events. To prevent that from happening, test the sizeof() a fictitious
    16	 * type called "struct _test_no_array_##item" which will fail if "item"
    17	 * contains array elements (like "arr[5]").
    18	 *
    19	 * If you hit this, use __array(int, arr, 5) instead.
    20	 */
    21	#undef __field
    22	#define __field(type, item)					\
  > 23		{ (void)sizeof(struct _test_no_array_##item *); }
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
