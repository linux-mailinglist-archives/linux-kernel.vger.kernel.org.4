Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E116BC565
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 05:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCPEr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 00:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCPErZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 00:47:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3033226C0E;
        Wed, 15 Mar 2023 21:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678942044; x=1710478044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OTKMO1yUHR8eFmXY+y8U27OXRlNvGqlxdrG28TwNNno=;
  b=frQeDmyqM62pJW0KpUTdq75xU3Xcnzfp4tkROoKG3EipOauzCyds6+Xn
   QoCbI/vOK7SPMBVtEhfC5k+me4WzPJgM03/g0ypfUEbpqGyvneaUl8dxc
   YVB74/ReIEraNUi8IFMW8ipN7gMJ9JPLUATNtNmeioKA9lBxLhLmAY7R9
   cEGgNra4lKbYgdXSGag0W8kZmSUP62JdAxnDSo4pcjytCisQDkRD5/BPV
   H+wHuwH5kRKhJmV2Hq4365DbY7aN3GTTFgGfXkDK+/S7oT7bxZcsg6hsg
   yYPEWaONTio1Qnyy/eiCPMfwju4se9oG7VjlrgKmfweXLTO1AJvMTMm0U
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="337906085"
X-IronPort-AV: E=Sophos;i="5.98,264,1673942400"; 
   d="scan'208";a="337906085"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 21:47:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="629723573"
X-IronPort-AV: E=Sophos;i="5.98,264,1673942400"; 
   d="scan'208";a="629723573"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Mar 2023 21:47:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcfWK-0008Ih-1C;
        Thu, 16 Mar 2023 04:47:20 +0000
Date:   Thu, 16 Mar 2023 12:46:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-usb@vger.kernel.org,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] extcon: usbc-tusb320: add usb_role_switch support
Message-ID: <202303161221.vGdSsAr9-lkp@intel.com>
References: <20230315220246.951213-2-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315220246.951213-2-alvin@pqrs.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alvin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on chanwoo-extcon/extcon-next]
[also build test WARNING on next-20230316]
[cannot apply to linus/master v6.3-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alvin-ipraga/extcon-usbc-tusb320-add-usb_role_switch-support/20230316-060433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git extcon-next
patch link:    https://lore.kernel.org/r/20230315220246.951213-2-alvin%40pqrs.dk
patch subject: [PATCH 2/2] extcon: usbc-tusb320: add usb_role_switch support
config: i386-randconfig-a013-20230313 (https://download.01.org/0day-ci/archive/20230316/202303161221.vGdSsAr9-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8ed7905410ebc9e2de0bd58d4cdd0a8225529f42
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alvin-ipraga/extcon-usbc-tusb320-add-usb_role_switch-support/20230316-060433
        git checkout 8ed7905410ebc9e2de0bd58d4cdd0a8225529f42
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/extcon/ fs/ksmbd/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303161221.vGdSsAr9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/extcon/extcon-usbc-tusb320.c:280:26: warning: unused variable 'role_sw' [-Wunused-variable]
           struct usb_role_switch *role_sw = priv->role_sw;
                                   ^
   1 warning generated.


vim +/role_sw +280 drivers/extcon/extcon-usbc-tusb320.c

   277	
   278	static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
   279	{
 > 280		struct usb_role_switch *role_sw = priv->role_sw;
   281		struct typec_port *port = priv->port;
   282		struct device *dev = priv->dev;
   283		int typec_mode;
   284		enum usb_role usb_role;
   285		enum typec_role pwr_role;
   286		enum typec_data_role data_role;
   287		u8 state, mode, accessory;
   288		int ret, reg8;
   289		bool ori;
   290	
   291		ret = regmap_read(priv->regmap, TUSB320_REG8, &reg8);
   292		if (ret) {
   293			dev_err(dev, "error during reg8 i2c read, ret=%d!\n", ret);
   294			return;
   295		}
   296	
   297		ori = reg9 & TUSB320_REG9_CABLE_DIRECTION;
   298		typec_set_orientation(port, ori ? TYPEC_ORIENTATION_REVERSE :
   299						  TYPEC_ORIENTATION_NORMAL);
   300	
   301		state = FIELD_GET(TUSB320_REG9_ATTACHED_STATE, reg9);
   302		accessory = FIELD_GET(TUSB320_REG8_ACCESSORY_CONNECTED, reg8);
   303	
   304		switch (state) {
   305		case TUSB320_ATTACHED_STATE_DFP:
   306			typec_mode = TYPEC_MODE_USB2;
   307			usb_role = USB_ROLE_HOST;
   308			pwr_role = TYPEC_SOURCE;
   309			data_role = TYPEC_HOST;
   310			break;
   311		case TUSB320_ATTACHED_STATE_UFP:
   312			typec_mode = TYPEC_MODE_USB2;
   313			usb_role = USB_ROLE_DEVICE;
   314			pwr_role = TYPEC_SINK;
   315			data_role = TYPEC_DEVICE;
   316			break;
   317		case TUSB320_ATTACHED_STATE_ACC:
   318			/*
   319			 * Accessory detected. For debug accessories, just make some
   320			 * qualified guesses as to the role for lack of a better option.
   321			 */
   322			if (accessory == TUSB320_REG8_ACCESSORY_CONNECTED_AUDIO ||
   323			    accessory == TUSB320_REG8_ACCESSORY_CONNECTED_ACHRG) {
   324				typec_mode = TYPEC_MODE_AUDIO;
   325				usb_role = USB_ROLE_NONE;
   326				pwr_role = TYPEC_SINK;
   327				data_role = TYPEC_DEVICE;
   328				break;
   329			} else if (accessory ==
   330				   TUSB320_REG8_ACCESSORY_CONNECTED_DBGDFP) {
   331				typec_mode = TYPEC_MODE_DEBUG;
   332				pwr_role = TYPEC_SOURCE;
   333				usb_role = USB_ROLE_HOST;
   334				data_role = TYPEC_HOST;
   335				break;
   336			} else if (accessory ==
   337				   TUSB320_REG8_ACCESSORY_CONNECTED_DBGUFP) {
   338				typec_mode = TYPEC_MODE_DEBUG;
   339				pwr_role = TYPEC_SINK;
   340				usb_role = USB_ROLE_DEVICE;
   341				data_role = TYPEC_DEVICE;
   342				break;
   343			}
   344	
   345			dev_warn(priv->dev, "unexpected ACCESSORY_CONNECTED state %d\n",
   346				 accessory);
   347	
   348			fallthrough;
   349		default:
   350			typec_mode = TYPEC_MODE_USB2;
   351			usb_role = USB_ROLE_NONE;
   352			pwr_role = TYPEC_SINK;
   353			data_role = TYPEC_DEVICE;
   354			break;
   355		}
   356	
   357		typec_set_vconn_role(port, pwr_role);
   358		typec_set_pwr_role(port, pwr_role);
   359		typec_set_data_role(port, data_role);
   360		typec_set_mode(port, typec_mode);
   361		usb_role_switch_set_role(priv->role_sw, usb_role);
   362	
   363		mode = FIELD_GET(TUSB320_REG8_CURRENT_MODE_DETECT, reg8);
   364		if (mode == TUSB320_REG8_CURRENT_MODE_DETECT_DEF)
   365			typec_set_pwr_opmode(port, TYPEC_PWR_MODE_USB);
   366		else if (mode == TUSB320_REG8_CURRENT_MODE_DETECT_MED)
   367			typec_set_pwr_opmode(port, TYPEC_PWR_MODE_1_5A);
   368		else if (mode == TUSB320_REG8_CURRENT_MODE_DETECT_HI)
   369			typec_set_pwr_opmode(port, TYPEC_PWR_MODE_3_0A);
   370		else	/* Charge through accessory */
   371			typec_set_pwr_opmode(port, TYPEC_PWR_MODE_USB);
   372	}
   373	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
