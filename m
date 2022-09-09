Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4E75B3CAD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiIIQI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiIIQIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:08:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AC912B351
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662739728; x=1694275728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IOusBextcdJmxpU1f1tWu5rHad0Vp5YhX9tuHZ5md1A=;
  b=H3gGUe0HOtSwzchgmt1/BB4i1Eo6OR8N/ytrz5aeWWf3RQ90aWqGViQU
   wEiDV9ej3MYAwhyIB/cfg6gu0cA4RleE9hyFjLdUF/AdRum7lPSkLaC0l
   cXAhPM9Eg6rk3nfuojtaR1+cpQYhop8MTeK0AvC/kxIyPPkwsijsfiFC2
   ZBWRy4AYta4tSb28cY8hvWhOz8kK7+FcWV5KZoFO+BOJ5ZNr9h0fBKffX
   UtGspNm0BTjdNctN/88Jwxxi9aLTkpNJ4jWAXFiPen2x5ArCRlWZB0ylC
   +VBbwyVxkHUWnNTcPVQOuPVf1LOzedXCqd64eUpta0tCr4MCRVqBdyxrx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="297508385"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="297508385"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 09:08:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="677217634"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 09:08:43 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWgYX-0001Pf-2u;
        Fri, 09 Sep 2022 16:08:37 +0000
Date:   Sat, 10 Sep 2022 00:07:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     kbuild-all@lists.01.org, qais.yousef@arm.com,
        chris.hyser@oracle.com, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v3 8/8] sched/fair: Add latency list
Message-ID: <202209092349.DjjxV7GB-lkp@intel.com>
References: <20220909130309.25458-9-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909130309.25458-9-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on linus/master v6.0-rc4 next-20220909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Guittot/Add-latency-priority-for-CFS-class/20220909-210655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git fb04563d1cae6f361892b4a339ad92100b1eb0d0
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220909/202209092349.DjjxV7GB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4bdc6637b9aab44577b65686a745a14b325f4c23
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vincent-Guittot/Add-latency-priority-for-CFS-class/20220909-210655
        git checkout 4bdc6637b9aab44577b65686a745a14b325f4c23
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/sched/fair.c:727:22: warning: no previous prototype for '__pick_first_latency' [-Wmissing-prototypes]
     727 | struct sched_entity *__pick_first_latency(struct cfs_rq *cfs_rq)
         |                      ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:742:5: warning: no previous prototype for 'sched_update_scaling' [-Wmissing-prototypes]
     742 | int sched_update_scaling(void)
         |     ^~~~~~~~~~~~~~~~~~~~


vim +/__pick_first_latency +727 kernel/sched/fair.c

   726	
 > 727	struct sched_entity *__pick_first_latency(struct cfs_rq *cfs_rq)
   728	{
   729		struct rb_node *left = rb_first_cached(&cfs_rq->latency_timeline);
   730	
   731		if (!left)
   732			return NULL;
   733	
   734		return __latency_node_2_se(left);
   735	}
   736	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
