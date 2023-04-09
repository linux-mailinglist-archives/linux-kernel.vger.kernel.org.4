Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E290A6DC1E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 00:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDIWWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 18:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIWWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 18:22:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35EDB1;
        Sun,  9 Apr 2023 15:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681078970; x=1712614970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5+MDRnDjJbwiwiiJOJfybKSPji2eRvgyyEX8Q8KlvxI=;
  b=LYVwPHrAXxKBlGw3qmvgVzRk/0i4SP3ZkvRqaRC4r6ObNixQe9pPdANq
   3ZXncZgVl/Y5YrcPFgM3S0lSVifRYtEaeV0oT7fZcP30xcSV7RENeYZxY
   bW2bbrEhKb7D4bXeRck8fdSvWV9H/F/UPpL0/s6/QRTQv8ONMNURbS6MQ
   +Jy1sVAJ1FpR0NXviinYhDwmwl1yfHSaFkUtDtIEgPQQ5Ke2vUvByhksE
   j1VPutgINcHNfCZjWyg4tUVmyisevBWAa8j+eG/i4MA2L5i8f2F4/WHpr
   yJnX98kMy1/bkn6kfne/DPzMj5zb2YVKHUXknlH3EtpI2olBO5f17AwLi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="406080055"
X-IronPort-AV: E=Sophos;i="5.98,332,1673942400"; 
   d="scan'208";a="406080055"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2023 15:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="688078327"
X-IronPort-AV: E=Sophos;i="5.98,332,1673942400"; 
   d="scan'208";a="688078327"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Apr 2023 15:22:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pldQs-000Uoj-1R;
        Sun, 09 Apr 2023 22:22:46 +0000
Date:   Mon, 10 Apr 2023 06:22:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>, sudeep.holla@arm.com
Cc:     oe-kbuild-all@lists.linux.dev, cristian.marussi@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikunj Kela <quic_nkela@quicinc.com>
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional parameters
Message-ID: <202304100606.kUjhsRYf-lkp@intel.com>
References: <20230409181918.29270-3-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230409181918.29270-3-quic_nkela@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikunj,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.3-rc6 next-20230406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikunj-Kela/dt-bindings-firmware-arm-scmi-support-parameter-passing-in-smc-hvc/20230410-022129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230409181918.29270-3-quic_nkela%40quicinc.com
patch subject: [PATCH 2/2] firmware: arm_scmi: Augment SMC/HVC to allow optional parameters
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230410/202304100606.kUjhsRYf-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9c34de66aa243da9824e8bbe749b24e36b0db483
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nikunj-Kela/dt-bindings-firmware-arm-scmi-support-parameter-passing-in-smc-hvc/20230410-022129
        git checkout 9c34de66aa243da9824e8bbe749b24e36b0db483
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304100606.kUjhsRYf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/firmware/arm_scmi/smc.c:9:
   drivers/firmware/arm_scmi/smc.c: In function 'smc_send_message':
>> include/linux/arm-smccc.h:436:29: error: register specified for 'arg1' isn't suitable for data type
     436 |         register typeof(a1) arg1 asm("r1") = __a1;                      \
         |                             ^~~~
   include/linux/arm-smccc.h:442:9: note: in expansion of macro '__declare_arg_3'
     442 |         __declare_arg_3(a0, a1, a2, a3, res);                           \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:447:9: note: in expansion of macro '__declare_arg_4'
     447 |         __declare_arg_4(a0, a1, a2, a3, a4, res);                       \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:452:9: note: in expansion of macro '__declare_arg_5'
     452 |         __declare_arg_5(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:457:9: note: in expansion of macro '__declare_arg_6'
     457 |         __declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:460:37: note: in expansion of macro '__declare_arg_7'
     460 | #define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:461:37: note: in expansion of macro '___declare_args'
     461 | #define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:479:17: note: in expansion of macro '__declare_args'
     479 |                 __declare_args(__count_args(__VA_ARGS__), __VA_ARGS__); \
         |                 ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:518:33: note: in expansion of macro '__arm_smccc_1_1'
     518 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:552:25: note: in expansion of macro 'arm_smccc_1_1_hvc'
     552 |                         arm_smccc_1_1_hvc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/firmware/arm_scmi/smc.c:250:17: note: in expansion of macro 'arm_smccc_1_1_invoke'
     250 |                 arm_smccc_1_1_invoke(scmi_info->func_id, p[0].x, p[1].x, p[2].x,
         |                 ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:438:29: error: register specified for 'arg3' isn't suitable for data type
     438 |         register typeof(a3) arg3 asm("r3") = __a3
         |                             ^~~~
   include/linux/arm-smccc.h:442:9: note: in expansion of macro '__declare_arg_3'
     442 |         __declare_arg_3(a0, a1, a2, a3, res);                           \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:447:9: note: in expansion of macro '__declare_arg_4'
     447 |         __declare_arg_4(a0, a1, a2, a3, a4, res);                       \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:452:9: note: in expansion of macro '__declare_arg_5'
     452 |         __declare_arg_5(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:457:9: note: in expansion of macro '__declare_arg_6'
     457 |         __declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:460:37: note: in expansion of macro '__declare_arg_7'
     460 | #define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:461:37: note: in expansion of macro '___declare_args'
     461 | #define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:479:17: note: in expansion of macro '__declare_args'
     479 |                 __declare_args(__count_args(__VA_ARGS__), __VA_ARGS__); \
         |                 ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:518:33: note: in expansion of macro '__arm_smccc_1_1'
     518 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:552:25: note: in expansion of macro 'arm_smccc_1_1_hvc'
     552 |                         arm_smccc_1_1_hvc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/firmware/arm_scmi/smc.c:250:17: note: in expansion of macro 'arm_smccc_1_1_invoke'
     250 |                 arm_smccc_1_1_invoke(scmi_info->func_id, p[0].x, p[1].x, p[2].x,
         |                 ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:448:29: error: register specified for 'arg5' isn't suitable for data type
     448 |         register typeof(a5) arg5 asm("r5") = __a5
         |                             ^~~~
   include/linux/arm-smccc.h:452:9: note: in expansion of macro '__declare_arg_5'
     452 |         __declare_arg_5(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:457:9: note: in expansion of macro '__declare_arg_6'
     457 |         __declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:460:37: note: in expansion of macro '__declare_arg_7'
     460 | #define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:461:37: note: in expansion of macro '___declare_args'
     461 | #define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:479:17: note: in expansion of macro '__declare_args'
     479 |                 __declare_args(__count_args(__VA_ARGS__), __VA_ARGS__); \
         |                 ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:518:33: note: in expansion of macro '__arm_smccc_1_1'
     518 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:552:25: note: in expansion of macro 'arm_smccc_1_1_hvc'
     552 |                         arm_smccc_1_1_hvc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/firmware/arm_scmi/smc.c:250:17: note: in expansion of macro 'arm_smccc_1_1_invoke'
     250 |                 arm_smccc_1_1_invoke(scmi_info->func_id, p[0].x, p[1].x, p[2].x,
         |                 ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:436:29: error: register specified for 'arg1' isn't suitable for data type
     436 |         register typeof(a1) arg1 asm("r1") = __a1;                      \
         |                             ^~~~
   include/linux/arm-smccc.h:442:9: note: in expansion of macro '__declare_arg_3'
     442 |         __declare_arg_3(a0, a1, a2, a3, res);                           \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:447:9: note: in expansion of macro '__declare_arg_4'
     447 |         __declare_arg_4(a0, a1, a2, a3, a4, res);                       \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:452:9: note: in expansion of macro '__declare_arg_5'
     452 |         __declare_arg_5(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:457:9: note: in expansion of macro '__declare_arg_6'
     457 |         __declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:460:37: note: in expansion of macro '__declare_arg_7'
     460 | #define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:461:37: note: in expansion of macro '___declare_args'
     461 | #define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:479:17: note: in expansion of macro '__declare_args'
     479 |                 __declare_args(__count_args(__VA_ARGS__), __VA_ARGS__); \
         |                 ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:502:33: note: in expansion of macro '__arm_smccc_1_1'
     502 | #define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:555:25: note: in expansion of macro 'arm_smccc_1_1_smc'
     555 |                         arm_smccc_1_1_smc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/firmware/arm_scmi/smc.c:250:17: note: in expansion of macro 'arm_smccc_1_1_invoke'
     250 |                 arm_smccc_1_1_invoke(scmi_info->func_id, p[0].x, p[1].x, p[2].x,
         |                 ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:438:29: error: register specified for 'arg3' isn't suitable for data type
     438 |         register typeof(a3) arg3 asm("r3") = __a3
         |                             ^~~~
   include/linux/arm-smccc.h:442:9: note: in expansion of macro '__declare_arg_3'
     442 |         __declare_arg_3(a0, a1, a2, a3, res);                           \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:447:9: note: in expansion of macro '__declare_arg_4'
     447 |         __declare_arg_4(a0, a1, a2, a3, a4, res);                       \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:452:9: note: in expansion of macro '__declare_arg_5'
     452 |         __declare_arg_5(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:457:9: note: in expansion of macro '__declare_arg_6'
     457 |         __declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:460:37: note: in expansion of macro '__declare_arg_7'
     460 | #define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:461:37: note: in expansion of macro '___declare_args'
     461 | #define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:479:17: note: in expansion of macro '__declare_args'
     479 |                 __declare_args(__count_args(__VA_ARGS__), __VA_ARGS__); \
         |                 ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:502:33: note: in expansion of macro '__arm_smccc_1_1'
     502 | #define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:555:25: note: in expansion of macro 'arm_smccc_1_1_smc'
     555 |                         arm_smccc_1_1_smc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/firmware/arm_scmi/smc.c:250:17: note: in expansion of macro 'arm_smccc_1_1_invoke'
     250 |                 arm_smccc_1_1_invoke(scmi_info->func_id, p[0].x, p[1].x, p[2].x,
         |                 ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:448:29: error: register specified for 'arg5' isn't suitable for data type
     448 |         register typeof(a5) arg5 asm("r5") = __a5
         |                             ^~~~
   include/linux/arm-smccc.h:452:9: note: in expansion of macro '__declare_arg_5'
     452 |         __declare_arg_5(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:457:9: note: in expansion of macro '__declare_arg_6'
     457 |         __declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:460:37: note: in expansion of macro '__declare_arg_7'
     460 | #define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:461:37: note: in expansion of macro '___declare_args'
     461 | #define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:479:17: note: in expansion of macro '__declare_args'
     479 |                 __declare_args(__count_args(__VA_ARGS__), __VA_ARGS__); \
         |                 ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:502:33: note: in expansion of macro '__arm_smccc_1_1'
     502 | #define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:555:25: note: in expansion of macro 'arm_smccc_1_1_smc'
     555 |                         arm_smccc_1_1_smc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/firmware/arm_scmi/smc.c:250:17: note: in expansion of macro 'arm_smccc_1_1_invoke'
     250 |                 arm_smccc_1_1_invoke(scmi_info->func_id, p[0].x, p[1].x, p[2].x,
         |                 ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:436:29: error: register specified for 'arg1' isn't suitable for data type
     436 |         register typeof(a1) arg1 asm("r1") = __a1;                      \
         |                             ^~~~
   include/linux/arm-smccc.h:442:9: note: in expansion of macro '__declare_arg_3'
     442 |         __declare_arg_3(a0, a1, a2, a3, res);                           \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:447:9: note: in expansion of macro '__declare_arg_4'
     447 |         __declare_arg_4(a0, a1, a2, a3, a4, res);                       \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:452:9: note: in expansion of macro '__declare_arg_5'
     452 |         __declare_arg_5(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:457:9: note: in expansion of macro '__declare_arg_6'
     457 |         __declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:460:37: note: in expansion of macro '__declare_arg_7'
     460 | #define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:461:37: note: in expansion of macro '___declare_args'
     461 | #define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:527:17: note: in expansion of macro '__declare_args'
     527 |                 __declare_args(__count_args(__VA_ARGS__), __VA_ARGS__); \
         |                 ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:558:25: note: in expansion of macro '__fail_smccc_1_1'
     558 |                         __fail_smccc_1_1(__VA_ARGS__);                  \
         |                         ^~~~~~~~~~~~~~~~
   drivers/firmware/arm_scmi/smc.c:250:17: note: in expansion of macro 'arm_smccc_1_1_invoke'
     250 |                 arm_smccc_1_1_invoke(scmi_info->func_id, p[0].x, p[1].x, p[2].x,
         |                 ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:438:29: error: register specified for 'arg3' isn't suitable for data type
     438 |         register typeof(a3) arg3 asm("r3") = __a3
         |                             ^~~~
   include/linux/arm-smccc.h:442:9: note: in expansion of macro '__declare_arg_3'
     442 |         __declare_arg_3(a0, a1, a2, a3, res);                           \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:447:9: note: in expansion of macro '__declare_arg_4'
     447 |         __declare_arg_4(a0, a1, a2, a3, a4, res);                       \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:452:9: note: in expansion of macro '__declare_arg_5'
     452 |         __declare_arg_5(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:457:9: note: in expansion of macro '__declare_arg_6'
     457 |         __declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:460:37: note: in expansion of macro '__declare_arg_7'
     460 | #define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:461:37: note: in expansion of macro '___declare_args'
     461 | #define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:527:17: note: in expansion of macro '__declare_args'
     527 |                 __declare_args(__count_args(__VA_ARGS__), __VA_ARGS__); \
         |                 ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:558:25: note: in expansion of macro '__fail_smccc_1_1'
     558 |                         __fail_smccc_1_1(__VA_ARGS__);                  \
         |                         ^~~~~~~~~~~~~~~~
   drivers/firmware/arm_scmi/smc.c:250:17: note: in expansion of macro 'arm_smccc_1_1_invoke'
     250 |                 arm_smccc_1_1_invoke(scmi_info->func_id, p[0].x, p[1].x, p[2].x,
         |                 ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:448:29: error: register specified for 'arg5' isn't suitable for data type
     448 |         register typeof(a5) arg5 asm("r5") = __a5
         |                             ^~~~
   include/linux/arm-smccc.h:452:9: note: in expansion of macro '__declare_arg_5'
     452 |         __declare_arg_5(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:457:9: note: in expansion of macro '__declare_arg_6'
     457 |         __declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:460:37: note: in expansion of macro '__declare_arg_7'
     460 | #define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:461:37: note: in expansion of macro '___declare_args'
     461 | #define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
         |                                     ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:527:17: note: in expansion of macro '__declare_args'
     527 |                 __declare_args(__count_args(__VA_ARGS__), __VA_ARGS__); \
         |                 ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:558:25: note: in expansion of macro '__fail_smccc_1_1'
     558 |                         __fail_smccc_1_1(__VA_ARGS__);                  \
         |                         ^~~~~~~~~~~~~~~~
   drivers/firmware/arm_scmi/smc.c:250:17: note: in expansion of macro 'arm_smccc_1_1_invoke'
     250 |                 arm_smccc_1_1_invoke(scmi_info->func_id, p[0].x, p[1].x, p[2].x,
         |                 ^~~~~~~~~~~~~~~~~~~~


vim +436 include/linux/arm-smccc.h

f2d3b2e8759a58 Marc Zyngier 2018-02-06  411  
f2d3b2e8759a58 Marc Zyngier 2018-02-06  412  #define __declare_arg_0(a0, res)					\
f2d3b2e8759a58 Marc Zyngier 2018-02-06  413  	struct arm_smccc_res   *___res = res;				\
0794a974d74dc7 Andrew Scull 2020-09-15  414  	register unsigned long arg0 asm("r0") = (u32)a0
f2d3b2e8759a58 Marc Zyngier 2018-02-06  415  
f2d3b2e8759a58 Marc Zyngier 2018-02-06  416  #define __declare_arg_1(a0, a1, res)					\
755a8bf5579d22 Marc Zyngier 2018-08-24  417  	typeof(a1) __a1 = a1;						\
f2d3b2e8759a58 Marc Zyngier 2018-02-06  418  	struct arm_smccc_res   *___res = res;				\
0794a974d74dc7 Andrew Scull 2020-09-15  419  	register unsigned long arg0 asm("r0") = (u32)a0;			\
0794a974d74dc7 Andrew Scull 2020-09-15  420  	register typeof(a1) arg1 asm("r1") = __a1
f2d3b2e8759a58 Marc Zyngier 2018-02-06  421  
f2d3b2e8759a58 Marc Zyngier 2018-02-06  422  #define __declare_arg_2(a0, a1, a2, res)				\
755a8bf5579d22 Marc Zyngier 2018-08-24  423  	typeof(a1) __a1 = a1;						\
755a8bf5579d22 Marc Zyngier 2018-08-24  424  	typeof(a2) __a2 = a2;						\
f2d3b2e8759a58 Marc Zyngier 2018-02-06  425  	struct arm_smccc_res   *___res = res;				\
0794a974d74dc7 Andrew Scull 2020-09-15  426  	register unsigned long arg0 asm("r0") = (u32)a0;			\
0794a974d74dc7 Andrew Scull 2020-09-15  427  	register typeof(a1) arg1 asm("r1") = __a1;			\
0794a974d74dc7 Andrew Scull 2020-09-15  428  	register typeof(a2) arg2 asm("r2") = __a2
f2d3b2e8759a58 Marc Zyngier 2018-02-06  429  
f2d3b2e8759a58 Marc Zyngier 2018-02-06  430  #define __declare_arg_3(a0, a1, a2, a3, res)				\
755a8bf5579d22 Marc Zyngier 2018-08-24  431  	typeof(a1) __a1 = a1;						\
755a8bf5579d22 Marc Zyngier 2018-08-24  432  	typeof(a2) __a2 = a2;						\
755a8bf5579d22 Marc Zyngier 2018-08-24  433  	typeof(a3) __a3 = a3;						\
f2d3b2e8759a58 Marc Zyngier 2018-02-06  434  	struct arm_smccc_res   *___res = res;				\
0794a974d74dc7 Andrew Scull 2020-09-15  435  	register unsigned long arg0 asm("r0") = (u32)a0;			\
0794a974d74dc7 Andrew Scull 2020-09-15 @436  	register typeof(a1) arg1 asm("r1") = __a1;			\
0794a974d74dc7 Andrew Scull 2020-09-15  437  	register typeof(a2) arg2 asm("r2") = __a2;			\
0794a974d74dc7 Andrew Scull 2020-09-15 @438  	register typeof(a3) arg3 asm("r3") = __a3
f2d3b2e8759a58 Marc Zyngier 2018-02-06  439  
f2d3b2e8759a58 Marc Zyngier 2018-02-06  440  #define __declare_arg_4(a0, a1, a2, a3, a4, res)			\
755a8bf5579d22 Marc Zyngier 2018-08-24  441  	typeof(a4) __a4 = a4;						\
f2d3b2e8759a58 Marc Zyngier 2018-02-06  442  	__declare_arg_3(a0, a1, a2, a3, res);				\
0794a974d74dc7 Andrew Scull 2020-09-15  443  	register typeof(a4) arg4 asm("r4") = __a4
f2d3b2e8759a58 Marc Zyngier 2018-02-06  444  
f2d3b2e8759a58 Marc Zyngier 2018-02-06  445  #define __declare_arg_5(a0, a1, a2, a3, a4, a5, res)			\
755a8bf5579d22 Marc Zyngier 2018-08-24  446  	typeof(a5) __a5 = a5;						\
f2d3b2e8759a58 Marc Zyngier 2018-02-06  447  	__declare_arg_4(a0, a1, a2, a3, a4, res);			\
0794a974d74dc7 Andrew Scull 2020-09-15 @448  	register typeof(a5) arg5 asm("r5") = __a5
f2d3b2e8759a58 Marc Zyngier 2018-02-06  449  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
