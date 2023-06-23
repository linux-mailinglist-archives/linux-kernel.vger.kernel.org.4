Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A731373AF4A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjFWEOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFWEOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:14:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B1B2116
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687493645; x=1719029645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pezzVGVqtBDROV1XjDruKDPfTik1gHEt+FcVzS1lrbs=;
  b=aMLOizBuTK42pxtHaLB5oCnm5cd0I8breUpreGiMsf+degFrOYbnUxql
   xZvW7XOO46IJ44g6et3gn6wcomuzO3ek5fpoSE/Oh4IEKVhwHFAEq8155
   BbkY+dM3A+3suiZIU4n5uEfrwQz76BH12nhoBc9ez3uV3MDkV9BAArxWk
   HVX3G0TGLUrOT68l/X/8p6OO/5aNxyKE0/DAI+sow8Tts6cpXWf94OQWI
   ZOGoNnTz5VF0M1g3imWAanwz0yRd3E9CrHz4sunXtRqOxGertmt5Mq1La
   o/jV7Pzw7UzIkL6ov8AAa2fG2UnewglufHQkaPwhZ4Xl/CkJwI3NdxRET
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359543346"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="359543346"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 21:14:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="665342239"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="665342239"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2023 21:13:56 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCYBH-0007yl-2f;
        Fri, 23 Jun 2023 04:13:55 +0000
Date:   Fri, 23 Jun 2023 12:13:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/12] ASoC: amd: acp: remove the redundant acp
 enable/disable interrupts functions
Message-ID: <202306231233.NynpYomQ-lkp@intel.com>
References: <20230622152406.3709231-9-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622152406.3709231-9-Syed.SabaKareem@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Syed,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on linus/master v6.4-rc7 next-20230622]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Syed-Saba-Kareem/ASoC-amd-acp-remove-acp-poweroff-function/20230622-233145
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230622152406.3709231-9-Syed.SabaKareem%40amd.com
patch subject: [PATCH 05/12] ASoC: amd: acp: remove the redundant acp enable/disable interrupts functions
config: i386-buildonly-randconfig-r006-20230622 (https://download.01.org/0day-ci/archive/20230623/202306231233.NynpYomQ-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230623/202306231233.NynpYomQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306231233.NynpYomQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: acp_enable_interrupts
   >>> referenced by acp-renoir.c:191 (sound/soc/amd/acp/acp-renoir.c:191)
   >>>               sound/soc/amd/acp/acp-renoir.o:(renoir_audio_probe) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: acp_disable_interrupts
   >>> referenced by acp-renoir.c:202 (sound/soc/amd/acp/acp-renoir.c:202)
   >>>               sound/soc/amd/acp/acp-renoir.o:(renoir_audio_remove) in archive vmlinux.a
   pahole: .tmp_vmlinux.btf: Invalid argument
   ld.lld: error: .btf.vmlinux.bin.o: unknown file type

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
