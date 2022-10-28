Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1890A611428
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJ1OMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJ1OMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:12:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C5A1C2F3C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:12:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fy4so13228680ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sj8HqllYMhfqKSvoQNCAihSbEuI4FzdlLzmNIw46HS4=;
        b=aSCxH4V0xWhwnLfV9pMe0XfN4ID4YAlJ0P8AuJMDr8MQsLUgliJ7DKMek2AnNfLxEF
         +2ppRP9SBmJR4ZgjRhHXuoDFBvPUp+ysV89R+Y67dKWSM4Y0v5Dt/t0MTlKsPimJ/QvN
         rXO98VseuYdpDVBiRSEIcdFxJF1u7xzWzXAjUN0lmnIbuL/tgscSTCSS/fDCfT5ZkBlz
         cIHso4eLUO6aunBIclS8lDu4VwjxEFxQbjzuY0lRT54CvhK80AwArFkgGf+m6Qjw992p
         68Nt/z1nNqEd0x9wDZYv1iSokRqTappf3lsaBaidhhkB1lvrK03uLtBMfMTGvgo4iHFF
         Vkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sj8HqllYMhfqKSvoQNCAihSbEuI4FzdlLzmNIw46HS4=;
        b=v9Xx/yRTZ23jA4ZobzdGGMko4Qo4VUxXu0Kr4Zsh6p7rMtdxB364DXrjeoMwibaE0C
         uaAon3NxvcI7Zk6U64xkYc3CItm8PyYaMvZjFkBYR4x93VPweYrEwLWXAwjuqsrfMirL
         DBXXlvBKrbPODtvzcBSrYbOTyBqrqmoeBzq+l1HD5gctgJcm5WH1XDjAMmXsFidWgIv4
         Pufd2abBLRSNH/JSaQJx8ehaSZieM5QKWZEs5p4GDFuZHvIrwjBBBsYEoAASlfUGQ5en
         koDkksffL8zjGk4O4W4zHJY1mm65D4LQi9thHEo06vxDqxaq86TzfyWSx2h3xz4X2nCO
         vddA==
X-Gm-Message-State: ACrzQf2PxGGZy3RaaLUGBbEYYujartDul7kPERCdCi1N0dvGfKfovK9E
        Dxl+foLm2CMqlu0uIW8oqf+GAk16qcQEp9LgZMk=
X-Google-Smtp-Source: AMsMyM6mA6aj5cK7n1IOR21s4CGJnScN3SYaB+eu81S/8fo6cgpjaWtiWo/dcNJNNXbaJgS8HtwxcQ==
X-Received: by 2002:a17:907:16a6:b0:78e:f140:a9b9 with SMTP id hc38-20020a17090716a600b0078ef140a9b9mr47339126ejc.502.1666966314346;
        Fri, 28 Oct 2022 07:11:54 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906300900b0073d753759fasm2241902ejz.172.2022.10.28.07.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 07:11:53 -0700 (PDT)
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
Subject: [PATCH] ASoC: fsl_asrc fsl_esai fsl_sai: allow CONFIG_PM=N
Date:   Fri, 28 Oct 2022 16:11:28 +0200
Message-Id: <20221028141129.100702-1-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
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

This commit is similar to commit 0434d3f (omap-mailbox.c).

This commit fixes:
cab04ab (ASoC: fsl_asrc: Don't use devm_regmap_init_mmio_clk)
203773e (ASoC: fsl_esai: Don't use devm_regmap_init_mmio_clk)
2277e7e (ASoC: fsl_sai: Don't use devm_regmap_init_mmio_clk)

Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
---
 sound/soc/fsl/fsl_asrc.c | 2 +-
 sound/soc/fsl/fsl_esai.c | 2 +-
 sound/soc/fsl/fsl_sai.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 44dcbf49456c..08ca410ef551 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1226,7 +1226,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	}
 
 	ret = pm_runtime_put_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0 && ret != -ENOSYS)
 		goto err_pm_get_sync;
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_asrc_component,
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index bda66b30e063..763f5f0592af 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -1070,7 +1070,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
 	regmap_write(esai_priv->regmap, REG_ESAI_RSMB, 0);
 
 	ret = pm_runtime_put_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0 && ret != -ENOSYS)
 		goto err_pm_get_sync;
 
 	/*
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 38f6362099d5..01f3463c0e47 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1149,7 +1149,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	}
 
 	ret = pm_runtime_put_sync(dev);
-	if (ret < 0)
+	if (ret < 0 && ret != -ENOSYS)
 		goto err_pm_get_sync;
 
 	/*
