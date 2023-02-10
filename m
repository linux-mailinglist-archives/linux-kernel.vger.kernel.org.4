Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDD9691C18
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjBJKAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjBJKAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:00:38 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC7A38673;
        Fri, 10 Feb 2023 02:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676023237; x=1707559237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=skyO+n4E72IHbnF1r9khsegze0IsfBWcm+0BlzjaYsw=;
  b=dtWo2Pitu6c/ZKjQNq00iezoXwGx3H5tPqkVJU1Jm6/TvufKJv+Ee3og
   ISkCauBgo338h5WAUz+MPx3Ugofbx/dZtksRNOVymVbQ8wE3LmqvE6DP4
   KGRqfFtQvzZ1hDgZANRKbBtDEKzGGDEy4eniHXQTkg1MDkujRIQiZlIYg
   buH9G/mPGNGUYoo6sbPkaEn9ijyMzBarHILRVnKvwuWyRxelK8ohCosEp
   mE1hYk90vNrcVaoM77TzIKR/nyZXVz2rBDvuMCzD53EGxCqKE6UfBrFxl
   ldrDWXyzDEO4X9Sd5m4j2XMNSO0QceZpmr9pt2OP3AaysPQKrWv8si14q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="314027993"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="314027993"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 02:00:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="661355216"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="661355216"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2023 02:00:32 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQQCm-0005jh-0Q;
        Fri, 10 Feb 2023 10:00:32 +0000
Date:   Fri, 10 Feb 2023 18:00:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/4] soc: aspeed: Add UART DMA support
Message-ID: <202302101749.ctd9pkv1-lkp@intel.com>
References: <20230210072643.2772-3-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210072643.2772-3-chiawei_wang@aspeedtech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chia-Wei,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus robh/for-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.2-rc7 next-20230210]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chia-Wei-Wang/dt-bindings-aspeed-Add-UART-controller/20230210-152832
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230210072643.2772-3-chiawei_wang%40aspeedtech.com
patch subject: [PATCH 2/4] soc: aspeed: Add UART DMA support
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230210/202302101749.ctd9pkv1-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b1e3a89584657d9b0398f3f46b09dc4229835fa3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chia-Wei-Wang/dt-bindings-aspeed-Add-UART-controller/20230210-152832
        git checkout b1e3a89584657d9b0398f3f46b09dc4229835fa3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/soc/aspeed/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302101749.ctd9pkv1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/soc/aspeed/aspeed-udma.c: In function 'aspeed_udma_request_chan':
>> drivers/soc/aspeed/aspeed-udma.c:194:13: warning: variable 'retval' set but not used [-Wunused-but-set-variable]
     194 |         int retval = 0;
         |             ^~~~~~


vim +/retval +194 drivers/soc/aspeed/aspeed-udma.c

   189	
   190	static int aspeed_udma_request_chan(u32 ch_no, dma_addr_t addr,
   191			struct circ_buf *rb, u32 rb_sz,
   192			aspeed_udma_cb_t cb, void *id, bool dis_tmout, bool is_tx)
   193	{
 > 194		int retval = 0;
   195		int rbsz_code;
   196	
   197		u32 reg;
   198		unsigned long flags;
   199		struct aspeed_udma_chan *ch;
   200	
   201		if (ch_no > UDMA_MAX_CHANNEL) {
   202			retval = -EINVAL;
   203			goto out;
   204		}
   205	
   206		if (IS_ERR_OR_NULL(rb) || IS_ERR_OR_NULL(rb->buf)) {
   207			retval = -EINVAL;
   208			goto out;
   209		}
   210	
   211		rbsz_code = aspeed_udma_get_bufsz_code(rb_sz);
   212		if (rbsz_code < 0) {
   213			retval = -EINVAL;
   214			goto out;
   215		}
   216	
   217		spin_lock_irqsave(&udma->lock, flags);
   218	
   219		if (is_tx) {
   220			reg = readl(udma->regs + UDMA_TX_DMA_INT_EN);
   221			if (reg & (0x1 << ch_no)) {
   222				retval = -EBUSY;
   223				goto unlock_n_out;
   224			}
   225	
   226			reg |= (0x1 << ch_no);
   227			writel(reg, udma->regs + UDMA_TX_DMA_INT_EN);
   228	
   229			reg = readl(udma->regs + UDMA_CHX_TX_CTRL(ch_no));
   230			reg |= (dis_tmout) ? UDMA_TX_CTRL_TMOUT_DISABLE : 0;
   231			reg |= (rbsz_code << UDMA_TX_CTRL_BUFSZ_SHIFT) & UDMA_TX_CTRL_BUFSZ_MASK;
   232			writel(reg, udma->regs + UDMA_CHX_TX_CTRL(ch_no));
   233	
   234			writel(addr, udma->regs + UDMA_CHX_TX_BUF_BASE(ch_no));
   235		} else {
   236			reg = readl(udma->regs + UDMA_RX_DMA_INT_EN);
   237			if (reg & (0x1 << ch_no)) {
   238				retval = -EBUSY;
   239				goto unlock_n_out;
   240			}
   241	
   242			reg |= (0x1 << ch_no);
   243			writel(reg, udma->regs + UDMA_RX_DMA_INT_EN);
   244	
   245			reg = readl(udma->regs + UDMA_CHX_RX_CTRL(ch_no));
   246			reg |= (dis_tmout) ? UDMA_RX_CTRL_TMOUT_DISABLE : 0;
   247			reg |= (rbsz_code << UDMA_RX_CTRL_BUFSZ_SHIFT) & UDMA_RX_CTRL_BUFSZ_MASK;
   248			writel(reg, udma->regs + UDMA_CHX_RX_CTRL(ch_no));
   249	
   250			writel(addr, udma->regs + UDMA_CHX_RX_BUF_BASE(ch_no));
   251		}
   252	
   253		ch = (is_tx) ? &udma->tx_chs[ch_no] : &udma->rx_chs[ch_no];
   254		ch->rb = rb;
   255		ch->rb_sz = rb_sz;
   256		ch->cb = cb;
   257		ch->cb_arg = id;
   258		ch->dma_addr = addr;
   259		ch->dis_tmout = dis_tmout;
   260	
   261	unlock_n_out:
   262		spin_unlock_irqrestore(&udma->lock, flags);
   263	out:
   264		return 0;
   265	}
   266	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
