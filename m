Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EBC744A6B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 18:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGAQEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 12:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGAQEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 12:04:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC782683;
        Sat,  1 Jul 2023 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688227458; x=1719763458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f6kxU9+J13QkSnx+aHuLhATVQStnxeWvDzsMCWH3B+Q=;
  b=T9WoP2mfDLzMP3UwbZrRHqieTNM0RGzr5xGI48xpdNFpQfTU4ApcrjcD
   vMzRVY8bmi2RZDwpwS0GiLqZ/LdP7NaGFojqjzmrlpacpQvvQy1w9c4fN
   UTSY8fDOoZjzz0GE+FeKnzFBfO6o1nx3tLYRUEc+oIaN6p9xInv3GJ4St
   TE9E4POC/1x+F7tk3ZcLb0BKTv6GRNQdKanFzDO28WXGy8l2JGkpe1z13
   JuzCDVOg+VoNFLL01sbqpifIc+h4NekO1ng9KOWYxIF1C0kA1KZJZObQG
   K+VF/shBIAWAK5yFc44j0Y1zF8fHBU/6MeYnY7JzsI1DqhXbjYEMIPujM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="347384626"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="347384626"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 09:04:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="753290468"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="753290468"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Jul 2023 09:04:17 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFd54-000G6r-2h;
        Sat, 01 Jul 2023 16:04:14 +0000
Date:   Sun, 2 Jul 2023 00:04:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhang Shurong <zhang_shurong@foxmail.com>,
        gregkh@linuxfoundation.org
Cc:     oe-kbuild-all@lists.linux.dev, u.kleine-koenig@pengutronix.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: Re: [PATCH] usb: r8a66597-hcd: host: fix port index underflow and
 UBSAN complains
Message-ID: <202307012328.34HpnWQC-lkp@intel.com>
References: <tencent_71A3B792C0AA3D9E148E517B24BC6E006A09@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_71A3B792C0AA3D9E148E517B24BC6E006A09@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus westeri-thunderbolt/next linus/master v6.4 next-20230630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhang-Shurong/usb-r8a66597-hcd-host-fix-port-index-underflow-and-UBSAN-complains/20230701-223726
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/tencent_71A3B792C0AA3D9E148E517B24BC6E006A09%40qq.com
patch subject: [PATCH] usb: r8a66597-hcd: host: fix port index underflow and UBSAN complains
config: riscv-randconfig-r035-20230701 (https://download.01.org/0day-ci/archive/20230701/202307012328.34HpnWQC-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230701/202307012328.34HpnWQC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307012328.34HpnWQC-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/usb/host/r8a66597-hcd.c: In function 'r8a66597_hub_control':
>> drivers/usb/host/r8a66597-hcd.c:2147:18: error: expected '=', ',', ';', 'asm' or '__attribute__' before '-=' token
    2147 |         int port -= (port_index > 0);
         |                  ^~
>> drivers/usb/host/r8a66597-hcd.c:2147:18: error: expected expression before '-=' token
>> drivers/usb/host/r8a66597-hcd.c:2148:60: error: 'port' undeclared (first use in this function)
    2148 |         struct r8a66597_root_hub *rh = &r8a66597->root_hub[port];
         |                                                            ^~~~
   drivers/usb/host/r8a66597-hcd.c:2148:60: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/usb/host/r8a66597-hcd.c:2148:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    2148 |         struct r8a66597_root_hub *rh = &r8a66597->root_hub[port];
         |         ^~~~~~


vim +2147 drivers/usb/host/r8a66597-hcd.c

  2138	
  2139	static int r8a66597_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
  2140					u16 wIndex, char *buf, u16 wLength)
  2141	{
  2142		struct r8a66597 *r8a66597 = hcd_to_r8a66597(hcd);
  2143		int ret;
  2144		unsigned long flags;
  2145		u32 port_index = wIndex & 0xFF;
  2146	
> 2147		int port -= (port_index > 0);
> 2148		struct r8a66597_root_hub *rh = &r8a66597->root_hub[port];
  2149	
  2150		ret = 0;
  2151	
  2152		spin_lock_irqsave(&r8a66597->lock, flags);
  2153		switch (typeReq) {
  2154		case ClearHubFeature:
  2155		case SetHubFeature:
  2156			switch (wValue) {
  2157			case C_HUB_OVER_CURRENT:
  2158			case C_HUB_LOCAL_POWER:
  2159				break;
  2160			default:
  2161				goto error;
  2162			}
  2163			break;
  2164		case ClearPortFeature:
  2165			if (wIndex > r8a66597->max_root_hub)
  2166				goto error;
  2167			if (wLength != 0)
  2168				goto error;
  2169	
  2170			switch (wValue) {
  2171			case USB_PORT_FEAT_ENABLE:
  2172				rh->port &= ~USB_PORT_STAT_POWER;
  2173				break;
  2174			case USB_PORT_FEAT_SUSPEND:
  2175				break;
  2176			case USB_PORT_FEAT_POWER:
  2177				r8a66597_port_power(r8a66597, port, 0);
  2178				break;
  2179			case USB_PORT_FEAT_C_ENABLE:
  2180			case USB_PORT_FEAT_C_SUSPEND:
  2181			case USB_PORT_FEAT_C_CONNECTION:
  2182			case USB_PORT_FEAT_C_OVER_CURRENT:
  2183			case USB_PORT_FEAT_C_RESET:
  2184				break;
  2185			default:
  2186				goto error;
  2187			}
  2188			rh->port &= ~(1 << wValue);
  2189			break;
  2190		case GetHubDescriptor:
  2191			r8a66597_hub_descriptor(r8a66597,
  2192						(struct usb_hub_descriptor *)buf);
  2193			break;
  2194		case GetHubStatus:
  2195			*buf = 0x00;
  2196			break;
  2197		case GetPortStatus:
  2198			if (wIndex > r8a66597->max_root_hub)
  2199				goto error;
  2200			*(__le32 *)buf = cpu_to_le32(rh->port);
  2201			break;
  2202		case SetPortFeature:
  2203			if (wIndex > r8a66597->max_root_hub)
  2204				goto error;
  2205			if (wLength != 0)
  2206				goto error;
  2207	
  2208			switch (wValue) {
  2209			case USB_PORT_FEAT_SUSPEND:
  2210				break;
  2211			case USB_PORT_FEAT_POWER:
  2212				r8a66597_port_power(r8a66597, port, 1);
  2213				rh->port |= USB_PORT_STAT_POWER;
  2214				break;
  2215			case USB_PORT_FEAT_RESET: {
  2216				struct r8a66597_device *dev = rh->dev;
  2217	
  2218				rh->port |= USB_PORT_STAT_RESET;
  2219	
  2220				disable_r8a66597_pipe_all(r8a66597, dev);
  2221				free_usb_address(r8a66597, dev, 1);
  2222	
  2223				r8a66597_mdfy(r8a66597, USBRST, USBRST | UACT,
  2224					      get_dvstctr_reg(port));
  2225				mod_timer(&r8a66597->rh_timer,
  2226					  jiffies + msecs_to_jiffies(50));
  2227				}
  2228				break;
  2229			default:
  2230				goto error;
  2231			}
  2232			rh->port |= 1 << wValue;
  2233			break;
  2234		default:
  2235	error:
  2236			ret = -EPIPE;
  2237			break;
  2238		}
  2239	
  2240		spin_unlock_irqrestore(&r8a66597->lock, flags);
  2241		return ret;
  2242	}
  2243	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
