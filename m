Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9467D6BF765
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 03:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjCRCaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 22:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCRCad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 22:30:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BDE298C4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 19:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679106631; x=1710642631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GvmzAJef4m3BJVSEAGAssA83vtoA9QXJ2aaMijbn1ok=;
  b=S5hERZF5NcaG6H7nEDTTnFtLkoS/O5Xby8iy1LrEpCV2z4rRPhd7m40R
   uyVnDf1JB9FQo1ABvvxe6UQaYWimnO2WtJxOvwj/HXriH+Wp3diiDZ8WX
   JTcl2NvKb5Sj+Zw8ww/xVDCFlBnl8iU6RhndW34Em/Tn3Ao6zwzgKrIGT
   3Ih0Hu/PybaliiNrwYjlL5E2Xy9iWegHV6HF1GBqz1/K1TgX58zski+jE
   4BVZ76R/Nk6PydCtrqrbk6/szUKfNEJjXLCTcDkNx10uDWsnKCwsTpKac
   EObU/8q06ObSWucFZdkqsLMTem4O0enOZgzTtCUcillqdA0FQB7s8Si+i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="335894894"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="335894894"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 19:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="673775340"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="673775340"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 17 Mar 2023 19:30:29 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdMKy-0009js-2F;
        Sat, 18 Mar 2023 02:30:28 +0000
Date:   Sat, 18 Mar 2023 10:29:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Keeping <john@metanate.com>, Takashi Iwai <tiwai@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev, John Keeping <john@metanate.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: usb-audio: Fix recursive locking on XRUN
Message-ID: <202303181006.qGZbdrAN-lkp@intel.com>
References: <20230317195128.3911155-1-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317195128.3911155-1-john@metanate.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tiwai-sound/for-next]
[also build test ERROR on tiwai-sound/for-linus v6.3-rc2 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Keeping/ALSA-usb-audio-Fix-recursive-locking-on-XRUN/20230318-035430
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20230317195128.3911155-1-john%40metanate.com
patch subject: [PATCH] ALSA: usb-audio: Fix recursive locking on XRUN
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230318/202303181006.qGZbdrAN-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/21bbf1266d22cbc0e1ec7c8d535738f66bbc9801
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review John-Keeping/ALSA-usb-audio-Fix-recursive-locking-on-XRUN/20230318-035430
        git checkout 21bbf1266d22cbc0e1ec7c8d535738f66bbc9801
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303181006.qGZbdrAN-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "snd_pcm_stop_xrun_under_stream_lock" [sound/usb/snd-usb-audio.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
