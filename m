Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF406E0D99
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDMMnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDMMnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:43:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAF593D6;
        Thu, 13 Apr 2023 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681389779; x=1712925779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AUmRE/yebNXpdkid5N0KqFC4R4ByzvArot+xXbENuPM=;
  b=G5WkMOUjdpL23MjMI+gX0zVf4Y5L39/1y8Q0aSkiX0Dp75dBnCeyiUkM
   ivT2VSIXgVLm8M4xg3f8omu3Gp/XuiCD4UHKIAGoz6CQDY6fzr76mKiDb
   LqrqjKpb9JOEdmZf42DoDGbo/ajS59XcVmc1oKfGZOUvMHWIkA6QoDOp6
   NL7OCXLmIt3s4zMLa7S/fZIWbtAwlYXVh+WYa+wJISkYKdS5UGlg8ASMw
   ZM2axZFyAIWO4tbycpnDVlw+Uu/sf3Ofn/ZQnrbldTAlhNsySsVZe2StF
   8s4GKnC3/jMZUaxzKqjmiJyuDrfGs6XFxXBMmcqdGyAOHJpwROIeWtG3S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="342916935"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="342916935"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 05:42:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="800801980"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="800801980"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Apr 2023 05:42:54 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmwHo-000YgZ-2M;
        Thu, 13 Apr 2023 12:42:48 +0000
Date:   Thu, 13 Apr 2023 20:42:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yi-De Wu <yi-de.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jades Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Yi-De Wu <yi-de.wu@mediatek.com>
Subject: Re: [PATCH v1 3/6] soc: mediatek: virt: geniezone: Introduce
 GenieZone hypervisor support
Message-ID: <202304132051.wGFK08qz-lkp@intel.com>
References: <20230413090735.4182-4-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413090735.4182-4-yi-de.wu@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi-De,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on krzk-dt/for-next arm64/for-next/core lwn/docs-next linus/master v6.3-rc6 next-20230412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yi-De-Wu/docs-geniezone-Introduce-GenieZone-hypervisor/20230413-170932
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230413090735.4182-4-yi-de.wu%40mediatek.com
patch subject: [PATCH v1 3/6] soc: mediatek: virt: geniezone: Introduce GenieZone hypervisor support
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230413/202304132051.wGFK08qz-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2d01949ddd48b1bc2cc9849154afe60781068f39
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yi-De-Wu/docs-geniezone-Introduce-GenieZone-hypervisor/20230413-170932
        git checkout 2d01949ddd48b1bc2cc9849154afe60781068f39
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/soc/mediatek/virt/geniezone/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304132051.wGFK08qz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/soc/mediatek/virt/geniezone/gzvm_vm.c:31:5: warning: no previous prototype for 'gzvm_gfn_to_pfn_memslot' [-Wmissing-prototypes]
      31 | int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn)
         |     ^~~~~~~~~~~~~~~~~~~~~~~


vim +/gzvm_gfn_to_pfn_memslot +31 drivers/soc/mediatek/virt/geniezone/gzvm_vm.c

    19	
    20	
    21	/**
    22	 * @brief Translate gfn (guest ipa) to pfn (host pa), result is in @pfn
    23	 *
    24	 * Leverage KVM's `gfn_to_pfn_memslot`. Because `gfn_to_pfn_memslot` needs
    25	 * kvm_memory_slot as parameter, this function populates necessary fileds
    26	 * for calling `gfn_to_pfn_memslot`.
    27	 *
    28	 * @retval 0 succeed
    29	 * @retval -EFAULT failed to convert
    30	 */
  > 31	int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn)
    32	{
    33		hfn_t __pfn;
    34		struct kvm_memory_slot kvm_slot = {0};
    35	
    36		kvm_slot.base_gfn = memslot->base_gfn;
    37		kvm_slot.npages = memslot->npages;
    38		kvm_slot.dirty_bitmap = NULL;
    39		kvm_slot.userspace_addr = memslot->userspace_addr;
    40		kvm_slot.flags = memslot->flags;
    41		kvm_slot.id = memslot->slot_id;
    42		kvm_slot.as_id = 0;
    43	
    44		__pfn = gfn_to_pfn_memslot(&kvm_slot, gfn);
    45		if (is_error_noslot_pfn(__pfn)) {
    46			*pfn = 0;
    47			return -EFAULT;
    48		}
    49	
    50		*pfn = __pfn;
    51		return 0;
    52	}
    53	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
