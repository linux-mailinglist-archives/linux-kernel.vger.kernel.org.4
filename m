Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DA273AC82
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjFVWcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjFVWcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:32:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD932122
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 15:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687473114; x=1719009114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SDXJENEeL/bpt6xMsVy0rg9NPjTbCICx2LYe2RbgEZ0=;
  b=F9KompVMCsBo8TzqkCSb2YZGlgm46vy8dioL7gVG/NkH7sYDIGI521Up
   K6u4WHqu+mYUL66nMtQq76rQnuM6UwYF3zOwl620uPh9R+M7SqN8o8nSt
   uiaMsKbMxaLFi5P2Z2FFkC8ggtv6ZNH/XRr12dbkemzI62rNJfyjchGY4
   Rzf53/sfHEugTvmMsAwVyUJu6woGdMoUF/NmBNA3c6F1cTRrXZoxkexpO
   fEiV5A+V+HxPyiVYrHORgOPC5Edl+2gypUuWQdDlBRwjUXpxaeSDS8XIJ
   5pUAYaG223T1f6Q9QbmJDpyu+ZBf2RDVqXBCy5BJQx5Sc5SYlQ5fu5A6N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="390494727"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="390494727"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 15:31:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="961750214"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="961750214"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2023 15:31:47 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCSqB-0007nH-0c;
        Thu, 22 Jun 2023 22:31:47 +0000
Date:   Fri, 23 Jun 2023 06:30:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     oe-kbuild-all@lists.linux.dev, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] ASoC: amd: acp: add acp i2s master clock
 generation for rembrandt platform
Message-ID: <202306230648.6X3y3ujR-lkp@intel.com>
References: <20230622152406.3709231-7-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622152406.3709231-7-Syed.SabaKareem@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Syed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.4-rc7 next-20230622]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Syed-Saba-Kareem/ASoC-amd-acp-remove-acp-poweroff-function/20230622-233145
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230622152406.3709231-7-Syed.SabaKareem%40amd.com
patch subject: [PATCH 04/12] ASoC: amd: acp: add acp i2s master clock generation for rembrandt platform
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230623/202306230648.6X3y3ujR-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230623/202306230648.6X3y3ujR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306230648.6X3y3ujR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/amd/acp/acp-rembrandt.c:169:5: warning: no previous prototype for 'acp6x_master_clock_generate' [-Wmissing-prototypes]
     169 | int acp6x_master_clock_generate(struct device *dev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/acp6x_master_clock_generate +169 sound/soc/amd/acp/acp-rembrandt.c

   168	
 > 169	int acp6x_master_clock_generate(struct device *dev)
   170	{
   171		int data = 0;
   172		struct pci_dev *smn_dev;
   173	
   174		smn_dev = pci_get_device(PCI_VENDOR_ID_AMD, HOST_BRIDGE_ID, NULL);
   175		if (!smn_dev) {
   176			dev_err(dev, "Failed to get host bridge device\n");
   177			return -ENODEV;
   178		}
   179	
   180		smn_write(smn_dev, MP1_C2PMSG_93, 0);
   181		smn_write(smn_dev, MP1_C2PMSG_85, 0xC4);
   182		smn_write(smn_dev, MP1_C2PMSG_69, 0x4);
   183		read_poll_timeout(smn_read, data, data, DELAY_US,
   184				  ACP_TIMEOUT, false, smn_dev, MP1_C2PMSG_93);
   185		return 0;
   186	}
   187	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
