Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8403D6DCD90
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDJWjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjDJWjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:39:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461401BCC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:39:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v6so5687901wrv.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681166348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEW0TzE/iHLHzvHGUl4AlDs0HbakMRi0xvPaOvsk9N0=;
        b=dHR8/FV/VB9elKmpSAI11sosqQDYQcCFq6jASEZo+UpPU3+vILSJQuioDyDmtNvHXf
         8u4dnSowc6o1mn6woXbnveHCEWdNhXZXUWsoATMtaEx8nI+XRbwu1okv/F6YHrmPxH+i
         9Q0VBDJs4BVSPHPZExrlCyqKVzB+p8G8ml4/nrC3z3dqWMBi6TnQyLG9nqCP4u79xhvx
         VL+GkBPP50Ez87OC3rF+87FPDQGNOOO7XcbIU+AqzEOYMGrz1GG4RxAz4FPXcYjH1Ep/
         3nCjTZPWchY/VTI4SIERMzRrV41pHntk/4eY9P4YHTGRb67w5IjyWoy0b+TN81uaim+h
         4g2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681166348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEW0TzE/iHLHzvHGUl4AlDs0HbakMRi0xvPaOvsk9N0=;
        b=oglLmU1yZqV7XbYKkotc2nskUE3mPq7Kak+fAUKO15vVqq/9sHH2zgCkKNwj9qOixE
         GcoKheWyFN8zdeW/6yL1D+wIhiC2c9vaN5SANndeVXXGVbzLu7sc+mLYeMK4HNBHXFWy
         IqqtCtQJm0T7MhxxMGvX/Cn0ZxUm8eOXmpvWn4wD8+NE9SUVeT2+HmfZy2xFJ1/VKEj/
         nnefXiqPpHygFjdIp46JItezpGW/2Od9EeH/gpwjlBsMvFKaQJ+LTFZKYjQYCqV+uFTv
         SxNDdvtNFrbq6R0L7tyAfMhwGQ0RW2Jow58mpx9Lll/lfrgzJYuqeJpv2Y0HAoJI3xk4
         6ORg==
X-Gm-Message-State: AAQBX9ei9uu1FM1BvEtSupkrFPNywxobu22W9kFDcn+cPcpDkWvCXWzB
        IZe22th1RORWzSviBnVg9Lc=
X-Google-Smtp-Source: AKy350b+wO4MJpD+u43vMScwz8azVmGnCXgzWl1VMIGqdNN/fQ1K6gERKuwr5WmiqLpz21Q+CGs6bw==
X-Received: by 2002:adf:e785:0:b0:2ef:b21c:f6a0 with SMTP id n5-20020adfe785000000b002efb21cf6a0mr5474454wrm.53.1681166347771;
        Mon, 10 Apr 2023 15:39:07 -0700 (PDT)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id p17-20020a056000019100b002f1dc56579esm3637350wrx.2.2023.04.10.15.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 15:39:07 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        David Rhodes <david.rhodes@cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 3/3] ASoC: ep93xx: i2s: Make it individually selectable
Date:   Tue, 11 Apr 2023 00:39:02 +0200
Message-Id: <20230410223902.2321834-4-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230410223902.2321834-1-alexander.sverdlin@gmail.com>
References: <20230410223902.2321834-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is necessary to replace EDB93XX specific SoC audio driver with generic
"simple-audio-card".

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 sound/soc/cirrus/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/cirrus/Kconfig b/sound/soc/cirrus/Kconfig
index 34870c2d0cba..38a83c4dcc2d 100644
--- a/sound/soc/cirrus/Kconfig
+++ b/sound/soc/cirrus/Kconfig
@@ -8,7 +8,11 @@ config SND_EP93XX_SOC
 	  the EP93xx I2S or AC97 interfaces.
 
 config SND_EP93XX_SOC_I2S
-	tristate
+	tristate "I2S controller support for the Cirrus Logic EP93xx series"
+	depends on SND_EP93XX_SOC
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the EP93xx I2S interface.
 
 if SND_EP93XX_SOC_I2S
 
-- 
2.40.0

