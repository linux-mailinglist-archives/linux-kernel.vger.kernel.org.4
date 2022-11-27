Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82196639CBF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiK0UXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiK0UXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:23:07 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBE9D120
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:23:06 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id e27so21284207ejc.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wfKh2Mf4Ino4G2YyHVeE+Z2MaLhC61+o3vx+CNzKjDQ=;
        b=nNMnxcyEBZ591wHcQIif8hhyoGN8Ob34xVLn1BE7WR/+2cbc1LZpS/SHbTz2X1vkxp
         5TXTWVZYYMy6Mn/yhpIJBIbnBvjJyg7H8OinLO/t8kq5LAJ18JpsZ4VhDE0EzuG3fI+G
         A46ml9lDujs9yT5n8V2K5anZa0hdC+SUNeSGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfKh2Mf4Ino4G2YyHVeE+Z2MaLhC61+o3vx+CNzKjDQ=;
        b=Vn0ht6HTVaY7AEs/1SiasX/m7KH2qjiTXf06rPyLBGW+mEASkI2x9cz2nmMPsKY8t7
         4DPdvxf0Q9Ru9Gqsdd0RxetrqmU6g8JAn7qNBylsGgyDse45gp2zpZOiDqmulLnl5xWt
         F/TlQEKCG0wNdKOMi6kavyONOOerlrLU+/CVizHhxyCNdxM71HImnIN/7wvwcpTdNJP4
         Xda6o/usQaaHOwyLpdXeTJ8LtdrUZgGTRuL+EM1JaYBOgRFSsg1bgdI/1W82JHVl8dlS
         qbv38m4+Cm2X1o5ve5I0eJgsRqJFmO0M4cZfCwdwxicOnMIF/9PvlXpM1nVZpI+A4YhY
         JANg==
X-Gm-Message-State: ANoB5pkCjZH352FhLJRGFzmsbxAdIaPMQO3nU1/sIYmODV8BtEUQJeG6
        0BRTHP2tnbcPo45jXF9c4uvCER6FrhmOCQ==
X-Google-Smtp-Source: AA0mqf5EgKvaGkUib8pzpuxBc1l9tI/0ro+ReGhiwOZ4uP5I8N+3wk7FIxnWqr3Zya96j80tQ00foQ==
X-Received: by 2002:a17:906:c24d:b0:7ac:2e16:a8d2 with SMTP id bl13-20020a170906c24d00b007ac2e16a8d2mr30381713ejb.584.1669580585321;
        Sun, 27 Nov 2022 12:23:05 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id j9-20020a1709066dc900b007ba46867e6asm4165278ejt.16.2022.11.27.12.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 12:23:05 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Sun, 27 Nov 2022 21:22:58 +0100
Subject: [PATCH] soc: mediatek: mtk-svs: Enable the IRQ later
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221127-mtk-svs-v1-0-7a5819595838@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=7DOft4Iv0/mgcfhfj8YN+wfHXirhGcx/iCjJqeykALw=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjg8cmyxwr2EJslRfWjI+SaTXHPsCiomTbm17eqkny
 rPpbu+GJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4PHJgAKCRDRN9E+zzrEiBIQD/
 0V8fIaN+zDO0ZjtYZlWHksrz5RjFtlpLQYHbOAEUGOaPDDE1kEUWYYYsvzJJsHSVRMiIA4I7bdgHGo
 YtXSmR9fn5XuqC73IuPa3gm1uWGmF02sQYO0ZrPRPb7YHDG+leTTTLzYUUXnKQQIGglcZanv2uGs0y
 1px7ILJpPxc7RRcNv+7XIYN3Nmp3lGJBXitLAOKhMcBfvR+ptmwet9xpmttA5gVN5xsY408PbcBuBZ
 6V44phnpyzrtRf6S0iL5X53CMXKmduK26sRW5qclTy4y0K1WoiwrzJU5oO93YHbQ654CtYGQg19Kis
 EEbv1hyY6b6ACJxBiwop0cMnz8dgXLWk6TPS5qCpURuEyybiTCmCd+n4L4V1UoLxQvdR366P/19l4V
 KjcrthaDGNSypfS3lJcNF9toyBXt0ActqvSoP8GX6GAXHRTx26lQRByM1HYVRZKwOthfCOB5y7DiGX
 7B9idyq68BaTdbr9ofGnD9SbBl/5uGsWEK/iTlVr7gp8jbzXwpcNSZ3RU4O5aK7JX0YR3H4sZd79DU
 D7qukNlw7gecCGG/1ht3GkLp63FMKvpkRv99cFI3xV2JmWMukNAsAQVarbq+VY6Efz56lN9LAq9xo3
 2gvyegi305LoO+zHWrHrKNbBIyk9V6IHsDnWldhIA74056o7FwM+uY403n/Q==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the system does not come from reset (like when is booted via
kexec()), the peripheral might triger an IRQ before the data structures
are initialised.

Fixes:

[    0.227710] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000f08
[    0.227913] Call trace:
[    0.227918]  svs_isr+0x8c/0x538

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/soc/mediatek/mtk-svs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 0469c9dfeb04..0451603a8cb0 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2385,14 +2385,6 @@ static int svs_probe(struct platform_device *pdev)
 		goto svs_probe_free_resource;
 	}
 
-	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
-					IRQF_ONESHOT, svsp->name, svsp);
-	if (ret) {
-		dev_err(svsp->dev, "register irq(%d) failed: %d\n",
-			svsp_irq, ret);
-		goto svs_probe_free_resource;
-	}
-
 	svsp->main_clk = devm_clk_get(svsp->dev, "main");
 	if (IS_ERR(svsp->main_clk)) {
 		dev_err(svsp->dev, "failed to get clock: %ld\n",
@@ -2426,6 +2418,14 @@ static int svs_probe(struct platform_device *pdev)
 		goto svs_probe_iounmap;
 	}
 
+	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
+					IRQF_ONESHOT, svsp->name, svsp);
+	if (ret) {
+		dev_err(svsp->dev, "register irq(%d) failed: %d\n",
+			svsp_irq, ret);
+		goto svs_probe_iounmap;
+	}
+
 	return 0;
 
 svs_probe_iounmap:

---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221127-mtk-svs-add137fbf187

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
