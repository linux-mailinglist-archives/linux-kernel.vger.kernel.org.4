Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606D8695363
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjBMVuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBMVul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:50:41 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52337CC19;
        Mon, 13 Feb 2023 13:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676325040; x=1707861040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=v79E84a7qAMQPFswqfoVVKqD06DuvOQc5wsFTfybqtE=;
  b=ObMNXKnqJq0LytuImRYlRAEJ6gP9I8UPIX47PhWGQw8mZGr+3TUoIX4H
   if6pgI4LW1wLdyPx8VcE8zIqtx5Mqb/M7dCkmKIXuMf2nYPLCV2DWOWmB
   8EpWAXoGcH5vuqoOKH01JBnMd8o976CRr2nqv0LCgvxOrxWM/fsO616TZ
   O6oKEyq312cFimWiwJbbzA1X+Rxh5ecBIcaipxKXqYPi1CmFqAgmm/Ns/
   THE0LOExP3d2x2OGOYGcCdLpcy0cB0K6Z0hP+lxN0Tujxz8urKJa0Nl2Y
   GKwLr6MNN5yWQVnq51dzcgHpCgivDuCHi5mBoguKbOmk51a0UKSUxwQPJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="393410515"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="393410515"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 13:50:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="778028455"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="778028455"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2023 13:50:36 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRgiZ-00081t-2U;
        Mon, 13 Feb 2023 21:50:35 +0000
Date:   Tue, 14 Feb 2023 05:49:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Eckert <fe@dev.tdt.de>, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
Subject: Re: [PATCH 1/2] tty: new helper function tty_get_mget
Message-ID: <202302140536.fks6kujh-lkp@intel.com>
References: <20230213140638.620206-2-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230213140638.620206-2-fe@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus pavel-leds/for-next staging/staging-testing staging/staging-next staging/staging-linus linus/master v6.2-rc8 next-20230213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Eckert/tty-new-helper-function-tty_get_mget/20230213-223413
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230213140638.620206-2-fe%40dev.tdt.de
patch subject: [PATCH 1/2] tty: new helper function tty_get_mget
config: x86_64-randconfig-a005-20230213 (https://download.01.org/0day-ci/archive/20230214/202302140536.fks6kujh-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/096ca9c9428ec2a8ebab4af0798461e66585cdde
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Florian-Eckert/tty-new-helper-function-tty_get_mget/20230213-223413
        git checkout 096ca9c9428ec2a8ebab4af0798461e66585cdde
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302140536.fks6kujh-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/leds/trigger/ledtrig-tty.c:7:
   include/linux/tty.h:423:3: error: expected ')'
                   struct serial_icounter_struct *icount);
                   ^
   include/linux/tty.h:422:19: note: to match this '('
   int tty_get_icount(struct tty_struct *tty
                     ^
>> drivers/leds/trigger/ledtrig-tty.c:116:42: error: too many arguments to function call, expected single argument 'tty', have 2 arguments
           ret = tty_get_icount(trigger_data->tty, &icount);
                 ~~~~~~~~~~~~~~                    ^~~~~~~
   include/linux/tty.h:422:5: note: 'tty_get_icount' declared here
   int tty_get_icount(struct tty_struct *tty
       ^
   2 errors generated.


vim +/tty +116 drivers/leds/trigger/ledtrig-tty.c

fd4a641ac88fbb Uwe Kleine-König 2021-01-13   78  
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   79  static void ledtrig_tty_work(struct work_struct *work)
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   80  {
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   81  	struct ledtrig_tty_data *trigger_data =
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   82  		container_of(work, struct ledtrig_tty_data, dwork.work);
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   83  	struct serial_icounter_struct icount;
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   84  	int ret;
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   85  
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   86  	mutex_lock(&trigger_data->mutex);
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   87  
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   88  	if (!trigger_data->ttyname) {
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   89  		/* exit without rescheduling */
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   90  		mutex_unlock(&trigger_data->mutex);
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   91  		return;
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   92  	}
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   93  
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   94  	/* try to get the tty corresponding to $ttyname */
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   95  	if (!trigger_data->tty) {
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   96  		dev_t devno;
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   97  		struct tty_struct *tty;
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   98  		int ret;
fd4a641ac88fbb Uwe Kleine-König 2021-01-13   99  
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  100  		ret = tty_dev_name_to_number(trigger_data->ttyname, &devno);
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  101  		if (ret < 0)
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  102  			/*
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  103  			 * A device with this name might appear later, so keep
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  104  			 * retrying.
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  105  			 */
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  106  			goto out;
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  107  
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  108  		tty = tty_kopen_shared(devno);
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  109  		if (IS_ERR(tty) || !tty)
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  110  			/* What to do? retry or abort */
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  111  			goto out;
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  112  
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  113  		trigger_data->tty = tty;
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  114  	}
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  115  
fd4a641ac88fbb Uwe Kleine-König 2021-01-13 @116  	ret = tty_get_icount(trigger_data->tty, &icount);
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  117  	if (ret) {
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  118  		dev_info(trigger_data->tty->dev, "Failed to get icount, stopped polling\n");
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  119  		mutex_unlock(&trigger_data->mutex);
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  120  		return;
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  121  	}
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  122  
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  123  	if (icount.rx != trigger_data->rx ||
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  124  	    icount.tx != trigger_data->tx) {
ba8a86e4dadb33 Uwe Kleine-König 2021-02-19  125  		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  126  
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  127  		trigger_data->rx = icount.rx;
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  128  		trigger_data->tx = icount.tx;
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  129  	} else {
ba8a86e4dadb33 Uwe Kleine-König 2021-02-19  130  		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  131  	}
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  132  
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  133  out:
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  134  	mutex_unlock(&trigger_data->mutex);
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  135  	schedule_delayed_work(&trigger_data->dwork, msecs_to_jiffies(100));
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  136  }
fd4a641ac88fbb Uwe Kleine-König 2021-01-13  137  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
