Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C3D72BBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjFLJLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjFLJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:11:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31C359E0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:06:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5151934a4e3so6093657a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686560768; x=1689152768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kY+WBQ4nCNMkOm+dsWka5XZ07KlSQo9hmsWmmoRsa2U=;
        b=D/FV+MyUBaCM3IKM4xkwpx9FWzBrg6NGsYOcVTfAQJTPdosotXa3jIfj/+r38tQxI+
         7+ldoE/VbKwiDBVYZ5HDh6ED+ZnbXiXVjVUcxRy9uhra3dRevtgTMI+T+zGVeU4XpEag
         WVWd1n2zMl9LSMBxCJbzIqMlkTSr+eReQJVPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686560768; x=1689152768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kY+WBQ4nCNMkOm+dsWka5XZ07KlSQo9hmsWmmoRsa2U=;
        b=P87pKbgqzuwfneU6NEERTK1tFIMz8xX8i7ybBTonZXWXhHS/hKlgo+65DkvAzs0OvM
         TbS+GrEcEm0/JLixTBdcuJJjwF6P0ohA2dMFvppwwI1MRbiXyRPHvtackNPtgMGPgooY
         J3pvZOk64pQrE93lI9XoTr7q/3nkDKmiAc83pxqKvgxrHWX1zRoqu4B9eD+rVx4tQlbN
         63ehMf/j6RtZKgnR49KkC+ktCORiALad0S01d9+ctzIiYZHOy0a2Gfe7gwuI4u+w5W0V
         KYJ/Vt30vGh54nLCkQrhs4TPBELpEM/463WWIq7X126DRnw2fmDx+feL5v6BneAFfvdF
         HdgQ==
X-Gm-Message-State: AC+VfDzvVcby5fvpMQ/a1bsJy6hSLz2QI6yPROBosWlLcuKpwUUei/x/
        0TxhQemAIAnnumo63BxGHJdDBA==
X-Google-Smtp-Source: ACHHUZ7a8jPTUOkb1YxMy6Q3DErGRuymN9KwkCEHdB9Brblou3evSACnVlv+NKkp5rTB5TcjBWoPVg==
X-Received: by 2002:a17:906:eec3:b0:96a:63d4:2493 with SMTP id wu3-20020a170906eec300b0096a63d42493mr9479085ejb.40.1686560768406;
        Mon, 12 Jun 2023 02:06:08 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:82e9:e3cf:d6f0:4c6a])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709061d4a00b0096a742beb68sm4867275ejh.201.2023.06.12.02.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:06:07 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@chromium.org>
Date:   Mon, 12 Jun 2023 11:05:32 +0200
Subject: [PATCH v2 2/2] ASoC: mediatek: mt8173: Fix irq error path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230612-mt8173-fixup-v2-2-432aa99ce24d@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=FuOIzKqJLwG9hXBBeHMxHbhQlBDg6wGyDQM7J3HtDFw=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkht/6RtNidnnzWFvIX6ID1lzhHxvqegz1CZUmV
 u0KTXtZhwiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZIbf+gAKCRDRN9E+zzrE
 iI6qD/9WuMsBy28BDqRklrMZs1zMwNmB6km8F0J5xnGYfBZKfhx0KO3Qf4CjjYp2tzvddMaeisX
 LleVvftuzAVp+ddSoEyGNitooKWpJgSR5dlgSi+ga+eD0mNMkq+wXeNOhBvDrFV1PCj87x3EkZa
 1evfQQDCE5xliJzbqVQ0mbopQsI7nHqEKtauzC9POVpa0LlvoJdXuuSFRlR0u/bouTHe73ef0l1
 vvK1l/DwaL25mPrKDlt1anBHCoZAcHub7nfAY1bNqDOo27n9pTOmw5K0lmoAJCs7r3be04W25pM
 m4tXlQMi3ua+Q6A5Y9l3rSklTSuVzUWLcuLVgK9QQtXwLF+IQESkD99IFUovazf4zOccU6lpCDs
 jfaiaH3wKUUvBPe0gYwEBMk+3bxfypBHIQ+KQfJUGdGZlF7RYIQ99ty1HU8sX2cJnCmUifXFgCv
 uK5oWbWb9vTs6i5XOK7auzTS5t/T4vHJp8ABatHp/17WmwrJZd90T6JjYsjCYDEW6sdM+8hJcS5
 i+DNYGENfBwR+KsgJHKFq3zDqpOFLymJ7QSlNwnLU+U2yDG+auTdZJNz6Zyt9f6lbPB3zfC2fsT
 ewya7Wod3/w8v87ZxtYhIIBAChXZzAN4PHk5mE9LxcuJh4MT25CQWfCg3Mm2VYzkPwU1GU2RVgE
 mlbQnqcwI0gq11Q==
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

After reordering the irq probe, the error path was not properly done.
Lets fix it.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stable@kernel.org
Fixes: 4cbb264d4e91 ("ASoC: mediatek: mt8173: Enable IRQ when pdata is ready")
Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
---
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index ff25c44070a3..06269f7e3756 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1070,6 +1070,10 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	afe->dev = &pdev->dev;
 
+	irq_id = platform_get_irq(pdev, 0);
+	if (irq_id <= 0)
+		return irq_id < 0 ? irq_id : -ENXIO;
+
 	afe->base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(afe->base_addr))
 		return PTR_ERR(afe->base_addr);
@@ -1175,14 +1179,11 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cleanup_components;
 
-	irq_id = platform_get_irq(pdev, 0);
-	if (irq_id <= 0)
-		return irq_id < 0 ? irq_id : -ENXIO;
 	ret = devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler,
 			       0, "Afe_ISR_Handle", (void *)afe);
 	if (ret) {
 		dev_err(afe->dev, "could not request_irq\n");
-		goto err_pm_disable;
+		goto err_cleanup_components;
 	}
 
 	dev_info(&pdev->dev, "MT8173 AFE driver initialized.\n");

-- 
2.41.0.162.gfafddb0af9-goog

