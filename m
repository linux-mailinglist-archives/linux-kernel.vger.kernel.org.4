Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C716CACC7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjC0SMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC0SMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:12:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AF495;
        Mon, 27 Mar 2023 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679940750; x=1711476750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y6w2xJ/oqEByFFIHKtzvwFaQsZynVoW8risyl+Pyoy4=;
  b=d7kOAQmP5fPC+x6egDBRB65MNBkU6PyQzovvVZBmYF2fK0eLBt2r4N+a
   Dt2taGwCtcYzNeUQ8rK3ZmDZU3Lq8Y9Vz65rx4/031GI4iPqAUtnDzTPA
   k39yZpGN+xeUT3oUihfVfsE1IDuR2YHqiMz6kd3SVrQdpTYpE8xHduhH9
   TJH4pactzS+SuKvJaALadrO3wB/DkUTyzrR0IKu3seEeCuejY9fs2+V3f
   B5TYvP//IRYeNxdBP9GmNFGWoIi2Y8OoHTXirZr6jw1ObtZgoXKMDSmdA
   hPSE6g1ycCbfyFCc6B7aOIlkci7/NP5Ks9ivMl/58jb4HxvF9BGVuN8Vx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342753090"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="342753090"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 11:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="713939744"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="713939744"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Mar 2023 11:12:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgrKP-000HuV-27;
        Mon, 27 Mar 2023 18:12:21 +0000
Date:   Tue, 28 Mar 2023 02:11:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maximilian Weigand <mweigand@mweigand.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 6/6] Input: cyttsp5: implement proper sleep and wakeup
 procedures
Message-ID: <202303280119.UlD7s4Rk-lkp@intel.com>
References: <20230323135205.1160879-7-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323135205.1160879-7-mweigand@mweigand.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maximilian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus linus/master v6.3-rc4 next-20230327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maximilian-Weigand/Input-cyttsp5-fix-array-length/20230323-215957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20230323135205.1160879-7-mweigand%40mweigand.net
patch subject: [PATCH 6/6] Input: cyttsp5: implement proper sleep and wakeup procedures
config: i386-randconfig-a011-20230327 (https://download.01.org/0day-ci/archive/20230328/202303280119.UlD7s4Rk-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9988f8132aa9a4e8c9f0eb3093b06a9f02d90ec9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Maximilian-Weigand/Input-cyttsp5-fix-array-length/20230323-215957
        git checkout 9988f8132aa9a4e8c9f0eb3093b06a9f02d90ec9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/input/touchscreen/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303280119.UlD7s4Rk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/input/touchscreen/cyttsp5.c:581:6: warning: unused variable 'crc' [-Wunused-variable]
           u16 crc;
               ^
   drivers/input/touchscreen/cyttsp5.c:620:6: warning: unused variable 'crc' [-Wunused-variable]
           u16 crc;
               ^
   drivers/input/touchscreen/cyttsp5.c:700:5: warning: unused variable 'cmd' [-Wunused-variable]
           u8 cmd[2];
              ^
>> drivers/input/touchscreen/cyttsp5.c:1004:6: warning: unused variable 'error' [-Wunused-variable]
           int error;
               ^
>> drivers/input/touchscreen/cyttsp5.c:1003:21: warning: unused variable 'client' [-Wunused-variable]
           struct i2c_client *client = to_i2c_client(dev);
                              ^
   5 warnings generated.


vim +/crc +581 drivers/input/touchscreen/cyttsp5.c

   576	
   577	static int cyttsp5_enter_sleep(struct cyttsp5 *ts)
   578	{
   579		int rc;
   580		u8 cmd[2];
 > 581		u16 crc;
   582	
   583		memset(cmd, 0, sizeof(cmd));
   584	
   585		SET_CMD_REPORT_TYPE(cmd[0], 0);
   586		SET_CMD_REPORT_ID(cmd[0], HID_POWER_SLEEP);
   587		SET_CMD_OPCODE(cmd[1], HID_CMD_SET_POWER);
   588	
   589		rc = cyttsp5_write(ts, HID_COMMAND_REG, cmd, 2);
   590		if (rc) {
   591			dev_err(ts->dev, "Failed to write command %d", rc);
   592			return rc;
   593		}
   594	
   595		rc = wait_for_completion_interruptible_timeout(&ts->cmd_command_done,
   596					msecs_to_jiffies(CY_HID_SET_POWER_TIMEOUT));
   597		if (rc <= 0) {
   598			dev_err(ts->dev, "HID output cmd execution timed out\n");
   599			rc = -ETIMEDOUT;
   600			return rc;
   601		}
   602	
   603		/* validate */
   604		if ((ts->response_buf[2] != HID_RESPONSE_REPORT_ID)
   605				|| ((ts->response_buf[3] & 0x3) != HID_POWER_SLEEP)
   606				|| ((ts->response_buf[4] & 0xF) != HID_CMD_SET_POWER)) {
   607			rc = -EINVAL;
   608			dev_err(ts->dev, "Validation of the sleep response failed\n");
   609			return rc;
   610		}
   611	
   612		return 0;
   613	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
