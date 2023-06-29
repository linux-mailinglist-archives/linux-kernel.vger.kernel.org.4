Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2917420E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjF2HXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjF2HXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:23:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E08E58;
        Thu, 29 Jun 2023 00:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688023399; x=1719559399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=74L0FNsCDZ5Sbc+RH88Wm9TjQdzKD1PxAYE2xBAuh/8=;
  b=Tw8mvKK65w+8pUiZEDNBI7rUQVFEyQQspsYT+jjVnsYEXLG0NXBINYPm
   d48xi/SMK/ks7gQLmZ6sj9Coz622UHEsgjhIGrasdXkRHy7cjmLuqR6oe
   csdrnuYDX7UJAWBNQfcIei/Qnc1kSANAM1kTfR12BDPCdtC6Hs7UGfctf
   zq4pVJ6amfoqpIlBSCF0xECkIBP9agW6sZaPt6VLBFkTPY8LOZMeBjljU
   3vtwjAORSP8x80bgJpVwUMKrVJwLX8lcb4gDX6+tz0b4uuD1cU0pHCs2E
   pNRid+lQLB3MQ2J22JnMgGhzT7qT1uVy2mOQMZi5AoljnAIC12EfPvNgH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="425714110"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="425714110"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 00:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="1047687351"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="1047687351"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2023 00:23:15 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qElzm-000Dwj-1p;
        Thu, 29 Jun 2023 07:23:14 +0000
Date:   Thu, 29 Jun 2023 15:22:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Hindborg <nmi@metaspace.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
        gost.dev@samsung.com, Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v4 3/4] ublk: enable zoned storage support
Message-ID: <202306291515.z7ox8OTz-lkp@intel.com>
References: <20230628190649.11233-4-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628190649.11233-4-nmi@metaspace.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3261ea42710e9665c9151006049411bd23b5411f]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Hindborg/ublk-change-ublk-IO-command-defines-to-enum/20230629-031015
base:   3261ea42710e9665c9151006049411bd23b5411f
patch link:    https://lore.kernel.org/r/20230628190649.11233-4-nmi%40metaspace.dk
patch subject: [PATCH v4 3/4] ublk: enable zoned storage support
config: i386-randconfig-i006-20230628 (https://download.01.org/0day-ci/archive/20230629/202306291515.z7ox8OTz-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230629/202306291515.z7ox8OTz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306291515.z7ox8OTz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __udivdi3
   >>> referenced by ublk_drv-zoned.c:16 (drivers/block/ublk_drv-zoned.c:16)
   >>>               drivers/block/ublk_drv-zoned.o:(ublk_set_nr_zones) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
