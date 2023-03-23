Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F046C700A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjCWSNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWSNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:13:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BA930EA;
        Thu, 23 Mar 2023 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679595221; x=1711131221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CItIdhfWQzSLqxClwXxP9K65h4AwMiALZAMPIBdeqKQ=;
  b=Di8YOgegGwVwZXe6uCG4j3xAscsSn3jwWzGMTCyVshy60WLww2MsRWHe
   3lPpCIPYigQ4i8hwFvw0Pm94p+I/rb+fBbZ9o3LIAhU5jMK9gx36RyhVE
   vM5T8VXcEZifx+8C0ufXi6huZWiy5RNDVkl4ML3LLTCDcEhUArKiua9B/
   wiMwMx4Mp7BjdxW9/lx6X2TDwTl7PWcu2kgsS1T1ciWkuYMGIn2V2NTD+
   JJ4IXwPnpIsdJqcB6GPmu3P6ei+PdCifqc426SCUc5n3KdPkRbt9NyXN/
   9C9pw5gslAyHef93fP5FCnJWyr6iSXDFvGInZGH0YhO3jPhSZGlNxXIsi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="402162368"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="402162368"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 11:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="714924898"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="714924898"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Mar 2023 11:13:38 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfPRS-000Ebo-06;
        Thu, 23 Mar 2023 18:13:38 +0000
Date:   Fri, 24 Mar 2023 02:13:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, dgilbert@interlog.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v2 06/11] scsi: scsi_debug: Dynamically allocate
 sdebug_queued_cmd
Message-ID: <202303240216.2NoF5RCq-lkp@intel.com>
References: <20230323094555.584624-7-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323094555.584624-7-john.g.garry@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on next-20230323]
[cannot apply to jejb-scsi/for-next linus/master v6.3-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Garry/scsi-scsi_debug-Fix-check-for-sdev-queue-full/20230323-175305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230323094555.584624-7-john.g.garry%40oracle.com
patch subject: [PATCH v2 06/11] scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20230324/202303240216.2NoF5RCq-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/be81e49de2c71f280dd3eac902d05afcb1061d12
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review John-Garry/scsi-scsi_debug-Fix-check-for-sdev-queue-full/20230323-175305
        git checkout be81e49de2c71f280dd3eac902d05afcb1061d12
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303240216.2NoF5RCq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/scsi_debug.c:5579:27: warning: no previous prototype for 'sdebug_alloc_queued_cmd' [-Wmissing-prototypes]
    5579 | struct sdebug_queued_cmd *sdebug_alloc_queued_cmd(struct scsi_cmnd *scmd)
         |                           ^~~~~~~~~~~~~~~~~~~~~~~


vim +/sdebug_alloc_queued_cmd +5579 drivers/scsi/scsi_debug.c

  5578	
> 5579	struct sdebug_queued_cmd *sdebug_alloc_queued_cmd(struct scsi_cmnd *scmd)
  5580	{
  5581		struct sdebug_queued_cmd *sqcp = kmem_cache_zalloc(queued_cmd_cache, GFP_ATOMIC);
  5582		struct sdebug_defer *sd_dp;
  5583	
  5584		if (!sqcp)
  5585			return NULL;
  5586	
  5587		sd_dp = &sqcp->sd_dp;
  5588	
  5589		hrtimer_init(&sd_dp->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
  5590		sd_dp->hrt.function = sdebug_q_cmd_hrt_complete;
  5591		INIT_WORK(&sd_dp->ew.work, sdebug_q_cmd_wq_complete);
  5592	
  5593		sqcp->scmd = scmd;
  5594		sd_dp->sqa_idx = -1;
  5595	
  5596		return sqcp;
  5597	}
  5598	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
