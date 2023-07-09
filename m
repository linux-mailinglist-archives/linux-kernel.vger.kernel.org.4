Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB6574C15B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 08:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjGIGzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 02:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGIGzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 02:55:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3BFE5A
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 23:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688885745; x=1720421745;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h9+iCkpAocXKRTcbofuGK30lQ2gnUDJc4Kyw7MRzMQY=;
  b=AUdWzXB/ZcRWc36XF7Ak/XpFFhWW7qg7ZoiqH5pDI2mmqdC3+4UOBagd
   svr7QlZvs4D1O6tvBKSk94FcvEV/XnvRP2DkNmffA4ZefjjlwkJzFRyBi
   4dcTUbuUpykV6mzeeoDikMPEENjMqks56H0X+EdGgy21GAdrKikIQykWl
   GvMsM62AbhFvzp3xJnuosj2F1ipDBVy6dK0FGJ+JpC6dgqlAKyGY0nptc
   FasyIrmBk2AzOetw0sYe16msqdIr52aC5mAsKA/jVnRv8j2juKBprlZMO
   uTjzFAB6NYOvnY894RrvNdolSx473JARLSXX1GgzLn6ht7gy9La0idY3s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10765"; a="427830780"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="427830780"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2023 23:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10765"; a="785784013"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="785784013"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jul 2023 23:55:43 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qIOKc-000388-1V;
        Sun, 09 Jul 2023 06:55:42 +0000
Date:   Sun, 9 Jul 2023 14:55:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: drivers/char/ipmi/ipmi_msghandler.c:5194:13: warning: stack frame
 size (1032) exceeds limit (1024) in 'ipmi_panic_request_and_wait'
Message-ID: <202307091420.gmc0Q2F3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c7873e3364570ec89343ff4877e0f27a7b21a61
commit: c9268ac615f9f6dded7801df5993374598934377 locking/atomic: scripts: add trivial raw_atomic*_<op>()
date:   5 weeks ago
config: arm-randconfig-r006-20230709 (https://download.01.org/0day-ci/archive/20230709/202307091420.gmc0Q2F3-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230709/202307091420.gmc0Q2F3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307091420.gmc0Q2F3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/char/ipmi/ipmi_msghandler.c:5194:13: warning: stack frame size (1032) exceeds limit (1024) in 'ipmi_panic_request_and_wait' [-Wframe-larger-than]
    5194 | static void ipmi_panic_request_and_wait(struct ipmi_smi *intf,
         |             ^
   1 warning generated.


vim +/ipmi_panic_request_and_wait +5194 drivers/char/ipmi/ipmi_msghandler.c

895dcfd1cab84d Corey Minyard  2012-03-28  5190  
895dcfd1cab84d Corey Minyard  2012-03-28  5191  /*
895dcfd1cab84d Corey Minyard  2012-03-28  5192   * Inside a panic, send a message and wait for a response.
895dcfd1cab84d Corey Minyard  2012-03-28  5193   */
a567b6230066e3 Corey Minyard  2018-04-05 @5194  static void ipmi_panic_request_and_wait(struct ipmi_smi *intf,
895dcfd1cab84d Corey Minyard  2012-03-28  5195  					struct ipmi_addr *addr,
895dcfd1cab84d Corey Minyard  2012-03-28  5196  					struct kernel_ipmi_msg *msg)
895dcfd1cab84d Corey Minyard  2012-03-28  5197  {
895dcfd1cab84d Corey Minyard  2012-03-28  5198  	struct ipmi_smi_msg  smi_msg;
895dcfd1cab84d Corey Minyard  2012-03-28  5199  	struct ipmi_recv_msg recv_msg;
895dcfd1cab84d Corey Minyard  2012-03-28  5200  	int rv;
895dcfd1cab84d Corey Minyard  2012-03-28  5201  
895dcfd1cab84d Corey Minyard  2012-03-28  5202  	smi_msg.done = dummy_smi_done_handler;
895dcfd1cab84d Corey Minyard  2012-03-28  5203  	recv_msg.done = dummy_recv_done_handler;
895dcfd1cab84d Corey Minyard  2012-03-28  5204  	atomic_add(2, &panic_done_count);
895dcfd1cab84d Corey Minyard  2012-03-28  5205  	rv = i_ipmi_request(NULL,
895dcfd1cab84d Corey Minyard  2012-03-28  5206  			    intf,
895dcfd1cab84d Corey Minyard  2012-03-28  5207  			    addr,
895dcfd1cab84d Corey Minyard  2012-03-28  5208  			    0,
895dcfd1cab84d Corey Minyard  2012-03-28  5209  			    msg,
895dcfd1cab84d Corey Minyard  2012-03-28  5210  			    intf,
895dcfd1cab84d Corey Minyard  2012-03-28  5211  			    &smi_msg,
895dcfd1cab84d Corey Minyard  2012-03-28  5212  			    &recv_msg,
895dcfd1cab84d Corey Minyard  2012-03-28  5213  			    0,
5fdb1fb2abe647 Corey Minyard  2017-09-05  5214  			    intf->addrinfo[0].address,
5fdb1fb2abe647 Corey Minyard  2017-09-05  5215  			    intf->addrinfo[0].lun,
895dcfd1cab84d Corey Minyard  2012-03-28  5216  			    0, 1); /* Don't retry, and don't wait. */
895dcfd1cab84d Corey Minyard  2012-03-28  5217  	if (rv)
895dcfd1cab84d Corey Minyard  2012-03-28  5218  		atomic_sub(2, &panic_done_count);
82802f968bd311 Hidehiro Kawai 2015-07-27  5219  	else if (intf->handlers->flush_messages)
82802f968bd311 Hidehiro Kawai 2015-07-27  5220  		intf->handlers->flush_messages(intf->send_info);
82802f968bd311 Hidehiro Kawai 2015-07-27  5221  
895dcfd1cab84d Corey Minyard  2012-03-28  5222  	while (atomic_read(&panic_done_count) != 0)
895dcfd1cab84d Corey Minyard  2012-03-28  5223  		ipmi_poll(intf);
^1da177e4c3f41 Linus Torvalds 2005-04-16  5224  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  5225  

:::::: The code at line 5194 was first introduced by commit
:::::: a567b6230066e3a2c964e2dc914e7f9a436806c4 ipmi: Change ipmi_smi_t to struct ipmi_smi *

:::::: TO: Corey Minyard <cminyard@mvista.com>
:::::: CC: Corey Minyard <cminyard@mvista.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
