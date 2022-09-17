Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4265BB85F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 15:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiIQNIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 09:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIQNIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 09:08:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B6633A21
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 06:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663420080; x=1694956080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4GgQvWqxbcuIDqU+vetR4DKizrn7NaA1pr/ULmoxbrA=;
  b=d0IrJe04UT7hi26Dm4t4lGQPbnHxLJNMgAN0u7fCTvBqXnWrL4eZI48M
   zmBIyllNZ8kMT/+NEKDEpWNCR70mhld5dTQEr0FcYPZ3m0U0UP+gHP4wG
   9zz/4uT9pqy4RIqnaiKRew1NU+OkKiq9iWgmh6Vn6Ikp0owxQtAgqQXPO
   154pKx0DcBawn0VnkCmRe2zmBKkUxovPoBhLRFm8nb1cfEvgqOajSL+pc
   b2HA4yMBMj74B15cqBjjHDqRCni6Q33kF03YNCO3F5HzusKUp2AASxAEW
   WHPrl8LbljI8SIeMhThwkV6dIl77P6Vq8K5n17x49aDf3M9N+5OpawvwQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="325431366"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="325431366"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 06:08:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="946681063"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 17 Sep 2022 06:07:57 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZXY5-0000LR-0t;
        Sat, 17 Sep 2022 13:07:57 +0000
Date:   Sat, 17 Sep 2022 21:06:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>
Cc:     kbuild-all@lists.01.org, Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.corp-partner.google.com>,
        Allen-kh Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v2] mailbox: mtk-cmdq: fix gce timeout issue
Message-ID: <202209172020.fo64pfnn-lkp@intel.com>
References: <20220917090940.10088-1-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917090940.10088-1-yongqiang.niu@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yongqiang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on fujitsu-integration/mailbox-for-next]
[also build test ERROR on soc/for-next linus/master v6.0-rc5 next-20220916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yongqiang-Niu/mailbox-mtk-cmdq-fix-gce-timeout-issue/20220917-171148
base:   https://git.linaro.org/landing-teams/working/fujitsu/integration.git mailbox-for-next
config: openrisc-randconfig-r023-20220916 (https://download.01.org/0day-ci/archive/20220917/202209172020.fo64pfnn-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/044a12235901d40a3442fa5ab0c4b3233f370e22
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yongqiang-Niu/mailbox-mtk-cmdq-fix-gce-timeout-issue/20220917-171148
        git checkout 044a12235901d40a3442fa5ab0c4b3233f370e22
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/mailbox/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mailbox/mtk-cmdq-mailbox.c:713:10: error: 'const struct gce_plat' has no member named 'sw_ddr_en'
     713 |         .sw_ddr_en = true,
         |          ^~~~~~~~~
   drivers/mailbox/mtk-cmdq-mailbox.c:714:20: warning: initialized field overwritten [-Woverride-init]
     714 |         .gce_num = 1
         |                    ^
   drivers/mailbox/mtk-cmdq-mailbox.c:714:20: note: (near initialization for 'gce_plat_v7.gce_num')


vim +713 drivers/mailbox/mtk-cmdq-mailbox.c

   708	
   709	static const struct gce_plat gce_plat_v7 = {
   710		.thread_nr = 24,
   711		.shift = 3,
   712		.control_by_sw = true,
 > 713		.sw_ddr_en = true,
   714		.gce_num = 1
   715	};
   716	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
