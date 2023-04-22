Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECD96EB8CB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 13:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDVLTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 07:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVLTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 07:19:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71D11BDA
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 04:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682162386; x=1713698386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+EVsdeVWlcugnqDpDcwqF5ABdA1G/6ft2d3YeGRsGVk=;
  b=mmyhVjZvA3oJtm7Y2PDTKc6n7787fyFV9dZPhOJg2XZZW+zn9uMeXwqF
   V6iYE9ooBSwA2qEdHXkPWquLIvCFNS/M3oyY2aWh1tf6dtKu2zO1cHi/i
   RcXyaOcyf6ssffTeSUeS3fg95Z+NjIECSS9tcnIno1UFE1hU7P/EW6kyw
   GprZnlhmrI5HaAH4lcL046I4odtZsBW2Rn6HzT/tbqZU/VRYWzDVRSGI2
   Q1oPsX6RFGxHrnvxlebdVyiQtFWq24XGwzjch4g6SRfzLqq0MN72aj3Kn
   HhI/x2UwZ8yxoiXDfNzldcwFkZTviWPRXb4mXSxXZj+sT4pi4H7hxqsN5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="343633985"
X-IronPort-AV: E=Sophos;i="5.99,218,1677571200"; 
   d="scan'208";a="343633985"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 04:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="816704438"
X-IronPort-AV: E=Sophos;i="5.99,218,1677571200"; 
   d="scan'208";a="816704438"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2023 04:19:43 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqBHK-000hGO-1B;
        Sat, 22 Apr 2023 11:19:42 +0000
Date:   Sat, 22 Apr 2023 19:18:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v4 2/3] mm, page_owner: Add page_owner_stacks file to
 print out only stacks and their counte
Message-ID: <202304221906.CKlcyd2r-lkp@intel.com>
References: <20230421101415.5734-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421101415.5734-3-osalvador@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc7]
[cannot apply to akpm-mm/mm-everything next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/lib-stackdepot-Add-a-refcount-field-in-stack_record/20230421-181709
base:   linus/master
patch link:    https://lore.kernel.org/r/20230421101415.5734-3-osalvador%40suse.de
patch subject: [PATCH v4 2/3] mm, page_owner: Add page_owner_stacks file to print out only stacks and their counte
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20230422/202304221906.CKlcyd2r-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304221906.CKlcyd2r-lkp@intel.com/

smatch warnings:
lib/stackdepot.c:558 stack_print() warn: unsigned 'stack->size' is never less than zero.

vim +558 lib/stackdepot.c

   551	
   552	int stack_print(struct seq_file *m, void *v)
   553	{
   554		char *buf;
   555		int ret = 0;
   556		struct stack_record *stack =v;
   557	
 > 558		if (!stack->size || stack->size < 0 ||
   559		    stack->size > PAGE_SIZE || stack->handle.valid != 1 ||
   560		    refcount_read(&stack->count) < 1)
   561			return 0;
   562	
   563		buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
   564		ret += stack_trace_snprint(buf, PAGE_SIZE, stack->entries, stack->size, 0);
   565		scnprintf(buf + ret, PAGE_SIZE - ret, "stack count: %d\n\n",
   566			  refcount_read(&stack->count));
   567		seq_printf(m, buf);
   568		seq_puts(m, "\n\n");
   569		kfree(buf);
   570	
   571	        return 0;
   572	}
   573	#endif
   574	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
