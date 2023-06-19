Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A2A735CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjFSRU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjFSRUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:20:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ABFB2;
        Mon, 19 Jun 2023 10:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687195220; x=1718731220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bEqeDD3qlJ8khKucahwjiIUNYJkrQelnvBDmHsOyzeg=;
  b=LrjxG/YMpV2mNCBu8ud282VtY3Z5fe9/VmNor8Jwcigy7CgTQ0ANtnd6
   dj1RL8zB/nMmyv/Tw3UgRyO2biYKlSEkrh3funj2YydqATn+ZcaZQtRy8
   qGQJwOOtWEwwh4DiOJIb5NBHtsKuNYOVrFCsOSlNEDCUjQgRU4xUDAW5N
   WE8NGf9QH36Fo8Hqp391nbAKZfZDEcSRZLoLaYkvAakwFFm4aMvMo7m3u
   CycKxI6S0czuE9XYH4kcX7bqN34NAm8ik6a6SZt0VP9xJ80iEfPx3hc/E
   Evo4KyCSyV9ZRMpr5E8FZoDYhBJifrAqkwfpokXm5F/l/5aFPRWMgshq/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="363105850"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="363105850"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 10:20:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="960482501"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="960482501"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jun 2023 10:20:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A68BE40F; Mon, 19 Jun 2023 20:20:23 +0300 (EEST)
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
Subject: [PATCH v1 2/4] lib/math/int_log: Use ARRAY_SIZE(logtable) where makes sense
Date:   Mon, 19 Jun 2023 20:20:17 +0300
Message-Id: <20230619172019.21457-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230619172019.21457-1-andriy.shevchenko@linux.intel.com>
References: <20230619172019.21457-1-andriy.shevchenko@linux.intel.com>
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

Use ARRAY_SIZE(logtable) where makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/math/int_log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/math/int_log.c b/lib/math/int_log.c
index 322df25a22d6..ea98fc0b3fe2 100644
--- a/lib/math/int_log.c
+++ b/lib/math/int_log.c
@@ -91,7 +91,7 @@ unsigned int intlog2(u32 value)
 	 *	so we would use the entry 0x18
 	 */
 	significand = value << (31 - msb);
-	logentry = (significand >> 23) & 0xff;
+	logentry = (significand >> 23) % ARRAY_SIZE(logtable);
 
 	/**
 	 *	last step we do is interpolation because of the
@@ -109,7 +109,7 @@ unsigned int intlog2(u32 value)
 	 *	logtable_next is 256
 	 */
 	interpolation = ((significand & 0x7fffff) *
-			((logtable[(logentry + 1) & 0xff] -
+			((logtable[(logentry + 1) % ARRAY_SIZE(logtable)] -
 			  logtable[logentry]) & 0xffff)) >> 15;
 
 	/* now we return the result */
-- 
2.40.0.1.gaa8946217a0b

