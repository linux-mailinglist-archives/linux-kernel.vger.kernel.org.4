Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FD260DBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiJZHQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZHQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:16:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F012D900EF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666768616; x=1698304616;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vVzu7eTnrwZ2NcZHoP8HWV3sYW9l/QA0ML8mjfjBHiI=;
  b=Ecgye1FF6rOqg3zJS5sxYwpuEHsPAhDEQ8LmoN7GTB7XcI8QqrBNFFWA
   JJl/ERd5Ao5sfG9cbccenPlTqPPdM3LTdfjGQnsOAmY2Tsq7AThp718dj
   ifwR63voQctsJP623TEuvz6AM3SAahTQ5Yx+4+QDImdIfl/vOpmpFC/Un
   Al3tRDEUbgyrqXgH6wBLF2WzAu5FNm9xxXs7tKHA6H5xjMbVPAOKU1Abb
   ryamNleDOBL9TEzU2dW1DBZ0a+r7PvUejdhp5qdfE/p9DJAfJlRbg3XtC
   1SVcQusxJ6wQB8NbwrrxeS5iNurc0pI1/UuQOGnSwu9bS2t1xYUp4oGLQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="309568970"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="309568970"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 00:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="663096896"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="663096896"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2022 00:16:52 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Yong Zhi <yong.zhi@intel.com>,
        Ajye Huang <ajye.huang@gmail.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Chao Song <chao.song@linux.intel.com>
Subject: [PATCH 0/2] ASoC: Intel: sof_rt5682: quirk auto detection
Date:   Wed, 26 Oct 2022 15:14:07 +0800
Message-Id: <20221026071409.3235144-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new feature to compose quirk value according to the result of
amplifier and SoC type detection at runtime.

Brent Lu (2):
  ASoC: Intel: add helpers to detect SoCs
  ASoC: Intel: sof_rt5682: quirk auto detection

 include/linux/platform_data/x86/soc.h         |  24 +++
 sound/soc/intel/boards/sof_rt5682.c           | 173 +++++++-----------
 .../intel/common/soc-acpi-intel-adl-match.c   |  12 +-
 .../intel/common/soc-acpi-intel-jsl-match.c   |   6 +-
 .../intel/common/soc-acpi-intel-tgl-match.c   |   6 +-
 5 files changed, 101 insertions(+), 120 deletions(-)

-- 
2.25.1

