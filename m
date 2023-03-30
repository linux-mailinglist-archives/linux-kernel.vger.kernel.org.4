Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5E56D0E00
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjC3Sm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjC3Smw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:42:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95865D53E;
        Thu, 30 Mar 2023 11:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680201756; x=1711737756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3X+EBk6MUL1ZnA4UwVxXj6Bph62XorP3HH/A5HZRS2c=;
  b=SoazjYIJmShRjlaDur7TdB52B7BO8EDx41Jdz1dsDK4Gxq9KPahWDjyE
   0VU7vfd2/eFXAF4lCH7CkB0E/qmwGlln70I0gjBNf3xVGKGDMwKEIxaMt
   gKsCNPBDibl5JFhQSHewwy7nqjhJSuPa8dbfvJZPt3VFlR1z80mKxFHBn
   +BcVR0GlLVWS3uC77y/L2m3k6TuekDgeJ03IHaScApbAho/rZDEZ96EDy
   yhtlqfLOYnT+wf+L+pmycC0Kej3zypI3dUKmxTNFpcclWIByH5XMB6UW1
   8SWLOTrWEjY9MNowSFLsMxWCmOi6jBJI1mWr6FA0svRkjTCb9OQLFlbCs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="342900639"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="342900639"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 11:41:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="754135467"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="754135467"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2023 11:41:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phxCr-000L6c-18;
        Thu, 30 Mar 2023 18:41:05 +0000
Date:   Fri, 31 Mar 2023 02:40:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, logang@deltatee.com,
        song@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 3/3] md: protect md_thread with rcu
Message-ID: <202303310252.5OJzxk7h-lkp@intel.com>
References: <20230330202046.795213-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330202046.795213-4-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on song-md/md-next]
[also build test WARNING on device-mapper-dm/for-next linus/master v6.3-rc4 next-20230330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/md-pass-a-md_thread-pointer-to-md_register_thread/20230330-202251
base:   git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
patch link:    https://lore.kernel.org/r/20230330202046.795213-4-yukuai1%40huaweicloud.com
patch subject: [PATCH v3 3/3] md: protect md_thread with rcu
config: x86_64-randconfig-s023 (https://download.01.org/0day-ci/archive/20230331/202303310252.5OJzxk7h-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/b6edd339e54dc14576816f285b99e0e1815ed1e0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yu-Kuai/md-pass-a-md_thread-pointer-to-md_register_thread/20230330-202251
        git checkout b6edd339e54dc14576816f285b99e0e1815ed1e0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303310252.5OJzxk7h-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/md/md.c:7905:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/md/md.c:7905:18: sparse:    struct md_thread [noderef] __rcu *
>> drivers/md/md.c:7905:18: sparse:    struct md_thread *
   drivers/md/md.c:7939:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/md.c:7939:9: sparse:    struct md_thread [noderef] __rcu *
   drivers/md/md.c:7939:9: sparse:    struct md_thread *
   drivers/md/md.c:7952:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/md.c:7952:9: sparse:    struct md_thread [noderef] __rcu *
   drivers/md/md.c:7952:9: sparse:    struct md_thread *

vim +7905 drivers/md/md.c

  7899	
  7900	void md_wakeup_thread(struct md_thread **threadp)
  7901	{
  7902		struct md_thread *thread;
  7903	
  7904		rcu_read_lock();
> 7905		thread = rcu_dereference(*threadp);
  7906		if (thread) {
  7907			pr_debug("md: waking up MD thread %s.\n", thread->tsk->comm);
  7908			set_bit(THREAD_WAKEUP, &thread->flags);
  7909			wake_up(&thread->wqueue);
  7910		}
  7911		rcu_read_unlock();
  7912	}
  7913	EXPORT_SYMBOL(md_wakeup_thread);
  7914	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
