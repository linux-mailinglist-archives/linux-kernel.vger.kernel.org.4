Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC1973EA70
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjFZSt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjFZStX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:49:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD7D97;
        Mon, 26 Jun 2023 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687805361; x=1719341361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qnLHMpbg3ZnkksbNh8pRUr1WSMMqWaeBQV6ilzbnCg0=;
  b=UIRmOQ6XeovKgXkRDurcWI0a6lk1o4Y4C5CmWYpuVJJ0Rxu7Ra/S5iUs
   AWoarBWkGUyPZlEyJphl5CSIuKf0xUG93DqwpbX0bb+ZkNLSoAD3FNCy4
   hAqBH9gkzyE6hFldQcOXjgjOWtXQjhacygNJvxmyJpyiuIi+N/43nZv4C
   zEEoV542qNAXs50/tESfhLB9VwdaxoZ1+WzY7zHFjGMz6IpEeQa45pEF1
   wNjDLFT7CAXB4PmEg9riGGkC67/o2+EKy7OeLnmMAm+zaoWYcl7e4muhQ
   hThQUMpShpErOBJ12Ib2nt/cN+2UQiMjPg2LXe3nGDW4nQL23/ZRkYd4h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="340944172"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="340944172"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 11:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="840385389"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="840385389"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2023 11:49:18 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDrH3-000AtJ-2M;
        Mon, 26 Jun 2023 18:49:17 +0000
Date:   Tue, 27 Jun 2023 02:48:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     You Kangren <youkangren@vivo.com>, Kalle Valo <kvalo@kernel.org>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Simon Horman <simon.horman@corigine.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "open list:RAYLINK/WEBGEAR 802.11 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, opensource.kernel@vivo.com
Subject: Re: [PATCH] wifi: ray_cs: Replace the ternary conditional operator
 with min()
Message-ID: <202306270226.5BCJkelL-lkp@intel.com>
References: <20230626093504.1325-1-youkangren@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626093504.1325-1-youkangren@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi You,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.4 next-20230626]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/You-Kangren/wifi-ray_cs-Replace-the-ternary-conditional-operator-with-min/20230626-173628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20230626093504.1325-1-youkangren%40vivo.com
patch subject: [PATCH] wifi: ray_cs: Replace the ternary conditional operator with min()
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230627/202306270226.5BCJkelL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230627/202306270226.5BCJkelL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306270226.5BCJkelL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:27,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/nospec-branch.h:14,
                    from arch/x86/include/asm/paravirt_types.h:27,
                    from arch/x86/include/asm/ptrace.h:97,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/net/wireless/legacy/ray_cs.c:20:
   drivers/net/wireless/legacy/ray_cs.c: In function 'ray_rx':
   include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                   ^~
   include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
         |                  ^~~~~~~~~~~
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:67:25: note: in expansion of macro '__careful_cmp'
      67 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   drivers/net/wireless/legacy/ray_cs.c:2089:35: note: in expansion of macro 'min'
    2089 |                                   min(rx_len, sizeof(struct beacon_rx));
         |                                   ^~~
>> drivers/net/wireless/legacy/ray_cs.c:2089:72: error: expected ')' before ';' token
    2089 |                                   min(rx_len, sizeof(struct beacon_rx));
         |                                                                        ^
   drivers/net/wireless/legacy/ray_cs.c:2088:34: note: to match this '('
    2088 |                 copy_from_rx_buff(local, (UCHAR *) &local->last_bcn, pkt_addr,
         |                                  ^
>> drivers/net/wireless/legacy/ray_cs.c:2098:23: error: expected ';' before '}' token
    2098 |                 break;
         |                       ^
         |                       ;
    2099 |         }
         |         ~              


vim +2089 drivers/net/wireless/legacy/ray_cs.c

  2042	
  2043	/*===========================================================================*/
  2044	static void ray_rx(struct net_device *dev, ray_dev_t *local,
  2045			   struct rcs __iomem *prcs)
  2046	{
  2047		int rx_len;
  2048		unsigned int pkt_addr;
  2049		void __iomem *pmsg;
  2050		pr_debug("ray_rx process rx packet\n");
  2051	
  2052		/* Calculate address of packet within Rx buffer */
  2053		pkt_addr = ((readb(&prcs->var.rx_packet.rx_data_ptr[0]) << 8)
  2054			    + readb(&prcs->var.rx_packet.rx_data_ptr[1])) & RX_BUFF_END;
  2055		/* Length of first packet fragment */
  2056		rx_len = (readb(&prcs->var.rx_packet.rx_data_length[0]) << 8)
  2057		    + readb(&prcs->var.rx_packet.rx_data_length[1]);
  2058	
  2059		local->last_rsl = readb(&prcs->var.rx_packet.rx_sig_lev);
  2060		pmsg = local->rmem + pkt_addr;
  2061		switch (readb(pmsg)) {
  2062		case DATA_TYPE:
  2063			pr_debug("ray_rx data type\n");
  2064			rx_data(dev, prcs, pkt_addr, rx_len);
  2065			break;
  2066		case AUTHENTIC_TYPE:
  2067			pr_debug("ray_rx authentic type\n");
  2068			if (sniffer)
  2069				rx_data(dev, prcs, pkt_addr, rx_len);
  2070			else
  2071				rx_authenticate(local, prcs, pkt_addr, rx_len);
  2072			break;
  2073		case DEAUTHENTIC_TYPE:
  2074			pr_debug("ray_rx deauth type\n");
  2075			if (sniffer)
  2076				rx_data(dev, prcs, pkt_addr, rx_len);
  2077			else
  2078				rx_deauthenticate(local, prcs, pkt_addr, rx_len);
  2079			break;
  2080		case NULL_MSG_TYPE:
  2081			pr_debug("ray_cs rx NULL msg\n");
  2082			break;
  2083		case BEACON_TYPE:
  2084			pr_debug("ray_rx beacon type\n");
  2085			if (sniffer)
  2086				rx_data(dev, prcs, pkt_addr, rx_len);
  2087	
  2088			copy_from_rx_buff(local, (UCHAR *) &local->last_bcn, pkt_addr,
> 2089					  min(rx_len, sizeof(struct beacon_rx));
  2090	
  2091			local->beacon_rxed = 1;
  2092			/* Get the statistics so the card counters never overflow */
  2093			ray_get_stats(dev);
  2094			break;
  2095		default:
  2096			pr_debug("ray_cs unknown pkt type %2x\n",
  2097			      (unsigned int)readb(pmsg));
> 2098			break;
  2099		}
  2100	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
