Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77F36C7613
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 03:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjCXC4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 22:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjCXC4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 22:56:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D321ED520;
        Thu, 23 Mar 2023 19:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679626557; x=1711162557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DO6YsYCdF4dQEBnvdYw32rQ5TOcKg8m5rWccaAoqGo8=;
  b=bzAdLbISSIDHOSAA4yzOyu8np37J4CrOGwl5YMJErjXBXMprSua3sDM/
   IOXdvKYaXyW8qkVCDC2AHOWQJhCHK56qRWOl58B5OKemdciddvKl4oAnh
   sDSVQtiW1xOhTtV2IgeQLCJK8JvqUY1obxpa2aYJ4oaPzdYGhMH+OGLzC
   zSIYoucnO5nPH1Bnbio2wOApuy8+smbJCs+mNeMEIpC9fgzKWvyS7EZDJ
   V5ysrot4HJHaPq+8f1mxKA96iTPE+yfxY8wo0FkdzYD7DZn4vZtyVVWW3
   eIp6k5KK0bq4fh6fv9YLycRCZHURmyXiGF8NCKVFlBFJqDzWwzC2oXffI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="339712177"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="339712177"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 19:55:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="856714502"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="856714502"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2023 19:55:55 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfXas-000Euy-2D;
        Fri, 24 Mar 2023 02:55:54 +0000
Date:   Fri, 24 Mar 2023 10:55:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Elliot Berman <quic_eberman@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mailbox: pcc: Use mbox_bind_client
Message-ID: <202303241039.usKTcpEw-lkp@intel.com>
References: <20230323191527.1472695-4-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323191527.1472695-4-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 6ccbe33a39523f6d62b22c5ee99c6695993c935e]

url:    https://github.com/intel-lab-lkp/linux/commits/Elliot-Berman/mailbox-Allow-direct-registration-to-a-channel/20230324-031813
base:   6ccbe33a39523f6d62b22c5ee99c6695993c935e
patch link:    https://lore.kernel.org/r/20230323191527.1472695-4-quic_eberman%40quicinc.com
patch subject: [PATCH v2 3/3] mailbox: pcc: Use mbox_bind_client
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20230324/202303241039.usKTcpEw-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5db6edf9f393224193ab13e82d63e0d7616c74c9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Elliot-Berman/mailbox-Allow-direct-registration-to-a-channel/20230324-031813
        git checkout 5db6edf9f393224193ab13e82d63e0d7616c74c9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/mailbox/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303241039.usKTcpEw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mailbox/pcc.c:285:17: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
           struct device *dev;
                          ^
>> drivers/mailbox/pcc.c:355:5: warning: no previous prototype for function 'pcc_startup' [-Wmissing-prototypes]
   int pcc_startup(struct mbox_chan *chan)
       ^
   drivers/mailbox/pcc.c:355:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int pcc_startup(struct mbox_chan *chan)
   ^
   static 
>> drivers/mailbox/pcc.c:378:6: warning: no previous prototype for function 'pcc_shutdown' [-Wmissing-prototypes]
   void pcc_shutdown(struct mbox_chan *chan)
        ^
   drivers/mailbox/pcc.c:378:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void pcc_shutdown(struct mbox_chan *chan)
   ^
   static 
   3 warnings generated.


vim +/pcc_startup +355 drivers/mailbox/pcc.c

   347	
   348	/**
   349	 * pcc_startup - Called from Mailbox Controller code. Used here
   350	 *		to request the interrupt.
   351	 * @chan: Pointer to Mailbox channel to startup.
   352	 *
   353	 * Return: Err if something failed else 0 for success.
   354	 */
 > 355	int pcc_startup(struct mbox_chan *chan)
   356	{
   357		struct pcc_chan_info *pchan = chan->con_priv;
   358		int rc;
   359	
   360		if (pchan->plat_irq > 0) {
   361			rc = devm_request_irq(chan->mbox->dev, pchan->plat_irq, pcc_mbox_irq, 0,
   362					      MBOX_IRQ_NAME, chan);
   363			if (unlikely(rc)) {
   364				dev_err(chan->mbox->dev, "failed to register PCC interrupt %d\n",
   365					pchan->plat_irq);
   366				return rc;
   367			}
   368		}
   369	
   370		return 0;
   371	}
   372	
   373	/**
   374	 * pcc_shutdown - Called from Mailbox Controller code. Used here
   375	 *		to free the interrupt.
   376	 * @chan: Pointer to Mailbox channel to shutdown.
   377	 */
 > 378	void pcc_shutdown(struct mbox_chan *chan)
   379	{
   380		struct pcc_chan_info *pchan = chan->con_priv;
   381	
   382		if (pchan->plat_irq > 0)
   383			devm_free_irq(chan->mbox->dev, pchan->plat_irq, chan);
   384	}
   385	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
