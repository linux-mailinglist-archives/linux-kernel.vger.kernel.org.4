Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A086BF81C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 06:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjCRFqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 01:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjCRFqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 01:46:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C6034F68
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 22:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679118396; x=1710654396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v9eB5JkgWbfJRDOeGsFJR4NKDaaEpmYmAYqO21RbRDY=;
  b=c06pCFblj2l3QTQHGkio0RYB9cmsZznYSTcswPEJehLOuSChg8nsWY4r
   dPBRce+/9FPX2o67CutLdxv3ZON5t4JKbWl3RET781Gb1NUUtax9Uoab/
   r2VlccDlW4HuVwykbQ/dr/JkNzLR6yvZ1oXA2HMpAUmuS+Gr7/Zgygemk
   BgL9AvQBJ6ICNHRMGttxLlWcaBGVetrhk6eS23/7XHAIhUfjqBNdjNLll
   Ndn0hXXSXd/HQKRe5ZTPinIuZARusnj4HaPuwgfmi/HIIZl3pWKTntaha
   a5YZlurhiSnv87XvNFw6iNGgaapAiN8g4wAARsl/iXOcIvKTldXjDRSdD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="335905687"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="335905687"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 22:46:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="744788455"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="744788455"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Mar 2023 22:46:35 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdPOk-0009po-1G;
        Sat, 18 Mar 2023 05:46:34 +0000
Date:   Sat, 18 Mar 2023 13:46:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Keeping <john@metanate.com>, Takashi Iwai <tiwai@suse.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        John Keeping <john@metanate.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: usb-audio: Fix recursive locking on XRUN
Message-ID: <202303181348.8bLUUc1G-lkp@intel.com>
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
[also build test ERROR on tiwai-sound/for-linus linus/master v6.3-rc2 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Keeping/ALSA-usb-audio-Fix-recursive-locking-on-XRUN/20230318-035430
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20230317195128.3911155-1-john%40metanate.com
patch subject: [PATCH] ALSA: usb-audio: Fix recursive locking on XRUN
config: x86_64-randconfig-a013-20230313 (https://download.01.org/0day-ci/archive/20230318/202303181348.8bLUUc1G-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/21bbf1266d22cbc0e1ec7c8d535738f66bbc9801
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review John-Keeping/ALSA-usb-audio-Fix-recursive-locking-on-XRUN/20230318-035430
        git checkout 21bbf1266d22cbc0e1ec7c8d535738f66bbc9801
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303181348.8bLUUc1G-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "snd_pcm_stop_xrun_under_stream_lock" [sound/usb/snd-usb-audio.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
