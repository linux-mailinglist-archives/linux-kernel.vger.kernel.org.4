Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B2C6D6FDC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbjDDWF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjDDWFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:05:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7043C06;
        Tue,  4 Apr 2023 15:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680645953; x=1712181953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sx1Df8zRzu2lBXbsGavKpvQNQMu0/c/0lVd4Tj/TiwU=;
  b=VWh7eoSFgiQMo/GdZOdkA1VgH2vTOau38q3cqFMqOniUtVSai8yqfS3q
   zxtj5RoJQJYjB1HJiXh4GhGwD5ttM8j8m7qlRb9biEDUUESTqcTcX6Gap
   KzeWvSwBuQG+Z2Yi6+mA7DtrP4hzXXYNAC2sW5FjQHmhQOvDor9Kjktbk
   8EaP3Q2MJquNWbanGz51NmajlEb8bw/SqGUX6F+v6bkVIwrcEPY11+TVl
   4feCjd4i85kyg3nUWmM1SFKGklT/FJoqsvjrPMi3xkO8wJ/NK/S8z1vtM
   4+wOUFXjiUGSd+hFLvAlCqlZL+9q06mVTr+OHS6ERtLk7dFHgGGrydRtC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="326350751"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="326350751"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 15:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="810420448"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="810420448"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Apr 2023 15:05:48 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjomh-000Q4U-0p;
        Tue, 04 Apr 2023 22:05:47 +0000
Date:   Wed, 5 Apr 2023 06:05:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: Re: [PATCH 2/2] spi: spi-qcom-qspi: Add DMA mode support
Message-ID: <202304050512.MN2oNY9Z-lkp@intel.com>
References: <1680631400-28865-3-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680631400-28865-3-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijaya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on robh/for-next broonie-sound/for-next linus/master v6.3-rc5 next-20230404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vijaya-Krishna-Nivarthi/arm64-dts-qcom-sc7280-Add-stream-id-of-qspi-to-iommus/20230405-020430
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/1680631400-28865-3-git-send-email-quic_vnivarth%40quicinc.com
patch subject: [PATCH 2/2] spi: spi-qcom-qspi: Add DMA mode support
config: arm64-randconfig-r001-20230403 (https://download.01.org/0day-ci/archive/20230405/202304050512.MN2oNY9Z-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/72895c4ce2b53c096fa03c9f56211df21faad6dd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vijaya-Krishna-Nivarthi/arm64-dts-qcom-sc7280-Add-stream-id-of-qspi-to-iommus/20230405-020430
        git checkout 72895c4ce2b53c096fa03c9f56211df21faad6dd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304050512.MN2oNY9Z-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-qcom-qspi.c:333:5: warning: no previous prototype for function 'qcom_qspi_alloc_desc' [-Wmissing-prototypes]
   int qcom_qspi_alloc_desc(struct qcom_qspi *ctrl, uint8_t *virt_ptr,
       ^
   drivers/spi/spi-qcom-qspi.c:333:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int qcom_qspi_alloc_desc(struct qcom_qspi *ctrl, uint8_t *virt_ptr,
   ^
   static 
   1 warning generated.


vim +/qcom_qspi_alloc_desc +333 drivers/spi/spi-qcom-qspi.c

   332	
 > 333	int qcom_qspi_alloc_desc(struct qcom_qspi *ctrl, uint8_t *virt_ptr,
   334				dma_addr_t dma_ptr, uint32_t n_bytes)
   335	{
   336		struct qspi_cmd_desc *virt_cmd_desc, *prev;
   337		uint8_t *virt_data_desc;
   338		dma_addr_t dma_cmd_desc, dma_data_desc;
   339	
   340		if (virt_ptr && n_bytes >= QSPI_ALIGN_REQ) {
   341			dev_err(ctrl->dev,
   342				"Exiting to avert memory overwrite, n_bytes-%d\n", n_bytes);
   343			return -ENOMEM;
   344		}
   345	
   346		/* allocate for dma cmd descriptor */
   347		virt_cmd_desc = (struct qspi_cmd_desc *)dma_pool_alloc(ctrl->dma_cmd_pool,
   348			GFP_KERNEL, &dma_cmd_desc);
   349		if (!virt_cmd_desc) {
   350			dev_err(ctrl->dev,
   351				"Could not allocate for cmd_desc\n");
   352			return -ENOMEM;
   353		}
   354		ctrl->virt_cmd_desc[ctrl->n_cmd_desc] = virt_cmd_desc;
   355		ctrl->dma_cmd_desc[ctrl->n_cmd_desc] = dma_cmd_desc;
   356		ctrl->n_cmd_desc++;
   357	
   358		/* allocate for dma data descriptor if unaligned else use pre-aligned */
   359		if (virt_ptr) {
   360			virt_data_desc = (uint8_t *)dma_pool_zalloc(ctrl->dma_data_pool,
   361				GFP_KERNEL, &dma_data_desc);
   362			if (!virt_data_desc) {
   363				dev_err(ctrl->dev,
   364					"Could not allocate for data_desc\n");
   365				return -ENOMEM;
   366			}
   367			ctrl->virt_data_desc[ctrl->n_data_desc] = virt_data_desc;
   368			ctrl->dma_data_desc[ctrl->n_data_desc] = dma_data_desc;
   369			ctrl->n_data_desc++;
   370	
   371			/*
   372			 * for tx copy xfer data into allocated buffer
   373			 * for rx setup bounce info to copy after xfer
   374			 */
   375			if (ctrl->xfer.dir == QSPI_WRITE) {
   376				memcpy(virt_data_desc, virt_ptr, n_bytes);
   377			} else {
   378				virt_cmd_desc->bounce_src = virt_data_desc;
   379				virt_cmd_desc->bounce_dst = virt_ptr;
   380				virt_cmd_desc->bounce_length = n_bytes;
   381			}
   382		} else {
   383			dma_data_desc = dma_ptr;
   384		}
   385	
   386		/* setup cmd descriptor */
   387		virt_cmd_desc->data_address = (uint32_t)(uintptr_t)(dma_data_desc);
   388		virt_cmd_desc->next_descriptor = 0;
   389		virt_cmd_desc->direction = ctrl->xfer.dir;
   390		virt_cmd_desc->multi_io_mode = ctrl->iomode;
   391		virt_cmd_desc->reserved1 = 0;
   392		virt_cmd_desc->fragment = 0;
   393		virt_cmd_desc->reserved2 = 0;
   394		virt_cmd_desc->length = n_bytes;
   395	
   396		/* update previous descriptor */
   397		if (ctrl->n_cmd_desc >= 2) {
   398			prev = (ctrl->virt_cmd_desc)[ctrl->n_cmd_desc - 2];
   399			prev->next_descriptor = dma_cmd_desc;
   400			prev->fragment = 1;
   401		}
   402	
   403		return 0;
   404	}
   405	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
