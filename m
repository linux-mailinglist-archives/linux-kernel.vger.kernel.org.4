Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32F673B045
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjFWFqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjFWFqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:46:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D292D59;
        Thu, 22 Jun 2023 22:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687499164; x=1719035164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZISzgnMYZN1mP4NRVo3qnOGqTIHRUPC8H737DadpiDc=;
  b=Lfby7GAHC3iMLmkxoe3KQ8vWROb6mMqwSYl5vkcwJ1lLkwdHxdasMYMh
   1aJ7tzQDNMAoKHMBHJxjwrvWbO0qvDvzMy8LzHsp1tz5KOGib3cmZdzHm
   /3aEuvEgBhIChgWMMGTEA99KtSNzw2xVJUyrlWr7aUKfS+5LXY1rUnOiQ
   na0aeb+db9UWbEltMxhe97fKI4Suwrq88+wHNsGCpHulKo/9L66MMfAUo
   hFNbUMLtkcd5uPv9vb4un7cbobi1bsC3xTc3EPCDeQCfSk0sXqsvh++yf
   cNw+Bwu5oy9CY/wp9gT2bmPeQS9UR1HPneuZgKeag/9c7R1WIt/UwVV/f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359561826"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="359561826"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 22:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="709339659"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="709339659"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 22 Jun 2023 22:45:58 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCZcM-000811-0g;
        Fri, 23 Jun 2023 05:45:58 +0000
Date:   Fri, 23 Jun 2023 13:45:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Su Hui <suhui@nfschina.com>, alexander.deucher@amd.com,
        airlied@gmail.com, Xinhui.Pan@amd.com, daniel@ffwll.ch
Cc:     oe-kbuild-all@lists.linux.dev, David.Francis@amd.com,
        Jane.Jian@amd.com, Bokun.Zhang@amd.com, monk.liu@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Properly tune the size of struct
Message-ID: <202306231320.jElZhRjj-lkp@intel.com>
References: <20230620045919.492128-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230620045919.492128-1-suhui@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Su,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v6.4-rc7 next-20230622]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Su-Hui/drm-amd-amdgpu-Properly-tune-the-size-of-struct/20230620-130013
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230620045919.492128-1-suhui%40nfschina.com
patch subject: [PATCH] drm/amd/amdgpu: Properly tune the size of struct
config: microblaze-randconfig-s032-20230622 (https://download.01.org/0day-ci/archive/20230623/202306231320.jElZhRjj-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230623/202306231320.jElZhRjj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306231320.jElZhRjj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:579:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2347:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2347:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2347:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__gu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2347:21: sparse:     expected unsigned int const [noderef] __user *__gu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2347:21: sparse:     got unsigned int [usertype] *
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:153:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:153:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:153:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:153:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:153:29: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:153:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:153:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:153:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:155:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:155:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:155:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__gu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:155:29: sparse:     expected unsigned int const [noderef] __user *__gu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:155:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:282:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:282:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:282:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:282:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:282:29: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:282:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:282:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:282:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:284:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:284:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:284:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__gu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:284:29: sparse:     expected unsigned int const [noderef] __user *__gu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:284:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:330:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct amdgpu_debugfs_regs2_iocdata_v2 * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:330:46: sparse:     expected void const [noderef] __user *from
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:330:46: sparse:     got struct amdgpu_debugfs_regs2_iocdata_v2 *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:336:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct amdgpu_debugfs_regs2_iocdata * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:336:47: sparse:     expected void const [noderef] __user *from
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:336:47: sparse:     got struct amdgpu_debugfs_regs2_iocdata *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:460:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:460:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:460:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:460:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:460:21: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:460:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:460:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:460:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:488:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct amdgpu_debugfs_gprwave_iocdata * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:488:37: sparse:     expected void const [noderef] __user *from
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:488:37: sparse:     got struct amdgpu_debugfs_gprwave_iocdata *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:543:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:543:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:543:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:543:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:543:21: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:543:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:543:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:543:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:598:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:598:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:598:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__gu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:598:21: sparse:     expected unsigned int const [noderef] __user *__gu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:598:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:656:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:656:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:656:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:656:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:656:21: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:656:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:656:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:656:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:711:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:711:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:711:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__gu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:711:21: sparse:     expected unsigned int const [noderef] __user *__gu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:711:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:769:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:769:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:769:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:769:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:769:21: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:769:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:769:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:769:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:824:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:824:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:824:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__gu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:824:21: sparse:     expected unsigned int const [noderef] __user *__gu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:824:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:925:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:925:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:925:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:925:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:925:21: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:925:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:925:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:925:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1003:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1003:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1003:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1003:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__pu_addr @@     got signed int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1003:29: sparse:     expected signed int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1003:29: sparse:     got signed int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1003:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1003:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1089:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1089:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1089:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1089:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1089:21: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1089:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1089:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1089:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1182:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1182:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1182:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1182:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1182:21: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1182:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1182:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1182:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1237:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1237:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1237:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1237:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1237:21: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1237:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1237:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1237:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1284:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1284:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1284:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__gu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1284:21: sparse:     expected unsigned int const [noderef] __user *__gu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1284:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1336:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1336:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1336:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1336:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__pu_addr @@     got unsigned long long [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1336:21: sparse:     expected unsigned long long [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1336:21: sparse:     got unsigned long long [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1336:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1336:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1383:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1383:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1383:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__gu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1383:21: sparse:     expected unsigned int const [noderef] __user *__gu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1383:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1431:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1431:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1431:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1431:21: sparse: sparse: too many warnings
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1808:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1808:25: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1808:25: sparse:    struct dma_fence *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1809:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1809:17: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1809:17: sparse:    struct dma_fence *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1868:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1868:17: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1868:17: sparse:    struct dma_fence *
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:479:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] pixclk_100hz @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:479:34: sparse:     expected unsigned int [addressable] [assigned] [usertype] pixclk_100hz
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:479:34: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:575:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] h_size @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:575:23: sparse:     expected unsigned short [assigned] [usertype] h_size
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:575:23: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:577:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] h_blanking_time @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:577:32: sparse:     expected unsigned short [assigned] [usertype] h_blanking_time
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:577:32: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:581:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] v_size @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:581:23: sparse:     expected unsigned short [assigned] [usertype] v_size
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:581:23: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:583:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] v_blanking_time @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:583:32: sparse:     expected unsigned short [assigned] [usertype] v_blanking_time
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:583:32: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:590:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] h_syncoffset @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:590:29: sparse:     expected unsigned short [assigned] [usertype] h_syncoffset
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:590:29: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:593:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] h_syncwidth @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:593:28: sparse:     expected unsigned short [assigned] [usertype] h_syncwidth
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:593:28: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:598:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] v_syncoffset @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:598:29: sparse:     expected unsigned short [assigned] [usertype] v_syncoffset
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:598:29: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:601:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] v_syncwidth @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:601:28: sparse:     expected unsigned short [assigned] [usertype] v_syncwidth
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:601:28: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:610:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:609:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] modemiscinfo @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:609:37: sparse:     expected unsigned short [assigned] [usertype] modemiscinfo
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:609:37: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:615:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:614:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] modemiscinfo @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:614:37: sparse:     expected unsigned short [assigned] [usertype] modemiscinfo
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:614:37: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:620:33: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:619:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] modemiscinfo @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:619:37: sparse:     expected unsigned short [assigned] [usertype] modemiscinfo
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:619:37: sparse:     got restricted __le16 [usertype]
>> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:638:39: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le16 [usertype] *var @@     got unsigned short * @@
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:638:39: sparse:     expected restricted __le16 [usertype] *var
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:638:39: sparse:     got unsigned short *
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:644:25: sparse: sparse: cast to restricted __le16
>> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:643:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] modemiscinfo @@     got restricted __le16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:643:37: sparse:     expected unsigned short [addressable] [assigned] [usertype] modemiscinfo
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:643:37: sparse:     got restricted __le16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:915:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] dceclk_10khz @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:915:43: sparse:     expected unsigned int [addressable] [assigned] [usertype] dceclk_10khz
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:915:43: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:924:53: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:924:53: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:924:53: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:924:53: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:924:53: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c:924:53: sparse: sparse: cast to restricted __le32

vim +2347 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c

d38ceaf99ed015 Alex Deucher    2015-04-20  2322  
75501872b4af93 Lee Jones       2020-11-12  2323  /*
50da51744f005f Tom St Denis    2018-05-09  2324   * amdgpu_ttm_vram_write - Linear write access to VRAM
50da51744f005f Tom St Denis    2018-05-09  2325   *
50da51744f005f Tom St Denis    2018-05-09  2326   * Accesses VRAM via MMIO for debugging purposes.
50da51744f005f Tom St Denis    2018-05-09  2327   */
08cab989f77582 Tom St Denis    2017-08-29  2328  static ssize_t amdgpu_ttm_vram_write(struct file *f, const char __user *buf,
08cab989f77582 Tom St Denis    2017-08-29  2329  				    size_t size, loff_t *pos)
08cab989f77582 Tom St Denis    2017-08-29  2330  {
08cab989f77582 Tom St Denis    2017-08-29  2331  	struct amdgpu_device *adev = file_inode(f)->i_private;
08cab989f77582 Tom St Denis    2017-08-29  2332  	ssize_t result = 0;
08cab989f77582 Tom St Denis    2017-08-29  2333  	int r;
08cab989f77582 Tom St Denis    2017-08-29  2334  
08cab989f77582 Tom St Denis    2017-08-29  2335  	if (size & 0x3 || *pos & 0x3)
08cab989f77582 Tom St Denis    2017-08-29  2336  		return -EINVAL;
08cab989f77582 Tom St Denis    2017-08-29  2337  
770d13b19fdf36 Christian König 2018-01-12  2338  	if (*pos >= adev->gmc.mc_vram_size)
08cab989f77582 Tom St Denis    2017-08-29  2339  		return -ENXIO;
08cab989f77582 Tom St Denis    2017-08-29  2340  
08cab989f77582 Tom St Denis    2017-08-29  2341  	while (size) {
08cab989f77582 Tom St Denis    2017-08-29  2342  		uint32_t value;
08cab989f77582 Tom St Denis    2017-08-29  2343  
770d13b19fdf36 Christian König 2018-01-12  2344  		if (*pos >= adev->gmc.mc_vram_size)
08cab989f77582 Tom St Denis    2017-08-29  2345  			return result;
08cab989f77582 Tom St Denis    2017-08-29  2346  
08cab989f77582 Tom St Denis    2017-08-29 @2347  		r = get_user(value, (uint32_t *)buf);
08cab989f77582 Tom St Denis    2017-08-29  2348  		if (r)
08cab989f77582 Tom St Denis    2017-08-29  2349  			return r;
08cab989f77582 Tom St Denis    2017-08-29  2350  
5fb95aa73f3c8d Kevin Wang      2021-07-15  2351  		amdgpu_device_mm_access(adev, *pos, &value, 4, true);
08cab989f77582 Tom St Denis    2017-08-29  2352  
08cab989f77582 Tom St Denis    2017-08-29  2353  		result += 4;
08cab989f77582 Tom St Denis    2017-08-29  2354  		buf += 4;
08cab989f77582 Tom St Denis    2017-08-29  2355  		*pos += 4;
08cab989f77582 Tom St Denis    2017-08-29  2356  		size -= 4;
08cab989f77582 Tom St Denis    2017-08-29  2357  	}
08cab989f77582 Tom St Denis    2017-08-29  2358  
08cab989f77582 Tom St Denis    2017-08-29  2359  	return result;
08cab989f77582 Tom St Denis    2017-08-29  2360  }
08cab989f77582 Tom St Denis    2017-08-29  2361  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
