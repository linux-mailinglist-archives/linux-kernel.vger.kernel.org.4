Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC4D69314E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 14:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBKNqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 08:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBKNqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 08:46:16 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6F12684C;
        Sat, 11 Feb 2023 05:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676123175; x=1707659175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QVWnlp6HxiMITi+4G7GRDcMltvoFp3zphx53HM0P+90=;
  b=iZkFMN43fykNwdNRdOH4U20rv54ownuEOSYTYk4KKl7UKaCTW60RXr9t
   TAUCKe8dw7CcbfFwL23CBOzVq9aABhOxRScl0laHvQcRc09otBmRYBise
   GE8N4mT3bllRGzJ6s8YRYJ7GBCvcNlH1Vy5+ure6C3hFXuQzoGLY5cAa9
   NooDLxcuvBvGOm/sZBFpqUy8FJoMrB0R5+ygt4DY23Lb9QDJnsdWge88W
   +k/V4c1AENQxZVcRDxXMaOcpMFaIvov5Lp02W5/b+ezFtV1FyXTLBnOB1
   davzQs7yGDax5xGphnuJci6auhcZwTjg61p32+cpRtBNOfhWsuS1H4rMI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="331915552"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="331915552"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 05:46:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="811117476"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="811117476"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2023 05:46:10 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQqCg-0006Y3-0f;
        Sat, 11 Feb 2023 13:46:10 +0000
Date:   Sat, 11 Feb 2023 21:45:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/6] nvmem: core: add nvmem_dev_size() helper
Message-ID: <202302112138.XOdXy4yF-lkp@intel.com>
References: <20230110105425.13188-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230110105425.13188-1-zajec5@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafał,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20230110]
[also build test WARNING on v6.2-rc7]
[cannot apply to robh/for-next shawnguo/for-next mtd/mtd/next mtd/mtd/fixes linus/master v6.2-rc3 v6.2-rc2 v6.2-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rafa-Mi-ecki/nvmem-core-allow-read_post_process-callbacks-to-adjust-data-length/20230110-185915
patch link:    https://lore.kernel.org/r/20230110105425.13188-1-zajec5%40gmail.com
patch subject: [PATCH 1/6] nvmem: core: add nvmem_dev_size() helper
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230211/202302112138.XOdXy4yF-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4d5cc61f8d02a82344468f172a852ffc56cf0d5c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rafa-Mi-ecki/nvmem-core-allow-read_post_process-callbacks-to-adjust-data-length/20230110-185915
        git checkout 4d5cc61f8d02a82344468f172a852ffc56cf0d5c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/nvmem/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302112138.XOdXy4yF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/nvmem/core.c:16:
>> include/linux/nvmem-consumer.h:81:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
      81 | const size_t nvmem_dev_size(struct nvmem_device *nvmem);
         | ^~~~~
>> drivers/nvmem/core.c:2070:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    2070 | const size_t nvmem_dev_size(struct nvmem_device *nvmem)
         | ^~~~~
--
   In file included from drivers/nvmem/brcm_nvram.c:10:
>> include/linux/nvmem-consumer.h:81:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
      81 | const size_t nvmem_dev_size(struct nvmem_device *nvmem);
         | ^~~~~


vim +81 include/linux/nvmem-consumer.h

    49	
    50	/* Cell based interface */
    51	struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id);
    52	struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *id);
    53	void nvmem_cell_put(struct nvmem_cell *cell);
    54	void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
    55	void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
    56	int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
    57	int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val);
    58	int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val);
    59	int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val);
    60	int nvmem_cell_read_u64(struct device *dev, const char *cell_id, u64 *val);
    61	int nvmem_cell_read_variable_le_u32(struct device *dev, const char *cell_id,
    62					    u32 *val);
    63	int nvmem_cell_read_variable_le_u64(struct device *dev, const char *cell_id,
    64					    u64 *val);
    65	
    66	/* direct nvmem device read/write interface */
    67	struct nvmem_device *nvmem_device_get(struct device *dev, const char *name);
    68	struct nvmem_device *devm_nvmem_device_get(struct device *dev,
    69						   const char *name);
    70	void nvmem_device_put(struct nvmem_device *nvmem);
    71	void devm_nvmem_device_put(struct device *dev, struct nvmem_device *nvmem);
    72	int nvmem_device_read(struct nvmem_device *nvmem, unsigned int offset,
    73			      size_t bytes, void *buf);
    74	int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
    75			       size_t bytes, void *buf);
    76	ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
    77				   struct nvmem_cell_info *info, void *buf);
    78	int nvmem_device_cell_write(struct nvmem_device *nvmem,
    79				    struct nvmem_cell_info *info, void *buf);
    80	
  > 81	const size_t nvmem_dev_size(struct nvmem_device *nvmem);
    82	const char *nvmem_dev_name(struct nvmem_device *nvmem);
    83	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
