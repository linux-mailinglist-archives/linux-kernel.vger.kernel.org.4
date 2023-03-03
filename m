Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF7D6A8DCD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCCATt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCCATq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:19:46 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704F743938
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 16:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677802785; x=1709338785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kXmGcpoPi7aVjOE9sTwljkk+GdRZsvI9R7Mz5TbQEgU=;
  b=NB+lUqdYvWVhxKtdSMegEtFD0gqbjGKvbSRauf5SNJ9isNwBfpA+5msG
   yCBvfs9IWh+MCoKVjgRRHcdMUOjcK8Np2nupUWX3DopLipFVY/LAhBQp9
   SYKxVjL1TC3MeeKEMKNPLypKSBoMZpNwsP/8EtlzH0nE19bfUSoRJkbIP
   AyPpmgs/4ZQOPNJitlALctejwMbbApm9Qr61nPXOxiKKo8Gs1ITzDcYdN
   cgjH3Iz063wq+v7Br/lIuEr+WKm5PzoLDBJTvEfFfR1874/oc7KbhzKwt
   xJbs97MtCHQF9fEHwXhlX4Sa8dHm8uEAsoPUc3LVSXv5thWNwepzDyuBe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="362495909"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="362495909"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 16:19:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="652601639"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="652601639"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2023 16:19:42 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXt9B-00011G-2O;
        Fri, 03 Mar 2023 00:19:41 +0000
Date:   Fri, 3 Mar 2023 08:19:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 10/18] printk: nobkl: Add emit function and
 callback functions for atomic printing
Message-ID: <202303030859.j7DLimWU-lkp@intel.com>
References: <20230302195618.156940-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-11-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 10d639febe5629687dac17c4a7500a96537ce11a]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ogness/kdb-do-not-assume-write-callback-available/20230303-040039
base:   10d639febe5629687dac17c4a7500a96537ce11a
patch link:    https://lore.kernel.org/r/20230302195618.156940-11-john.ogness%40linutronix.de
patch subject: [PATCH printk v1 10/18] printk: nobkl: Add emit function and callback functions for atomic printing
config: nios2-buildonly-randconfig-r004-20230302 (https://download.01.org/0day-ci/archive/20230303/202303030859.j7DLimWU-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cae46beabb2dfe79a4c4c602601fa538a8d840f7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review John-Ogness/kdb-do-not-assume-write-callback-available/20230303-040039
        git checkout cae46beabb2dfe79a4c4c602601fa538a8d840f7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash kernel/printk/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303030859.j7DLimWU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/printk/printk.c:2841:6: warning: no previous prototype for 'printk_get_next_message' [-Wmissing-prototypes]
    2841 | bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/printk_get_next_message +2841 kernel/printk/printk.c

  2821	
  2822	/*
  2823	 * Read and format the specified record (or a later record if the specified
  2824	 * record is not available).
  2825	 *
  2826	 * @pmsg will contain the formatted result. @pmsg->pbufs must point to a
  2827	 * struct printk_buffers.
  2828	 *
  2829	 * @seq is the record to read and format. If it is not available, the next
  2830	 * valid record is read.
  2831	 *
  2832	 * @is_extended specifies if the message should be formatted for extended
  2833	 * console output.
  2834	 *
  2835	 * @may_supress specifies if records may be skipped based on loglevel.
  2836	 *
  2837	 * Returns false if no record is available. Otherwise true and all fields
  2838	 * of @pmsg are valid. (See the documentation of struct printk_message
  2839	 * for information about the @pmsg fields.)
  2840	 */
> 2841	bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
  2842				     bool is_extended, bool may_suppress)
  2843	{
  2844		static int panic_console_dropped;
  2845	
  2846		struct printk_buffers *pbufs = pmsg->pbufs;
  2847		const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
  2848		const size_t outbuf_sz = sizeof(pbufs->outbuf);
  2849		char *scratchbuf = &pbufs->scratchbuf[0];
  2850		char *outbuf = &pbufs->outbuf[0];
  2851		struct printk_info info;
  2852		struct printk_record r;
  2853		size_t len = 0;
  2854	
  2855		/*
  2856		 * Formatting extended messages requires a separate buffer, so use the
  2857		 * scratch buffer to read in the ringbuffer text.
  2858		 *
  2859		 * Formatting normal messages is done in-place, so read the ringbuffer
  2860		 * text directly into the output buffer.
  2861		 */
  2862		if (is_extended)
  2863			prb_rec_init_rd(&r, &info, scratchbuf, scratchbuf_sz);
  2864		else
  2865			prb_rec_init_rd(&r, &info, outbuf, outbuf_sz);
  2866	
  2867		if (!prb_read_valid(prb, seq, &r))
  2868			return false;
  2869	
  2870		pmsg->seq = r.info->seq;
  2871		pmsg->dropped = r.info->seq - seq;
  2872	
  2873		/*
  2874		 * Check for dropped messages in panic here so that printk
  2875		 * suppression can occur as early as possible if necessary.
  2876		 */
  2877		if (pmsg->dropped &&
  2878		    panic_in_progress() &&
  2879		    panic_console_dropped++ > 10) {
  2880			suppress_panic_printk = 1;
  2881			pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
  2882		}
  2883	
  2884		/* Skip record that has level above the console loglevel. */
  2885		if (may_suppress && suppress_message_printing(r.info->level))
  2886			goto out;
  2887	
  2888		if (is_extended) {
  2889			len = info_print_ext_header(outbuf, outbuf_sz, r.info);
  2890			len += msg_print_ext_body(outbuf + len, outbuf_sz - len,
  2891						  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
  2892		} else {
  2893			len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
  2894		}
  2895	out:
  2896		pmsg->outbuf_len = len;
  2897		return true;
  2898	}
  2899	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
