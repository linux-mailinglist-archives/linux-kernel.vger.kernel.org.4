Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9095BB88A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 15:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiIQNiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 09:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIQNiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 09:38:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091F331EE6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663421882; x=1694957882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tIryiFgQl9COzjEcEkX38EUN2UYw3EZiOxUHcq8DolY=;
  b=eWkP615OSorqAQcCg4SIGjdkSTVGHR2Lfi9xF4c5gUCVbavMUtLXHygd
   q9o9AkmRj+8Aw1z2ByKpGgchnBR6HuTikunPx9sG4axOSxVpFRafExFrq
   dusIf+rTLWoVd/Asz8Culh6VjtftCFD2NddovdEzeUgDhJ58Y+51JOaiG
   k4zOnCY0bBbvBT3mlEilD8BS00FISnEPpCtZQ4v6b/PhIgHPSFRyNFVUy
   te5JpIG1/rs/y8cws476Om/egZrCO0FQQGZJdZuYPIOhLWKNhlHWYt0rr
   Vn3YumniOitnO5PfxpJk7p72SW1NMrlzw0FGc1xldKr3xnH9aUxBECDsB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="282179885"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="282179885"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 06:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="760343021"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Sep 2022 06:37:58 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZY18-0000Ml-08;
        Sat, 17 Sep 2022 13:37:58 +0000
Date:   Sat, 17 Sep 2022 21:37:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.corp-partner.google.com>,
        Allen-kh Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v2] mailbox: mtk-cmdq: fix gce timeout issue
Message-ID: <202209172147.lNB8ZX1j-lkp@intel.com>
References: <20220917090940.10088-1-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917090940.10088-1-yongqiang.niu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: arm-randconfig-r033-20220916 (https://download.01.org/0day-ci/archive/20220917/202209172147.lNB8ZX1j-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/044a12235901d40a3442fa5ab0c4b3233f370e22
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yongqiang-Niu/mailbox-mtk-cmdq-fix-gce-timeout-issue/20220917-171148
        git checkout 044a12235901d40a3442fa5ab0c4b3233f370e22
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mailbox/mtk-cmdq-mailbox.c:713:3: error: field designator 'sw_ddr_en' does not refer to any field in type 'const struct gce_plat'
           .sw_ddr_en = true,
            ^
   1 error generated.


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
