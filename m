Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFDC6ED113
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjDXPN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDXPNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:13:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830B119F;
        Mon, 24 Apr 2023 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682349234; x=1713885234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=frhCaQHz/0+SvLWssH9RMMeJzPVGe5R5XNjt8rhsOKc=;
  b=Kquv+soqcrtifWZgGebbAFGGCwiTcJqzlNIE50d35HN1raMHAAtymkJh
   NgVBNa5Mt8EaRbAK7jIz3MZ5BJia7SIFphJZlMz8EjzxY3zMxTfDOUfOI
   YtE0goqbX4K8EmoVZPcwv9xNOqZqYdMqfwtcVXBQ+TAcFWF0THzTBwSOv
   rpERsFinAspnxjtg5XqAy+/eqyb7JJ3eVW9FohCsuLz/7ctHQHXWtL/ta
   VzAB16ATJxiAPEx/n/7GrJo9ISJoNM4JhLeCPGxHvqdfjdpQ5UA/wiHXF
   LhqIk2kg49/M9hv2lJzPlPxFLd0tmOM7tZaGCTURFd/JCHip8eA3bzqJk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="345234160"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="345234160"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:13:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="723617191"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="723617191"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 24 Apr 2023 08:13:51 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqxt1-000iSG-05;
        Mon, 24 Apr 2023 15:13:51 +0000
Date:   Mon, 24 Apr 2023 23:13:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        Shyam-sundar.S-k@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: x86: Separate out the Microsoft _DSM function calls
Message-ID: <202304242231.68KXGyif-lkp@intel.com>
References: <20230420160923.14127-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420160923.14127-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7124d7671af0facf115d70f9d1fadde0d768d325]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-x86-Separate-out-the-Microsoft-_DSM-function-calls/20230421-001547
base:   7124d7671af0facf115d70f9d1fadde0d768d325
patch link:    https://lore.kernel.org/r/20230420160923.14127-1-mario.limonciello%40amd.com
patch subject: [PATCH] ACPI: x86: Separate out the Microsoft _DSM function calls
config: i386-randconfig-s003 (https://download.01.org/0day-ci/archive/20230424/202304242231.68KXGyif-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/e4ea0d2f15f2d0486bc3b4f59cbf9cea6c63fda1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/ACPI-x86-Separate-out-the-Microsoft-_DSM-function-calls/20230421-001547
        git checkout e4ea0d2f15f2d0486bc3b4f59cbf9cea6c63fda1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304242231.68KXGyif-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/acpi/x86/s2idle.c:479:13: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/acpi/x86/s2idle.c:479:33: sparse: sparse: restricted suspend_state_t degrades to integer
>> drivers/acpi/x86/s2idle.c:552:6: sparse: sparse: symbol 'lps0_s2idle_wake' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
