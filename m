Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8525A720CEF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 03:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbjFCBRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 21:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFCBRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 21:17:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0B8B9;
        Fri,  2 Jun 2023 18:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685755033; x=1717291033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZqjGZ5QOK5/9p0dBTmL1jSNej1ZvjR79xQrDuqbSz60=;
  b=Uie7uu5TIcfBNKXaInDaknHuwZGBaqqOVwcgYOg6H/vyJd6a3kCIQxts
   /3B0AEAeouHRI1KLneflNIPjluf3Mz35jUWoiGYEpalcBxdUhdhfPCPJZ
   ylHV/HFiO6foR3G1sMydWbez3SymhymDM0nUmtMmOVP7Hr+vqOZT7ciwo
   RGNOFu0I1ewg5xVfBmhYtentZZukLwTSy6P1RpHyL5OPtqrtZBYvWSud2
   Cc33fq/W6ul/GD0zRdEhAZ/Vv5AFUAjZjWsald34iBejOCJnn7dKzAngn
   fVawbSj8Zn2hDSixU1AZxybZBTZQMnvRRSNR0L3O0DTeevPFRR45ub2OZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="419549579"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="419549579"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 18:17:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="658443953"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="658443953"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2023 18:17:10 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5FtG-000185-00;
        Sat, 03 Jun 2023 01:17:10 +0000
Date:   Sat, 3 Jun 2023 09:16:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: Re: [PATCH v2 5/5] perf: arm_cspmu: ampere_cspmu: Add support for
 Ampere SoC PMU
Message-ID: <202306030958.1IskqGEt-lkp@intel.com>
References: <20230601030144.3458136-6-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601030144.3458136-6-ilkka@os.amperecomputing.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilkka,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm-perf/for-next/perf]
[also build test WARNING on soc/for-next linus/master v6.4-rc4 next-20230602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ilkka-Koskinen/perf-arm_cspmu-Support-32-bit-accesses-to-64-bit-registers/20230601-110440
base:   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf
patch link:    https://lore.kernel.org/r/20230601030144.3458136-6-ilkka%40os.amperecomputing.com
patch subject: [PATCH v2 5/5] perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/6757d231639bb7a9f0b47f52d7d4f101ad3a0e29
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ilkka-Koskinen/perf-arm_cspmu-Support-32-bit-accesses-to-64-bit-registers/20230601-110440
        git checkout 6757d231639bb7a9f0b47f52d7d4f101ad3a0e29
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306030958.1IskqGEt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/perf/ampere_cspmu.rst: WARNING: document isn't included in any toctree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
