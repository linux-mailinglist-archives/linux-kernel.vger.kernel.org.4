Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B8771F077
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjFARQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjFARQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:16:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB5EE2;
        Thu,  1 Jun 2023 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685639797; x=1717175797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zJ/eQ8hVnS5028QEn4DwKlid6LJ4fXWWbli9hnrbanc=;
  b=KbeS7LEjdxZ4YYFhmhei77T6ZMyljK8zfzI5AYBrSRo9VqiNZKY1nEC9
   6qywow4o6gWS+2tkekGTe4ogF4WeAM/ACrjRkuLLX/LP9lb7EnR/3b4Uh
   +gjpGDLjh6iaTv8E52161pcHmt+Yy1uSLrlsXEC0t5KufUHr5nl6+H04Y
   mQs/FZieUfhwBlbRa/cuZBSKNOYycf+cSHkznHNbd90UXfSjVAAdJdJtv
   reuOsoM8LM5TKhN+wzc9ODEjoeAiFJpeYwBRsCKGNd2VoTSJHih1gps4e
   Pgdwuys/N7fwO7F2cV1wXxHfKkGj+xg4St3crW/GBQWFTbnADSOwXsgq4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358922501"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="358922501"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 10:16:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="657874712"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="657874712"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2023 10:16:33 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4lua-0002WK-2j;
        Thu, 01 Jun 2023 17:16:32 +0000
Date:   Fri, 2 Jun 2023 01:15:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH 3/9] rcu: Rename jiffies_till_flush to jiffies_lazy_flush
Message-ID: <202306020110.p6f7zsig-lkp@intel.com>
References: <20230531101736.12981-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531101736.12981-4-frederic@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

kernel test robot noticed the following build errors:

[auto build test ERROR on paulmck-rcu/dev]
[also build test ERROR on linus/master v6.4-rc4 next-20230601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frederic-Weisbecker/rcu-Assume-IRQS-disabled-from-rcu_report_dead/20230531-182004
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
patch link:    https://lore.kernel.org/r/20230531101736.12981-4-frederic%40kernel.org
patch subject: [PATCH 3/9] rcu: Rename jiffies_till_flush to jiffies_lazy_flush
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20230602/202306020110.p6f7zsig-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c07a1bea9df8b80429d4e24052d83de94f5ee160
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Frederic-Weisbecker/rcu-Assume-IRQS-disabled-from-rcu_report_dead/20230531-182004
        git checkout c07a1bea9df8b80429d4e24052d83de94f5ee160
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306020110.p6f7zsig-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "rcu_get_jiffies_lazy_flush" [kernel/rcu/rcuscale.ko] undefined!
>> ERROR: modpost: "rcu_set_jiffies_lazy_flush" [kernel/rcu/rcuscale.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
