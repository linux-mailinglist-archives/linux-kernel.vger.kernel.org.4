Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBC6720E85
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 09:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjFCHkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 03:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFCHk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 03:40:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837D41A6;
        Sat,  3 Jun 2023 00:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685778028; x=1717314028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cW9DTSdTxyAKRe9XKCSoC/96vhR3nXHtujwISq7tXks=;
  b=n6/CnBjvY7D/7KfxTmXDCDlrYu3Llx9KRIiuv3dGAWo6H0okF7GZAJXe
   jxxvwQX0md7spnn9mEPpNufgRsUQFXZaN7gs6Pabx+x66lU9LlPhz8qmc
   lyAFiVNyDc6IOs3IJXeCe5BeAGbuQAbTRyxlR+vaXnH8eO30FUrBKthmb
   pzow9dao/vL9UsF7H4YoDPzm2B+Roo9JaclnOboSBh2ZbVAF9VbGW9ecP
   K/V2V7pKZeaiE2oqrF95f57ubbB2fZlbWF1qLYx954ueWWZK3ZUAkn24b
   Fo2YNdT9NCnWd5fahsNaQI/wE60CHG+jKqtTSDNFb/B1fj8imsAQ8p93N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="335665206"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="335665206"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 00:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="737798077"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="737798077"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Jun 2023 00:40:25 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5Ls8-0001QX-1w;
        Sat, 03 Jun 2023 07:40:24 +0000
Date:   Sat, 3 Jun 2023 15:40:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/6] device-mapper: Avoid double-fetch of version
Message-ID: <202306031511.xIeQ4BQz-lkp@intel.com>
References: <20230601212456.1533-5-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601212456.1533-5-demi@invisiblethingslab.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Demi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on device-mapper-dm/for-next]
[also build test WARNING on linus/master v6.4-rc4 next-20230602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Demi-Marie-Obenour/device-mapper-Check-that-target-specs-are-sufficiently-aligned/20230602-052741
base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
patch link:    https://lore.kernel.org/r/20230601212456.1533-5-demi%40invisiblethingslab.com
patch subject: [PATCH 4/6] device-mapper: Avoid double-fetch of version
config: x86_64-randconfig-c032-20230531 (https://download.01.org/0day-ci/archive/20230603/202306031511.xIeQ4BQz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306031511.xIeQ4BQz-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/md/dm-ioctl.c:1900:42-48: ERROR: application of sizeof to pointer

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
