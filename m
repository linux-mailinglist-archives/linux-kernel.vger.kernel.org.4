Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68A9719CEE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjFANGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbjFANGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:06:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2E4138
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:06:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25673e8c464so287441a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685624778; x=1688216778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tm7KDaSSjYvTYPu798lAyVQ8TuXxD3ciaiRSHMe2MWI=;
        b=cRNwyrR6RhCtm54eNkfyDGqAwseqfMo+xydQcUdKy/QlVcZqFRAlkI3bQCOaN1cDu7
         9d6pDMsFJC703p+mSJAHYKXwKJfhiv+Fv6yeoln1PUPfZvi4RBw1AedgK+hc9fazXGqN
         YI4kXpD4+O6j3R5pvJzSFx9Eo50ooTzwSOI+oqFQPglxckMxS/CGqotCZCb2AQWvrlv2
         DD3BASB+s/Rnsb/Fwi5Jr2rJiCPDeA7cKgjinyR/+9l6NFzj1l5eRpN2tvDDdCMoiN99
         oqBYLUgewJAAb4/T43J0AF+fLzTPbkkB75g0c/+HahjIt0tlrAkeJVkOOfKKZfLKM7Qg
         Djzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685624778; x=1688216778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tm7KDaSSjYvTYPu798lAyVQ8TuXxD3ciaiRSHMe2MWI=;
        b=BX3l2N2ie+SSnyqGRse9x/YHiccv5GEyinnda4Gp8yzbUK4BhkWMfj2SI14HNwifCT
         zMtSVJAbOdpBhaLEpwr2nl//p1xm1rBKgQzcwCKznBlxcmFM9B7gQEr7bKRfpt0Nlxui
         zJpbQoxCfKaeUFQSpUORJiv5LZYbeih/Py8inPDvKq12H/e2UtMjTadwN4Z5wI8Rs+YJ
         RjiYran6q13AtiQSJe/qTZg5WF+Sq4eguEFN6B0vlrHT876hkLb/kGqQ669Rg2YVEsfX
         PWxW6/R6aezZk5XoF1R+XRfk7+3lqT6QIW9KxA0DmIcJOFFxJkGYwdpHCyKGuOyy1H6U
         n1og==
X-Gm-Message-State: AC+VfDxulwww7JRn2ap2tGJRJPOleuhPn1PPMfVPb9f1XX6kypxVTJgS
        h/Puyoa772oRqQ1SZXOFp5oQ8c8by00=
X-Google-Smtp-Source: ACHHUZ417r58s1N53t2yURhkDqH5J9VetxhvfpIj4hjoAzs3iSk/8iUou1gI/nCvjvcxUdqMBSoWtg==
X-Received: by 2002:a17:90a:a40e:b0:256:8cb7:2b2b with SMTP id y14-20020a17090aa40e00b002568cb72b2bmr6413171pjp.14.1685624777949;
        Thu, 01 Jun 2023 06:06:17 -0700 (PDT)
Received: from ryan-ThinkPad-T470.. (c-24-6-63-212.hsd1.ca.comcast.net. [24.6.63.212])
        by smtp.gmail.com with ESMTPSA id s34-20020a17090a2f2500b0024df6bbf5d8sm1430096pjd.30.2023.06.01.06.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 06:06:17 -0700 (PDT)
From:   =?UTF-8?q?=E2=80=9CRyan?= <ryan.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ryans.lee@analog.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     jairaj.arava@intel.com
Subject: [PATCH 1/2] ASoC: max98363: Removed 32bit support
Date:   Thu,  1 Jun 2023 06:05:59 -0700
Message-Id: <20230601130600.25344-1-ryan.lee.analog@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Lee <ryans.lee@analog.com>

MAX98363 does not support 32bit depth audio.
Removed 32bit from the supported format list.
Instead, added 16bit and 24bit to the list.

Signed-off-by: Ryan Lee <ryans.lee@analog.com>
---
 sound/soc/codecs/max98363.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98363.c b/sound/soc/codecs/max98363.c
index 4585ebb1e82c..8aa9d9c67aa2 100644
--- a/sound/soc/codecs/max98363.c
+++ b/sound/soc/codecs/max98363.c
@@ -211,7 +211,7 @@ static int max98363_io_init(struct sdw_slave *slave)
 }
 
 #define MAX98363_RATES SNDRV_PCM_RATE_8000_192000
-#define MAX98363_FORMATS (SNDRV_PCM_FMTBIT_S32_LE)
+#define MAX98363_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 
 static int max98363_sdw_dai_hw_params(struct snd_pcm_substream *substream,
 				      struct snd_pcm_hw_params *params,
-- 
2.34.1

