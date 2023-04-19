Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E146E8009
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjDSREJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjDSREE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:04:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9697EF6;
        Wed, 19 Apr 2023 10:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681923842; x=1713459842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YWEFkjk4Tn32C8B9bIF5tMsJFwcjS2BBCkRcNPRL1DQ=;
  b=Yz2T8buo5MzkVoHNGVFWq5aJXUDeimuw72EhY38eDy7iIgpGJRhabyGW
   5q2reARDYKTqOXv20FYSbwszv8ckH6Ryv+D7e3j1Zlzjdb79ZXh2K+4CY
   ULE3PtNKh5EdD2HDbxbapxcajh48Nh2OvUH7bNkmB6jPcEaqo3BMryD44
   UDWvkYM3DRbD6hAh7cVJR/g5yrZxCKXOnVL1n6GRi4/NuvA0Iep+YFJpJ
   /mD5lkAUE5PCPqSUWN1eeFlDd3N2EIP/nQ07/9NhoZ/QUi+QSuWBYIJA5
   80WP9NLMkDSxiTgUCCP03mHwkKXFsjKEYJXTDx/NcUa/5/aLhOq2hnJF7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="325117127"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="325117127"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 10:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="756171542"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="756171542"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Apr 2023 10:03:57 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppBDp-000f2M-0Q;
        Wed, 19 Apr 2023 17:03:57 +0000
Date:   Thu, 20 Apr 2023 01:03:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sarannya S <quic_sarannya@quicinc.com>, quic_bjorande@quicinc.com,
        arnaud.pouliquen@foss.st.com, swboyd@chromium.org,
        quic_clew@quicinc.com, mathieu.poirier@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Sarannya S <quic_sarannya@quicinc.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH V6 3/3] rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL
 support
Message-ID: <202304200018.ik0k7dKN-lkp@intel.com>
References: <1681912409-25248-4-git-send-email-quic_sarannya@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681912409-25248-4-git-send-email-quic_sarannya@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sarannya,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.3-rc7]
[also build test ERROR on linus/master next-20230418]
[cannot apply to remoteproc/rpmsg-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sarannya-S/rpmsg-core-Add-signal-API-support/20230419-220040
patch link:    https://lore.kernel.org/r/1681912409-25248-4-git-send-email-quic_sarannya%40quicinc.com
patch subject: [PATCH V6 3/3] rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230420/202304200018.ik0k7dKN-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4f765ede8c129f07c522ef4a7c6aee27cb466be6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sarannya-S/rpmsg-core-Add-signal-API-support/20230419-220040
        git checkout 4f765ede8c129f07c522ef4a7c6aee27cb466be6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304200018.ik0k7dKN-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/rpmsg/rpmsg_char.c: In function 'rpmsg_eptdev_ioctl':
>> drivers/rpmsg/rpmsg_char.c:334:23: error: too few arguments to function 'rpmsg_set_flow_control'
     334 |                 ret = rpmsg_set_flow_control(eptdev->ept, set);
         |                       ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/rpmsg/rpmsg_char.c:23:
   include/linux/rpmsg.h:200:5: note: declared here
     200 | int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst);
         |     ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/rpmsg/rpmsg_char.c:321:13: warning: variable 'val' set but not used [-Wunused-but-set-variable]
     321 |         u32 val;
         |             ^~~


vim +/rpmsg_set_flow_control +334 drivers/rpmsg/rpmsg_char.c

   314	
   315	static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
   316				       unsigned long arg)
   317	{
   318		struct rpmsg_eptdev *eptdev = fp->private_data;
   319	
   320		bool set;
 > 321		u32 val;
   322		int ret;
   323	
   324		switch (cmd) {
   325		case RPMSG_GET_OUTGOING_FLOWCONTROL:
   326			eptdev->remote_flow_updated = false;
   327			ret = put_user(eptdev->remote_flow, (int __user *)arg);
   328			break;
   329		case RPMSG_SET_INCOMING_FLOWCONTROL:
   330			ret = get_user(val, (int __user *)arg);
   331			if (ret)
   332				break;
   333			set = !!arg;
 > 334			ret = rpmsg_set_flow_control(eptdev->ept, set);
   335			break;
   336		case RPMSG_DESTROY_EPT_IOCTL:
   337			/* Don't allow to destroy a default endpoint. */
   338			if (eptdev->default_ept) {
   339				ret = -EINVAL;
   340				break;
   341			}
   342			ret = rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
   343			break;
   344		default:
   345			ret = -EINVAL;
   346		}
   347	
   348		return ret;
   349	}
   350	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
