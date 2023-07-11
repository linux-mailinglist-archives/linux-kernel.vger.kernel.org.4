Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A667774E5DE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 06:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGKEdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 00:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGKEdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:33:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE89190;
        Mon, 10 Jul 2023 21:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689050008; x=1720586008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ewu6VMUcTeikFWa5CFXvONYk/FtXbAlUf+kOjZwvfOY=;
  b=UV23SOtnNIFp7KX5Vn9iJ+NBOQKU6dwU/TBrq9e6rWtSQ0BZPiJKGu+T
   Nde3eJa8fcGmObpU+F9+3+RNbHZHPiMNQ8JuRFQ2j61H6KNKmZ7dDZ1GS
   aPgXVXC58Xjb8PNDL0YFCd0wL3Yd+jbqTN/ORsjtmzDEyktXsC01vg71c
   wXaVak3RgRrAX+utlaAjc4MIM0NYNBAA+9catu22zzB+5o0kILylyOnlE
   eQqSVYNO3OrCemQWHx5W6k10+2TbmcNDC8H5spBDA9EBe2WoATQnrnTtY
   Co1ZdOJditS/tztsnAPase/CNWYEuvdW4Yqx/3QkOMi51KMYr3S0lsWyb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="354380703"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="354380703"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 21:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="865627539"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="865627539"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2023 21:32:41 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJ53I-0004Jh-36;
        Tue, 11 Jul 2023 04:32:40 +0000
Date:   Tue, 11 Jul 2023 12:32:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>, ray.huang@amd.com,
        rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Wyes Karny <wyes.karny@amd.com>,
        Perry Yuan <perry.yuan@amd.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: Add sysfs file for base frequency
Message-ID: <202307111214.8H56UUiU-lkp@intel.com>
References: <20230629135454.177421-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629135454.177421-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.5-rc1 next-20230711]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/cpufreq-amd-pstate-Add-sysfs-file-for-base-frequency/20230630-203900
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230629135454.177421-1-mario.limonciello%40amd.com
patch subject: [PATCH] cpufreq: amd-pstate: Add sysfs file for base frequency
reproduce: (https://download.01.org/0day-ci/archive/20230711/202307111214.8H56UUiU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307111214.8H56UUiU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/pm/amd-pstate.rst:286: WARNING: Block quote ends without a blank line; unexpected unindent.

vim +286 Documentation/admin-guide/pm/amd-pstate.rst

   283	
   284	``base_frequency``
   285		Shows the base frequency of the CPU. Frequencies above this will be in the
 > 286	  ``boost`` range. This attribute is read-only.
   287	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
