Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB91611956
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJ1Re0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ1ReX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:34:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C39229E75
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:34:22 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n12so14513918eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXgFQ2AiirDn7ylvDdK02G7QYybBypCEVhzqiAXGlxg=;
        b=Scyhmj02CKM5yxBdbaYtrAYm1fwrxtc4tLIwSA/sRtHag12CtQy2AjaU2237oxsWZZ
         lop/DZe74+wPugi3WBwjHcSgWRIREq0aoa4BTgpCdh3eHEuFzCY4/zGdiV6W8Z5AbIRM
         QEAqkNt2Xj5VweRGQyCNodWQ2cr69+tVh7giqmXV+LKeahpntt6CD8KkTPWShlb1sbP3
         XpDdj7ZUkpc8KQggPzg9gv0H8NBq3KnP6z6toMt5HXEPZNtVK1fw1qTPWBE2X5srE+Bs
         vmJMbhn5+FgUDKrMLXZASwoAkXQGud+D3HMBxb0SUqHgIPpo2kG8HOUSGpdrOzXVjxxK
         h0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXgFQ2AiirDn7ylvDdK02G7QYybBypCEVhzqiAXGlxg=;
        b=yTx/VuoRQzN8MHCsII5RRKvA/r3qGIuUDnmXLtK9OgmoDixFtbPdQION9tz/HMsLS8
         NTRA+hi19NGCiof6BuetVzE3wY1//pKBclGsgWi3LgTp8ltEBk2NSzA0qKGliGEGzASS
         KShSTzRjZRu+2GfG6r/tuDunTCv5c4wymA/rcpU2xVVxMTr1pwtjwwmX23M7txAkdsPV
         AhNpI63sQduqeSe9sR8ycSDGGfy6BotorCJs3jTGHy2FKVerhk3pHt/WnOMGT1sh9rCT
         3UYjzVpyWS8O1eO6fYSlABuKseyDI/OfVUwn2XDTlJvd4z7ZVnFkWaUfhbkpUqZdqizB
         JEjA==
X-Gm-Message-State: ACrzQf0DeFMAHF/0EmeDq2b9oHiY0GfMOj/vJ2VDJJ+qo+GprfDpgK0R
        NaorKQujseswYomBZLq6PgWHbw==
X-Google-Smtp-Source: AMsMyM43tumq4AVpXyo00mGeFeYdaSFpUgltayHAirnrZ1oFPURcmdLfFC4Anm4hdUD30bsqCUmHfQ==
X-Received: by 2002:a17:907:3da2:b0:78d:3b45:11d9 with SMTP id he34-20020a1709073da200b0078d3b4511d9mr407191ejc.87.1666978460491;
        Fri, 28 Oct 2022 10:34:20 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id v8-20020a170906b00800b0078dce9984afsm2388868ejy.220.2022.10.28.10.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:34:20 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] ASoC: fsl_asrc fsl_esai fsl_sai: allow CONFIG_PM=N
Date:   Fri, 28 Oct 2022 19:34:04 +0200
Message-Id: <20221028173405.155264-1-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <Y1v68WuDck1oaVmk@sirena.org.uk>
References: <Y1v68WuDck1oaVmk@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PM=N, pm_runtime_put_sync() returns -ENOSYS
which breaks the probe function of these drivers.

Other users of pm_runtime_put_sync() typically don't check
the return value. In order to keep the program flow as
intended, check for -ENOSYS.

This commit is similar to
commit 0434d3f4525a ("mailbox/omap: Handle if CONFIG_PM is disabled")

This commit fixes
commit cab04ab5900f ("ASoC: fsl_asrc: Don't use devm_regmap_init_mmio_clk")
commit 203773e39347 ("ASoC: fsl_esai: Don't use devm_regmap_init_mmio_clk")
commit 2277e7e36b4b ("ASoC: fsl_sai: Don't use devm_regmap_init_mmio_clk")

Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 2 +-
 sound/soc/fsl/fsl_esai.c | 2 +-
 sound/soc/fsl/fsl_sai.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 936aef5d2767..e16e7b3fa96c 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1232,7 +1232,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	}
 
 	ret = pm_runtime_put_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0 && ret != -ENOSYS)
 		goto err_pm_get_sync;
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_asrc_component,
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 5c21fc490fce..17fefd27ec90 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -1069,7 +1069,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
 	regmap_write(esai_priv->regmap, REG_ESAI_RSMB, 0);
 
 	ret = pm_runtime_put_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0 && ret != -ENOSYS)
 		goto err_pm_get_sync;
 
 	/*
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 81f89f6767a2..e60c7b344562 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1446,7 +1446,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	}
 
 	ret = pm_runtime_put_sync(dev);
-	if (ret < 0)
+	if (ret < 0 && ret != -ENOSYS)
 		goto err_pm_get_sync;
 
 	/*
-- 
2.37.3

