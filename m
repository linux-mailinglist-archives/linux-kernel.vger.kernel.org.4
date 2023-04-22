Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90C66EB6E0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 04:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDVCgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 22:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVCgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 22:36:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649522109;
        Fri, 21 Apr 2023 19:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682130995; x=1713666995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/juVSSj7CyS7SRJ/nRbt/3sIAZrGeNxLQufHh/oQk1I=;
  b=dfkNQapcBQGrn3+6HnpPnSxc3ADHbbGdG3iSDJ6Ep2DJb3okUme7pLt7
   FApmcRS9S3bwnLhh32sfSwBvMlhx35Xwsa2valetL8X7ngap/GxjND4ga
   b2g8kJeWvMWRXVfYFgzBjhZrmbSkLzLw2SedAZRs5aQUyEne7gA7HNBWU
   2a39eNZMVHk1VAoGYL/tec2OXEPk3OViYjWGWOYnczpMmi+A2JwEIovSQ
   D419XY7SkwJgsZ+is9loD7/KdHi76LklNc5m2u7cX+MalZYxwksT7uW8o
   nVoV7/FvqGZTrpvfjJEo8gCa52UJvPi/pOwBa9GqAMNqMym8V1jE/858x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="374056933"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="374056933"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 19:36:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="836364825"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="836364825"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2023 19:36:32 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pq371-000h0y-1b;
        Sat, 22 Apr 2023 02:36:31 +0000
Date:   Sat, 22 Apr 2023 10:35:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, hannes@cmpxchg.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bfoster@redhat.com, willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v12 2/3] cachestat: implement cachestat syscall
Message-ID: <202304221049.51AIFM7O-lkp@intel.com>
References: <20230421231421.2401346-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421231421.2401346-3-nphamcs@gmail.com>
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

Hi Nhat,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[cannot apply to shuah-kselftest/next shuah-kselftest/fixes linus/master tip/x86/asm v6.3-rc7 next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230422-071625
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230421231421.2401346-3-nphamcs%40gmail.com
patch subject: [PATCH v12 2/3] cachestat: implement cachestat syscall
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230422/202304221049.51AIFM7O-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9691e4430fbb59890619289b45ee0ce9ec3e97ee
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230422-071625
        git checkout 9691e4430fbb59890619289b45ee0ce9ec3e97ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304221049.51AIFM7O-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> <stdin>:1567:2: warning: #warning syscall cachestat not implemented [-Wcpp]
--
>> <stdin>:1567:2: warning: #warning syscall cachestat not implemented [-Wcpp]
--
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> <stdin>:1567:2: warning: #warning syscall cachestat not implemented [-Wcpp]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
