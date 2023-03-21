Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E306C27F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCUCST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCUCSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:18:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F138661;
        Mon, 20 Mar 2023 19:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679365091; x=1710901091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QBIssQwI18us+dgn2chNBQX5l2ZatxK5ht9vMn5tRT0=;
  b=L7Kd1DfWJLnpoIfFL21aWrmBl4R9bXcyzh9WnWJsQhhVQ3JzL0aDVUwK
   Kx/hbkmbTv/++MHOLHSmYK7kT4REijZSmXFc7ohzoGNChdY28LdrTLTGt
   Ixn3LgHWxet9VLQGOjfhqDsgTWaqRACLRN1YhHTE8GCTc7eszh81l7wjq
   IlAV4dCla//G3GCuLJNdbk1hpCS5uUemvaQHSOEeGiK8J3G1U5z0xTB0z
   JwfnIGyUEiy2BissnFw+ltmzhs4fJA20iQ/OqSAj7+tFB4jxTM1umYoqL
   cqX3W9JylQKZ/j9G8jsFpiCwMWAL9Yha2lFm6Xq0QwQoS8Oo4b/a+w3AX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="401402498"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="401402498"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 19:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="711618653"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="711618653"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Mar 2023 19:18:07 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peRZf-000BV2-03;
        Tue, 21 Mar 2023 02:18:07 +0000
Date:   Tue, 21 Mar 2023 10:17:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: add iostat latency statistics support for
 discard
Message-ID: <202303211005.RGxljvli-lkp@intel.com>
References: <20230320175529.39129-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320175529.39129-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

I love your patch! Perhaps something to improve:

[auto build test WARNING on jaegeuk-f2fs/dev-test]
[also build test WARNING on jaegeuk-f2fs/dev linus/master v6.3-rc3 next-20230320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yangtao-Li/f2fs-add-iostat-latency-statistics-support-for-discard/20230321-020736
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20230320175529.39129-1-frank.li%40vivo.com
patch subject: [PATCH v2] f2fs: add iostat latency statistics support for discard
config: x86_64-randconfig-s023 (https://download.01.org/0day-ci/archive/20230321/202303211005.RGxljvli-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/a094ea0014763420eb8e3577552baac00c63efad
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yangtao-Li/f2fs-add-iostat-latency-statistics-support-for-discard/20230321-020736
        git checkout a094ea0014763420eb8e3577552baac00c63efad
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303211005.RGxljvli-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/f2fs/iostat.c:259:29: sparse: sparse: mixing different enum types:
>> fs/f2fs/iostat.c:259:29: sparse:    unsigned int enum iostat_lat_type
>> fs/f2fs/iostat.c:259:29: sparse:    unsigned int enum page_type
   fs/f2fs/iostat.c:262:29: sparse: sparse: mixing different enum types:
   fs/f2fs/iostat.c:262:29: sparse:    unsigned int enum iostat_lat_type
   fs/f2fs/iostat.c:262:29: sparse:    unsigned int enum page_type

vim +259 fs/f2fs/iostat.c

   246	
   247	void iostat_update_submit_ctx(struct bio *bio, enum page_type type)
   248	{
   249		struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
   250		enum iostat_lat_type lat_type;
   251	
   252		iostat_ctx->submit_ts = jiffies;
   253	
   254		if (type == DISCARD) {
   255			lat_type = DISCARD_LAT;
   256		} else if (op_is_write(bio_op(bio))) {
   257			lat_type = bio->bi_opf & REQ_SYNC ?
   258					WRITE_SYNC_DATA_LAT : WRITE_ASYNC_DATA_LAT;
 > 259			lat_type += type;
   260		} else {
   261			lat_type = READ_DATA_LAT;
   262			lat_type += type;
   263		}
   264	
   265		iostat_ctx->lat_type = lat_type;
   266	}
   267	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
