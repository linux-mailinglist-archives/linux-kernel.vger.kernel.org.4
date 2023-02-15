Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3E669875C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjBOVaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBOVai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:30:38 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEEF2313C;
        Wed, 15 Feb 2023 13:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676496636; x=1708032636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ruaFmQvw0ZYZOgXQykasAiwomUvuehEVW/GogxRD7bA=;
  b=MX1TOmxpcLjBikCUWUybXzUGx1SnU8AmG/Oxld0XVt7vKaDG9oyD1X3P
   U6hNimqx/38hMFJl41KJyo0iclSdECewQE+QuyQxnXuFvJQNdu+MWOiRK
   gAb/HeJBThUmTUualQfYbVReL0G/QaIGtkPTkMEF7LI5zkx8rk2eMyiwT
   dmtXQuWxXTbkGshw+3c0q3dt32mJUUi0cqsEBtxqOtEQpfPzhykK/9gwf
   eEdSTpTYU8IDs94PBs7iZ6Mfcuv+jH5tRNngzE+TBKNGtNp5FxrqHCC3d
   h3r1jTic5nuJ03U6rR5G1B1IYmhRyabpGCRUXYnPdd/JeFwfvarBXk+Md
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="329270543"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="329270543"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 13:30:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="915392945"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="915392945"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 Feb 2023 13:30:06 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSPLp-0009oF-2t;
        Wed, 15 Feb 2023 21:30:05 +0000
Date:   Thu, 16 Feb 2023 05:29:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Andreas Gruenbacher <agruen@linbit.com>,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 3/7] drbd: INFO_bm_xfer_stats(): Pass a peer device
 argument
Message-ID: <202302160521.CQ9teCgI-lkp@intel.com>
References: <20230215163204.2856631-4-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215163204.2856631-4-christoph.boehmwalder@linbit.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I love your patch! Perhaps something to improve:

[auto build test WARNING on a06377c5d01eeeaa52ad979b62c3c72efcc3eff0]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/drbd-Rip-out-the-ERR_IF_CNT_IS_NEGATIVE-macro/20230216-003454
base:   a06377c5d01eeeaa52ad979b62c3c72efcc3eff0
patch link:    https://lore.kernel.org/r/20230215163204.2856631-4-christoph.boehmwalder%40linbit.com
patch subject: [PATCH 3/7] drbd: INFO_bm_xfer_stats(): Pass a peer device argument
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230216/202302160521.CQ9teCgI-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5c0303cbd7f9f393f07ff9b8738a25cb1883e947
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christoph-B-hmwalder/drbd-Rip-out-the-ERR_IF_CNT_IS_NEGATIVE-macro/20230216-003454
        git checkout 5c0303cbd7f9f393f07ff9b8738a25cb1883e947
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/block/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302160521.CQ9teCgI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/block/drbd/drbd_bitmap.c:22:
>> drivers/block/drbd/drbd_int.h:129:39: warning: 'struct drbd_peer_device' declared inside parameter list will not be visible outside of this definition or declaration
     129 | extern void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
         |                                       ^~~~~~~~~~~~~~~~
--
   In file included from drivers/block/drbd/drbd_receiver.c:37:
>> drivers/block/drbd/drbd_int.h:129:39: warning: 'struct drbd_peer_device' declared inside parameter list will not be visible outside of this definition or declaration
     129 | extern void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
         |                                       ^~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_receiver.c: In function 'drbd_sync_handshake':
   drivers/block/drbd/drbd_receiver.c:3593:21: error: too many arguments to function 'drbd_bitmap_io'
    3593 |                 if (drbd_bitmap_io(device, &drbd_bmio_set_n_write, "set_n_write from sync_handshake",
         |                     ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: declared here
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_receiver.c: In function 'receive_uuids':
   drivers/block/drbd/drbd_receiver.c:4271:25: error: too many arguments to function 'drbd_bitmap_io'
    4271 |                         drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
         |                         ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: declared here
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_receiver.c: At top level:
   drivers/block/drbd/drbd_receiver.c:4769:6: error: conflicting types for 'INFO_bm_xfer_stats'; have 'void(struct drbd_peer_device *, const char *, struct bm_xfer_ctx *)'
    4769 | void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
         |      ^~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:129:13: note: previous declaration of 'INFO_bm_xfer_stats' with type 'void(struct drbd_peer_device *, const char *, struct bm_xfer_ctx *)'
     129 | extern void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
         |             ^~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_receiver.c: In function 'receive_bitmap':
   drivers/block/drbd/drbd_receiver.c:4880:23: error: too few arguments to function 'drbd_send_bitmap'
    4880 |                 err = drbd_send_bitmap(device);
         |                       ^~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1045:12: note: declared here
    1045 | extern int drbd_send_bitmap(struct drbd_device *device, struct drbd_peer_device *peer_device);
         |            ^~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_receiver.c: In function 'drbd_disconnected':
   drivers/block/drbd/drbd_receiver.c:5216:40: error: passing argument 2 of 'drbd_bitmap_io' from incompatible pointer type [-Werror=incompatible-pointer-types]
    5216 |                 drbd_bitmap_io(device, &drbd_bm_write_copy_pages,
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                        |
         |                                        int (*)(struct drbd_device *)
   drivers/block/drbd/drbd_int.h:1073:23: note: expected 'int (*)(struct drbd_device *, struct drbd_peer_device *)' but argument is of type 'int (*)(struct drbd_device *)'
    1073 |                 int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
         |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_receiver.c:5216:17: error: too many arguments to function 'drbd_bitmap_io'
    5216 |                 drbd_bitmap_io(device, &drbd_bm_write_copy_pages,
         |                 ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: declared here
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/block/drbd/drbd_main.c:46:
>> drivers/block/drbd/drbd_int.h:129:39: warning: 'struct drbd_peer_device' declared inside parameter list will not be visible outside of this definition or declaration
     129 | extern void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
         |                                       ^~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_main.c: In function 'send_bitmap_rle_or_plain':
   drivers/block/drbd/drbd_main.c:1203:29: error: 'device' redeclared as different kind of symbol
    1203 |         struct drbd_device *device = peer_device->device;
         |                             ^~~~~~
   drivers/block/drbd/drbd_main.c:1201:51: note: previous definition of 'device' with type 'struct drbd_peer_device *'
    1201 | send_bitmap_rle_or_plain(struct drbd_peer_device *device, struct bm_xfer_ctx *c)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   drivers/block/drbd/drbd_main.c:1203:38: error: 'peer_device' undeclared (first use in this function); did you mean 'phy_device'?
    1203 |         struct drbd_device *device = peer_device->device;
         |                                      ^~~~~~~~~~~
         |                                      phy_device
   drivers/block/drbd/drbd_main.c:1203:38: note: each undeclared identifier is reported only once for each function it appears in
   drivers/block/drbd/drbd_main.c: In function '_drbd_send_bitmap':
   drivers/block/drbd/drbd_main.c:1272:29: error: too few arguments to function 'drbd_bm_write'
    1272 |                         if (drbd_bm_write(device)) {
         |                             ^~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1293:13: note: declared here
    1293 | extern int  drbd_bm_write(struct drbd_device *device,
         |             ^~~~~~~~~~~~~
   drivers/block/drbd/drbd_main.c: At top level:
   drivers/block/drbd/drbd_main.c:3497:6: error: conflicting types for 'drbd_queue_bitmap_io'; have 'void(struct drbd_device *, int (*)(struct drbd_device *, struct drbd_peer_device *), void (*)(struct drbd_device *, int), char *, enum bm_flag,  struct drbd_peer_device *)'
    3497 | void drbd_queue_bitmap_io(struct drbd_device *device,
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1068:13: note: previous declaration of 'drbd_queue_bitmap_io' with type 'void(struct drbd_device *, int (*)(struct drbd_device *, struct drbd_peer_device *), void (*)(struct drbd_device *, int), char *, enum bm_flag)'
    1068 | extern void drbd_queue_bitmap_io(struct drbd_device *device,
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_main.c:3540:5: error: conflicting types for 'drbd_bitmap_io'; have 'int(struct drbd_device *, int (*)(struct drbd_device *, struct drbd_peer_device *), char *, enum bm_flag,  struct drbd_peer_device *)'
    3540 | int drbd_bitmap_io(struct drbd_device *device,
         |     ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: previous declaration of 'drbd_bitmap_io' with type 'int(struct drbd_device *, int (*)(struct drbd_device *, struct drbd_peer_device *), char *, enum bm_flag)'
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
--
   In file included from drivers/block/drbd/drbd_nl.c:24:
>> drivers/block/drbd/drbd_int.h:129:39: warning: 'struct drbd_peer_device' declared inside parameter list will not be visible outside of this definition or declaration
     129 | extern void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
         |                                       ^~~~~~~~~~~~~~~~
   In file included from include/linux/drbd_genl_api.h:54,
                    from drivers/block/drbd/drbd_int.h:35:
   include/linux/drbd_genl_api.h:51:33: warning: no previous prototype for 'drbd_genl_cmd_to_str' [-Wmissing-prototypes]
      51 | #define GENL_MAGIC_FAMILY       drbd
         |                                 ^~~~
   include/linux/genl_magic_struct.h:20:25: note: in definition of macro 'CONCAT__'
      20 | #define CONCAT__(a,b)   a ## b
         |                         ^
   include/linux/genl_magic_func.h:212:13: note: in expansion of macro 'CONCAT_'
     212 | const char *CONCAT_(GENL_MAGIC_FAMILY, _genl_cmd_to_str)(__u8 cmd)
         |             ^~~~~~~
   include/linux/genl_magic_func.h:212:21: note: in expansion of macro 'GENL_MAGIC_FAMILY'
     212 | const char *CONCAT_(GENL_MAGIC_FAMILY, _genl_cmd_to_str)(__u8 cmd)
         |                     ^~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c: In function 'drbd_determine_dev_size':
   drivers/block/drbd/drbd_nl.c:1055:70: warning: pointer type mismatch in conditional expression
    1055 |                 drbd_bitmap_io(device, md_moved ? &drbd_bm_write_all : &drbd_bm_write,
         |                                                                      ^
   drivers/block/drbd/drbd_nl.c:1055:17: error: too many arguments to function 'drbd_bitmap_io'
    1055 |                 drbd_bitmap_io(device, md_moved ? &drbd_bm_write_all : &drbd_bm_write,
         |                 ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: declared here
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_attach':
   drivers/block/drbd/drbd_nl.c:2029:21: error: too many arguments to function 'drbd_bitmap_io'
    2029 |                 if (drbd_bitmap_io(device, &drbd_bmio_set_n_write,
         |                     ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: declared here
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c:2036:21: error: too many arguments to function 'drbd_bitmap_io'
    2036 |                 if (drbd_bitmap_io(device, &drbd_bm_read,
         |                     ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: declared here
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_invalidate':
   drivers/block/drbd/drbd_nl.c:2976:29: error: too many arguments to function 'drbd_bitmap_io'
    2976 |                         if (drbd_bitmap_io(device, &drbd_bmio_set_n_write,
         |                             ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: declared here
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c: In function 'drbd_bmio_set_susp_al':
   drivers/block/drbd/drbd_nl.c:3014:14: error: too few arguments to function 'drbd_bmio_set_n_write'
    3014 |         rv = drbd_bmio_set_n_write(device);
         |              ^~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1078:12: note: declared here
    1078 | extern int drbd_bmio_set_n_write(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_invalidate_peer':
   drivers/block/drbd/drbd_nl.c:3055:52: error: passing argument 2 of 'drbd_bitmap_io' from incompatible pointer type [-Werror=incompatible-pointer-types]
    3055 |                         if (drbd_bitmap_io(device, &drbd_bmio_set_susp_al,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~
         |                                                    |
         |                                                    int (*)(struct drbd_device *)
   drivers/block/drbd/drbd_int.h:1073:23: note: expected 'int (*)(struct drbd_device *, struct drbd_peer_device *)' but argument is of type 'int (*)(struct drbd_device *)'
    1073 |                 int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
         |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c:3055:29: error: too many arguments to function 'drbd_bitmap_io'
    3055 |                         if (drbd_bitmap_io(device, &drbd_bmio_set_susp_al,
         |                             ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: declared here
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_new_c_uuid':
   drivers/block/drbd/drbd_nl.c:4152:23: error: too many arguments to function 'drbd_bitmap_io'
    4152 |                 err = drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
         |                       ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: declared here
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/block/drbd/drbd_state.c:17:
>> drivers/block/drbd/drbd_int.h:129:39: warning: 'struct drbd_peer_device' declared inside parameter list will not be visible outside of this definition or declaration
     129 | extern void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
         |                                       ^~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_state.c:1520:5: error: conflicting types for 'drbd_bitmap_io_from_worker'; have 'int(struct drbd_device *, int (*)(struct drbd_device *, struct drbd_peer_device *), char *, enum bm_flag,  struct drbd_peer_device *)'
    1520 | int drbd_bitmap_io_from_worker(struct drbd_device *device,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1075:12: note: previous declaration of 'drbd_bitmap_io_from_worker' with type 'int(struct drbd_device *, int (*)(struct drbd_device *, struct drbd_peer_device *), char *, enum bm_flag)'
    1075 | extern int drbd_bitmap_io_from_worker(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_state.c: In function 'after_state_ch':
   drivers/block/drbd/drbd_state.c:1842:25: error: too few arguments to function 'drbd_bitmap_io_from_worker'
    1842 |                         drbd_bitmap_io_from_worker(device, &drbd_bm_write,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_state.c:1520:5: note: declared here
    1520 | int drbd_bitmap_io_from_worker(struct drbd_device *device,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_state.c:1854:17: error: too few arguments to function 'drbd_bitmap_io_from_worker'
    1854 |                 drbd_bitmap_io_from_worker(device, &drbd_bm_write,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_state.c:1520:5: note: declared here
    1520 | int drbd_bitmap_io_from_worker(struct drbd_device *device,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_state.c:2014:46: error: passing argument 2 of 'drbd_queue_bitmap_io' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2014 |                 drbd_queue_bitmap_io(device, &drbd_bm_write_copy_pages, NULL,
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                              |
         |                                              int (*)(struct drbd_device *)
   drivers/block/drbd/drbd_int.h:1069:40: note: expected 'int (*)(struct drbd_device *, struct drbd_peer_device *)' but argument is of type 'int (*)(struct drbd_device *)'
    1069 |                                  int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
         |                                  ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +129 drivers/block/drbd/drbd_int.h

   128	
 > 129	extern void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
   130				       const char *direction, struct bm_xfer_ctx *c);
   131	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
