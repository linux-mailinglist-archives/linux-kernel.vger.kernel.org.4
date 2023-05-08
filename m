Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE17C6FB5C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjEHRNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjEHRNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:13:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663174C32;
        Mon,  8 May 2023 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683566020; x=1715102020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5NIJkXs6LUjGrSFzNNxUCT1m1jDLIh1i0BRiM4BtLpM=;
  b=Wz0B+q6rY/jJd62BVskZBKoXKjIrXUgEwLe0ZSJzv91vOoN8MS149pgq
   FyxXDfZB66PiaoYJSTvvR/VutwPxmlP0Wm8H9NDf6ZTf0bJFBCNMxIUEb
   XNHtn40EPKFqPnyEq8Ma5gGsOMDNqaY493efX/DUgWMmkllMemkmtBQ4P
   uGpEOnt0W9n5XgYdYci2vbzgrHXZ5eFtQ0gvelO8Ai+5A9TF0OwgDUWgs
   TNviMzscbzcsTyuawp8cjRijQq2gNnYOqP38yIXOC2v0NIvuFeadFjJ6T
   dMenyfumB3Fx45rhR2zWSPo3eNztU+PGkXvkWvU5FyKY7HtUyLf864UJ8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="348533001"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="348533001"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 10:13:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="701493547"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="701493547"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 May 2023 10:13:38 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pw4Qb-0001Kz-0o;
        Mon, 08 May 2023 17:13:37 +0000
Date:   Tue, 9 May 2023 01:13:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>, paul@paul-moore.com,
        eparis@redhat.com, linux-kernel@vger.kernel.org,
        audit@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: Re: [PATCH 4/4] audit: check if queue is full after
 prepare_to_wait_exclusive()
Message-ID: <202305090112.uJSc0NBw-lkp@intel.com>
References: <20230508075812.76077-5-eiichi.tsukata@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508075812.76077-5-eiichi.tsukata@nutanix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eiichi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pcmoore-audit/next]
[also build test WARNING on linus/master v6.4-rc1 next-20230508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eiichi-Tsukata/audit-refactor-queue-full-checks/20230508-160019
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
patch link:    https://lore.kernel.org/r/20230508075812.76077-5-eiichi.tsukata%40nutanix.com
patch subject: [PATCH 4/4] audit: check if queue is full after prepare_to_wait_exclusive()
config: i386-randconfig-a001-20230508 (https://download.01.org/0day-ci/archive/20230509/202305090112.uJSc0NBw-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cbc69d0c34bdbc06ebca3e3020cfc24034fcf173
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eiichi-Tsukata/audit-refactor-queue-full-checks/20230508-160019
        git checkout cbc69d0c34bdbc06ebca3e3020cfc24034fcf173
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305090112.uJSc0NBw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/audit.c:651:6: warning: variable 'rtime' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (audit_queue_full(&audit_queue)) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/audit.c:657:9: note: uninitialized use occurs here
           return rtime;
                  ^~~~~
   kernel/audit.c:651:2: note: remove the 'if' if its condition is always true
           if (audit_queue_full(&audit_queue)) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/audit.c:642:12: note: initialize the variable 'rtime' to silence this warning
           long rtime;
                     ^
                      = 0
   1 warning generated.


vim +651 kernel/audit.c

   630	
   631	/**
   632	 * wait_for_kauditd - Wait for kauditd to drain the queue
   633	 * @stime: time to sleep
   634	 *
   635	 * Description:
   636	 * Waits for kauditd to drain the queue then adds duration of sleep time to
   637	 * audit_backlog_wait_time_actual as cumulative sum.
   638	 * Returns remaining time to sleep.
   639	 */
   640	static long wait_for_kauditd(long stime)
   641	{
   642		long rtime;
   643		DEFINE_WAIT(wait);
   644	
   645		prepare_to_wait_exclusive(&audit_backlog_wait, &wait,
   646					  TASK_UNINTERRUPTIBLE);
   647	
   648		/* need to check if the queue is full again because kauditd might have
   649		 * flushed the queue and went to sleep after prepare_to_wait_exclusive()
   650		 */
 > 651		if (audit_queue_full(&audit_queue)) {
   652			rtime = schedule_timeout(stime);
   653			atomic_add(stime - rtime, &audit_backlog_wait_time_actual);
   654		}
   655		finish_wait(&audit_backlog_wait, &wait);
   656	
   657		return rtime;
   658	}
   659	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
