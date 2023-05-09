Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7266FBD80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjEIDKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbjEIDJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:09:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AAC4C15
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 20:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683601793; x=1715137793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E85fafjTlmWr7GJ+3EI1MkY1pjy3i3bTw12YeWK7fU4=;
  b=mB1zaVMcmFPO/xn4mDirw/ANnaSI8KUtf2LDToq73/V23vgyM+mytPGa
   rnS0cxKwXgqedlTK35+p39Xoov0V56CxFXSSKIc3FB85ZzABbfe2d60BJ
   eWPgCpcrYi74o/2fnYKFdnErT7X6LpT3Ah26TEJI+YE4SY/CD+v+e7p+Z
   0UndH8y63Cu5eJFi3WBMgNO+KTLOQS45oSPPWnhdSoz4bI03tIZnrR/Iy
   19D7lufYW/C08wYCIgbzvB3g1n6e/gIYVacoNR2y7PYfgo+To359lzuHQ
   +Rh7O9Iihyshl24Kl+rGi5gieGnblkorDtsf7wMEWJ+yE8kBvVkgYcvaB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="334250145"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="334250145"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 20:09:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="842939434"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="842939434"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 May 2023 20:09:50 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwDjZ-0001cE-2l;
        Tue, 09 May 2023 03:09:49 +0000
Date:   Tue, 9 May 2023 11:09:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     alison@she-devel.com, johan@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        alison@she-devel.com, achaiken@aurora.tech
Subject: Re: [PATCH 1/2] gnss: ubx: customize serial device open to set
 U-Blox Zed-F9P baud
Message-ID: <202305091016.ekHtVcRp-lkp@intel.com>
References: <20230429224349.1935029-2-alison@she-devel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230429224349.1935029-2-alison@she-devel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.4-rc1 next-20230508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alison-she-devel-com/gnss-ubx-customize-serial-device-open-to-set-U-Blox-Zed-F9P-baud/20230430-065242
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230429224349.1935029-2-alison%40she-devel.com
patch subject: [PATCH 1/2] gnss: ubx: customize serial device open to set U-Blox Zed-F9P baud
config: mips-randconfig-c004-20230507 (https://download.01.org/0day-ci/archive/20230509/202305091016.ekHtVcRp-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305091016.ekHtVcRp-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gnss/ubx.c:263:5-11: ERROR: allocation function on line 262 returns NULL not ERR_PTR on failure

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
