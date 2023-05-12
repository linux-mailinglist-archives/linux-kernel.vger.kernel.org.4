Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0D16FFE39
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbjELBCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 21:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjELBCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:02:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D441FE0;
        Thu, 11 May 2023 18:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683853354; x=1715389354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dCRxN8GRlqazVUhRpYDi45qn973c860pPkgbS7cXHpY=;
  b=DfjZ6wvvIyyVdxsGGFehKpLcIF2wBWq7/wqnx+F5Y+1/4e4wMPuaU9D2
   aFCNItNST2r9BpPXEnjtLs1qHe7rwt6ybNGvqSK2yI8C7LcJisIDSMgKr
   MmjiR51hJyN+Oo+7F9Whm2xPN9GJdg1wWxMtdVP3GY4fudH5TrmRPIudf
   nZ3Unm3oOA8+WyhHP/ZWJ0MW6lihobD1W1Ese1N1apsB3LS0lb0JQS1dF
   nf/YKrItqC4bguy8cIkJoEl1VbV/sD8cVHZ6MhlrXMKkkWIHhXasB9Clw
   PwEyGVuOGNBBKhjSvOMNUW6k5yCqleuHOdQZJ4I2Z0+hWwRR4BxZe3ws7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335181908"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="335181908"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 18:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730613312"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="730613312"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2023 18:02:32 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxHB1-0004MJ-11;
        Fri, 12 May 2023 01:02:31 +0000
Date:   Fri, 12 May 2023 09:01:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] Input: libps2 - introduce common interrupt handler
Message-ID: <202305120818.unCn8fQ9-lkp@intel.com>
References: <20230511185252.386941-7-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511185252.386941-7-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

kernel test robot noticed the following build errors:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on dtor-input/for-linus hid/for-next linus/master v6.4-rc1 next-20230511]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Torokhov/Input-libps2-attach-ps2dev-instances-as-serio-port-s-drvdata/20230512-025431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20230511185252.386941-7-dmitry.torokhov%40gmail.com
patch subject: [PATCH 6/7] Input: libps2 - introduce common interrupt handler
config: mips-randconfig-r031-20230510 (https://download.01.org/0day-ci/archive/20230512/202305120818.unCn8fQ9-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0fb98227c90adf2536c9ad644a74d5e92961111)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/1f2ba3a941e6f6a3ad745fa780825ac56570616e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dmitry-Torokhov/Input-libps2-attach-ps2dev-instances-as-serio-port-s-drvdata/20230512-025431
        git checkout 1f2ba3a941e6f6a3ad745fa780825ac56570616e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/input/keyboard/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305120818.unCn8fQ9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/input/keyboard/atkbd.c:424:3: error: must use 'struct' tag to refer to type 'atkbd'
                   atkbd->resend = false;
                   ^
                   struct 
>> drivers/input/keyboard/atkbd.c:424:3: error: expected expression
   2 errors generated.


vim +424 drivers/input/keyboard/atkbd.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  400  
1f2ba3a941e6f6 Dmitry Torokhov 2023-05-11  401  static enum ps2_disposition atkbd_pre_receive_byte(struct ps2dev *ps2dev,
1f2ba3a941e6f6 Dmitry Torokhov 2023-05-11  402  						   u8 data, unsigned int flags)
^1da177e4c3f41 Linus Torvalds  2005-04-16  403  {
1f2ba3a941e6f6 Dmitry Torokhov 2023-05-11  404  	struct serio *serio = ps2dev->serio;
^1da177e4c3f41 Linus Torvalds  2005-04-16  405  
a9a1f9c315c27f Dmitry Torokhov 2010-01-06  406  	dev_dbg(&serio->dev, "Received %02x flags %02x\n", data, flags);
^1da177e4c3f41 Linus Torvalds  2005-04-16  407  
^1da177e4c3f41 Linus Torvalds  2005-04-16  408  #if !defined(__i386__) && !defined (__x86_64__)
1f2ba3a941e6f6 Dmitry Torokhov 2023-05-11  409  	if ((flags & (SERIO_FRAME | SERIO_PARITY)) &&
1f2ba3a941e6f6 Dmitry Torokhov 2023-05-11  410  	    (~flags & SERIO_TIMEOUT)) {
1f2ba3a941e6f6 Dmitry Torokhov 2023-05-11  411  		struct atkbd *atkbd = container_of(ps2dev, struct atkbd,
1f2ba3a941e6f6 Dmitry Torokhov 2023-05-11  412  						   ps2dev);
1f2ba3a941e6f6 Dmitry Torokhov 2023-05-11  413  
1f2ba3a941e6f6 Dmitry Torokhov 2023-05-11  414  		if (!atkbd->resend && atkbd->write) {
1f2ba3a941e6f6 Dmitry Torokhov 2023-05-11  415  			dev_warn(&serio->dev,
1f2ba3a941e6f6 Dmitry Torokhov 2023-05-11  416  				 "Frame/parity error: %02x\n", flags);
^1da177e4c3f41 Linus Torvalds  2005-04-16  417  			serio_write(serio, ATKBD_CMD_RESEND);
a9a1f9c315c27f Dmitry Torokhov 2010-01-06  418  			atkbd->resend = true;
1f2ba3a941e6f6 Dmitry Torokhov 2023-05-11  419  			return PS2_IGNORE;
1f2ba3a941e6f6 Dmitry Torokhov 2023-05-11  420  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  421  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  422  
^1da177e4c3f41 Linus Torvalds  2005-04-16  423  	if (!flags && data == ATKBD_RET_ACK)
a9a1f9c315c27f Dmitry Torokhov 2010-01-06 @424  		atkbd->resend = false;
^1da177e4c3f41 Linus Torvalds  2005-04-16  425  #endif
^1da177e4c3f41 Linus Torvalds  2005-04-16  426  
1f2ba3a941e6f6 Dmitry Torokhov 2023-05-11  427  	return PS2_PROCESS;
1f2ba3a941e6f6 Dmitry Torokhov 2023-05-11  428  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  429  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
