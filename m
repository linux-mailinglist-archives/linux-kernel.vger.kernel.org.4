Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4867066710E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjALLh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjALLgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:36:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57408FD01
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673522918; x=1705058918;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mTlCGYhSJLhEo6MLNDgqqw8mFX9HYOQ2vC7ZnQjQzqg=;
  b=W+9HwDTgRwsNVT6pd1J2qr0PIDsvlhJqAptlRd3O0Ixa9sGkqxC/YxnB
   CKtubVSvoM8A6y3FvGWvSNoqqof9uu4nwr8kbQ1A9XzR92vvkXsvlJvQi
   kEZ5Qm6VPc/mBpEXK7nIKMu8Z6HjY11L7o78bfmOzgYM+u7NeaBUKHKWz
   fEq+wNQyhhnBclaG64jJW8ohc7H0ZtpOPp/bGJA81wEn5fws3V8OUPrYw
   TSjofDJ+7K3tqFieInMMVOLOIcxFTPROoVyZL94cknHWrGcVPkSxviqyK
   GhGXD9Iy6cKJSS/5VbEujDttMRoM8ZRZ8BYjFtYQ5r3MqoLwgit23WKfE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="385994969"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="385994969"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 03:28:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="986519416"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="986519416"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jan 2023 03:28:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 622F0130; Thu, 12 Jan 2023 13:28:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/5] ASoC: Intel: Balance ACPI device refcount
Date:   Thu, 12 Jan 2023 13:28:47 +0200
Message-Id: <20230112112852.67714-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking for the open coded put_device(&adev->dev) cases, where
adev stands for ACPI device, I noticed that in a few ASoC Intel driver,
among others, the refcount is not balanced properly in some cases.

This series fixes that issue and converts to use acpi_dev_put().

Changelog v2:
- split Intel drivers out from others (Pierre)
- sent with cover letter (Mark)

Andy Shevchenko (5):
  ASoC: Intel: bytcht_es8316: Drop reference count of ACPI device after
    use
  ASoC: Intel: bytcr_rt5651: Drop reference count of ACPI device after
    use
  ASoC: Intel: bytcr_rt5640: Drop reference count of ACPI device after
    use
  ASoC: Intel: bytcr_wm5102: Drop reference count of ACPI device after
    use
  ASoC: Intel: sof_es8336: Drop reference count of ACPI device after use

 sound/soc/intel/boards/bytcht_es8316.c | 20 ++++++++++++--------
 sound/soc/intel/boards/bytcr_rt5640.c  | 12 ++++++------
 sound/soc/intel/boards/bytcr_rt5651.c  |  2 +-
 sound/soc/intel/boards/bytcr_wm5102.c  |  2 +-
 sound/soc/intel/boards/sof_es8336.c    | 14 ++++++++------
 5 files changed, 28 insertions(+), 22 deletions(-)

-- 
2.39.0

