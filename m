Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A54D640BBE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiLBRG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiLBRGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:06:49 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76738E345A;
        Fri,  2 Dec 2022 09:06:48 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h11so8699344wrw.13;
        Fri, 02 Dec 2022 09:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DuvKie3Dx2KIgWNRcmW0oxZHrl+MI0NaSKfULcEr3I8=;
        b=HGiMw5fSSEK86bo28QTWOXXexS72VOF3eIa05RufmYXooCYpg+Vsf6Vh8X2wyN4Bs6
         MwzYUA2h49FXlk/FBIwVypsBzk6Zmg+sNlhKc6uCTC2bkeLHIy7Q13Su77LuR+7oHXf7
         3Bnl4CAcYGyEZHQRDd45DPzuJL/x6EUMFWfvUZ3SRz568gLzMWSPBCN7LreLVFM9S9TH
         cYW33nSiIdXolIbHhVax7b9LExJ7PLp64lG9vTWX7Sum5tbUdpCFmYOGXMRQgDJU4iPA
         AKEEt+DBoQTm0mBOIwr388Yr+hLAHiJCG87lAc1leji7PDLlTZXwBKKkm4ENGU6vFZrK
         xv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuvKie3Dx2KIgWNRcmW0oxZHrl+MI0NaSKfULcEr3I8=;
        b=em1nkLV/IneqGakLPK7gsJ1cEIhlTuQLKZiqz/Bx1hOOGIfyu3r+1fTH91W6veDYHv
         eEOXFuXnCuyGtZ2OY/lKcqsLl0n3U0QYMcT6SzU37dY3qzm3iN2xDgKPpE98j5UuN1W5
         QFJpGljXTwLo+qRCqUNjKxFT0WDK01DfjDtOHP127HW/nqV2SluTKoYgSSDWrdavdqTk
         1mSLcoim0Zm7TBIeoYP/9PFR5jLo6z9Wldk2uPs4om15DprbzpCBovbfeZZ1dxKblH9a
         75g4Oc76XnFKOtluMIgYZiMuFeveEPsJulFdoEg/CeXQ2SCmKe2Bvn9Pp38ynAO1HqOc
         AQZw==
X-Gm-Message-State: ANoB5pn0MUS8Z0FnvzblIdUvPbZTLQMj8BFosSPI7aHaCs5Lwbmx0h1p
        5w24forsi4lx8cpTSF19CqMNoF8eZTizdZSQ
X-Google-Smtp-Source: AA0mqf70wTOVwdJGdTTAZ0nkrF5y+kMmAztOCT121fxYREi9ws+qOBLZYyWqLUG5xCbHTrUzVmuz7w==
X-Received: by 2002:adf:a319:0:b0:242:45fe:740 with SMTP id c25-20020adfa319000000b0024245fe0740mr2219428wrb.408.1670000806808;
        Fri, 02 Dec 2022 09:06:46 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q1-20020a05600000c100b002422fddcc94sm6849665wrx.96.2022.12.02.09.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:06:45 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: wcd938x: Make read-only array minCode_param static const
Date:   Fri,  2 Dec 2022 17:06:44 +0000
Message-Id: <20221202170644.1814720-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array minCode_param on the stack but
instead make it static const. Also makes the object code a little
smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/wcd938x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index aca06a4026f3..fcac763b04d1 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3128,8 +3128,8 @@ static inline void wcd938x_mbhc_get_result_params(struct wcd938x_priv *wcd938x,
 	s16 c1;
 	s32 x1, d1;
 	int32_t denom;
-	int minCode_param[] = {
-			3277, 1639, 820, 410, 205, 103, 52, 26
+	static const int minCode_param[] = {
+		3277, 1639, 820, 410, 205, 103, 52, 26
 	};
 
 	regmap_update_bits(wcd938x->regmap, WCD938X_ANA_MBHC_ZDET, 0x20, 0x20);
-- 
2.38.1

