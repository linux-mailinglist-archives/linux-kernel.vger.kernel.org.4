Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BC073E104
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjFZNuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjFZNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:50:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A4EE7E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687787413; x=1719323413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qGg5y33q4e4oK5lvtFhWNAJKSP92j8o3bpLPCrQZZfs=;
  b=I/G7MI3l43Oa8jCMqzJX8vIz4JaB2A5VcHnraZM5K9dvDR4DxWd+J8IT
   pvFCXl4YBUbMoH1xAjB8+O/aQ9OuOYjVAUPRvqQ15QXw6HmqLc0NcsUb3
   6WQXaKqJ9/ypXya1EN/dr/CH7XTRqXqY6VKzW7/V9MScQ+2S+BW1DdM6D
   TT26WZXuDgjLMvhfmTRaWiUiBNZAtcAATQ2eS2ydErwhh8e7+fjhxTLp2
   XauX0625nNh804aHHK5VbF9w6oRBOI5bLL90h/qO1baM48OHyPJEHmnS9
   CmTxizWCqtiLCish7vF5+qBUsWrh+R1qBOr9lKsQuhyLajHq8ZgOWCOUc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="346026083"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="346026083"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 06:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="890288228"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="890288228"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Jun 2023 06:50:10 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDmbZ-000AiL-0r;
        Mon, 26 Jun 2023 13:50:09 +0000
Date:   Mon, 26 Jun 2023 21:49:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     D Scott Phillips <scott@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Subject: Re: [PATCH v5] arm64: sdei: abort running SDEI handlers during crash
Message-ID: <202306262128.wAk7FLHn-lkp@intel.com>
References: <20230626074748.2785-1-scott@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626074748.2785-1-scott@os.amperecomputing.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on arm/for-next arm/fixes kvmarm/next soc/for-next linus/master v6.4 next-20230626]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/D-Scott-Phillips/arm64-sdei-abort-running-SDEI-handlers-during-crash/20230626-180652
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230626074748.2785-1-scott%40os.amperecomputing.com
patch subject: [PATCH v5] arm64: sdei: abort running SDEI handlers during crash
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20230626/202306262128.wAk7FLHn-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230626/202306262128.wAk7FLHn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306262128.wAk7FLHn-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/acpi/apei/ghes.c:20:
>> include/linux/arm_sdei.h:10:10: fatal error: asm/sdei.h: No such file or directory
      10 | #include <asm/sdei.h>
         |          ^~~~~~~~~~~~
   compilation terminated.


vim +10 include/linux/arm_sdei.h

f9f05395f384ee James Morse 2019-01-29   9  
ad6eb31ef90355 James Morse 2018-01-08 @10  #include <asm/sdei.h>
ad6eb31ef90355 James Morse 2018-01-08  11  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
