Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6AB6A649F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCABTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjCABTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:19:02 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83016592
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677633541; x=1709169541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZVaWKwbsgD+p7IQYEkRGQzQoEAFikHwsCb+688JuDPg=;
  b=X3tz+8DF3AN5HQ9brDr+ubw+mWFgDLbpagCv7B9vQwHL7TE8h8PAzPNF
   6H6y0r2bYAR2Dj2S3zrcrej3XcrLn97HoVwh6uIwzRecwONn2CyrGs1XA
   JQttzcn0OLO/jssOo9oGKiXOrgXyPg1rPfAO7suqnkwMg0sbKionaIh+W
   zSISOdZRM+Dmsz8DUZpQpWKksr8yRiDCCP+70gTrAhtkWQrik/mpvQlYb
   11DxKifkjDKX/rkmuCn8FNFMY+wMe8Z++f254fkKI+wnQF8kCemG0Kca5
   Nop0pdAjxGh7k/k3NNioAtL2K7A6BNuLttkTzIiHfSgzgy/cfVFb1NlD6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="396859619"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="396859619"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 17:19:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="784120925"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="784120925"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2023 17:18:59 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXB7S-0005md-1l;
        Wed, 01 Mar 2023 01:18:58 +0000
Date:   Wed, 1 Mar 2023 09:18:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     oe-kbuild-all@lists.linux.dev,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/11] vduse: Support automatic irq callback affinity
Message-ID: <202303010802.fyGx4T0d-lkp@intel.com>
References: <20230228094110.37-6-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228094110.37-6-xieyongji@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xie,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on linus/master next-20230228]
[cannot apply to mst-vhost/linux-next hch-configfs/for-next v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xie-Yongji/lib-group_cpus-Export-group_cpus_evenly/20230228-174438
patch link:    https://lore.kernel.org/r/20230228094110.37-6-xieyongji%40bytedance.com
patch subject: [PATCH v3 05/11] vduse: Support automatic irq callback affinity
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20230301/202303010802.fyGx4T0d-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/6c15cc28cb814c0e6cb80955bc59517e80c15ae2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xie-Yongji/lib-group_cpus-Export-group_cpus_evenly/20230228-174438
        git checkout 6c15cc28cb814c0e6cb80955bc59517e80c15ae2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/vdpa/vdpa_user/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303010802.fyGx4T0d-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/vdpa/vdpa_user/vduse_dev.c:724:16: sparse: sparse: symbol 'create_affinity_masks' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
