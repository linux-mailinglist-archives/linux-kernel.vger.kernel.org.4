Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029EF728C24
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbjFIAEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjFIAEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:04:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4772733;
        Thu,  8 Jun 2023 17:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686269039; x=1717805039;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fymNTbVpyMtUrnTiFAG8s1bvxZisFSkwOOtOcGLXR64=;
  b=KV+lKkfP2tguiB1iO/ugw77w1F+vu5PkB1WatUI6BJAVoo3QdjI9bwdw
   iF27PZFUNkes8ZG1730BJt78IH7ZIJX3zlpqbx6BFOI7BVs6fAQfTLKd/
   /zWV61X5XTJHlEwhJC9x4gF2tDjS3PHKic7GZELjApkOJRLeomJJaxUmy
   b4Xr0z8p/0WrAmehHKtKHyhcdTk1x0ZekNmEim3RK1MHuyuMaATzDqCZC
   ceYkCDAbPVF/cWC/La+dnw0VrzCvL9ayA/G6LvihsV7+63wbtsQybIkoQ
   wxI21mdjTts6WZWYBk5kVs6J1XfTj0a1ZJBlDdgRkR9HKKksUTE8FIDlx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342142873"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="342142873"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 17:03:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713296039"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="713296039"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2023 17:03:49 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7PbY-0008N6-1W;
        Fri, 09 Jun 2023 00:03:48 +0000
Date:   Fri, 9 Jun 2023 08:03:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/tuners/xc2028.c:717:12: warning: stack frame size
 (3520) exceeds limit (2048) in 'check_firmware'
Message-ID: <202306090751.d3DQi8se-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8d15d5e1851b1bbb9cd3289b84c7f32399e06ac5
commit: d76231e460fbaba7115212bf55f1eab35aba6223 media: xc2028: rename the driver from tuner-xc2028
date:   1 year, 3 months ago
config: riscv-randconfig-r012-20230608 (https://download.01.org/0day-ci/archive/20230609/202306090751.d3DQi8se-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d76231e460fbaba7115212bf55f1eab35aba6223
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d76231e460fbaba7115212bf55f1eab35aba6223
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/ drivers/hid/ drivers/media/tuners/ lib/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306090751.d3DQi8se-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/tuners/xc2028.c:717:12: warning: stack frame size (3520) exceeds limit (2048) in 'check_firmware' [-Wframe-larger-than]
   static int check_firmware(struct dvb_frontend *fe, unsigned int type,
              ^
   1 warning generated.


vim +/check_firmware +717 drivers/media/tuners/xc2028.c

ebf044f46f138b drivers/media/tuners/tuner-xc2028.c        Mauro Carvalho Chehab 2014-01-06  716  
00deff1a076dc1 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-24 @717  static int check_firmware(struct dvb_frontend *fe, unsigned int type,
66c2d53db28276 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-25  718  			  v4l2_std_id std, __u16 int_freq)
6cb45879dca84c drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-02  719  {
215b95baf969c6 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-23  720  	struct xc2028_data         *priv = fe->tuner_priv;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  721  	struct firmware_properties new_fw;
61a96113de51e1 drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2012-06-30  722  	int			   rc, retry_count = 0;
7d58d1117ec02f drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  723  	u16			   version, hwmodel;
47bd5bc6486a52 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  724  	v4l2_std_id		   std0;
6cb45879dca84c drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-02  725  
7e28adb2497f6b drivers/media/video/tuner-xc2028.c         Harvey Harrison       2008-04-08  726  	tuner_dbg("%s called\n", __func__);
6cb45879dca84c drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-02  727  
61a96113de51e1 drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2012-06-30  728  	rc = check_device_status(priv);
de3fe21ba2fdc0 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-24  729  	if (rc < 0)
de3fe21ba2fdc0 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-24  730  		return rc;
de3fe21ba2fdc0 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-24  731  
0f6dac18ccc6fb drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2008-01-05  732  	if (priv->ctrl.mts && !(type & FM))
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  733  		type |= MTS;
6cb45879dca84c drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-02  734  
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  735  retry:
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  736  	new_fw.type = type;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  737  	new_fw.id = std;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  738  	new_fw.std_req = std;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  739  	new_fw.scode_table = SCODE | priv->ctrl.scode_table;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  740  	new_fw.scode_nr = 0;
66c2d53db28276 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-25  741  	new_fw.int_freq = int_freq;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  742  
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  743  	tuner_dbg("checking firmware, user requested type=");
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  744  	if (debug) {
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  745  		dump_firm_type(new_fw.type);
15c8ffc41a1559 drivers/media/tuners/tuner-xc2028.c        Mauro Carvalho Chehab 2016-10-12  746  		printk(KERN_CONT "(%x), id %016llx, ", new_fw.type,
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  747  		       (unsigned long long)new_fw.std_req);
e026268870b5f0 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-12-02  748  		if (!int_freq) {
15c8ffc41a1559 drivers/media/tuners/tuner-xc2028.c        Mauro Carvalho Chehab 2016-10-12  749  			printk(KERN_CONT "scode_tbl ");
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  750  			dump_firm_type(priv->ctrl.scode_table);
15c8ffc41a1559 drivers/media/tuners/tuner-xc2028.c        Mauro Carvalho Chehab 2016-10-12  751  			printk(KERN_CONT "(%x), ", priv->ctrl.scode_table);
e026268870b5f0 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-12-02  752  		} else
15c8ffc41a1559 drivers/media/tuners/tuner-xc2028.c        Mauro Carvalho Chehab 2016-10-12  753  			printk(KERN_CONT "int_freq %d, ", new_fw.int_freq);
15c8ffc41a1559 drivers/media/tuners/tuner-xc2028.c        Mauro Carvalho Chehab 2016-10-12  754  		printk(KERN_CONT "scode_nr %d\n", new_fw.scode_nr);
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  755  	}
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  756  
61a96113de51e1 drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2012-06-30  757  	/*
61a96113de51e1 drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2012-06-30  758  	 * No need to reload base firmware if it matches and if the tuner
61a96113de51e1 drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2012-06-30  759  	 * is not at sleep mode
61a96113de51e1 drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2012-06-30  760  	 */
3a495ed77a2f58 drivers/media/common/tuners/tuner-xc2028.c Dan Carpenter         2012-07-21  761  	if ((priv->state == XC2028_ACTIVE) &&
61a96113de51e1 drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2012-06-30  762  	    (((BASE | new_fw.type) & BASE_TYPES) ==
61a96113de51e1 drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2012-06-30  763  	    (priv->cur_fw.type & BASE_TYPES))) {
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  764  		tuner_dbg("BASE firmware not changed.\n");
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  765  		goto skip_base;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  766  	}
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  767  
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  768  	/* Updating BASE - forget about all currently loaded firmware */
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  769  	memset(&priv->cur_fw, 0, sizeof(priv->cur_fw));
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  770  
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  771  	/* Reset is needed before loading firmware */
d7cba043d7ec84 drivers/media/common/tuners/tuner-xc2028.c Michael Krufky        2008-09-12  772  	rc = do_tuner_callback(fe, XC2028_TUNER_RESET, 0);
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  773  	if (rc < 0)
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  774  		goto fail;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  775  
47bd5bc6486a52 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  776  	/* BASE firmwares are all std0 */
47bd5bc6486a52 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  777  	std0 = 0;
47bd5bc6486a52 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  778  	rc = load_firmware(fe, BASE | new_fw.type, &std0);
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  779  	if (rc < 0) {
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  780  		tuner_err("Error %d while loading base firmware\n",
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  781  			  rc);
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  782  		goto fail;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  783  	}
5403bbae9bfebe drivers/media/video/tuner-xc2028.c         Michel Ludwig         2007-11-16  784  
de3fe21ba2fdc0 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-24  785  	/* Load INIT1, if needed */
83fb340b318487 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  786  	tuner_dbg("Load init1 firmware, if exists\n");
de3fe21ba2fdc0 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-24  787  
47bd5bc6486a52 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  788  	rc = load_firmware(fe, BASE | INIT1 | new_fw.type, &std0);
1ad0b796a3fa3d drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  789  	if (rc == -ENOENT)
1ad0b796a3fa3d drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  790  		rc = load_firmware(fe, (BASE | INIT1 | new_fw.type) & ~F8MHZ,
1ad0b796a3fa3d drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  791  				   &std0);
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  792  	if (rc < 0 && rc != -ENOENT) {
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  793  		tuner_err("Error %d while loading init1 firmware\n",
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  794  			  rc);
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  795  		goto fail;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  796  	}
de3fe21ba2fdc0 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-24  797  
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  798  skip_base:
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  799  	/*
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  800  	 * No need to reload standard specific firmware if base firmware
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  801  	 * was not reloaded and requested video standards have not changed.
de3fe21ba2fdc0 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-24  802  	 */
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  803  	if (priv->cur_fw.type == (BASE | new_fw.type) &&
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  804  	    priv->cur_fw.std_req == std) {
83fb340b318487 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  805  		tuner_dbg("Std-specific firmware already loaded.\n");
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  806  		goto skip_std_specific;
2e4160ca8046e3 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-07-18  807  	}
6cb45879dca84c drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-02  808  
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  809  	/* Reloading std-specific firmware forces a SCODE update */
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  810  	priv->cur_fw.scode_table = 0;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  811  
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  812  	rc = load_firmware(fe, new_fw.type, &new_fw.id);
cca83798119c92 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-22  813  	if (rc == -ENOENT)
cca83798119c92 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-22  814  		rc = load_firmware(fe, new_fw.type & ~F8MHZ, &new_fw.id);
cca83798119c92 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-22  815  
6cb45879dca84c drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-02  816  	if (rc < 0)
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  817  		goto fail;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  818  
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  819  skip_std_specific:
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  820  	if (priv->cur_fw.scode_table == new_fw.scode_table &&
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  821  	    priv->cur_fw.scode_nr == new_fw.scode_nr) {
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  822  		tuner_dbg("SCODE firmware already loaded.\n");
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  823  		goto check_device;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  824  	}
6cb45879dca84c drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-02  825  
40ae91a758df91 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2008-02-14  826  	if (new_fw.type & FM)
40ae91a758df91 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2008-02-14  827  		goto check_device;
40ae91a758df91 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2008-02-14  828  
f380e1d2c9a1ff drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  829  	/* Load SCODE firmware, if exists */
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  830  	tuner_dbg("Trying to load scode %d\n", new_fw.scode_nr);
f380e1d2c9a1ff drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-15  831  
66c2d53db28276 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-25  832  	rc = load_scode(fe, new_fw.type | new_fw.scode_table, &new_fw.id,
66c2d53db28276 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-25  833  			new_fw.int_freq, new_fw.scode_nr);
43efe70253dd13 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-14  834  
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  835  check_device:
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  836  	if (xc2028_get_reg(priv, 0x0004, &version) < 0 ||
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  837  	    xc2028_get_reg(priv, 0x0008, &hwmodel) < 0) {
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  838  		tuner_err("Unable to read tuner registers.\n");
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  839  		goto fail;
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  840  	}
80b522085a2c87 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-05  841  
2af3eb647e9b90 drivers/media/tuners/tuner-xc2028.c        Mauro Carvalho Chehab 2016-10-12  842  	tuner_dbg("Device is Xceive %d version %d.%d, firmware version %d.%d\n",
80b522085a2c87 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-05  843  		  hwmodel, (version & 0xf000) >> 12, (version & 0xf00) >> 8,
80b522085a2c87 drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-11-05  844  		  (version & 0xf0) >> 4, version & 0xf);
6cb45879dca84c drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-02  845  
0fb84ce0dbffee drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2008-12-02  846  
0fb84ce0dbffee drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2008-12-02  847  	if (priv->ctrl.read_not_reliable)
0fb84ce0dbffee drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2008-12-02  848  		goto read_not_reliable;
0fb84ce0dbffee drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2008-12-02  849  
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  850  	/* Check firmware version against what we downloaded. */
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  851  	if (priv->firm_version != ((version & 0xf0) << 4 | (version & 0x0f))) {
2d5024a9e97337 drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2009-09-14  852  		if (!priv->ctrl.read_not_reliable) {
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  853  			tuner_err("Incorrect readback of firmware version.\n");
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  854  			goto fail;
2d5024a9e97337 drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2009-09-14  855  		} else {
2af3eb647e9b90 drivers/media/tuners/tuner-xc2028.c        Mauro Carvalho Chehab 2016-10-12  856  			tuner_err("Returned an incorrect version. However, read is not reliable enough. Ignoring it.\n");
2d5024a9e97337 drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2009-09-14  857  			hwmodel = 3028;
2d5024a9e97337 drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2009-09-14  858  		}
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  859  	}
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  860  
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  861  	/* Check that the tuner hardware model remains consistent over time. */
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  862  	if (priv->hwmodel == 0 && (hwmodel == 2028 || hwmodel == 3028)) {
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  863  		priv->hwmodel = hwmodel;
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  864  		priv->hwvers  = version & 0xff00;
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  865  	} else if (priv->hwmodel == 0 || priv->hwmodel != hwmodel ||
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  866  		   priv->hwvers != (version & 0xff00)) {
2af3eb647e9b90 drivers/media/tuners/tuner-xc2028.c        Mauro Carvalho Chehab 2016-10-12  867  		tuner_err("Read invalid device hardware information - tuner hung?\n");
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  868  		goto fail;
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  869  	}
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  870  
0fb84ce0dbffee drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2008-12-02  871  read_not_reliable:
03c420010f4c5d drivers/media/tuners/tuner-xc2028.c        Ezequiel Garcia       2012-10-23  872  	priv->cur_fw = new_fw;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  873  
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  874  	/*
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  875  	 * By setting BASE in cur_fw.type only after successfully loading all
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  876  	 * firmwares, we can:
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  877  	 * 1. Identify that BASE firmware with type=0 has been loaded;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  878  	 * 2. Tell whether BASE firmware was just changed the next time through.
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  879  	 */
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  880  	priv->cur_fw.type |= BASE;
61a96113de51e1 drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2012-06-30  881  	priv->state = XC2028_ACTIVE;
6cb45879dca84c drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-02  882  
6cb45879dca84c drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-02  883  	return 0;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  884  
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  885  fail:
22a1e7783e173a drivers/media/tuners/tuner-xc2028.c        Takashi Iwai          2016-11-17  886  	free_firmware(priv);
61a96113de51e1 drivers/media/common/tuners/tuner-xc2028.c Mauro Carvalho Chehab 2012-06-30  887  
b8bc77db1e23c6 drivers/media/common/tuners/tuner-xc2028.c Alina Friedrichsen    2011-01-23  888  	if (retry_count < 8) {
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  889  		msleep(50);
b8bc77db1e23c6 drivers/media/common/tuners/tuner-xc2028.c Alina Friedrichsen    2011-01-23  890  		retry_count++;
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  891  		tuner_dbg("Retrying firmware load\n");
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  892  		goto retry;
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  893  	}
8bf799a6217f63 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  894  
ebf044f46f138b drivers/media/tuners/tuner-xc2028.c        Mauro Carvalho Chehab 2014-01-06  895  	/* Firmware didn't load. Put the device to sleep */
ebf044f46f138b drivers/media/tuners/tuner-xc2028.c        Mauro Carvalho Chehab 2014-01-06  896  	xc2028_sleep(fe);
ebf044f46f138b drivers/media/tuners/tuner-xc2028.c        Mauro Carvalho Chehab 2014-01-06  897  
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  898  	if (rc == -ENOENT)
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  899  		rc = -EINVAL;
e0f0b37a3e6244 drivers/media/video/tuner-xc2028.c         Chris Pascoe          2007-11-19  900  	return rc;
6cb45879dca84c drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-02  901  }
6cb45879dca84c drivers/media/video/tuner-xc2028.c         Mauro Carvalho Chehab 2007-10-02  902  

:::::: The code at line 717 was first introduced by commit
:::::: 00deff1a076dc1cf6743813657623626720bf0f5 V4L/DVB (6671): Avoids checking digital/analog at check_firmware

:::::: TO: Mauro Carvalho Chehab <mchehab@infradead.org>
:::::: CC: Mauro Carvalho Chehab <mchehab@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
