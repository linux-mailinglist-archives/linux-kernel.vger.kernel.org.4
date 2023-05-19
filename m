Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B1F709045
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 09:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjESHRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 03:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjESHRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 03:17:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01093E6E;
        Fri, 19 May 2023 00:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684480626; x=1716016626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ruhXfckvLspilVJ3phWpSekvwmW04n6cod92Xsdx9rw=;
  b=GZijsJFhZqgtSoeUukdpQKV6OoD03TNzwRADhELcT5qJHj/+Lwh+mQQT
   33ECol+vVKUmgNv+NsHwQ/YiZ+aW02zdSPgRO7LGtdeEtHDONbIb4CjIr
   08QgVxjsY4XfNHr8yj8mWWBjFgZTIFZkVKLjL0cIcpu3MLvVhbP/RSTBn
   f7lfi7+nQJ+S5HvDFecsi5LC6aZciYOMIhyH9w4PWCyH72DdK8aPbfGyA
   uprbhF7J+5tbtRd8QJ3425O8oio1KsYbIe9aDHC+GeBjGBL7HLEScQOeK
   C0O5KLq8lSeuXvvQP6wrWM5D9tVlJKYQqycmIKJCg8S9ceeVVYkCZYCwc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="380515528"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="380515528"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 00:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="826692519"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="826692519"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 May 2023 00:17:02 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pzuMI-000Ag2-09;
        Fri, 19 May 2023 07:17:02 +0000
Date:   Fri, 19 May 2023 15:16:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org,
        hdegoede@redhat.com, linus.walleij@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        Shyam-sundar.S-k@amd.com, Basavaraj.Natikar@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/4] ACPI: x86: Add pm_debug_messages for LPS0 _DSM state
 tracking
Message-ID: <202305191405.u2HzFqxM-lkp@intel.com>
References: <20230518172752.93322-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518172752.93322-3-mario.limonciello@amd.com>
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

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dac0c6388ff86af74dc6f4dd6e90a7db5a429e3d]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/include-linux-suspend-h-Only-show-pm_pr_dbg-messages-at-suspend-resume/20230519-013031
base:   dac0c6388ff86af74dc6f4dd6e90a7db5a429e3d
patch link:    https://lore.kernel.org/r/20230518172752.93322-3-mario.limonciello%40amd.com
patch subject: [PATCH 2/4] ACPI: x86: Add pm_debug_messages for LPS0 _DSM state tracking
config: x86_64-randconfig-c022 (https://download.01.org/0day-ci/archive/20230519/202305191405.u2HzFqxM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305191405.u2HzFqxM-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/acpi/x86/s2idle.c:345:3-4: Unneeded semicolon

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
