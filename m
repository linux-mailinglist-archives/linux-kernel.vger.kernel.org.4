Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559DC69B29F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 19:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBQSxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 13:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBQSxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:53:04 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C491D1448C;
        Fri, 17 Feb 2023 10:52:59 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id u16so1621826wml.5;
        Fri, 17 Feb 2023 10:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/A919F9IBosDEaWyCb/73T8vE9zvjGLy6ESUu/4zI1k=;
        b=DRkvBo8HrqhoNEnVQkJijyoTu4tJIpcPAcLm96lSXnKe5xjMxskZREzRJzb/hRRdI7
         7u0VP9Zi3SVJrx7MdavpnGlnDb3GEp3MmB6AA5yMS1+GqBhQhhFhKeu+zr6ONLlmRX9C
         bKZ86QaFOnCExdeuq1xDZq+vrGp3q5gvNpXwgloaqbEpzIRg7R4SDOFsiuE0HA8M2Htw
         /a81hWYdu2EnySIyoC/wtphnGM7I+hsWhUaBIJ98thnhJwabHOGfV0wfsecblEGNJaL9
         x359qx8rdyAQiUX4hV97NI7wvr5zEPUs7MvFlF0rzujfxXWKV9jU9/lrw/YrNcCy/lbb
         xbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/A919F9IBosDEaWyCb/73T8vE9zvjGLy6ESUu/4zI1k=;
        b=Wtp3S0B3qmC3yRhH3kmUNAzQDJMBKpIXCHDh0p8osljfugkBt9Q7sw7djSRfFFcHMx
         DgPzIhGc+Ik2Yb70gLbSZ1G00V+pHgGlipLI06MnzbhYLvTPnOtScVYkTPAjokNGTUpf
         JCSNeDTaue7IOfnJ2kpfqUphX9jcDmOhhptSSHEEZeYqsiqzvb6u8BW4KpQiuAnUQQq1
         KbMpvG3CzZq93y5TnxEP4xtzcKPJLsMmPVO2EYGS6bwTxmJBs34BNRAnfTP0H3Qm2Qgr
         6VFae4OrJMaMZdFlHjWc4DBQlMRZUkd9P+26CF3Zwnk1i57Vq1SNgEnj2pE4kIAMHePg
         Wo/w==
X-Gm-Message-State: AO0yUKXTEzq6ybeK4L0S06IFGQX6H4D61AamT9juSoWOQJ6eQ7xHxQk0
        tU5EFS8i0QnLNINBFfRAGAtI6PFPgMYS9w==
X-Google-Smtp-Source: AK7set9e9Xm3a3p0mdhhU+9BZol1f16dYjY64XmBIuqiYSW8Vh5fuveUKOhMZlqOed8cGr/wNmFWkg==
X-Received: by 2002:a05:600c:44d6:b0:3e2:cf0:4087 with SMTP id f22-20020a05600c44d600b003e20cf04087mr5482571wmo.32.1676659978386;
        Fri, 17 Feb 2023 10:52:58 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:d8bd:e692:c27f:c09d])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b003db0ad636d1sm2964514wms.28.2023.02.17.10.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 10:52:57 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/4] ASoC: sh: rz-ssi: Update interrupt handling for half duplex channels
Date:   Fri, 17 Feb 2023 18:52:23 +0000
Message-Id: <20230217185225.43310-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230217185225.43310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230217185225.43310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

For half duplex channels we dont have separate interrupts for Tx and Rx
instead we have single interrupt Rt (where the signal for Rx and Tx is
muxed). To handle such a case install a handler in case we have a dma_rt
interrupt specified in the DT for the PIO mode.

Note, for backward compatibility we check if the Rx and Tx interrupts
are present first instead of checking Rt interrupt.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 63 ++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 5d6bae33ae34..d502aa55c5a8 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -109,6 +109,7 @@ struct rz_ssi_priv {
 	int irq_int;
 	int irq_tx;
 	int irq_rx;
+	int irq_rt;
 
 	spinlock_t lock;
 
@@ -565,6 +566,17 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data)
 		rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
 	}
 
+	if (irq == ssi->irq_rt) {
+		struct snd_pcm_substream *substream = strm->substream;
+
+		if (rz_ssi_stream_is_play(ssi, substream)) {
+			strm->transfer(ssi, &ssi->playback);
+		} else {
+			strm->transfer(ssi, &ssi->capture);
+			rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
+		}
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -993,26 +1005,39 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	if (!rz_ssi_is_dma_enabled(ssi)) {
 		/* Tx and Rx interrupts (pio only) */
 		ssi->irq_tx = platform_get_irq_byname(pdev, "dma_tx");
-		if (ssi->irq_tx < 0)
-			return ssi->irq_tx;
-
-		ret = devm_request_irq(&pdev->dev, ssi->irq_tx,
-				       &rz_ssi_interrupt, 0,
-				       dev_name(&pdev->dev), ssi);
-		if (ret < 0)
-			return dev_err_probe(&pdev->dev, ret,
-					     "irq request error (dma_tx)\n");
-
 		ssi->irq_rx = platform_get_irq_byname(pdev, "dma_rx");
-		if (ssi->irq_rx < 0)
-			return ssi->irq_rx;
-
-		ret = devm_request_irq(&pdev->dev, ssi->irq_rx,
-				       &rz_ssi_interrupt, 0,
-				       dev_name(&pdev->dev), ssi);
-		if (ret < 0)
-			return dev_err_probe(&pdev->dev, ret,
-					     "irq request error (dma_rx)\n");
+		if (ssi->irq_tx == -ENXIO && ssi->irq_rx == -ENXIO) {
+			ssi->irq_rt = platform_get_irq_byname(pdev, "dma_rt");
+			if (ssi->irq_rt < 0)
+				return ssi->irq_rt;
+
+			ret = devm_request_irq(&pdev->dev, ssi->irq_rt,
+					       &rz_ssi_interrupt, 0,
+					       dev_name(&pdev->dev), ssi);
+			if (ret < 0)
+				return dev_err_probe(&pdev->dev, ret,
+						"irq request error (dma_tx)\n");
+		} else {
+			if (ssi->irq_tx < 0)
+				return ssi->irq_tx;
+
+			if (ssi->irq_rx < 0)
+				return ssi->irq_rx;
+
+			ret = devm_request_irq(&pdev->dev, ssi->irq_tx,
+					       &rz_ssi_interrupt, 0,
+					       dev_name(&pdev->dev), ssi);
+			if (ret < 0)
+				return dev_err_probe(&pdev->dev, ret,
+						"irq request error (dma_tx)\n");
+
+			ret = devm_request_irq(&pdev->dev, ssi->irq_rx,
+					       &rz_ssi_interrupt, 0,
+					       dev_name(&pdev->dev), ssi);
+			if (ret < 0)
+				return dev_err_probe(&pdev->dev, ret,
+						"irq request error (dma_rx)\n");
+		}
 	}
 
 	ssi->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-- 
2.25.1

