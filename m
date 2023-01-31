Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ABC682BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjAaLzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjAaLy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:54:58 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034E016AE4;
        Tue, 31 Jan 2023 03:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675166095; x=1706702095;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ou7PMp5acdV7RgjsgZCydhFDy8bgWAyFGa1btEiHIfo=;
  b=S2ep36UCTqiGLbOtyAwSU8E3FuovUUwpoKq0cULFJ8SryjeyWUJWLr8K
   YD/h5f3eDQ5wuRrJFf+bTS7YP2Ryhe91hn7F2JEPkQc74vz3DNS8IxozV
   kROPJqnrrOl/N6Dn8et8aemURGcTYvLLJxNwvDyxJC5Maf/sWSjs6u7+N
   mNDOIRH0uuHZPGIaLxKRJLMA5zR7O2/8DJd8sDGaq7asq+RcgGgCQXmA1
   IdHEXrKuZokNflwuv3T/Ex2tuIfOYAuq3FtYZNwovNqO6WcMq4xlKbkHx
   kJmehnJUt3RBaCoUqeiFZHm67fQCbf9GOCVBIB79g+k1Nu/3gqrudY2jR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="414035235"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="414035235"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 03:54:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="641951844"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="641951844"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Jan 2023 03:54:52 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMpDv-0004PO-16;
        Tue, 31 Jan 2023 11:54:51 +0000
Date:   Tue, 31 Jan 2023 19:54:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: drivers/staging/media/deprecated/saa7146/common/saa7146_hlp.c:648:5:
 warning: stack frame size (1072) exceeds limit (1024) in
 'saa7146_enable_overlay'
Message-ID: <202301311905.1FjIpgOK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   22b8077d0fcec86c6ed0e0fce9f7e7e5a4c2d56a
commit: e33fdb5a02490059e2f48ced2c038c8a46c6476d media: saa7146: deprecate hexium_gemini/orion, mxb and ttpci
date:   5 months ago
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230131/202301311905.1FjIpgOK-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/mellanox/mlx5/core/steering/ drivers/staging/media/deprecated/saa7146/common/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

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
