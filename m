Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A948E69B7A7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 03:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBRCHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 21:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRCHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 21:07:46 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078295F242;
        Fri, 17 Feb 2023 18:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676686065; x=1708222065;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mJAHrXAWrfL2lvxNdKWgwnv47B8c9wg7eap7KWQCYtQ=;
  b=Gm7tycKTAUgDzcA7xtci3AuQZRDY7r3AUrmBG4eP5aiAqj8W3ZPVD1FO
   OWnws3ndg1Rly0VWNt7JSSI6hJpEluLq2RpcVuP6rR77xpRyHhOctqcgQ
   ADTiGb7Vwr/wUwZ7dg3HYuaUKHNxYi52Q/djcr4wnA85wXje8aVi3fP/m
   rN33TYYLBLwdaFccZOKjs5DNLDPOJT938P+ITIqdVO/4i+TQsQmfa9rLm
   zMrG+LVIjTyg2bfWE8LwXLeFzcsVhkbwgvgy5lPwMB5+U70gsvcQV9V4A
   oQTH0EzWbshHI0K02SBS1XKZj4DFkT44okJkt/jFQ8thuDpLz7VhqP5kE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="311763201"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="311763201"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 18:07:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="813551667"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="813551667"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2023 18:07:43 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTCda-000C0L-15;
        Sat, 18 Feb 2023 02:07:42 +0000
Date:   Sat, 18 Feb 2023 10:07:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: drivers/staging/media/deprecated/saa7146/common/saa7146_hlp.c:648:5:
 warning: stack frame size (1072) exceeds limit (1024) in
 'saa7146_enable_overlay'
Message-ID: <202302180911.6Dde6M71-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dbeed98d89ea91ae68ff6dce6060671726292e85
commit: e33fdb5a02490059e2f48ced2c038c8a46c6476d media: saa7146: deprecate hexium_gemini/orion, mxb and ttpci
date:   6 months ago
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20230218/202302180911.6Dde6M71-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e33fdb5a02490059e2f48ced2c038c8a46c6476d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e33fdb5a02490059e2f48ced2c038c8a46c6476d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/staging/media/deprecated/saa7146/common/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302180911.6Dde6M71-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/staging/media/deprecated/saa7146/common/saa7146_hlp.c:648:5: warning: stack frame size (1072) exceeds limit (1024) in 'saa7146_enable_overlay' [-Wframe-larger-than]
   int saa7146_enable_overlay(struct saa7146_fh *fh)
       ^
   257/1072 (23.97%) spills, 815/1072 (76.03%) variables
   1 warning generated.


vim +/saa7146_enable_overlay +648 drivers/staging/media/deprecated/saa7146/common/saa7146_hlp.c

^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  647  
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16 @648  int saa7146_enable_overlay(struct saa7146_fh *fh)
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  649  {
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  650  	struct saa7146_dev *dev = fh->dev;
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  651  	struct saa7146_vv *vv = dev->vv_data;
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  652  
5da545ad08a3c6 drivers/media/common/saa7146_hlp.c Hans Verkuil   2012-05-01  653  	saa7146_set_window(dev, vv->ov.win.w.width, vv->ov.win.w.height, vv->ov.win.field);
5da545ad08a3c6 drivers/media/common/saa7146_hlp.c Hans Verkuil   2012-05-01  654  	saa7146_set_position(dev, vv->ov.win.w.left, vv->ov.win.w.top, vv->ov.win.w.height, vv->ov.win.field, vv->ov_fmt->pixelformat);
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  655  	saa7146_set_output_format(dev, vv->ov_fmt->trans);
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  656  	saa7146_set_clipping_rect(fh);
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  657  
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  658  	/* enable video dma1 */
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  659  	saa7146_write(dev, MC1, (MASK_06 | MASK_22));
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  660  	return 0;
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  661  }
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  662  

:::::: The code at line 648 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
