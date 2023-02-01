Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A4D686A81
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjBAPjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjBAPjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:39:37 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E006D5E8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675265976; x=1706801976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h9OLENDYQGay9pJJJVvRsBkMjqRaBlTrJfaKEC2n4IE=;
  b=ALLnBt6KVmOos50oGLlu0fqwlRhMJ5z7TBPT0VLksd6fGFgkdamglFfJ
   NDstyQWM6kt6r38yU+vOm1vdP/1BdhjFuqN/g6EywGBR9XlqWxyVkS0K1
   627CQzQ+zCkxUPR7owo3nbtr3qaerg9JoQ/MBtTjqT9aCJedpy57FzB+o
   ybOm/OQrqYDIHmzIl2cn/sV2HpwuUqNXzVjDSc2jDK05tXaLf/5fL67qP
   jlZ/IVXm738gPsSORCLuxtRRoeJ9ZZBoveTdjCVICICAjTdWZt11XVhX3
   Ds1QMhfmbCjVvPy26+9cu5GdODUlwSoYQcWj+IsPi4ztYRdEi0QcYT0EK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="325875812"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="325875812"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 07:39:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="728450867"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="728450867"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Feb 2023 07:39:31 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNFCt-0005XY-0P;
        Wed, 01 Feb 2023 15:39:31 +0000
Date:   Wed, 1 Feb 2023 23:38:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     George Prekas <george@enfabrica.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        George Prekas <george@enfabrica.net>
Subject: Re: [PATCH 1/9] mm: kmemleak: properly disable task stack scanning
Message-ID: <202302012338.O1vnQ1Ar-lkp@intel.com>
References: <20230123170419.7292-2-george@enfabrica.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123170419.7292-2-george@enfabrica.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on vbabka-slab/for-next]
[also build test WARNING on linus/master v6.2-rc6]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/George-Prekas/mm-kmemleak-properly-disable-task-stack-scanning/20230124-010911
base:   git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git for-next
patch link:    https://lore.kernel.org/r/20230123170419.7292-2-george%40enfabrica.net
patch subject: [PATCH 1/9] mm: kmemleak: properly disable task stack scanning
config: s390-randconfig-s051-20230129 (https://download.01.org/0day-ci/archive/20230201/202302012338.O1vnQ1Ar-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/f0d9df4305849ecea4402bc614cadb0dd357da77
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review George-Prekas/mm-kmemleak-properly-disable-task-stack-scanning/20230124-010911
        git checkout f0d9df4305849ecea4402bc614cadb0dd357da77
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> mm/kmemleak.c:1244:46: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long ptr @@     got void const *ptr @@
   mm/kmemleak.c:1244:46: sparse:     expected unsigned long ptr
   mm/kmemleak.c:1244:46: sparse:     got void const *ptr
   mm/kmemleak.c:1772:13: sparse: sparse: context imbalance in 'kmemleak_seq_start' - different lock contexts for basic block
   mm/kmemleak.c: note: in included file (through include/linux/rculist.h, include/linux/sched/signal.h):
   include/linux/rcupdate.h:795:9: sparse: sparse: context imbalance in 'kmemleak_seq_stop' - unexpected unlock

vim +1244 mm/kmemleak.c

  1233	
  1234	/**
  1235	 * kmemleak_mark_stack - mark the allocated object as a kernel stack
  1236	 *
  1237	 * @ptr:	pointer to beginning of the object
  1238	 */
  1239	void __ref kmemleak_mark_stack(const void *ptr)
  1240	{
  1241		struct kmemleak_object *object;
  1242	
  1243		if (kmemleak_enabled && ptr && !IS_ERR(ptr)) {
> 1244			object = find_and_get_object(ptr, 0);
  1245			if (object) {
  1246				object->flags |= OBJECT_STACK;
  1247				put_object(object);
  1248			}
  1249		}
  1250	}
  1251	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
