Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6980C6D008C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjC3KDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjC3KDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:03:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E706665B6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680170574; x=1711706574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+9ccg6ek/jHml4i7Wci/X40KyGe9PpwtzuJDixBUjm0=;
  b=azdpOv+FCiUHLDb4v9GCHZw2bXEy1APaS23Roan5b7lni/+zVRKwtZfC
   62nY7JGMRbYX8iWsAF88jCoWV9PG2rnEnYL5atMlW1BOVesyx5Q6On0GC
   T5ejnDM+Yqi0DBhg/zCQJAGWgdwyYXDF3ZZZMX5LqOHljGbpyXbC3TbY2
   kiD03oDdMUozCj6pNeoRFDMSKYdw0JNODk+QlDM+FWA1o3smiA3BGPtFv
   BT/b1h7FAsr9rr2sCz5PzDCGDATjsLU+BHuD6+mf38HxkJ/ZnbkiQ5U70
   HW0KQ4Dvp8/BzSjnhN8+UNG0RKh64TumQy/ePq6PVcs3JGSgNimt5JcIB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="403775168"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="403775168"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="930673637"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="930673637"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2023 03:02:52 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1php7H-000KjC-0J;
        Thu, 30 Mar 2023 10:02:47 +0000
Date:   Thu, 30 Mar 2023 18:02:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Boon Khai Ng <boon.khai.ng@intel.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Tien Sung Ang <tien.sung.ang@intel.com>,
        Boon Khai Ng <boon.khai.ng@intel.com>
Subject: Re: [PATCH v1 2/8] drivers: net: stmmac_main: fix vlan toggle option.
Message-ID: <202303301734.QmN1Bc6n-lkp@intel.com>
References: <20230330070305.18808-1-boon.khai.ng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330070305.18808-1-boon.khai.ng@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boon,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.3-rc4 next-20230330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Boon-Khai-Ng/drivers-net-stmmac_main-Add-support-for-HW-accelerated-VLAN-Stripping/20230330-150648
patch link:    https://lore.kernel.org/r/20230330070305.18808-1-boon.khai.ng%40intel.com
patch subject: [PATCH v1 2/8] drivers: net: stmmac_main: fix vlan toggle option.
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230330/202303301734.QmN1Bc6n-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/fb80bd4d4331439d42a4c555121e4bc27ddcd16f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Boon-Khai-Ng/drivers-net-stmmac_main-Add-support-for-HW-accelerated-VLAN-Stripping/20230330-150648
        git checkout fb80bd4d4331439d42a4c555121e4bc27ddcd16f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/stmicro/stmmac/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303301734.QmN1Bc6n-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: In function 'stmmac_set_features':
>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5684:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    5684 |         if (changed & NETIF_F_HW_VLAN_CTAG_RX)
         |         ^~
   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5686:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    5686 |                 priv->plat->use_hw_vlan = features & NETIF_F_HW_VLAN_CTAG_RX;
         |                 ^~~~
   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5687:9: error: no return statement in function returning non-void [-Werror=return-type]
    5687 |         }
         |         ^
   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: At top level:
   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5689:9: error: expected identifier or '(' before 'return'
    5689 |         return 0;
         |         ^~~~~~
   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5690:1: error: expected identifier or '(' before '}' token
    5690 | }
         | ^
   cc1: some warnings being treated as errors


vim +/if +5684 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

47dd7a540b8a0cd drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro 2009-10-14  5656  
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5657  static int stmmac_set_features(struct net_device *netdev,
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5658  			       netdev_features_t features)
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5659  {
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5660  	struct stmmac_priv *priv = netdev_priv(netdev);
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5661  
854ecb883886d78 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Boon Khai Ng       2023-03-30  5662  	netdev_features_t changed;
854ecb883886d78 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Boon Khai Ng       2023-03-30  5663  
854ecb883886d78 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Boon Khai Ng       2023-03-30  5664  	changed = netdev->features ^ features;
854ecb883886d78 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Boon Khai Ng       2023-03-30  5665  
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5666  	/* Keep the COE Type in case of csum is supporting */
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5667  	if (features & NETIF_F_RXCSUM)
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5668  		priv->hw->rx_csum = priv->plat->rx_coe;
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5669  	else
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5670  		priv->hw->rx_csum = 0;
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5671  	/* No check needed because rx_coe has been set before and it will be
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5672  	 * fixed in case of issue.
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5673  	 */
c10d4c82a5c84c2 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu         2018-04-16  5674  	stmmac_rx_ipc(priv, priv->hw);
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5675  
f8e7dfd6fdabb83 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Vincent Whitchurch 2021-11-26  5676  	if (priv->sph_cap) {
f8e7dfd6fdabb83 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Vincent Whitchurch 2021-11-26  5677  		bool sph_en = (priv->hw->rx_csum > 0) && priv->sph;
f8e7dfd6fdabb83 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Vincent Whitchurch 2021-11-26  5678  		u32 chan;
5fabb01207a2d34 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong     2021-04-01  5679  
67afd6d1cfdf0d0 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu         2019-08-17  5680  		for (chan = 0; chan < priv->plat->rx_queues_to_use; chan++)
67afd6d1cfdf0d0 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu         2019-08-17  5681  			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
f8e7dfd6fdabb83 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Vincent Whitchurch 2021-11-26  5682  	}
67afd6d1cfdf0d0 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu         2019-08-17  5683  
854ecb883886d78 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Boon Khai Ng       2023-03-30 @5684  	if (changed & NETIF_F_HW_VLAN_CTAG_RX)
854ecb883886d78 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Boon Khai Ng       2023-03-30  5685  		stmmac_set_hw_vlan_mode(priv, priv->ioaddr, features);
fb80bd4d4331439 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Boon Khai Ng       2023-03-30  5686  		priv->plat->use_hw_vlan = features & NETIF_F_HW_VLAN_CTAG_RX;
fb80bd4d4331439 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Boon Khai Ng       2023-03-30  5687  	}
854ecb883886d78 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Boon Khai Ng       2023-03-30  5688  
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5689  	return 0;
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5690  }
d2afb5bdffde3da drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO 2014-09-01  5691  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
