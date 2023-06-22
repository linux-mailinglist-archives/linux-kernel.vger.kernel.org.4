Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6073A958
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjFVUJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVUJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:09:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61281710
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 13:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687464589; x=1719000589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rMYEm8dbaQOauXtEW2aM8kbljQdU8H0asFUgdMQJAw4=;
  b=enOHGsdOfpHTHpy5OJD22E8kA8ptPcZXx0VVnr+GBLizUemcg313DfMh
   8uBKflBLIY49g+l7P69myQW57JdP2SIB07lNeQgngZzq3EP3o8KOt1qMB
   4YY69+6j7t6kqnxy/wwCJ5PlnVE1xue2+exfytgA8t7w740r4ekD4Aibi
   qfoUgELg8/DPw7ay3qTvRKDldHYhb3/aYKI8Gmughj7ExW3zjsJH6t7A5
   sDDFxUuIycBRxUEC+G6tQm5f4eLW2E7rGClmyAh8BkraL0NEepsinlShS
   WZ+ZaKSlPtctkyVKupRnYkGxz28lq9dtRujUkQ774oE/F0Uqc3dIUThzs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350359337"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="350359337"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 13:08:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="780372167"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="780372167"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2023 13:08:47 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCQbm-0007lR-0Q;
        Thu, 22 Jun 2023 20:08:46 +0000
Date:   Fri, 23 Jun 2023 04:07:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Naveen N Rao <naveen@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 14/14] powerpc: Implement UACCESS validation on PPC32
Message-ID: <202306230351.SpwvWyz3-lkp@intel.com>
References: <be282f27ad808418c7475b51a00b4cb035f89a95.1687430631.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be282f27ad808418c7475b51a00b4cb035f89a95.1687430631.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on powerpc/next]
[also build test WARNING on powerpc/fixes masahiroy-kbuild/for-next masahiroy-kbuild/fixes linus/master v6.4-rc7]
[cannot apply to next-20230622]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/powerpc-kuap-Avoid-unnecessary-reads-of-MD_AP/20230622-185950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/be282f27ad808418c7475b51a00b4cb035f89a95.1687430631.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH v2 14/14] powerpc: Implement UACCESS validation on PPC32
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230623/202306230351.SpwvWyz3-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230623/202306230351.SpwvWyz3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306230351.SpwvWyz3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/powerpc/platforms/powermac/smp.c:416:13: warning: no previous prototype for 'smp_psurge_take_timebase' [-Wmissing-prototypes]
     416 | void __init smp_psurge_take_timebase(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/platforms/powermac/smp.c:432:13: warning: no previous prototype for 'smp_psurge_give_timebase' [-Wmissing-prototypes]
     432 | void __init smp_psurge_give_timebase(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/platforms/powermac/smp.o: warning: objtool: .text.pmac_cpu_offline_self: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
