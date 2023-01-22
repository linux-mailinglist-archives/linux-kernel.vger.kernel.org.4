Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04EE677282
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjAVVAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjAVVAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:00:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F091E1EB;
        Sun, 22 Jan 2023 13:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674421244; x=1705957244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PQNjpofFpMssJkWxIxJZIPzr371EnJU3297F89kKntQ=;
  b=XqfqqxEUhlM/my2164johJ6tKFWiZ1uTc8OUVlJsWNrPDQwUk9YttkBT
   jBlMeGuAhwm8hooSqjiKlYOHxUeDh7OjsCnCOhZPW6WFo/pNSRtvrlk4e
   +ooK7AhyRJ1B7F8tp4Gb3xOUh6ZicsuSj8gqP0n9sn9nUHjGDNf935733
   6UwjvAnpL3WL5MloQi4q4bByPhDj2qeNrSb8s4lv7O0GATekhm6N944IN
   hLjmnZ/Y4lVoi5wNW9XGCmQpHYDdK1g/gmCmRfdfeEiY1H+LEHa3D7SXV
   RUuGuRp847c/fNgIGQ2UmaeUjo0TDrxb47/Qi3DkC2nJkP1nNabcOj64t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="328030390"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="328030390"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 13:00:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="638925230"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="638925230"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Jan 2023 13:00:40 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJhSB-0005FM-0e;
        Sun, 22 Jan 2023 21:00:39 +0000
Date:   Mon, 23 Jan 2023 05:00:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ajay Kaher <akaher@vmware.com>, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH 8/8] eventfs: moving tracing/events to eventfs
Message-ID: <202301230402.yk3757pr-lkp@intel.com>
References: <1674407228-49109-8-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674407228-49109-8-git-send-email-akaher@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ajay,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.2-rc5 next-20230120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
patch link:    https://lore.kernel.org/r/1674407228-49109-8-git-send-email-akaher%40vmware.com
patch subject: [PATCH 8/8] eventfs: moving tracing/events to eventfs
config: arc-defconfig (https://download.01.org/0day-ci/archive/20230123/202301230402.yk3757pr-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/be995c36ba2232edcd4fa64e4581b9a6763c75e6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
        git checkout be995c36ba2232edcd4fa64e4581b9a6763c75e6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/trace/trace_events.c: In function 'event_create_dir':
>> kernel/trace/trace_events.c:2405:24: warning: variable 'd_events' set but not used [-Wunused-but-set-variable]
    2405 |         struct dentry *d_events;
         |                        ^~~~~~~~


vim +/d_events +2405 kernel/trace/trace_events.c

ac343da7bc9048 Masami Hiramatsu         2020-09-10  2398  
1473e4417c79f1 Steven Rostedt           2009-02-24  2399  static int
7f1d2f8210195c Steven Rostedt (Red Hat  2015-05-05  2400) event_create_dir(struct dentry *parent, struct trace_event_file *file)
1473e4417c79f1 Steven Rostedt           2009-02-24  2401  {
2425bcb9240f8c Steven Rostedt (Red Hat  2015-05-05  2402) 	struct trace_event_call *call = file->event_call;
ae63b31e4d0e2e Steven Rostedt           2012-05-03  2403  	struct trace_array *tr = file->tr;
be995c36ba2232 Ajay Kaher               2023-01-22  2404  	struct eventfs_file *ef_subsystem = NULL;
ae63b31e4d0e2e Steven Rostedt           2012-05-03 @2405  	struct dentry *d_events;
de7b2973903c6c Mathieu Desnoyers        2014-04-08  2406  	const char *name;
fd99498989f3b3 Steven Rostedt           2009-02-28  2407  	int ret;
1473e4417c79f1 Steven Rostedt           2009-02-24  2408  
6ecc2d1ca39177 Steven Rostedt           2009-02-27  2409  	/*
6ecc2d1ca39177 Steven Rostedt           2009-02-27  2410  	 * If the trace point header did not define TRACE_SYSTEM
6ecc2d1ca39177 Steven Rostedt           2009-02-27  2411  	 * then the system would be called "TRACE_SYSTEM".
6ecc2d1ca39177 Steven Rostedt           2009-02-27  2412  	 */
ae63b31e4d0e2e Steven Rostedt           2012-05-03  2413  	if (strcmp(call->class->system, TRACE_SYSTEM) != 0) {
be995c36ba2232 Ajay Kaher               2023-01-22  2414  		ef_subsystem = event_subsystem_dir(tr, call->class->system, file, parent);
be995c36ba2232 Ajay Kaher               2023-01-22  2415  		if (!ef_subsystem)
ae63b31e4d0e2e Steven Rostedt           2012-05-03  2416  			return -ENOMEM;
ae63b31e4d0e2e Steven Rostedt           2012-05-03  2417  	} else
ae63b31e4d0e2e Steven Rostedt           2012-05-03  2418  		d_events = parent;
6ecc2d1ca39177 Steven Rostedt           2009-02-27  2419  
687fcc4aee4567 Steven Rostedt (Red Hat  2015-05-13  2420) 	name = trace_event_name(call);
be995c36ba2232 Ajay Kaher               2023-01-22  2421  	file->ef = eventfs_add_dir(name, ef_subsystem);
be995c36ba2232 Ajay Kaher               2023-01-22  2422  	if (IS_ERR(file->ef)) {
8434dc9340cd2e Steven Rostedt (Red Hat  2015-01-20  2423) 		pr_warn("Could not create tracefs '%s' directory\n", name);
1473e4417c79f1 Steven Rostedt           2009-02-24  2424  		return -1;
1473e4417c79f1 Steven Rostedt           2009-02-24  2425  	}
1473e4417c79f1 Steven Rostedt           2009-02-24  2426  
9b63776fa3ca96 Steven Rostedt           2012-05-10  2427  	if (call->class->reg && !(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE))
be995c36ba2232 Ajay Kaher               2023-01-22  2428  		eventfs_add_file("enable", TRACE_MODE_WRITE, file->ef, file,
620a30e97febc8 Oleg Nesterov            2013-07-31  2429  				  &ftrace_enable_fops);
1473e4417c79f1 Steven Rostedt           2009-02-24  2430  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
