Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EF76BBC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjCOSnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjCOSnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:43:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0250674317;
        Wed, 15 Mar 2023 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905760; x=1710441760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WqLIUzmP8asZLzY4oGPhwU9LNM1qEQ5ClJyEqOCyqrA=;
  b=bUkTOVf6rQ1OuAOHs+QDlUxCmuSO5U2W6yiJ3UZjPrR1fqTfDOzrzBPq
   qb5ITDdoLW6I2B5qRvxPNhQfDXe7yqywg0xDZGhRIYoM7iNM53Muhxh7s
   2S9KrIGMIgCdjF6zpK+72nitYiyQjMI9dgy3XObbA4xIM0N/8svAX1UBM
   gGhR8GB3xxBC7xZU/0EP0tTjooe0Goq+HAnbHWdZs0vVGJybGpAcX3Tga
   Uvrk+C8xQMpoKqxzMAne7TSYAQWbcRsD5ZsFro0CCvk4kaS75hnJj9WyS
   tAgBy/5ycfzbEYhqTpnZeLDpeloamgifnQKFkd07nwSjvmkh0KjkHr1+/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340156096"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340156096"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:42:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925436387"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925436387"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2023 11:42:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcW4X-0007xF-2D;
        Wed, 15 Mar 2023 18:42:01 +0000
Date:   Thu, 16 Mar 2023 02:41:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeffrey Kardatzke <jkardatzke@chromium.org>,
        op-tee@lists.trustedfirmware.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Garg <sumit.garg@linaro.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9] tee: optee: Add SMC for loading OP-TEE image
Message-ID: <202303160226.q1JZZFAw-lkp@intel.com>
References: <20230314135704.v9.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314135704.v9.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffrey,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc2 next-20230315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeffrey-Kardatzke/tee-optee-Add-SMC-for-loading-OP-TEE-image/20230315-045847
patch link:    https://lore.kernel.org/r/20230314135704.v9.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb%40changeid
patch subject: [PATCH v9] tee: optee: Add SMC for loading OP-TEE image
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/cab42c7807bc48ef664573253d3f37c6bf7c1d08
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jeffrey-Kardatzke/tee-optee-Add-SMC-for-loading-OP-TEE-image/20230315-045847
        git checkout cab42c7807bc48ef664573253d3f37c6bf7c1d08
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303160226.q1JZZFAw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/staging/tee.rst:233: WARNING: Unexpected indentation.
>> Documentation/staging/tee.rst:234: WARNING: Block quote ends without a blank line; unexpected unindent.
>> Documentation/staging/tee.rst:237: WARNING: Enumerated list ends without a blank line; unexpected unindent.

vim +233 Documentation/staging/tee.rst

   230	
   231	1. Boot chain security.
   232	   Attack vector: Replace the OP-TEE OS image in the rootfs to gain control of
 > 233	                  the system.
 > 234	   Migitation: There must be boot chain security that verifies the kernel and
   235	               rootfs, otherwise an attacker can modify the loaded OP-TEE
   236	               binary by modifying it in the rootfs.
 > 237	3. Alternate boot modes.
   238	   Attack vector: Using an alternate boot mode (i.e. recovery mode), the OP-TEE
   239	                  driver isn't loaded, leaving the SMC hole open.
   240	   Mitigation: If there are alternate methods of booting the device, such as a
   241	               recovery mode, it should be ensured that the same mitigations are
   242	               applied in that mode.
   243	3. Attacks prior to SMC invocation.
   244	   Attack vector: Code that is executed prior to issuing the SMC call to load
   245	                  OP-TEE can be exploited to then load an alternate OS image.
   246	   Mitigation: The OP-TEE driver must be loaded before any potential attack
   247	               vectors are opened up. This should include mounting of any
   248	               modifiable filesystems, opening of network ports or communicating
   249	               with external devices (e.g. USB).
   250	4. Blocking SMC call to load OP-TEE.
   251	   Attack vector: Prevent the driver from being probed, so the SMC call to load
   252	                  OP-TEE isn't executed when desired, leaving it open to being
   253	                  executed later and loading a modified OS.
   254	   Mitigation: It is recommended to build the OP-TEE driver as an included
   255	               driver rather than a module to prevent exploits that may cause
   256	               the module to not be loaded.
   257	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
