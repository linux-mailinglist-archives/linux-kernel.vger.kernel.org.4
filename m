Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFAA69BB5C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 19:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBRSIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 13:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRSIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 13:08:16 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C54CA3E
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 10:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676743695; x=1708279695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=73PcYXx0QvqT7wmHuvNq557Kq98ZMB+myXxHH0XBF98=;
  b=Wf6saV+dw8aU2HTr8O4rlhWMRXwkUZfJxEFItfOzDkdV/g5haxbogss/
   aaTyLJFudn28sFLT1Udsj41zNT+De4fZwItpgleQVklmX3VZK1TntAMW2
   72aDwRZYSTgtl+Q9E8/mRyrvFMWoA5m+5UbtYgcHlSkRfcvJ9WPjgjREm
   3TxysK0gCEiJmd7JDs/4XqheLZA7DV32Ffw0uhSLdxNnNe1CgkhmBmIlO
   /NQTzkIpf8w2J3jIHxYBBsoi0G2WGjx5V4BIacLaPqePA3KaeY/tw+GCu
   R4zcTDrMv+AkTrMAu2tPWQmjz44SSt90J4dfWstauuNcecoZ8C/6s3ZV3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="396871505"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="396871505"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 10:08:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="672945253"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="672945253"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Feb 2023 10:08:09 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTRd2-000CcT-2y;
        Sat, 18 Feb 2023 18:08:08 +0000
Date:   Sun, 19 Feb 2023 02:07:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Subject: Re: [PATCH v2 13/46] hugetlb: add hugetlb_hgm_walk and
 hugetlb_walk_step
Message-ID: <202302190101.aoXrbN26-lkp@intel.com>
References: <20230218002819.1486479-14-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218002819.1486479-14-jthoughton@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20230217]
[cannot apply to kvm/queue shuah-kselftest/next shuah-kselftest/fixes arnd-asm-generic/master linus/master kvm/linux-next v6.2-rc8 v6.2-rc7 v6.2-rc6 v6.2-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Houghton/hugetlb-don-t-set-PageUptodate-for-UFFDIO_CONTINUE/20230218-083216
patch link:    https://lore.kernel.org/r/20230218002819.1486479-14-jthoughton%40google.com
patch subject: [PATCH v2 13/46] hugetlb: add hugetlb_hgm_walk and hugetlb_walk_step
config: arm64-randconfig-r005-20230217 (https://download.01.org/0day-ci/archive/20230219/202302190101.aoXrbN26-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/7e55fe945a1b5f042746277050390bdeba9e22d2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review James-Houghton/hugetlb-don-t-set-PageUptodate-for-UFFDIO_CONTINUE/20230218-083216
        git checkout 7e55fe945a1b5f042746277050390bdeba9e22d2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302190101.aoXrbN26-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: hugetlb_walk_step
   >>> referenced by hugetlb.c
   >>>               mm/hugetlb.o:(__hugetlb_hgm_walk) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
