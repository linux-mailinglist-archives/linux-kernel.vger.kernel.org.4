Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C7F728241
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbjFHOHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbjFHOHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816C830C7;
        Thu,  8 Jun 2023 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233226; x=1717769226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oa6x8KM0eNi6FTDPQxF93G9pAVh+iU8hs4FXo1R4OIU=;
  b=Zn4Eytj6OY+MIRunDRmQT19ayQ8JAKoSBMyKMnt2JBnH0uQCY6nF3YEF
   5kk5C1yhnPkCmmNaTSNErekZ5Dflb7xQWo9llM/LEyTvrESn6ANuxk/K+
   5AnO6dg3uC1H5j3/13nESNmoZjq+Ouk5tkXmfe2d87pAeNVgZukq5Z+2d
   JABEUrGPHAVCFQaCEWs6OcVwipVYqhsKAmqTohyXe+xQ0erIRqxyzixGB
   1o9XbJZ7c/bZm/wjuP4Ae0y9flWYGSOs8ZpiCKU90Ky2XEpEFzL5vzz0a
   5/s6Tw7Wvsq7uS4w0FrH7owA3A9L0Eea5pv2zAnyiZ3GmzY6dMVTmC7vX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176152"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176152"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="660379152"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="660379152"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Jun 2023 06:36:13 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7FoD-0007qC-0q;
        Thu, 08 Jun 2023 13:36:13 +0000
Date:   Thu, 8 Jun 2023 21:35:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Joshua Dickens <Joshua@joshua-dickens.com>,
        Jason Gerecke <jason.gerecke@wacom.com>
Subject: Re: [PATCH] HID: wacom: Use ktime_t rather than int when dealing
 with timestamps
Message-ID: <202306082127.6r7qAALi-lkp@intel.com>
References: <20230607214102.2113-1-jason.gerecke@wacom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607214102.2113-1-jason.gerecke@wacom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[also build test ERROR on linus/master v6.4-rc5 next-20230608]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Gerecke/HID-wacom-Use-ktime_t-rather-than-int-when-dealing-with-timestamps/20230608-054255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20230607214102.2113-1-jason.gerecke%40wacom.com
patch subject: [PATCH] HID: wacom: Use ktime_t rather than int when dealing with timestamps
config: arc-randconfig-c003-20230608 (https://download.01.org/0day-ci/archive/20230608/202306082127.6r7qAALi-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hid https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
        git fetch hid for-next
        git checkout hid/for-next
        b4 shazam https://lore.kernel.org/r/20230607214102.2113-1-jason.gerecke@wacom.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306082127.6r7qAALi-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__divdi3" [drivers/hid/wacom.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
