Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DEB6C3793
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCURC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCURCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:02:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C869298FF;
        Tue, 21 Mar 2023 10:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679418141; x=1710954141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d+hlpp3Zd9LOfPprBhu8Y574GqlBNBa7l4yvc+7zCA4=;
  b=hD3Ex+xYorAllQOAgJ9bbT4hj5zXH1GtpGdG9AIBqoygx85HT0BvcgjQ
   v391fXzc7e0iKKrF0U/QE8uJvJ7wJRiXC+efXb2/jtwqTQA8LS+6e8mVJ
   IVQPs3MW0/nZuGSyl7DPediWkb00bJpJzmF5hxxaRzfqF781T7iSdkrAp
   x2/DKFQuLeN0I9jNoa7ikdHl4wOEN05r2cJBQSk8aWMs0CNHK53bUUEdF
   udOmjk91K2mg9ayN11fuxUCiLWMi0vyp9URlWh67uVaLgTwu+xUXdYm2Y
   1FiCde0ni4jZBLO7kYExCKlxdiRAkkcOhNkZVWdoCzxs+4ebgaxHPucjV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="322846091"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="322846091"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 10:01:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="631664574"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="631664574"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Mar 2023 10:01:41 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pefMi-000CBa-0v;
        Tue, 21 Mar 2023 17:01:40 +0000
Date:   Wed, 22 Mar 2023 01:01:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        daniel.almeida@collabora.com, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, jernel@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 3/8] media: videobuf2: Add a module param to limit vb2
 queue buffer storage
Message-ID: <202303220057.J83sWVI1-lkp@intel.com>
References: <20230321102855.346732-4-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321102855.346732-4-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

I love your patch! Yet something to improve:

[auto build test ERROR on media-tree/master]
[also build test ERROR on linus/master v6.3-rc3 next-20230321]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/media-videobuf2-Access-vb2_queue-bufs-array-through-helper-functions/20230321-183154
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230321102855.346732-4-benjamin.gaignard%40collabora.com
patch subject: [PATCH v2 3/8] media: videobuf2: Add a module param to limit vb2 queue buffer storage
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20230322/202303220057.J83sWVI1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/aab64e29070dfec3a043b5020399f79554d6cae4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Benjamin-Gaignard/media-videobuf2-Access-vb2_queue-bufs-array-through-helper-functions/20230321-183154
        git checkout aab64e29070dfec3a043b5020399f79554d6cae4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303220057.J83sWVI1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/module.h:22,
                    from drivers/media/common/videobuf2/videobuf2-core.c:21:
   drivers/media/common/videobuf2/videobuf2-core.c: In function '__check_max_vb_buffer_per_queue':
>> include/linux/moduleparam.h:150:34: error: returning 'size_t *' {aka 'unsigned int *'} from a function with incompatible return type 'long unsigned int *' [-Werror=incompatible-pointer-types]
     150 |         param_check_##type(name, &(value));                                \
         |                                  ^
   include/linux/moduleparam.h:409:75: note: in definition of macro '__param_check'
     409 |         static inline type __always_unused *__check_##name(void) { return(p); }
         |                                                                           ^
   include/linux/moduleparam.h:150:9: note: in expansion of macro 'param_check_ulong'
     150 |         param_check_##type(name, &(value));                                \
         |         ^~~~~~~~~~~~
   include/linux/moduleparam.h:127:9: note: in expansion of macro 'module_param_named'
     127 |         module_param_named(name, name, type, perm)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/media/common/videobuf2/videobuf2-core.c:37:1: note: in expansion of macro 'module_param'
      37 | module_param(max_vb_buffer_per_queue, ulong, 0644);
         | ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +150 include/linux/moduleparam.h

^1da177e4c3f415 Linus Torvalds  2005-04-16  100  
546970bc6afc7fb Rusty Russell   2010-08-11  101  /**
546970bc6afc7fb Rusty Russell   2010-08-11  102   * module_param - typesafe helper for a module/cmdline parameter
e2854a1054ab171 Zhenzhong Duan  2019-11-04  103   * @name: the variable to alter, and exposed parameter name.
546970bc6afc7fb Rusty Russell   2010-08-11  104   * @type: the type of the parameter
546970bc6afc7fb Rusty Russell   2010-08-11  105   * @perm: visibility in sysfs.
546970bc6afc7fb Rusty Russell   2010-08-11  106   *
e2854a1054ab171 Zhenzhong Duan  2019-11-04  107   * @name becomes the module parameter, or (prefixed by KBUILD_MODNAME and a
546970bc6afc7fb Rusty Russell   2010-08-11  108   * ".") the kernel commandline parameter.  Note that - is changed to _, so
546970bc6afc7fb Rusty Russell   2010-08-11  109   * the user can use "foo-bar=1" even for variable "foo_bar".
546970bc6afc7fb Rusty Russell   2010-08-11  110   *
c6a8b84da4c28bd Randy Dunlap    2020-07-17  111   * @perm is 0 if the variable is not to appear in sysfs, or 0444
546970bc6afc7fb Rusty Russell   2010-08-11  112   * for world-readable, 0644 for root-writable, etc.  Note that if it
b51d23e4e9fea6f Dan Streetman   2015-06-17  113   * is writable, you may need to use kernel_param_lock() around
546970bc6afc7fb Rusty Russell   2010-08-11  114   * accesses (esp. charp, which can be kfreed when it changes).
546970bc6afc7fb Rusty Russell   2010-08-11  115   *
546970bc6afc7fb Rusty Russell   2010-08-11  116   * The @type is simply pasted to refer to a param_ops_##type and a
546970bc6afc7fb Rusty Russell   2010-08-11  117   * param_check_##type: for convenience many standard types are provided but
546970bc6afc7fb Rusty Russell   2010-08-11  118   * you can create your own by defining those variables.
546970bc6afc7fb Rusty Russell   2010-08-11  119   *
546970bc6afc7fb Rusty Russell   2010-08-11  120   * Standard types are:
7d8365771ffb0ed Paul Menzel     2020-07-03  121   *	byte, hexint, short, ushort, int, uint, long, ulong
546970bc6afc7fb Rusty Russell   2010-08-11  122   *	charp: a character pointer
546970bc6afc7fb Rusty Russell   2010-08-11  123   *	bool: a bool, values 0/1, y/n, Y/N.
546970bc6afc7fb Rusty Russell   2010-08-11  124   *	invbool: the above, only sense-reversed (N = true).
546970bc6afc7fb Rusty Russell   2010-08-11  125   */
546970bc6afc7fb Rusty Russell   2010-08-11  126  #define module_param(name, type, perm)				\
546970bc6afc7fb Rusty Russell   2010-08-11  127  	module_param_named(name, name, type, perm)
546970bc6afc7fb Rusty Russell   2010-08-11  128  
3baee201b06cfaf Jani Nikula     2014-08-27  129  /**
3baee201b06cfaf Jani Nikula     2014-08-27  130   * module_param_unsafe - same as module_param but taints kernel
b6d0531ec7e2ae9 Fabien Dessenne 2019-12-02  131   * @name: the variable to alter, and exposed parameter name.
b6d0531ec7e2ae9 Fabien Dessenne 2019-12-02  132   * @type: the type of the parameter
b6d0531ec7e2ae9 Fabien Dessenne 2019-12-02  133   * @perm: visibility in sysfs.
3baee201b06cfaf Jani Nikula     2014-08-27  134   */
3baee201b06cfaf Jani Nikula     2014-08-27  135  #define module_param_unsafe(name, type, perm)			\
3baee201b06cfaf Jani Nikula     2014-08-27  136  	module_param_named_unsafe(name, name, type, perm)
3baee201b06cfaf Jani Nikula     2014-08-27  137  
546970bc6afc7fb Rusty Russell   2010-08-11  138  /**
546970bc6afc7fb Rusty Russell   2010-08-11  139   * module_param_named - typesafe helper for a renamed module/cmdline parameter
546970bc6afc7fb Rusty Russell   2010-08-11  140   * @name: a valid C identifier which is the parameter name.
546970bc6afc7fb Rusty Russell   2010-08-11  141   * @value: the actual lvalue to alter.
546970bc6afc7fb Rusty Russell   2010-08-11  142   * @type: the type of the parameter
546970bc6afc7fb Rusty Russell   2010-08-11  143   * @perm: visibility in sysfs.
546970bc6afc7fb Rusty Russell   2010-08-11  144   *
546970bc6afc7fb Rusty Russell   2010-08-11  145   * Usually it's a good idea to have variable names and user-exposed names the
546970bc6afc7fb Rusty Russell   2010-08-11  146   * same, but that's harder if the variable must be non-static or is inside a
546970bc6afc7fb Rusty Russell   2010-08-11  147   * structure.  This allows exposure under a different name.
546970bc6afc7fb Rusty Russell   2010-08-11  148   */
546970bc6afc7fb Rusty Russell   2010-08-11  149  #define module_param_named(name, value, type, perm)			   \
546970bc6afc7fb Rusty Russell   2010-08-11 @150  	param_check_##type(name, &(value));				   \
546970bc6afc7fb Rusty Russell   2010-08-11  151  	module_param_cb(name, &param_ops_##type, &value, perm);		   \
546970bc6afc7fb Rusty Russell   2010-08-11  152  	__MODULE_PARM_TYPE(name, #type)
546970bc6afc7fb Rusty Russell   2010-08-11  153  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
