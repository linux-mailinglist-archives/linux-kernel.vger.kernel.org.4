Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B5D6A8EA3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjCCBXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCBXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:23:48 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A46915141
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677806627; x=1709342627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bCEoUrg9KrFGmWGkMBU4A/iaIhFJtfSNlf5HEVBJOIM=;
  b=P9YVCK2HJm9fcSiP2tjlo461cjY16Q8ja+3p47SQruCGddYJP9sKR09K
   4VzGcQLq4OsoLiRUdwk3In6iLTCyWjMtzzjMVgJIskFj4R5YzeWolERDi
   SFbCEiilkf0Ru4R/bKxd8aU47vXDPxDHklok/vefPjuCr5xwlPY/Q2cwr
   ugpzI/sXssq2fY8DB+au1nfAcLxhBp8TR9YUibFhHbrl1D7fWDedK7irq
   njExCFwDrT4lfDQnVS6aHROl6opSdWlC7h6VvQhf1ppds+Kon9PDeeb8j
   g+Tdnz97FEMb0yXL8JkR0x2SQ+Prq2ZubxXb/jndkzn5jYzkjPIkrODU4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="333639683"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="333639683"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 17:23:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="675185734"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="675185734"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2023 17:23:44 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXu99-00014C-2C;
        Fri, 03 Mar 2023 01:23:43 +0000
Date:   Fri, 3 Mar 2023 09:23:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/18] printk: nobkl: Introduce printer threads
Message-ID: <202303030957.Hkt9zcFz-lkp@intel.com>
References: <20230302195618.156940-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-12-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I love your patch! Yet something to improve:

[auto build test ERROR on 10d639febe5629687dac17c4a7500a96537ce11a]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ogness/kdb-do-not-assume-write-callback-available/20230303-040039
base:   10d639febe5629687dac17c4a7500a96537ce11a
patch link:    https://lore.kernel.org/r/20230302195618.156940-12-john.ogness%40linutronix.de
patch subject: [PATCH printk v1 11/18] printk: nobkl: Introduce printer threads
config: nios2-buildonly-randconfig-r004-20230302 (https://download.01.org/0day-ci/archive/20230303/202303030957.Hkt9zcFz-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/72ef8a364036e7e813e7f7dfa8d37a4466d1ca8a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review John-Ogness/kdb-do-not-assume-write-callback-available/20230303-040039
        git checkout 72ef8a364036e7e813e7f7dfa8d37a4466d1ca8a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash kernel/printk/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303030957.Hkt9zcFz-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/printk/printk.c:2802:6: warning: no previous prototype for 'printk_get_next_message' [-Wmissing-prototypes]
    2802 | bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c: In function 'console_flush_all':
>> kernel/printk/printk.c:2979:30: error: implicit declaration of function 'console_is_usable'; did you mean 'console_exit_unsafe'? [-Werror=implicit-function-declaration]
    2979 |                         if (!console_is_usable(con, flags))
         |                              ^~~~~~~~~~~~~~~~~
         |                              console_exit_unsafe
   cc1: some warnings being treated as errors


vim +2979 kernel/printk/printk.c

a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2933  
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2934  /*
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2935   * Print out all remaining records to all consoles.
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2936   *
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2937   * @do_cond_resched is set by the caller. It can be true only in schedulable
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2938   * context.
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2939   *
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2940   * @next_seq is set to the sequence number after the last available record.
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2941   * The value is valid only when this function returns true. It means that all
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2942   * usable consoles are completely flushed.
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2943   *
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2944   * @handover will be set to true if a printk waiter has taken over the
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2945   * console_lock, in which case the caller is no longer holding the
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2946   * console_lock. Otherwise it is set to false.
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2947   *
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2948   * Returns true when there was at least one usable console and all messages
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2949   * were flushed to all usable consoles. A returned false informs the caller
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2950   * that everything was not flushed (either there were no usable consoles or
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2951   * another context has taken over printing or it is a panic situation and this
5831788afb17b89 kernel/printk/printk.c Petr Mladek             2022-06-23  2952   * is not the panic CPU). Regardless the reason, the caller should assume it
5831788afb17b89 kernel/printk/printk.c Petr Mladek             2022-06-23  2953   * is not useful to immediately try again.
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2954   *
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2955   * Requires the console_lock.
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2956   */
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2957  static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2958  {
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2959  	bool any_usable = false;
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2960  	struct console *con;
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2961  	bool any_progress;
fc956ae0de7fa25 kernel/printk/printk.c John Ogness             2022-11-16  2962  	int cookie;
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2963  
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2964  	*next_seq = 0;
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2965  	*handover = false;
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2966  
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2967  	do {
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2968  		any_progress = false;
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2969  
fc956ae0de7fa25 kernel/printk/printk.c John Ogness             2022-11-16  2970  		cookie = console_srcu_read_lock();
fc956ae0de7fa25 kernel/printk/printk.c John Ogness             2022-11-16  2971  		for_each_console_srcu(con) {
cfa886eee9834d5 kernel/printk/printk.c Thomas Gleixner         2023-03-02  2972  			short flags = console_srcu_read_flags(con);
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2973  			bool progress;
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2974  
cfa886eee9834d5 kernel/printk/printk.c Thomas Gleixner         2023-03-02  2975  			/* console_flush_all() is only for legacy consoles. */
cfa886eee9834d5 kernel/printk/printk.c Thomas Gleixner         2023-03-02  2976  			if (flags & CON_NO_BKL)
cfa886eee9834d5 kernel/printk/printk.c Thomas Gleixner         2023-03-02  2977  				continue;
cfa886eee9834d5 kernel/printk/printk.c Thomas Gleixner         2023-03-02  2978  
cfa886eee9834d5 kernel/printk/printk.c Thomas Gleixner         2023-03-02 @2979  			if (!console_is_usable(con, flags))
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2980  				continue;
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2981  			any_usable = true;
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2982  
daaab5b5bba36a5 kernel/printk/printk.c John Ogness             2023-01-09  2983  			progress = console_emit_next_record(con, handover, cookie);
fc956ae0de7fa25 kernel/printk/printk.c John Ogness             2022-11-16  2984  
fc956ae0de7fa25 kernel/printk/printk.c John Ogness             2022-11-16  2985  			/*
fc956ae0de7fa25 kernel/printk/printk.c John Ogness             2022-11-16  2986  			 * If a handover has occurred, the SRCU read lock
fc956ae0de7fa25 kernel/printk/printk.c John Ogness             2022-11-16  2987  			 * is already released.
fc956ae0de7fa25 kernel/printk/printk.c John Ogness             2022-11-16  2988  			 */
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2989  			if (*handover)
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2990  				return false;
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2991  
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2992  			/* Track the next of the highest seq flushed. */
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2993  			if (con->seq > *next_seq)
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2994  				*next_seq = con->seq;
8d91f8b15361dfb kernel/printk/printk.c Tejun Heo               2016-01-15  2995  
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2996  			if (!progress)
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2997  				continue;
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2998  			any_progress = true;
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  2999  
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  3000  			/* Allow panic_cpu to take over the consoles safely. */
8ebc476fd51e6c0 kernel/printk/printk.c Stephen Brennan         2022-02-02  3001  			if (abandon_console_lock_in_panic())
fc956ae0de7fa25 kernel/printk/printk.c John Ogness             2022-11-16  3002  				goto abandon;
8ebc476fd51e6c0 kernel/printk/printk.c Stephen Brennan         2022-02-02  3003  
8d91f8b15361dfb kernel/printk/printk.c Tejun Heo               2016-01-15  3004  			if (do_cond_resched)
8d91f8b15361dfb kernel/printk/printk.c Tejun Heo               2016-01-15  3005  				cond_resched();
^1da177e4c3f415 kernel/printk.c        Linus Torvalds          2005-04-16  3006  		}
fc956ae0de7fa25 kernel/printk/printk.c John Ogness             2022-11-16  3007  		console_srcu_read_unlock(cookie);
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  3008  	} while (any_progress);
dbdda842fe96f89 kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  3009) 
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  3010  	return any_usable;
fc956ae0de7fa25 kernel/printk/printk.c John Ogness             2022-11-16  3011  
fc956ae0de7fa25 kernel/printk/printk.c John Ogness             2022-11-16  3012  abandon:
fc956ae0de7fa25 kernel/printk/printk.c John Ogness             2022-11-16  3013  	console_srcu_read_unlock(cookie);
fc956ae0de7fa25 kernel/printk/printk.c John Ogness             2022-11-16  3014  	return false;
a699449bb13b70b kernel/printk/printk.c John Ogness             2022-04-21  3015  }
fe3d8ad31cf51b0 kernel/printk.c        Feng Tang               2011-03-22  3016  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
