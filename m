Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF95F6A63C6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjB1XXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB1XXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:23:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF81FF06
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677626579; x=1709162579;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H3NtiTL57k3QRMzsEg5CLuDxysALqPEoOP7/lIquUZ0=;
  b=KtLN9B8qM/7sV2SVNl/32ps4eQefTaiJXXuQ2Kd/89HGGT/dFe9IMTpG
   r5cYcqnOw+mfziQIo5DlAGYWypglSy9oXmfjrzolUxiVg7htbDd+MVuY6
   ZoR3PIAcMFHQZ8FNtLgkJxirIB0IwLA6yk9DjoTVvEtFZq8ArWK+Y7QVw
   +Z/Eerv28crqCZmsVDbRC6ZkBTanvJDdPFFrerFemHO9sjs1t1IDvVA31
   kLHzGOMftrxrmwuNX/PC/FfI/3uer42+5TGe50W5p+Ugz2gEh9fGpDxvw
   m6d2j8xyPNolH21v9JTDz+fUdZKMtnAOHzRMAvPnroDJXV7UvsIajaXPL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="335763426"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="335763426"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 15:22:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="798216216"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="798216216"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2023 15:22:55 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pX9J8-0005iH-1N;
        Tue, 28 Feb 2023 23:22:54 +0000
Date:   Wed, 1 Mar 2023 07:22:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko]
 undefined!
Message-ID: <202303010701.KWYce0Mt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yonghong,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e492250d5252635b6c97d52eddf2792ec26f1ec1
commit: dffbbdc2d9889670c30e07d05fc0dd712e8ad430 libbpf: Add enum64 parsing and new enum64 public API
date:   9 months ago
config: s390-randconfig-r021-20230227 (https://download.01.org/0day-ci/archive/20230301/202303010701.KWYce0Mt-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dffbbdc2d9889670c30e07d05fc0dd712e8ad430
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dffbbdc2d9889670c30e07d05fc0dd712e8ad430
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303010701.KWYce0Mt-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
>> ERROR: modpost: "ioremap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
ERROR: modpost: "ioremap" [drivers/net/arcnet/com90xx.ko] undefined!
ERROR: modpost: "iounmap" [drivers/net/arcnet/com90xx.ko] undefined!
>> ERROR: modpost: "iounmap" [drivers/pcmcia/pcmcia.ko] undefined!
>> ERROR: modpost: "ioremap" [drivers/pcmcia/pcmcia.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
