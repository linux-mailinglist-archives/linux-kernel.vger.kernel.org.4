Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C417611633
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJ1PqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiJ1PqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:46:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33AF1B5764
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:46:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x2so8471988edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9dtDrkTtJDWiY55QD7A/AEXd7H01h6LFKl1oWBL6fQ=;
        b=b7KpZsfqzkutWlZGik4MAB1Tx6dfC3eHgxL5t+NdtcgaRf3bRJlJmpysb/wWaxN3uV
         O4fiJWluRqxiZGZkVAeZN95K960I3FdolJKeE6hrTrREE/C1FWpCylkLwjAnL5eUy+Rm
         cu51JQj0wsZSQz5IhNg22FlJln2wsMmaUqJKXyZgyiT7jIAh3EIEaNMUYx/fm5yK+XhH
         qD/NUodEX9yxxkKKY+s/cVr6feGYrVfzuhvT0g/lDAEJHkiXqqcIgeoa64GshzeL6c+O
         V4FxWupBqrgnm9yejdqyzW6K9Cv139uVN5D5WJNQUFm+9eWR162wnk8PPJ7a6LMlE8B6
         gDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9dtDrkTtJDWiY55QD7A/AEXd7H01h6LFKl1oWBL6fQ=;
        b=ft5QPiaHF4TFHAxt1FkaxSDeXnh8lDSGNughQwOqEnYnoTW4jY2cZT/rHgyyoCP4c8
         SAriy6hZLnaqTFP75sDJA+jdojyg9WBI+NFyoM7pi1kZZ5+cXyH9mMNmZukOqNc1VYSy
         afwUifor9EijMcu+ksGFgq9/4bGPpmJ+0bcYWImnCYwT6zFVdC59EiLlWBJv7X+CP45U
         r2TcgJxmQKgbhmFJwxOe1MfeSjhUUTy26iTZxIC9+MBimCbqd9uXKN/AKvsEzNo4v/wV
         22ElROX2styQ+4tlMpptOgfSjWa4C3LVbuAK+dhUfMMuq1eH6bL7s5Jt/PcUtAT6ceXk
         3Hjg==
X-Gm-Message-State: ACrzQf2Oqhi3HActgGDCfqhGLRVyPWh66TOPqrf/m4dRzR9rCI8lp9tu
        mQORWrIbm1VmOWmRg+3vRh0lGA==
X-Google-Smtp-Source: AMsMyM5dyCd1eEohQv62c02F5R5xcIrjosFu9rz+3oYRdB87GVstKjFzAVec4TcpCWzH0Wqqpc7mRg==
X-Received: by 2002:a50:eb05:0:b0:457:c6f5:5f65 with SMTP id y5-20020a50eb05000000b00457c6f55f65mr26705edp.311.1666971964506;
        Fri, 28 Oct 2022 08:46:04 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906309200b007a23fe14442sm2329092ejv.195.2022.10.28.08.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:46:04 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: fsl_asrc fsl_esai fsl_sai: allow CONFIG_PM=N
Date:   Fri, 28 Oct 2022 17:45:34 +0200
Message-Id: <20221028154534.112175-1-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <Y1vyMQ8Jj7/smeC6@sirena.org.uk>
References: <Y1vyMQ8Jj7/smeC6@sirena.org.uk>
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

