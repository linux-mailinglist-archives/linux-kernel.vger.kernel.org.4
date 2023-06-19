Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD72735CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjFSRUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjFSRUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:20:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D736194;
        Mon, 19 Jun 2023 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687195219; x=1718731219;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M8cpsIdLnXuuGWAJvDw9amJqINMPDXinMkvsofzWarg=;
  b=OgAyet8Ncy4YSguU9Ts7KSft997A0tLOtSzqufKOPHkMcM3/6cYRgoT/
   3PMFgb+g8BQgJsVyiS6nQiaXqM52tSFEkAe6+KuhrJ9Sv+1nyqjlJeGcq
   G6fP5wbnLtRGyd1D6HYrciYlZaU0/05zc3/iqQSUkkAyu+9TGChjhCG9w
   fAhwgujuneQarL/erLR84c2wgM6D+Hx2Fu0wBFPjcXSdfe87qaiXG3wvb
   RxGa30wz6oS/6oo17WBuEH1DJyME0ZIS0+eAFzRxErDqce0K8whm4Np1p
   rVEgGh128I+5nUf0pmonNZkKNXtQWAp1+x3fGvizFPYsXKs6iYn0paAKP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="363105833"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="363105833"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 10:20:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="960482500"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="960482500"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jun 2023 10:20:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B0323CC; Mon, 19 Jun 2023 20:20:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        David Lin <CTLIN0@nuvoton.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Antti Palosaari <crope@iki.fi>, Sergey Kozlov <serjk@netup.ru>,
        Abylay Ospan <aospan@netup.ru>,
        Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Akihiro Tsukada <tskd08@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 0/4] ASoC: remove copy of intlog10()
Date:   Mon, 19 Jun 2023 20:20:15 +0300
Message-Id: <20230619172019.21457-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first three patches moves intlog10() to be available in entire
kernel. The last one removes copy of it in one driver. Besides already
good Lines of Code (LoC) statistics the upcoming users, if any, can
utilize the exported functions.

The series can be routed either via ASoC tree or media tree.

Note, int_log.h is separated from math.h due to licensing.
I dunno if we can mix two in a single header file. In any
case we may do it later on.

Andy Shevchenko (4):
  lib/math: Move dvb_math.c into lib/math/int_log.c
  lib/math/int_log: Use ARRAY_SIZE(logtable) where makes sense
  lib/math/int_log: Replace LGPL-2.1-or-later boilerplate with SPDX
    identifier
  ASoC: nau8825: Replace copied'n'pasted intlog10()

 Documentation/driver-api/media/dtv-common.rst |  2 +-
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
 32 files changed, 45 insertions(+), 150 deletions(-)
 rename include/{media/dvb_math.h => linux/int_log.h} (63%)
 rename drivers/media/dvb-core/dvb_math.c => lib/math/int_log.c (84%)

-- 
2.40.0.1.gaa8946217a0b

