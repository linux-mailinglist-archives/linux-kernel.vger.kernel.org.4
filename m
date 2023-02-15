Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29E96985B7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBOUjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBOUjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:39:16 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C068F1;
        Wed, 15 Feb 2023 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676493553; x=1708029553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dKk5YIYfLfZwhe2c6BAgxkOXzw6JptB/O7GNtet6fz4=;
  b=C/rhzBrMbBJ5KzizRE7hog7vsceM5E3Pcrvnf55eN8m6cgrl7Yjf3bsX
   clgU9N52qT8QRDEryKe1KTH3OiFgw583xjjm2xpTwtHXBxhzBc40K7L4p
   Eqf3FI5bNCEnMyQ8Ea30qdEFQwlFcABaiI245epHgMlsLMZFcWX01AW46
   bN269eoGHKI/CsKA0W5GU6za+9XwZxJ9sUqKhige4XKqWr9WG6OpmvkGr
   8Ee73L59Mb40l57XSP+H9+jyeDTamXbB3e4Hxjyp8RoEnvtPVOzDwfU3u
   kOArBurqGH3pGSedxn2e6oN7r3WdTqfP47FyTDp1tXpXl62VjWkuPUb0g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="358964677"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="358964677"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 12:39:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="812672832"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="812672832"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2023 12:39:05 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSOYS-0009m9-0r;
        Wed, 15 Feb 2023 20:39:04 +0000
Date:   Thu, 16 Feb 2023 04:38:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Andreas Gruenbacher <agruen@kernel.org>,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 2/7] drbd: Add peer device parameter to whole-bitmap I/O
 handlers
Message-ID: <202302160440.lpWjbVR5-lkp@intel.com>
References: <20230215163204.2856631-3-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215163204.2856631-3-christoph.boehmwalder@linbit.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I love your patch! Yet something to improve:

[auto build test ERROR on a06377c5d01eeeaa52ad979b62c3c72efcc3eff0]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/drbd-Rip-out-the-ERR_IF_CNT_IS_NEGATIVE-macro/20230216-003454
base:   a06377c5d01eeeaa52ad979b62c3c72efcc3eff0
patch link:    https://lore.kernel.org/r/20230215163204.2856631-3-christoph.boehmwalder%40linbit.com
patch subject: [PATCH 2/7] drbd: Add peer device parameter to whole-bitmap I/O handlers
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230216/202302160440.lpWjbVR5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e55221e8a69f80303803dab7e079bff7b698ea02
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christoph-B-hmwalder/drbd-Rip-out-the-ERR_IF_CNT_IS_NEGATIVE-macro/20230216-003454
        git checkout e55221e8a69f80303803dab7e079bff7b698ea02
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302160440.lpWjbVR5-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/block/drbd/drbd_receiver.c: In function 'drbd_sync_handshake':
>> drivers/block/drbd/drbd_receiver.c:3593:21: error: too many arguments to function 'drbd_bitmap_io'
    3593 |                 if (drbd_bitmap_io(device, &drbd_bmio_set_n_write, "set_n_write from sync_handshake",
         |                     ^~~~~~~~~~~~~~
   In file included from drivers/block/drbd/drbd_receiver.c:37:
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
   drivers/block/drbd/drbd_receiver.c: In function 'receive_bitmap':
>> drivers/block/drbd/drbd_receiver.c:4880:23: error: too few arguments to function 'drbd_send_bitmap'
    4880 |                 err = drbd_send_bitmap(device);
         |                       ^~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1045:12: note: declared here
    1045 | extern int drbd_send_bitmap(struct drbd_device *device, struct drbd_peer_device *peer_device);
         |            ^~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_receiver.c: In function 'drbd_disconnected':
>> drivers/block/drbd/drbd_receiver.c:5216:40: error: passing argument 2 of 'drbd_bitmap_io' from incompatible pointer type [-Werror=incompatible-pointer-types]
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
   drivers/block/drbd/drbd_main.c: In function 'send_bitmap_rle_or_plain':
>> drivers/block/drbd/drbd_main.c:1203:29: error: 'device' redeclared as different kind of symbol
    1203 |         struct drbd_device *device = peer_device->device;
         |                             ^~~~~~
   drivers/block/drbd/drbd_main.c:1201:51: note: previous definition of 'device' with type 'struct drbd_peer_device *'
    1201 | send_bitmap_rle_or_plain(struct drbd_peer_device *device, struct bm_xfer_ctx *c)
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
>> drivers/block/drbd/drbd_main.c:1203:38: error: 'peer_device' undeclared (first use in this function); did you mean 'phy_device'?
    1203 |         struct drbd_device *device = peer_device->device;
         |                                      ^~~~~~~~~~~
         |                                      phy_device
   drivers/block/drbd/drbd_main.c:1203:38: note: each undeclared identifier is reported only once for each function it appears in
   drivers/block/drbd/drbd_main.c: In function '_drbd_send_bitmap':
>> drivers/block/drbd/drbd_main.c:1272:29: error: too few arguments to function 'drbd_bm_write'
    1272 |                         if (drbd_bm_write(device)) {
         |                             ^~~~~~~~~~~~~
   In file included from drivers/block/drbd/drbd_main.c:46:
   drivers/block/drbd/drbd_int.h:1293:13: note: declared here
    1293 | extern int  drbd_bm_write(struct drbd_device *device,
         |             ^~~~~~~~~~~~~
   drivers/block/drbd/drbd_main.c: At top level:
>> drivers/block/drbd/drbd_main.c:3497:6: error: conflicting types for 'drbd_queue_bitmap_io'; have 'void(struct drbd_device *, int (*)(struct drbd_device *, struct drbd_peer_device *), void (*)(struct drbd_device *, int), char *, enum bm_flag,  struct drbd_peer_device *)'
    3497 | void drbd_queue_bitmap_io(struct drbd_device *device,
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1068:13: note: previous declaration of 'drbd_queue_bitmap_io' with type 'void(struct drbd_device *, int (*)(struct drbd_device *, struct drbd_peer_device *), void (*)(struct drbd_device *, int), char *, enum bm_flag)'
    1068 | extern void drbd_queue_bitmap_io(struct drbd_device *device,
         |             ^~~~~~~~~~~~~~~~~~~~
>> drivers/block/drbd/drbd_main.c:3540:5: error: conflicting types for 'drbd_bitmap_io'; have 'int(struct drbd_device *, int (*)(struct drbd_device *, struct drbd_peer_device *), char *, enum bm_flag,  struct drbd_peer_device *)'
    3540 | int drbd_bitmap_io(struct drbd_device *device,
         |     ^~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1072:12: note: previous declaration of 'drbd_bitmap_io' with type 'int(struct drbd_device *, int (*)(struct drbd_device *, struct drbd_peer_device *), char *, enum bm_flag)'
    1072 | extern int drbd_bitmap_io(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~
--
   In file included from include/linux/drbd_genl_api.h:54,
                    from drivers/block/drbd/drbd_int.h:35,
                    from drivers/block/drbd/drbd_nl.c:24:
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
>> drivers/block/drbd/drbd_nl.c:1055:17: error: too many arguments to function 'drbd_bitmap_io'
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
>> drivers/block/drbd/drbd_nl.c:3014:14: error: too few arguments to function 'drbd_bmio_set_n_write'
    3014 |         rv = drbd_bmio_set_n_write(device);
         |              ^~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_int.h:1078:12: note: declared here
    1078 | extern int drbd_bmio_set_n_write(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_invalidate_peer':
>> drivers/block/drbd/drbd_nl.c:3055:52: error: passing argument 2 of 'drbd_bitmap_io' from incompatible pointer type [-Werror=incompatible-pointer-types]
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
>> drivers/block/drbd/drbd_state.c:1520:5: error: conflicting types for 'drbd_bitmap_io_from_worker'; have 'int(struct drbd_device *, int (*)(struct drbd_device *, struct drbd_peer_device *), char *, enum bm_flag,  struct drbd_peer_device *)'
    1520 | int drbd_bitmap_io_from_worker(struct drbd_device *device,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/block/drbd/drbd_state.c:17:
   drivers/block/drbd/drbd_int.h:1075:12: note: previous declaration of 'drbd_bitmap_io_from_worker' with type 'int(struct drbd_device *, int (*)(struct drbd_device *, struct drbd_peer_device *), char *, enum bm_flag)'
    1075 | extern int drbd_bitmap_io_from_worker(struct drbd_device *device,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_state.c: In function 'after_state_ch':
>> drivers/block/drbd/drbd_state.c:1842:25: error: too few arguments to function 'drbd_bitmap_io_from_worker'
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
>> drivers/block/drbd/drbd_state.c:2014:46: error: passing argument 2 of 'drbd_queue_bitmap_io' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2014 |                 drbd_queue_bitmap_io(device, &drbd_bm_write_copy_pages, NULL,
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                              |
         |                                              int (*)(struct drbd_device *)
   drivers/block/drbd/drbd_int.h:1069:40: note: expected 'int (*)(struct drbd_device *, struct drbd_peer_device *)' but argument is of type 'int (*)(struct drbd_device *)'
    1069 |                                  int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
         |                                  ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/drbd_bitmap_io +3593 drivers/block/drbd/drbd_receiver.c

b411b3637fa71f Philipp Reisner     2009-09-25  3443  
b411b3637fa71f Philipp Reisner     2009-09-25  3444  /* drbd_sync_handshake() returns the new conn state on success, or
b411b3637fa71f Philipp Reisner     2009-09-25  3445     CONN_MASK (-1) on failure.
b411b3637fa71f Philipp Reisner     2009-09-25  3446   */
69a227731a378f Andreas Gruenbacher 2011-08-09  3447  static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
69a227731a378f Andreas Gruenbacher 2011-08-09  3448  					   enum drbd_role peer_role,
b411b3637fa71f Philipp Reisner     2009-09-25  3449  					   enum drbd_disk_state peer_disk) __must_hold(local)
b411b3637fa71f Philipp Reisner     2009-09-25  3450  {
69a227731a378f Andreas Gruenbacher 2011-08-09  3451  	struct drbd_device *device = peer_device->device;
b411b3637fa71f Philipp Reisner     2009-09-25  3452  	enum drbd_conns rv = C_MASK;
b411b3637fa71f Philipp Reisner     2009-09-25  3453  	enum drbd_disk_state mydisk;
44ed167da74825 Philipp Reisner     2011-04-19  3454  	struct net_conf *nc;
d29e89e34952a9 Roland Kammerer     2018-12-20  3455  	int hg, rule_nr, rr_conflict, tentative, always_asbp;
b411b3637fa71f Philipp Reisner     2009-09-25  3456  
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3457  	mydisk = device->state.disk;
b411b3637fa71f Philipp Reisner     2009-09-25  3458  	if (mydisk == D_NEGOTIATING)
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3459  		mydisk = device->new_state_tmp.disk;
b411b3637fa71f Philipp Reisner     2009-09-25  3460  
d01801710265cf Andreas Gruenbacher 2011-07-03  3461  	drbd_info(device, "drbd_sync_handshake:\n");
9f2247bb9b75b2 Philipp Reisner     2012-08-16  3462  
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3463  	spin_lock_irq(&device->ldev->md.uuid_lock);
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3464  	drbd_uuid_dump(device, "self", device->ldev->md.uuid, device->comm_bm_set, 0);
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3465  	drbd_uuid_dump(device, "peer", device->p_uuid,
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3466  		       device->p_uuid[UI_SIZE], device->p_uuid[UI_FLAGS]);
b411b3637fa71f Philipp Reisner     2009-09-25  3467  
f2d3d75b66fc80 Lars Ellenberg      2016-06-14  3468  	hg = drbd_uuid_compare(device, peer_role, &rule_nr);
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3469  	spin_unlock_irq(&device->ldev->md.uuid_lock);
b411b3637fa71f Philipp Reisner     2009-09-25  3470  
d01801710265cf Andreas Gruenbacher 2011-07-03  3471  	drbd_info(device, "uuid_compare()=%d by rule %d\n", hg, rule_nr);
b411b3637fa71f Philipp Reisner     2009-09-25  3472  
b411b3637fa71f Philipp Reisner     2009-09-25  3473  	if (hg == -1000) {
d01801710265cf Andreas Gruenbacher 2011-07-03  3474  		drbd_alert(device, "Unrelated data, aborting!\n");
b411b3637fa71f Philipp Reisner     2009-09-25  3475  		return C_MASK;
b411b3637fa71f Philipp Reisner     2009-09-25  3476  	}
f2d3d75b66fc80 Lars Ellenberg      2016-06-14  3477  	if (hg < -0x10000) {
f2d3d75b66fc80 Lars Ellenberg      2016-06-14  3478  		int proto, fflags;
f2d3d75b66fc80 Lars Ellenberg      2016-06-14  3479  		hg = -hg;
f2d3d75b66fc80 Lars Ellenberg      2016-06-14  3480  		proto = hg & 0xff;
f2d3d75b66fc80 Lars Ellenberg      2016-06-14  3481  		fflags = (hg >> 8) & 0xff;
f2d3d75b66fc80 Lars Ellenberg      2016-06-14  3482  		drbd_alert(device, "To resolve this both sides have to support at least protocol %d and feature flags 0x%x\n",
f2d3d75b66fc80 Lars Ellenberg      2016-06-14  3483  					proto, fflags);
f2d3d75b66fc80 Lars Ellenberg      2016-06-14  3484  		return C_MASK;
f2d3d75b66fc80 Lars Ellenberg      2016-06-14  3485  	}
4a23f264969827 Philipp Reisner     2011-01-11  3486  	if (hg < -1000) {
d01801710265cf Andreas Gruenbacher 2011-07-03  3487  		drbd_alert(device, "To resolve this both sides have to support at least protocol %d\n", -hg - 1000);
b411b3637fa71f Philipp Reisner     2009-09-25  3488  		return C_MASK;
b411b3637fa71f Philipp Reisner     2009-09-25  3489  	}
b411b3637fa71f Philipp Reisner     2009-09-25  3490  
b411b3637fa71f Philipp Reisner     2009-09-25  3491  	if    ((mydisk == D_INCONSISTENT && peer_disk > D_INCONSISTENT) ||
b411b3637fa71f Philipp Reisner     2009-09-25  3492  	    (peer_disk == D_INCONSISTENT && mydisk    > D_INCONSISTENT)) {
b411b3637fa71f Philipp Reisner     2009-09-25  3493  		int f = (hg == -100) || abs(hg) == 2;
b411b3637fa71f Philipp Reisner     2009-09-25  3494  		hg = mydisk > D_INCONSISTENT ? 1 : -1;
b411b3637fa71f Philipp Reisner     2009-09-25  3495  		if (f)
b411b3637fa71f Philipp Reisner     2009-09-25  3496  			hg = hg*2;
d01801710265cf Andreas Gruenbacher 2011-07-03  3497  		drbd_info(device, "Becoming sync %s due to disk states.\n",
b411b3637fa71f Philipp Reisner     2009-09-25  3498  		     hg > 0 ? "source" : "target");
b411b3637fa71f Philipp Reisner     2009-09-25  3499  	}
b411b3637fa71f Philipp Reisner     2009-09-25  3500  
3a11a4878939e0 Adam Gandelman      2010-04-08  3501  	if (abs(hg) == 100)
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3502  		drbd_khelper(device, "initial-split-brain");
3a11a4878939e0 Adam Gandelman      2010-04-08  3503  
44ed167da74825 Philipp Reisner     2011-04-19  3504  	rcu_read_lock();
69a227731a378f Andreas Gruenbacher 2011-08-09  3505  	nc = rcu_dereference(peer_device->connection->net_conf);
d29e89e34952a9 Roland Kammerer     2018-12-20  3506  	always_asbp = nc->always_asbp;
d29e89e34952a9 Roland Kammerer     2018-12-20  3507  	rr_conflict = nc->rr_conflict;
d29e89e34952a9 Roland Kammerer     2018-12-20  3508  	tentative = nc->tentative;
d29e89e34952a9 Roland Kammerer     2018-12-20  3509  	rcu_read_unlock();
44ed167da74825 Philipp Reisner     2011-04-19  3510  
d29e89e34952a9 Roland Kammerer     2018-12-20  3511  	if (hg == 100 || (hg == -100 && always_asbp)) {
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3512  		int pcount = (device->state.role == R_PRIMARY)
b411b3637fa71f Philipp Reisner     2009-09-25  3513  			   + (peer_role == R_PRIMARY);
b411b3637fa71f Philipp Reisner     2009-09-25  3514  		int forced = (hg == -100);
b411b3637fa71f Philipp Reisner     2009-09-25  3515  
b411b3637fa71f Philipp Reisner     2009-09-25  3516  		switch (pcount) {
b411b3637fa71f Philipp Reisner     2009-09-25  3517  		case 0:
69a227731a378f Andreas Gruenbacher 2011-08-09  3518  			hg = drbd_asb_recover_0p(peer_device);
b411b3637fa71f Philipp Reisner     2009-09-25  3519  			break;
b411b3637fa71f Philipp Reisner     2009-09-25  3520  		case 1:
69a227731a378f Andreas Gruenbacher 2011-08-09  3521  			hg = drbd_asb_recover_1p(peer_device);
b411b3637fa71f Philipp Reisner     2009-09-25  3522  			break;
b411b3637fa71f Philipp Reisner     2009-09-25  3523  		case 2:
69a227731a378f Andreas Gruenbacher 2011-08-09  3524  			hg = drbd_asb_recover_2p(peer_device);
b411b3637fa71f Philipp Reisner     2009-09-25  3525  			break;
b411b3637fa71f Philipp Reisner     2009-09-25  3526  		}
b411b3637fa71f Philipp Reisner     2009-09-25  3527  		if (abs(hg) < 100) {
d01801710265cf Andreas Gruenbacher 2011-07-03  3528  			drbd_warn(device, "Split-Brain detected, %d primaries, "
b411b3637fa71f Philipp Reisner     2009-09-25  3529  			     "automatically solved. Sync from %s node\n",
b411b3637fa71f Philipp Reisner     2009-09-25  3530  			     pcount, (hg < 0) ? "peer" : "this");
b411b3637fa71f Philipp Reisner     2009-09-25  3531  			if (forced) {
d01801710265cf Andreas Gruenbacher 2011-07-03  3532  				drbd_warn(device, "Doing a full sync, since"
b411b3637fa71f Philipp Reisner     2009-09-25  3533  				     " UUIDs where ambiguous.\n");
b411b3637fa71f Philipp Reisner     2009-09-25  3534  				hg = hg*2;
b411b3637fa71f Philipp Reisner     2009-09-25  3535  			}
b411b3637fa71f Philipp Reisner     2009-09-25  3536  		}
b411b3637fa71f Philipp Reisner     2009-09-25  3537  	}
b411b3637fa71f Philipp Reisner     2009-09-25  3538  
b411b3637fa71f Philipp Reisner     2009-09-25  3539  	if (hg == -100) {
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3540  		if (test_bit(DISCARD_MY_DATA, &device->flags) && !(device->p_uuid[UI_FLAGS]&1))
b411b3637fa71f Philipp Reisner     2009-09-25  3541  			hg = -1;
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3542  		if (!test_bit(DISCARD_MY_DATA, &device->flags) && (device->p_uuid[UI_FLAGS]&1))
b411b3637fa71f Philipp Reisner     2009-09-25  3543  			hg = 1;
b411b3637fa71f Philipp Reisner     2009-09-25  3544  
b411b3637fa71f Philipp Reisner     2009-09-25  3545  		if (abs(hg) < 100)
d01801710265cf Andreas Gruenbacher 2011-07-03  3546  			drbd_warn(device, "Split-Brain detected, manually solved. "
b411b3637fa71f Philipp Reisner     2009-09-25  3547  			     "Sync from %s node\n",
b411b3637fa71f Philipp Reisner     2009-09-25  3548  			     (hg < 0) ? "peer" : "this");
b411b3637fa71f Philipp Reisner     2009-09-25  3549  	}
b411b3637fa71f Philipp Reisner     2009-09-25  3550  
b411b3637fa71f Philipp Reisner     2009-09-25  3551  	if (hg == -100) {
580b9767dbdf2c Lars Ellenberg      2010-02-26  3552  		/* FIXME this log message is not correct if we end up here
580b9767dbdf2c Lars Ellenberg      2010-02-26  3553  		 * after an attempted attach on a diskless node.
580b9767dbdf2c Lars Ellenberg      2010-02-26  3554  		 * We just refuse to attach -- well, we drop the "connection"
580b9767dbdf2c Lars Ellenberg      2010-02-26  3555  		 * to that disk, in a way... */
d01801710265cf Andreas Gruenbacher 2011-07-03  3556  		drbd_alert(device, "Split-Brain detected but unresolved, dropping connection!\n");
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3557  		drbd_khelper(device, "split-brain");
b411b3637fa71f Philipp Reisner     2009-09-25  3558  		return C_MASK;
b411b3637fa71f Philipp Reisner     2009-09-25  3559  	}
b411b3637fa71f Philipp Reisner     2009-09-25  3560  
b411b3637fa71f Philipp Reisner     2009-09-25  3561  	if (hg > 0 && mydisk <= D_INCONSISTENT) {
d01801710265cf Andreas Gruenbacher 2011-07-03  3562  		drbd_err(device, "I shall become SyncSource, but I am inconsistent!\n");
b411b3637fa71f Philipp Reisner     2009-09-25  3563  		return C_MASK;
b411b3637fa71f Philipp Reisner     2009-09-25  3564  	}
b411b3637fa71f Philipp Reisner     2009-09-25  3565  
b411b3637fa71f Philipp Reisner     2009-09-25  3566  	if (hg < 0 && /* by intention we do not use mydisk here. */
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3567  	    device->state.role == R_PRIMARY && device->state.disk >= D_CONSISTENT) {
44ed167da74825 Philipp Reisner     2011-04-19  3568  		switch (rr_conflict) {
b411b3637fa71f Philipp Reisner     2009-09-25  3569  		case ASB_CALL_HELPER:
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3570  			drbd_khelper(device, "pri-lost");
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  3571  			fallthrough;
b411b3637fa71f Philipp Reisner     2009-09-25  3572  		case ASB_DISCONNECT:
d01801710265cf Andreas Gruenbacher 2011-07-03  3573  			drbd_err(device, "I shall become SyncTarget, but I am primary!\n");
b411b3637fa71f Philipp Reisner     2009-09-25  3574  			return C_MASK;
b411b3637fa71f Philipp Reisner     2009-09-25  3575  		case ASB_VIOLENTLY:
d01801710265cf Andreas Gruenbacher 2011-07-03  3576  			drbd_warn(device, "Becoming SyncTarget, violating the stable-data"
b411b3637fa71f Philipp Reisner     2009-09-25  3577  			     "assumption\n");
b411b3637fa71f Philipp Reisner     2009-09-25  3578  		}
b411b3637fa71f Philipp Reisner     2009-09-25  3579  	}
b411b3637fa71f Philipp Reisner     2009-09-25  3580  
69a227731a378f Andreas Gruenbacher 2011-08-09  3581  	if (tentative || test_bit(CONN_DRY_RUN, &peer_device->connection->flags)) {
cf14c2e987ba0a Philipp Reisner     2010-02-02  3582  		if (hg == 0)
d01801710265cf Andreas Gruenbacher 2011-07-03  3583  			drbd_info(device, "dry-run connect: No resync, would become Connected immediately.\n");
cf14c2e987ba0a Philipp Reisner     2010-02-02  3584  		else
d01801710265cf Andreas Gruenbacher 2011-07-03  3585  			drbd_info(device, "dry-run connect: Would become %s, doing a %s resync.",
cf14c2e987ba0a Philipp Reisner     2010-02-02  3586  				 drbd_conn_str(hg > 0 ? C_SYNC_SOURCE : C_SYNC_TARGET),
cf14c2e987ba0a Philipp Reisner     2010-02-02  3587  				 abs(hg) >= 2 ? "full" : "bit-map based");
cf14c2e987ba0a Philipp Reisner     2010-02-02  3588  		return C_MASK;
cf14c2e987ba0a Philipp Reisner     2010-02-02  3589  	}
cf14c2e987ba0a Philipp Reisner     2010-02-02  3590  
b411b3637fa71f Philipp Reisner     2009-09-25  3591  	if (abs(hg) >= 2) {
d01801710265cf Andreas Gruenbacher 2011-07-03  3592  		drbd_info(device, "Writing the whole bitmap, full sync required after drbd_sync_handshake.\n");
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03 @3593  		if (drbd_bitmap_io(device, &drbd_bmio_set_n_write, "set_n_write from sync_handshake",
e55221e8a69f80 Andreas Gruenbacher 2023-02-15  3594  					BM_LOCKED_SET_ALLOWED, NULL))
b411b3637fa71f Philipp Reisner     2009-09-25  3595  			return C_MASK;
b411b3637fa71f Philipp Reisner     2009-09-25  3596  	}
b411b3637fa71f Philipp Reisner     2009-09-25  3597  
b411b3637fa71f Philipp Reisner     2009-09-25  3598  	if (hg > 0) { /* become sync source. */
b411b3637fa71f Philipp Reisner     2009-09-25  3599  		rv = C_WF_BITMAP_S;
b411b3637fa71f Philipp Reisner     2009-09-25  3600  	} else if (hg < 0) { /* become sync target */
b411b3637fa71f Philipp Reisner     2009-09-25  3601  		rv = C_WF_BITMAP_T;
b411b3637fa71f Philipp Reisner     2009-09-25  3602  	} else {
b411b3637fa71f Philipp Reisner     2009-09-25  3603  		rv = C_CONNECTED;
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3604  		if (drbd_bm_total_weight(device)) {
d01801710265cf Andreas Gruenbacher 2011-07-03  3605  			drbd_info(device, "No resync, but %lu bits in bitmap!\n",
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3606  			     drbd_bm_total_weight(device));
b411b3637fa71f Philipp Reisner     2009-09-25  3607  		}
b411b3637fa71f Philipp Reisner     2009-09-25  3608  	}
b411b3637fa71f Philipp Reisner     2009-09-25  3609  
b411b3637fa71f Philipp Reisner     2009-09-25  3610  	return rv;
b411b3637fa71f Philipp Reisner     2009-09-25  3611  }
b411b3637fa71f Philipp Reisner     2009-09-25  3612  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
