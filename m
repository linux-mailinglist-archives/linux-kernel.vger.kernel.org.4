Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49531745DDA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjGCNwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjGCNwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:52:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D4E69;
        Mon,  3 Jul 2023 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688392354; x=1719928354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yiDh5WIcW2KT2120kFMdLbZdsriKf6EVEQj+JVu7p4Q=;
  b=ZeUGsoQqoY1NDxeoI7D1N0FbIbu3vBG3FcmCGST+pV33wUDoFo5DW1UD
   dK2wFRWkEwVLGbQmBrvUtKf7dcEoND3sNmxX6ZD+MY5BwMRfipgcERnkA
   GtSOhukNxOO1mybwEphBeJKmEdMozWZuSxhxo0veFPwesdhRdXY6RWLS6
   chzsRt988eEDZksgWGtM1laVIplzwNoTYswWxDAspWw5weLdKkr0fznmB
   hJTUAtnpTFx3ISXZVHuzIo3lYUE25hoZN2kPSescorj4o8BNhV2aQNOzG
   oBv//TCEoVop9AGKmPfBym1+tRxqx39wU6BCzwtFEUrcPTTM6eWaV4cBd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="347673035"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="347673035"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 06:52:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="863093278"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="863093278"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2023 06:52:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E5C3C177; Mon,  3 Jul 2023 16:52:29 +0300 (EEST)
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
Subject: [PATCH v2 2/4] lib/math/int_log: Use ARRAY_SIZE(logtable) where makes sense
Date:   Mon,  3 Jul 2023 16:52:09 +0300
Message-Id: <20230703135211.87416-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703135211.87416-1-andriy.shevchenko@linux.intel.com>
References: <20230703135211.87416-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ARRAY_SIZE(logtable) where makes sense.

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Link: https://lore.kernel.org/r/20230619172019.21457-3-andriy.shevchenko@linux.intel.com
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

