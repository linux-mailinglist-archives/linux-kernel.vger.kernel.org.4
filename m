Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192AF6E78DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjDSLp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjDSLp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:45:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EF3196
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B41CE63E04
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53D3C433EF;
        Wed, 19 Apr 2023 11:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681904754;
        bh=0EimNkwL3NzqPyYJdRFVT8tpM9/mvdkOg05MG6AIYZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=pjoRgABhi15Q0t2nLYVz7bbdt2nxD+ZqRwMiJdIXKyGO2bRFnAHrSY25L/Eg27VA3
         f6X3o0Wz6jRwJOQ/kmwX/BwgATGbM1qMyiZSAcnIKE5naPS/i57iL2t0DyP85zNDXw
         liX5LuRkHVFxPSC2ySeZ/+MCRvILg4M7IhYLidYdPLuhd0ez8XJcH1wX3CL3fDyX+5
         t6VIkE/MHK8u1id89Mw22aj2rM7sv+rDkAU9G0G2eK/I3YqVQhJXyAx3R0qn3WjdOJ
         7jxKOY3sSvs7aNsJcXAPyvrU9idhAw5xeTOnm8WfNXe9RnhSPXXhWJu5YKAl32kNKG
         CVpBjkrmrk88Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Lin <CTLIN0@nuvoton.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Peter Rosin <peda@axentia.se>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] ASoC: nau8825: fix delay time range check
Date:   Wed, 19 Apr 2023 13:45:39 +0200
Message-Id: <20230419114546.820921-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang points out that the recently added range check is nonsensical:

sound/soc/codecs/nau8825.c:2826:31: error: overlapping comparisons always evaluate to false [-Werror,-Wtautological-overlap-compare]
        if (nau8825->adc_delay < 125 && nau8825->adc_delay > 500)
            ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~

The DT binding document confirms that the intention is to warn if
it's outside of the 125..500 range, so do that instead.

Fixes: fc0b096c9291 ("ASoC: nau8825: Add delay control for input path")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/nau8825.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index c4389f5fe603..f4eb999761a4 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -2823,7 +2823,7 @@ static int nau8825_read_device_properties(struct device *dev,
 	ret = device_property_read_u32(dev, "nuvoton,adc-delay-ms", &nau8825->adc_delay);
 	if (ret)
 		nau8825->adc_delay = 125;
-	if (nau8825->adc_delay < 125 && nau8825->adc_delay > 500)
+	if (nau8825->adc_delay < 125 || nau8825->adc_delay > 500)
 		dev_warn(dev, "Please set the suitable delay time!\n");
 
 	nau8825->mclk = devm_clk_get(dev, "mclk");
-- 
2.39.2

