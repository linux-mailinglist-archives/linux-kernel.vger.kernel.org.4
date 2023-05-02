Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEBB6F3C6C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 05:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjEBDeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 23:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjEBDeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 23:34:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A9A3C19
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 20:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682998458; x=1714534458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+6dA6KdIKutJxGniT6UriJY7gWQ2DD7E0/cszDATHKI=;
  b=XI71fl8KpqOHUUtsMawlymTY7FfLmsTQUT0CwoIsGK4qTMv3oxFtePZV
   TBNJqmeFydwzDSVAT988c2M0/wkbas2wUCpE5BOkGVUjHuJstWRy+0QoZ
   P7ZHPNAifCQcPJZDBRs1hVmtMp5N0/4IWnmI25F2SL2IfFVg/v84gMF6y
   Bv2dUK+JpH8H7huGLQCZbOVXzK7uS3HtmgVII/CavurSqYeqLyr4hNd21
   //H0jhlPoLVn0DaEZHsvmCZ8MZbTxkg98H/YCp0vof+ouSO0dt1ZDfDAF
   RcdkUOsUmjA55ec2x+M5EjtyMkWMvgdLGKzs6anRHpJJZTstty9ctGw3t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="413734247"
X-IronPort-AV: E=Sophos;i="5.99,243,1677571200"; 
   d="scan'208";a="413734247"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 20:34:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="1025889706"
X-IronPort-AV: E=Sophos;i="5.99,243,1677571200"; 
   d="scan'208";a="1025889706"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 May 2023 20:34:10 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ptgmI-0000oK-0s;
        Tue, 02 May 2023 03:34:10 +0000
Date:   Tue, 2 May 2023 11:33:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing
 to file-backed mappings
Message-ID: <202305021142.vBYXxxEh-lkp@intel.com>
References: <dee4f4ad6532b0f94d073da263526de334d5d7e0.1682981880.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dee4f4ad6532b0f94d073da263526de334d5d7e0.1682981880.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-mmap-separate-writenotify-and-dirty-tracking-logic/20230502-071520
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/dee4f4ad6532b0f94d073da263526de334d5d7e0.1682981880.git.lstoakes%40gmail.com
patch subject: [PATCH v6 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing to file-backed mappings
config: arm-randconfig-r013-20230502 (https://download.01.org/0day-ci/archive/20230502/202305021142.vBYXxxEh-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b1465cd49efcbc114a75220b153f5a055ce7911f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/602bb9fab888bd9176b8eeb80a0da68499c343ed
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lorenzo-Stoakes/mm-mmap-separate-writenotify-and-dirty-tracking-logic/20230502-071520
        git checkout 602bb9fab888bd9176b8eeb80a0da68499c343ed
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305021142.vBYXxxEh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/gup.c:114:49: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static bool stabilise_mapping_rcu(struct folio *)
                                                   ^
   1 warning generated.


vim +114 mm/gup.c

   108	
   109	static void unlock_rcu(void)
   110	{
   111		rcu_read_unlock();
   112	}
   113	#else
 > 114	static bool stabilise_mapping_rcu(struct folio *)
   115	{
   116		return true;
   117	}
   118	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
