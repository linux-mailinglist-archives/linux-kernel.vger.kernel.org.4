Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38406F2421
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 12:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjD2KbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 06:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjD2KbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 06:31:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0131B1BE1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 03:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682764261; x=1714300261;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zTOqmkEbQ+DxMgDz3Z8f38DUCSFgfHq12Q6zBdQDTjM=;
  b=DYQQ9ZlW87hbFd0eOxiQ7GV73Eaj2uuFjrYT5Xxg0RjH1dqSQ4pVzFZg
   8hDwFrnGjtOEGFg6O/f4x3scqOIxuUTi5h3OIJXHo0dVR/ri0DlnDeOat
   LTn2U1yB6ripuLdsnMfT6KteEmQEC6xtnvP6zC/jMR6TT2kY/5QiQOvKu
   +pE45T8ibvpEKYsv15X4OZYLrNEp3i5pltfhL+pLDSJEppdtpIvZB6kWL
   TNjnhuIFsfgHgXJAt0ukjcvSU4vLUI5k/dG3mkACcmhV22IMiyHOGrhV1
   /Y/6XCho/z4QFsOADmyXA0L3EtUW/VQWGi/VNeEqF8NZV0AQ8OGAPRrY+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="434222273"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="434222273"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 03:31:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="941448765"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="941448765"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 29 Apr 2023 03:31:00 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pshr1-000140-1H;
        Sat, 29 Apr 2023 10:30:59 +0000
Date:   Sat, 29 Apr 2023 18:30:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/scsi/fcoe/fcoe_ctlr.c:1871:13: warning: stack frame size
 (1072) exceeds limit (1024) in 'fcoe_ctlr_recv_work'
Message-ID: <202304291839.L1PvCRkL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89d77f71f493a3663b10fa812d17f472935d24be
commit: 54d9469bc515dc5fcbc20eecbe19cea868b70d68 fortify: Add run-time WARN for cross-field memcpy()
date:   8 months ago
config: riscv-randconfig-r015-20230429 (https://download.01.org/0day-ci/archive/20230429/202304291839.L1PvCRkL-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=54d9469bc515dc5fcbc20eecbe19cea868b70d68
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 54d9469bc515dc5fcbc20eecbe19cea868b70d68
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/scsi/fcoe/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304291839.L1PvCRkL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/fcoe/fcoe_ctlr.c:1871:13: warning: stack frame size (1072) exceeds limit (1024) in 'fcoe_ctlr_recv_work' [-Wframe-larger-than]
   static void fcoe_ctlr_recv_work(struct work_struct *recv_work)
               ^
   677/1072 (63.15%) spills, 395/1072 (36.85%) variables
   1 warning generated.


vim +/fcoe_ctlr_recv_work +1871 drivers/scsi/fcoe/fcoe_ctlr.c

97c8389d54b966 drivers/scsi/fcoe/libfcoe.c Joe Eykholt 2009-03-17  1866  
97c8389d54b966 drivers/scsi/fcoe/libfcoe.c Joe Eykholt 2009-03-17  1867  /**
70b51aabf3b03f drivers/scsi/fcoe/libfcoe.c Robert Love 2009-11-03  1868   * fcoe_ctlr_recv_work() - Worker thread function for receiving FIP frames
70b51aabf3b03f drivers/scsi/fcoe/libfcoe.c Robert Love 2009-11-03  1869   * @recv_work: Handle to a FCoE controller
97c8389d54b966 drivers/scsi/fcoe/libfcoe.c Joe Eykholt 2009-03-17  1870   */
97c8389d54b966 drivers/scsi/fcoe/libfcoe.c Joe Eykholt 2009-03-17 @1871  static void fcoe_ctlr_recv_work(struct work_struct *recv_work)
97c8389d54b966 drivers/scsi/fcoe/libfcoe.c Joe Eykholt 2009-03-17  1872  {
97c8389d54b966 drivers/scsi/fcoe/libfcoe.c Joe Eykholt 2009-03-17  1873  	struct fcoe_ctlr *fip;
97c8389d54b966 drivers/scsi/fcoe/libfcoe.c Joe Eykholt 2009-03-17  1874  	struct sk_buff *skb;
97c8389d54b966 drivers/scsi/fcoe/libfcoe.c Joe Eykholt 2009-03-17  1875  
97c8389d54b966 drivers/scsi/fcoe/libfcoe.c Joe Eykholt 2009-03-17  1876  	fip = container_of(recv_work, struct fcoe_ctlr, recv_work);
1f4aed818d26eb drivers/scsi/fcoe/libfcoe.c Joe Eykholt 2009-11-03  1877  	while ((skb = skb_dequeue(&fip->fip_recv_list)))
97c8389d54b966 drivers/scsi/fcoe/libfcoe.c Joe Eykholt 2009-03-17  1878  		fcoe_ctlr_recv_handler(fip, skb);
97c8389d54b966 drivers/scsi/fcoe/libfcoe.c Joe Eykholt 2009-03-17  1879  }
97c8389d54b966 drivers/scsi/fcoe/libfcoe.c Joe Eykholt 2009-03-17  1880  

:::::: The code at line 1871 was first introduced by commit
:::::: 97c8389d54b9665c38105ea72a428a44b97ff2f6 [SCSI] fcoe, libfcoe: Add support for FIP. FCoE discovery and keep-alive.

:::::: TO: Joe Eykholt <jeykholt@cisco.com>
:::::: CC: James Bottomley <James.Bottomley@HansenPartnership.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
