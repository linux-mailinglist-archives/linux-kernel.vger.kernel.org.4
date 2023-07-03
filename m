Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774D6745DCF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjGCNw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGCNw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:52:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E638E58;
        Mon,  3 Jul 2023 06:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688392345; x=1719928345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d7GySrGTjr8ZNAoiest4xrB1TTCUEMZaaC1CRETXOOo=;
  b=FBb5wQWs6EIBby+7ju/n0GLWoXmdi5adiPfzkecNuRPgtUtSN0Z9XIts
   kHTG2OYlPpbp1uvXfIjJ4ehndOZKNiE3Yym/UFgoPt0mTVZ5a477jBgbr
   AMoxDAaWgkFRMq9VFwMEe8YFYLeVmAkTioo5J/IH0T15bCDx8HtKaYbOP
   m+PQT46fZ96V92inKQvIfeyaQ+oWhzAQNsr7Uk86OGoSWyejI9FCQvnyZ
   OmFi720uLUBEkjBji7+rN0EpBrHw21t7kW+I+1/t8X0Bx1GNXTyZdkTBE
   ow1TXFe4hN+glO+ZsiPpNFxiT8PqjttzTzoZwbDjCuG4EgULCENE/BpdW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="365457290"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="365457290"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 06:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="721773868"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="721773868"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2023 06:52:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ADCC9170; Mon,  3 Jul 2023 16:52:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        David Lin <CTLIN0@nuvoton.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Antti Palosaari <crope@iki.fi>,
        Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>,
        Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Akihiro Tsukada <tskd08@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 0/4] ASoC: remove copy of intlog10()
Date:   Mon,  3 Jul 2023 16:52:07 +0300
Message-Id: <20230703135211.87416-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first three patches moves intlog10() to be available in entire
kernel. The last one removes copy of it in one driver. Besides already
good Lines of Code (LoC) statistics the upcoming users, if any, can
utilize the exported functions.

The series can be routed via ASoC tree (as Mauro suggested).

Note, int_log.h is separated from math.h due to licensing.
I dunno if we can mix two in a single header file. In any
case we may do it later on.

Changelog v2:
- moved kernel doc inclusion to the generic place (Mauro)
- added tags (Mauro, Mark)

Andy Shevchenko (4):
  lib/math: Move dvb_math.c into lib/math/int_log.c
  lib/math/int_log: Use ARRAY_SIZE(logtable) where makes sense
  lib/math/int_log: Replace LGPL-2.1-or-later boilerplate with SPDX
    identifier
  ASoC: nau8825: Replace copied'n'pasted intlog10()

 Documentation/core-api/kernel-api.rst         |  7 +-
 Documentation/driver-api/media/dtv-common.rst |  9 --
 drivers/media/dvb-core/Makefile               |  2 +-
 drivers/media/dvb-frontends/af9013_priv.h     |  2 +-
 drivers/media/dvb-frontends/af9033_priv.h     |  2 +-
 drivers/media/dvb-frontends/cxd2820r_priv.h   |  2 +-
 drivers/media/dvb-frontends/cxd2841er.c       |  2 +-
 .../cxd2880/cxd2880_tnrdmd_dvbt2_mon.c        |  2 +-
 .../cxd2880/cxd2880_tnrdmd_dvbt_mon.c         |  2 +-
 .../media/dvb-frontends/cxd2880/cxd2880_top.c |  2 +-
 drivers/media/dvb-frontends/dib7000p.c        |  2 +-
 drivers/media/dvb-frontends/dib8000.c         |  2 +-
 drivers/media/dvb-frontends/dib9000.c         |  2 +-
 drivers/media/dvb-frontends/drxk_hard.c       |  2 +-
 drivers/media/dvb-frontends/lgdt3305.c        |  2 +-
 drivers/media/dvb-frontends/lgdt3306a.c       |  2 +-
 drivers/media/dvb-frontends/lgdt330x.c        |  2 +-
 drivers/media/dvb-frontends/m88ds3103_priv.h  |  2 +-
 drivers/media/dvb-frontends/mn88443x.c        |  2 +-
 drivers/media/dvb-frontends/mn88472_priv.h    |  2 +-
 drivers/media/dvb-frontends/mn88473_priv.h    |  2 +-
 drivers/media/dvb-frontends/or51132.c         |  2 +-
 drivers/media/dvb-frontends/or51211.c         |  2 +-
 drivers/media/dvb-frontends/rtl2830_priv.h    |  2 +-
 drivers/media/dvb-frontends/rtl2832_priv.h    |  2 +-
 drivers/media/dvb-frontends/si2165.c          |  2 +-
 drivers/media/dvb-frontends/stv0367.c         |  2 +-
 drivers/media/dvb-frontends/tc90522.c         |  2 +-
 drivers/media/dvb-frontends/tda10048.c        |  2 +-
 include/{media/dvb_math.h => linux/int_log.h} | 18 +---
 lib/math/Makefile                             |  2 +-
 .../dvb-core/dvb_math.c => lib/math/int_log.c | 26 ++----
 sound/soc/codecs/nau8825.c                    | 93 +------------------
 33 files changed, 49 insertions(+), 160 deletions(-)
 rename include/{media/dvb_math.h => linux/int_log.h} (63%)
 rename drivers/media/dvb-core/dvb_math.c => lib/math/int_log.c (84%)

-- 
2.40.0.1.gaa8946217a0b

