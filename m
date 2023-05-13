Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C08A701871
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjEMRWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEMRWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:22:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1BD1FEB
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683998537; x=1715534537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yCiE+DM/RmCoDfRlV+pV24ATWliUJ51tjtagVjTL+vM=;
  b=P4UxpQv9cVFwmDgrmpOdnEbaZHTWvVnjLeS+T4lpoidwwBX/epk+mnoU
   1mRgS/L+xIbStxz2tFdY/MvQ8RQGHD2H68IFaZoHrm60kcMpQP2upfFtM
   EAXESz2AtLQxs7yswkJxqmOd6k8ZHaTEtjREDGN54k+KjH0bhAg22vZNB
   1V3OzGJQTFVqbokxrMbRNAQ0uEQgFN63toSm/W2lVFiG5vMRgKCKUqYWD
   V7Q1UibJhr7JBm/8hZHFoBtT525KgECqrSz3CQzxoxaaZFk0orHR8QJcr
   YKDeo0u04mjQY8FCjsHODaPfswqF3Y6NiHFv5orbdiLFVZq84Ag6Ba4MW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="354118133"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="354118133"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 10:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="824684509"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="824684509"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2023 10:22:14 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxswf-0005bA-2H;
        Sat, 13 May 2023 17:22:13 +0000
Date:   Sun, 14 May 2023 01:22:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhenwei pi <pizhenwei@bytedance.com>, stefanha@redhat.com,
        mst@redhat.com, jasowang@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 1/2] virtio: abstract virtqueue related methods
Message-ID: <202305140142.c0QQq9wZ-lkp@intel.com>
References: <20230512094618.433707-2-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512094618.433707-2-pizhenwei@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhenwei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.4-rc1 next-20230512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhenwei-pi/virtio-abstract-virtqueue-related-methods/20230512-174928
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20230512094618.433707-2-pizhenwei%40bytedance.com
patch subject: [PATCH 1/2] virtio: abstract virtqueue related methods
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/372bc1a0371968752fe0f5ec6e81edee6f9c44dd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhenwei-pi/virtio-abstract-virtqueue-related-methods/20230512-174928
        git checkout 372bc1a0371968752fe0f5ec6e81edee6f9c44dd
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305140142.c0QQq9wZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ./drivers/virtio/virtio_ring.c:1: warning: 'virtqueue_add_inbuf' not found
>> ./drivers/virtio/virtio_ring.c:1: warning: 'virtqueue_add_outbuf' not found
>> ./drivers/virtio/virtio_ring.c:1: warning: 'virtqueue_add_sgs' not found
>> ./drivers/virtio/virtio_ring.c:1: warning: 'virtqueue_get_buf_ctx' not found
>> ./drivers/virtio/virtio_ring.c:1: warning: 'virtqueue_disable_cb' not found
>> ./drivers/virtio/virtio_ring.c:1: warning: 'virtqueue_enable_cb' not found

vim +/virtqueue_add_inbuf +1 ./drivers/virtio/virtio_ring.c

fd534e9b5fdcf9 Thomas Gleixner     2019-05-23  @1  // SPDX-License-Identifier: GPL-2.0-or-later
0a8a69dd77ddbd Rusty Russell       2007-10-22   2  /* Virtio ring implementation.
0a8a69dd77ddbd Rusty Russell       2007-10-22   3   *
0a8a69dd77ddbd Rusty Russell       2007-10-22   4   *  Copyright 2007 Rusty Russell IBM Corporation
0a8a69dd77ddbd Rusty Russell       2007-10-22   5   */
0a8a69dd77ddbd Rusty Russell       2007-10-22   6  #include <linux/virtio.h>
0a8a69dd77ddbd Rusty Russell       2007-10-22   7  #include <linux/virtio_ring.h>
e34f87256794b8 Rusty Russell       2008-07-25   8  #include <linux/virtio_config.h>
0a8a69dd77ddbd Rusty Russell       2007-10-22   9  #include <linux/device.h>
5a0e3ad6af8660 Tejun Heo           2010-03-24  10  #include <linux/slab.h>
b5a2c4f1996d1d Paul Gortmaker      2011-07-03  11  #include <linux/module.h>
e93300b1afc7cd Rusty Russell       2012-01-12  12  #include <linux/hrtimer.h>
780bc7903a32ed Andy Lutomirski     2016-02-02  13  #include <linux/dma-mapping.h>
88938359e2dfe1 Alexander Potapenko 2022-09-15  14  #include <linux/kmsan.h>
f8ce72632fa7ed Michael S. Tsirkin  2021-08-10  15  #include <linux/spinlock.h>
78fe39872378b0 Andy Lutomirski     2016-02-02  16  #include <xen/xen.h>
0a8a69dd77ddbd Rusty Russell       2007-10-22  17  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
