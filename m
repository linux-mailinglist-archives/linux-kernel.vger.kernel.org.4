Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ECC72BBC8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjFLJLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjFLJLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:11:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC0859DA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:06:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977d7bdde43so843011766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686560767; x=1689152767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7+T9ror82USLosqb+kMl4rjrjfhje49/ZyOCNXi7ko=;
        b=JKzEkLKynaeNnaDVnKlCrW+rJ6NPX6yrmcjLwwFMzvrx+LGGoTZ46EYY9KmOQw5xDf
         L5ZAn2nVbhCbw7Q97Yeh089Uchbr+imzUnZk19tHLCuR8gJOGIiYQ+jkbvUXFX7hmqPR
         AUrQNYN6RKc4XrTUhbOWzTLCuBvZUJstuDZ7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686560767; x=1689152767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7+T9ror82USLosqb+kMl4rjrjfhje49/ZyOCNXi7ko=;
        b=NkcPBoE9kbK5tpM/BZ/5R8nBctlKDQZvHRE4qJ3empQrRH7YM12k0vSvYTGYcMWu81
         wr+KOzx5tHkHSz/mrHXebnsgBaz1UKzgwwWqGFG6OMJOnQAtFpjS3N99cIbW8wiRiM2M
         lmN0fn1uK4/Wv/yksbuzx0ctNwFvCi5C/CKPP/enYg86Wna6+xtGI28bawS5aBtfrQWD
         usu81k5DM1usmxY3XNa1DCLpFYJCSModvkVXEFX05mXi1GNY1CEdnj2+pJgyyuvBZj7x
         xVR72D9jaDynBj9vFo/0wS0A3NZEj8sWqrhA0eTzMAp1y8Dh0Lb7k1zPJfAesZdn1hYI
         JkVg==
X-Gm-Message-State: AC+VfDxcFDSqBFk2+r8h4EMF+pFv1pY9BgRqDnsy/3rC9fkft/w7/yXN
        JW3X22M46fKr1YvooSNuiATv9g==
X-Google-Smtp-Source: ACHHUZ5InuqYeOZy5I+/X3fsLat/TnUkv5PBIlf5CBZNkJRYvqzQiZVsCvIG7tT/Degh88f2AnjcCw==
X-Received: by 2002:a17:906:9751:b0:96f:c545:6fd with SMTP id o17-20020a170906975100b0096fc54506fdmr8866911ejy.10.1686560766808;
        Mon, 12 Jun 2023 02:06:06 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:82e9:e3cf:d6f0:4c6a])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709061d4a00b0096a742beb68sm4867275ejh.201.2023.06.12.02.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:06:06 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@chromium.org>
Date:   Mon, 12 Jun 2023 11:05:31 +0200
Subject: [PATCH v2 1/2] ASoC: mediatek: mt8173: Fix
 snd_soc_component_initialize error path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230612-mt8173-fixup-v2-1-432aa99ce24d@chromium.org>
References: <20230612-mt8173-fixup-v2-0-432aa99ce24d@chromium.org>
In-Reply-To: <20230612-mt8173-fixup-v2-0-432aa99ce24d@chromium.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Ricardo Ribalda Delgado <ribalda@chromium.org>,
        Dan Carpenter <dan.carpenter@linaro.org>, stable@kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=jo+X8uO9gXWIQ4Yp4MLiXi4sgrrGbroD4LCNGNV+4M4=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkht/4yUvNcHG35BG/KrFS5PrlpHzlqdRlErE+H
 JfuJwL5SciJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZIbf+AAKCRDRN9E+zzrE
 iG8SD/4qf+ADY8vriM5ijaza7D/izE7k3S+iQQf8OA2OdmLDusxEwt0iCSonmOkAQndcQwzS0GH
 jEY3n8wpzqw0Ze01VbE8RQrERCr6UKBTO/6gtNyyqLC/pDjNdX7RTNk+QLMONTchv5luMdp6vdJ
 KkbwJGHlL+us+x3zasP1S8fTsg6m9OmhUNV2CYa/yBw4WaZu4qTA5xN76h2enS00k9Z/qFDHKQl
 mnDMs0H8HeMaZStjyC2oFscPcjaH0CNtGNnbRdXDBGotVAHH5QnTc3bakku8J2YBIVrgzhIag5i
 EjzQ2FM9adCpfKPPUnFW+LgHyfMjPgttDv0icRtzHqp7B8KDPZYuzUYlu2Iy8VsImCjklQAtvzu
 iOrymbnM98iYTzMX6G2BFyofM2ntQoINlib58d6Ud/eROQ9/MGpWyVTqjDC9vb3A+8L8Y5UIi8q
 WqytQosaCOH+4DFyTY0a0cnQlN+x9p333zBrcI1J09EKREZyaesS6WiUipncrOxUdMwjMPYjS+/
 33D2atsdtmdjIB9GElht1KH3ziKp6hVjoWbywTW677Rv7OHNDoTbMmI6+jOjqIyRj6awpZNctaW
 i7XKRgC+8yknqBXjUxyYeBy5z5FDEGPOz/9hRbv5FTiG4hnUqwmtvRVnSygWxg0VD25jxUrenM8
 6F60DksxzEzPdKA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the second component fails to initialize, cleanup the first on.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stable@kernel.org
Fixes: f1b5bf07365d ("ASoC: mt2701/mt8173: replace platform to component")
Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
---
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index f93c2ec8beb7..ff25c44070a3 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1156,14 +1156,14 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 	comp_hdmi = devm_kzalloc(&pdev->dev, sizeof(*comp_hdmi), GFP_KERNEL);
 	if (!comp_hdmi) {
 		ret = -ENOMEM;
-		goto err_pm_disable;
+		goto err_cleanup_components;
 	}
 
 	ret = snd_soc_component_initialize(comp_hdmi,
 					   &mt8173_afe_hdmi_dai_component,
 					   &pdev->dev);
 	if (ret)
-		goto err_pm_disable;
+		goto err_cleanup_components;
 
 #ifdef CONFIG_DEBUG_FS
 	comp_hdmi->debugfs_prefix = "hdmi";

-- 
2.41.0.162.gfafddb0af9-goog

