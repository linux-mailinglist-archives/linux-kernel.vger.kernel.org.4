Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB655BC5C3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiISJtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiISJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:49:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F39EAD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663580970; x=1695116970;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=svTkVyxj/7octH6O5gXyHJdkr5RMcoQ3/z5d2IlBtJU=;
  b=n6wCYqM0EUiOhycpACQmvUWT/Qzd9AHv8gTiHX+bWLo2uYnTcMvKstJA
   eS9kLsgHp/fqJYcqnYP2YTSsVmckQWUifURMrVNws0a3Z2xE86rLtcFnY
   +d68BHv7DFsJKiOvTjmIsc6S4xmXP8DfCrlIu8ty5bTOkg5KRZQ1wrEA4
   wYzHtSPiZH5iTs8o8pnIrq/v42pbxhgUbyB0mKBS2VHjvOTtQNqXh8jjM
   xS7hDwrGsEH3BD/PNo+fgqwM6sJye3isoJduSEfmPvrbcqqcPTMh0BKuZ
   lnZC0Ds7HsQDXhSY1ZOqndfMkc8Jzg+cmA5jYLNa7YQ3tioFPURRKr+dz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="325645248"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="325645248"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 02:49:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="649076762"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Sep 2022 02:49:27 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaDP4-0001tE-1k;
        Mon, 19 Sep 2022 09:49:26 +0000
Date:   Mon, 19 Sep 2022 17:49:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-attest 8/9] arch/x86/coco/tdx/tdx.c:904:13-20:
 WARNING opportunity for memdup_user
Message-ID: <202209191759.OT0VLBym-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-attest
head:   9bb81d656ad4e186ad241f08f8b787f87a22c34f
commit: 82114551ae4b398f3283fc843586cf47af178d2d [8/9] x86/tdx: Add VERIFYREPORT support
config: x86_64-randconfig-c002-20220919 (https://download.01.org/0day-ci/archive/20220919/202209191759.OT0VLBym-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

cocci warnings: (new ones prefixed by >>)
>> arch/x86/coco/tdx/tdx.c:904:13-20: WARNING opportunity for memdup_user

vim +904 arch/x86/coco/tdx/tdx.c

   884	
   885	static long tdx_verifyreport(void __user *argp)
   886	{
   887		struct tdx_verifyreport_req req;
   888		void *reportmac = NULL;
   889		long ret;
   890	
   891		/* Copy verifyrequest struct from the user buffer */
   892		if (copy_from_user(&req, argp, sizeof(req)))
   893			return -EFAULT;
   894	
   895		/*
   896		 * Per TDX Module 1.5 specification, section titled
   897		 * "TDG.MR.VERIFYREPORT", REPORTMACSTRUCT length is
   898		 * fixed as TDX_REPORTMACSTRUCT_LEN.
   899		 */
   900		if (req.rpm_len != TDX_REPORTMACSTRUCT_LEN)
   901			return -EINVAL;
   902	
   903		/* Allocate buffer space for REPORTMACSTRUCT */
 > 904		reportmac = kmalloc(req.rpm_len, GFP_KERNEL);
   905		if (!reportmac)
   906			return -ENOMEM;
   907	
   908		/* Copy REPORTDATA from the user buffer */
   909		if (copy_from_user(reportmac, u64_to_user_ptr(req.reportmac),
   910					req.rpm_len)) {
   911			ret = -EFAULT;
   912			goto out;
   913		}
   914	
   915		/*
   916		 * Verify REPORTMACSTRUCT using "TDG.MR.VERIFYREPORT" TDCALL.
   917		 *
   918		 * Verify whether REPORTMACSTRUCT is created on current TEE on
   919		 * the current platform. Refer to section 8.5.11
   920		 * TDG.MR.VERIFYREPORT leaf in the TDX Module 1.5 Specification
   921		 * for detailed information.
   922		 */
   923		ret = __tdx_module_call(TDX_VERIFYREPORT, virt_to_phys(reportmac),
   924					0, 0, 0, NULL);
   925		if (ret) {
   926			pr_debug("VERIFYREPORT TDCALL failed, status:%lx\n", ret);
   927			ret = -EIO;
   928			goto out;
   929		}
   930	
   931		/* Copy TDREPORT back to the user buffer */
   932		if (copy_to_user(u64_to_user_ptr(req.reportmac), reportmac,
   933					req.rpm_len))
   934			ret = -EFAULT;
   935	
   936	out:
   937		kfree(reportmac);
   938		return ret;
   939	}
   940	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
