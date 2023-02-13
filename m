Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7056950A6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjBMT1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjBMT1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:27:06 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FB11F925;
        Mon, 13 Feb 2023 11:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676316423; x=1707852423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Dul4F7DMk/3e5EF5hfjZuKYjBrTrPsCyZnnoSZ0rNQ=;
  b=aEptj9B/RBkLR5uA9k9Ijkox4/YfVonH4y7tHUwleMunRAdDQ3e/+ydn
   Uz0ZbRWVOfeQdmr/gU/O0GbrniwuvYLbQSCNVl3fyTkATpgatQf+ZlTAV
   qnkFiyINtdDB+L4BO0iyYWOmidrMRHMrssD6tB2vNRYAVx5w/FnRilh6+
   ldZ/ZNK/vrWuMxJ7KsxT3DqxPoTrZgETr/LcJ0PhMzkjlT63AZGOjhMzs
   RC5ZR+UfKXQBMLrYPc0V3ryFzim57dQBhgzOTR1MMPl5gQ1ePJjzjCKQ5
   zTMp5DU05zcU93HGwImnCH+U0r3iNQEfjyG+7S3iAkEZlgmK5sW94e3F7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="358382954"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="358382954"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:26:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="701390906"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="701390906"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2023 11:26:33 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pReTA-0007yT-19;
        Mon, 13 Feb 2023 19:26:32 +0000
Date:   Tue, 14 Feb 2023 03:25:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Eckert <fe@dev.tdt.de>, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
Subject: Re: [PATCH 1/2] tty: new helper function tty_get_mget
Message-ID: <202302140339.1vFSjZ1M-lkp@intel.com>
References: <20230213140638.620206-2-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213140638.620206-2-fe@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus pavel-leds/for-next staging/staging-testing staging/staging-next staging/staging-linus linus/master v6.2-rc8 next-20230213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Eckert/tty-new-helper-function-tty_get_mget/20230213-223413
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230213140638.620206-2-fe%40dev.tdt.de
patch subject: [PATCH 1/2] tty: new helper function tty_get_mget
config: x86_64-randconfig-a002-20230213 (https://download.01.org/0day-ci/archive/20230214/202302140339.1vFSjZ1M-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/bcm-vk/ drivers/tty/ fs/proc/ init/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302140339.1vFSjZ1M-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/tty/tty_port.c:8:
   include/linux/tty.h:423:3: error: expected ')'
                   struct serial_icounter_struct *icount);
                   ^
   include/linux/tty.h:422:19: note: to match this '('
   int tty_get_icount(struct tty_struct *tty
                     ^
>> drivers/tty/tty_port.c:266:2: warning: implicit conversion from 'unsigned long' to 'unsigned int' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
           INIT_KFIFO(port->xmit_fifo);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:130:69: note: expanded from macro 'INIT_KFIFO'
           __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : ARRAY_SIZE(__tmp->buf) - 1;\
                         ~                             ~~~~~~~~~~~~~~~~~~~~~~~^~~
   1 warning and 1 error generated.
--
   In file included from fs/proc/array.c:62:
   include/linux/tty.h:423:3: error: expected ')'
                   struct serial_icounter_struct *icount);
                   ^
   include/linux/tty.h:422:19: note: to match this '('
   int tty_get_icount(struct tty_struct *tty
                     ^
   In file included from fs/proc/array.c:64:
>> include/linux/mman.h:154:9: warning: division by zero is undefined [-Wdivision-by-zero]
                  _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:132:21: note: expanded from macro '_calc_vm_trans'
      : ((x) & (bit1)) / ((bit1) / (bit2))))
                       ^ ~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.
--
   In file included from drivers/misc/bcm-vk/bcm_vk_dev.c:20:
   In file included from drivers/misc/bcm-vk/bcm_vk.h:18:
   include/linux/tty.h:423:3: error: expected ')'
                   struct serial_icounter_struct *icount);
                   ^
   include/linux/tty.h:422:19: note: to match this '('
   int tty_get_icount(struct tty_struct *tty
                     ^
>> drivers/misc/bcm-vk/bcm_vk_dev.c:1320:6: warning: shift count >= width of type [-Wshift-count-overflow]
                                           DMA_BIT_MASK(BCM_VK_DMA_BITS));
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   1 warning and 1 error generated.


vim +266 drivers/tty/tty_port.c

9e48565d217a8a drivers/char/tty_port.c Alan Cox   2008-10-13  260  
9e48565d217a8a drivers/char/tty_port.c Alan Cox   2008-10-13  261  void tty_port_free_xmit_buf(struct tty_port *port)
9e48565d217a8a drivers/char/tty_port.c Alan Cox   2008-10-13  262  {
44e4909e453eaa drivers/char/tty_port.c Alan Cox   2009-11-30  263  	mutex_lock(&port->buf_mutex);
9e48565d217a8a drivers/char/tty_port.c Alan Cox   2008-10-13  264  	free_page((unsigned long)port->xmit_buf);
9e48565d217a8a drivers/char/tty_port.c Alan Cox   2008-10-13  265  	port->xmit_buf = NULL;
4e2a44c1408b6a drivers/tty/tty_port.c  Jiri Slaby 2022-01-24 @266  	INIT_KFIFO(port->xmit_fifo);
44e4909e453eaa drivers/char/tty_port.c Alan Cox   2009-11-30  267  	mutex_unlock(&port->buf_mutex);
9e48565d217a8a drivers/char/tty_port.c Alan Cox   2008-10-13  268  }
9e48565d217a8a drivers/char/tty_port.c Alan Cox   2008-10-13  269  EXPORT_SYMBOL(tty_port_free_xmit_buf);
9e48565d217a8a drivers/char/tty_port.c Alan Cox   2008-10-13  270  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
