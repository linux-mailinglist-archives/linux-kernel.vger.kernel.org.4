Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4DD63D616
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiK3M6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiK3M6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:58:49 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDBC4E408
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:58:47 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id fy37so41061523ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VZK/oG0G2NuDkN3Zt9Gzw1YbRQao+w/pvv7GC7syMzY=;
        b=cax1DoaooXKpn0DF2NXjX+cZUNFQzeHQsCF3ZlsrPv1mureGxgy8+ADefVUXNM9uIW
         CKdRCuZ1qiDSLkuA/mpqLbMJT48eBQA4KsmIXG17gTWU82KIzEJXH3n38mFc6HfFhK5+
         ril5KOr3MFDTFh3dl6cvFxSrNY3+19bKzJ7HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZK/oG0G2NuDkN3Zt9Gzw1YbRQao+w/pvv7GC7syMzY=;
        b=gnoeg+CYvEoypRKVCi4f5QJt+ons9pfn4cqsQDojZOq//riu5AlnZgvtvAu5swaG8o
         D6rciROwSE8TKlKLRBUk3Y+O63Cl49dsc7/dA92Sx81Kwk/KlDwpm0Vau4zWEyGN0hGk
         M1nna0bSvRD7HM2xSPsUsWWJ8hgMzJUD+oqAd96ea0wWO0fG1xWzHPufH4lOXP+D5KFc
         UowNWNOsVHWdj65cipDHkR6I4UwaXg6HP8sQ/O4JdOBsV8zyrSiweB0aRFWf6il7JHjw
         d5Y2mw69i8hPR5oJeWGMk1dl4iNRgl6VzeZnWv0w/bVm8MFvUQ857TLjjEinudemZ/J/
         rLhg==
X-Gm-Message-State: ANoB5pkEHhnZd3Poh/RAxYEQFshyAdcR5XaMhSkBS6t79ebUiikLZc6V
        3irogZsWGVJIQBevMn77dTN3jg==
X-Google-Smtp-Source: AA0mqf7o7/gIBBokSQZ3QX/bREXblDhig+YjdUuH56LgZKXBvfJV2rnrsfAhMcMRbMa/ZSeYTImISQ==
X-Received: by 2002:a17:906:dfc1:b0:78d:894d:e123 with SMTP id jt1-20020a170906dfc100b0078d894de123mr1246435ejc.112.1669813126359;
        Wed, 30 Nov 2022 04:58:46 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:29cf:b72a:5a9b:a4aa])
        by smtp.gmail.com with ESMTPSA id j10-20020a50ed0a000000b0046892e493dcsm619872eds.26.2022.11.30.04.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 04:58:46 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 30 Nov 2022 13:58:22 +0100
Subject: [PATCH v3] mailbox: mtk-cmdq: Do not request irq until we are ready
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221125-mtk-mailbox-v3-0-c4b635052b65@chromium.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2213; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=JaMGeOMpmAXuv3OKor0whCcN0kyMhzBZsPq/TlDMCd0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjh1N1HmjWa3ZkM+ohfEpYfD/yTFRjgkqcXvs7TAbz
 iHD9waiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4dTdQAKCRDRN9E+zzrEiNVbD/
 997bPhkM4Tp0Vm9eaTCHZ8XZDPLNvOrVogWdgK/ByjYWNQ4137QEZwgW+YLN7LCGEm6Z5ByeTACf0+
 3dSNgK+4ftYeEsYPIEzOVSVkfK+bWMz4H/y4/OrzicCKQOJTXsO9r47SmwYHLLM/7YL09pdpuGxAIG
 7Aa2DYVQ8cQy0WctP5qFfZ7W6iGXFdZKRtTSCX2eHGwb6iPjCXAc1l+INxVyF8URkCIHF3zIF3zTL+
 3uyntHRoTPECk+hDVXm+htEE/l40MiVxoR6+/BH2YzMOJK4n0h8nhU4zTwok1Vkt5x8q9SpJsOnZFA
 nn3LauNEQJSHpUwhac+Y04QnL1FZCg6nhGOxLGtleSNrc3wDuLtHI0oMMx82SvGI7gH4FQgaP9yQte
 fvEClF21UVBxwTm0ZwEJG779oWAFitYo1NhkZOL2UN9/PytWLjI+NA8rj0bJVP+FNrvcQuMivvUbAv
 Xo6N5hFPbfCetD0jkRt0UGQ/FylvHNNzURWVIamvdZCuUTZUHcRQmojrT8EFSQKTprna5Q5HVYELKz
 LG/ze+fwSOUyskGXYl4KLaNvEjB7qZ/Q7t2YRAG1GnhHdZIlTEVrsiYL+e9OwA6eUSSvF+gxqAsqBx
 GaoDFXUS7nA3mDn7Joo3MvwEqbtrdjczM91St6Jt3JqhzuRpChFdNKAbrdYA==
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

If the system comes from kexec() the peripheral might trigger an IRQ
befoe we are ready for it. Triggering a crash due to an access to
invalid memory.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
---
Changes in v3:
- Rebase on top of https://patchwork.kernel.org/project/linux-mediatek/patch/20221102100736.37815-1-angelogioacchino.delregno@collabora.com/
- Link to v2: https://lore.kernel.org/r/20221125-mtk-mailbox-v2-0-886f70c7173c@chromium.org

Changes in v2:
- I have managed to repro a different panic. Moving the irq enabling to the very end of probe.
- Link to v1: https://lore.kernel.org/r/20221125-mtk-mailbox-v1-0-2e3ee120850c@chromium.org
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index a460ee26eb11..b18d47ea13a0 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -569,12 +569,6 @@ static int cmdq_probe(struct platform_device *pdev)
 	}
 
 	cmdq->irq_mask = GENMASK(cmdq->pdata->thread_nr - 1, 0);
-	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
-			       "mtk_cmdq", cmdq);
-	if (err < 0) {
-		dev_err(dev, "failed to register ISR (%d)\n", err);
-		return err;
-	}
 
 	dev_dbg(dev, "cmdq device: addr:0x%p, va:0x%p, irq:%d\n",
 		dev, cmdq->base, cmdq->irq);
@@ -641,6 +635,13 @@ static int cmdq_probe(struct platform_device *pdev)
 
 	cmdq_init(cmdq);
 
+	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
+			       "mtk_cmdq", cmdq);
+	if (err < 0) {
+		dev_err(dev, "failed to register ISR (%d)\n", err);
+		return err;
+	}
+
 	return 0;
 }
 

---
base-commit: 1642107db81361b4339643eb90af4839e2cf229f
change-id: 20221125-mtk-mailbox-ba6cbd1d91b6

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
