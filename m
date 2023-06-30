Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AD4744119
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjF3RWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjF3RWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:22:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010C9421E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688145719; x=1719681719;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZBN4991fc3Az5Y2Qu0dseNwl7x1yFt5qfZkPD0JoAOk=;
  b=le1Cu38aRUbn0TDOfW9gHqR6B+URyUWT4QThWivAX46Smz4B0ThLhZT3
   3396gT8ZyEdQUVSbdLELM7m3xpAPGKRJ72fxRM4FWhqKL6SpMZquAI1hC
   ePILzmUCGJHp/WWX+t78Futou5bsS23ctub8umNJyqAZPcWq2SwzaaPnk
   lHHmJ5UgRQbP8kwN3owurlYe0OIh1QX8xxrRhG8uiZ8XYw5MAx+3J3YKq
   M8jcqFxyAExORUwLZJATougQu0p+n2p/m0pU1+yNRZYvd/iaVh3fak7Qf
   sV/sxaMcrpr5qWpTPbraZd5fXP901bBZ5iqgaBaSek0Yii2M/up+EPamr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="342032355"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="342032355"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 10:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="711879223"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="711879223"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2023 10:21:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CB225358; Fri, 30 Jun 2023 20:21:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 0/4] ASoC: rt5677: Refactor GPIO and use device_get_match_data()
Date:   Fri, 30 Jun 2023 20:21:51 +0300
Message-Id: <20230630172155.83754-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code can be simplified with refactored GPIO parts and with use of
device_get_match_data(). Besides that couple of additional changes,
one for maintenance and one for making IRQ domain agnostic (not being
pinned to OF).

Changelog v2:
- refactored GPIO code in (a new) patch 1
- fixed compilation error in patch 2 (LKP)

Andy Shevchenko (4):
  ASoC: rt5677: Refactor GPIO support code
  ASoC: rt5677: Use agnostic irq_domain_create_linear()
  ASoC: rt5677: Use device_get_match_data()
  ASoC: rt5677: Sort headers alphabetically

 sound/soc/codecs/rt5677.c | 117 +++++++++++++-------------------------
 sound/soc/codecs/rt5677.h |  92 +++++-------------------------
 2 files changed, 53 insertions(+), 156 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

