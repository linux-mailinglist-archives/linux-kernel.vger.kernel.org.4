Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C53E6A5B37
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjB1O7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjB1O7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:59:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0B8212AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 06:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677596381; x=1709132381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KcIVbG3EqIfGRw6VdwlfjeAJaYXjwr/2du/u9KQ2UuU=;
  b=i+RigBZJDXCPDxYFolvRdwQ1Dq7amqgoJXNGbhmxZsQV3RTrF2eNqJVi
   Ga2WI8h/yMDKblEMNeLSN7k5LSvCa2i0lKsmETjqCsDBg9zRhn/ecTygI
   1W9RqSNW0bzG7jPRCGZGmVrLcVBHIFgxhNszDivZUOw3nkCYuK26ZVwtQ
   bmY59hfqWiGZY8y9RMW6LFbS+ozAZjSNlFjYNFkYs5WbY9n3o/B4FRNkQ
   5vPvObWrmwzD5HmHYnWFZir/futWpP93FM+QpOBKbQ/vCskmyl0S9uvKR
   AfZr1J+wM0YjBZY64iA8Lbh478SqjhzlKlAMczsZo4zDbN+pgcPusiwJZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="317950945"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="317950945"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 06:59:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="667500776"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="667500776"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2023 06:59:38 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pX1S5-0005Td-1p;
        Tue, 28 Feb 2023 14:59:37 +0000
Date:   Tue, 28 Feb 2023 22:59:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH v2] firmware_loader: Add debug message with checksum for
 FW file
Message-ID: <202302282231.g7ZUHJUm-lkp@intel.com>
References: <20230228185507.1729059-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228185507.1729059-1-amadeuszx.slawinski@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amadeusz,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.2 next-20230228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Amadeusz-S-awi-ski/firmware_loader-Add-debug-message-with-checksum-for-FW-file/20230228-185558
patch link:    https://lore.kernel.org/r/20230228185507.1729059-1-amadeuszx.slawinski%40linux.intel.com
patch subject: [PATCH v2] firmware_loader: Add debug message with checksum for FW file
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20230228/202302282231.g7ZUHJUm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/229a0f94cfda465aff751f6a0395b8d6c6688acd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Amadeusz-S-awi-ski/firmware_loader-Add-debug-message-with-checksum-for-FW-file/20230228-185558
        git checkout 229a0f94cfda465aff751f6a0395b8d6c6688acd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302282231.g7ZUHJUm-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/base/firmware_loader/main.o: in function `fw_log_firmware_info':
>> drivers/base/firmware_loader/main.c:805: undefined reference to `crypto_alloc_shash'
>> ld: drivers/base/firmware_loader/main.c:817: undefined reference to `crypto_shash_digest'
   ld: drivers/base/firmware_loader/main.o: in function `crypto_free_shash':
>> include/crypto/hash.h:736: undefined reference to `crypto_destroy_tfm'


vim +805 drivers/base/firmware_loader/main.c

   797	
   798	static void fw_log_firmware_info(const struct firmware *fw, const char *name, struct device *device)
   799	{
   800		struct shash_desc *shash;
   801		struct crypto_shash *alg;
   802		u8 *sha256buf;
   803		char *outbuf;
   804	
 > 805		alg = crypto_alloc_shash("sha256", 0, 0);
   806		if (!alg)
   807			return;
   808	
   809		sha256buf = kmalloc(SHA256_DIGEST_SIZE, GFP_KERNEL);
   810		outbuf = kmalloc(SHA256_BLOCK_SIZE + 1, GFP_KERNEL);
   811		shash = kmalloc(sizeof(*shash) + crypto_shash_descsize(alg), GFP_KERNEL);
   812		if (!sha256buf || !outbuf || !shash)
   813			goto out_free;
   814	
   815		shash->tfm = alg;
   816	
 > 817		if (crypto_shash_digest(shash, fw->data, fw->size, sha256buf) < 0)
   818			goto out_shash;
   819	
   820		for (int i = 0; i < SHA256_DIGEST_SIZE; i++)
   821			sprintf(&outbuf[i * 2], "%02x", sha256buf[i]);
   822		outbuf[SHA256_BLOCK_SIZE] = 0;
   823		dev_dbg(device, "Loaded FW: %s, sha256: %s\n", name, outbuf);
   824	
   825	out_shash:
   826		crypto_free_shash(alg);
   827	out_free:
   828		kfree(shash);
   829		kfree(outbuf);
   830		kfree(sha256buf);
   831	}
   832	#else
   833	static void fw_log_firmware_info(const struct firmware *fw, const char *name,
   834					 struct device *device)
   835	{}
   836	#endif
   837	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
