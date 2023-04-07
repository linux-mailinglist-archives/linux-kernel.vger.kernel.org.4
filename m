Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD76DAA4B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbjDGIj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjDGIjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:39:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5155D46B0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:39:22 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so21257619wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 01:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680856760; x=1683448760;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HxTQKNVO9ztRpkc2329fvzZfgl6sigcHzow48LG+lXo=;
        b=8EVqZbtwbu2U8jJnTEzeZJ6A3/1LVcQdXSOpDE1X2virde+vRsRuh5k4MOeGCVlLSq
         7bBNCuHF9EILDe1lh1YuPbfZ/Tm49+ELdcYK+otsxjS/ErOP7XQAqZxGGOfNmv+Aid+/
         iMHsCYIryW4MAc9FV1G21UrlviNwEWrn6/wWNl19K4eVsk4ZWFGL1va1ZSoK9h5gLAKL
         KhMddTMytwK7+pyXXAD73Ttxv7tF4rHq7Acjy1bbynrCVL90wLvPYIP3PcudbNmRu++Y
         if6otrvaW8jx5xzowv4trDqD/cZfkyoMg60uMC83769+LT2CWPAQjdq1L7Jk4308EjdW
         6XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680856760; x=1683448760;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxTQKNVO9ztRpkc2329fvzZfgl6sigcHzow48LG+lXo=;
        b=JLGgVPDoMEYX+QZbqJutPIKmDQFJqjWCk7BUhweXBh+pEEZefI+ke0cPaiq63fKK/I
         d2pTrEJZKekB8MvnjUVnE7RZQ6CHwhX22bm8FAXnG1Yt86kSeqXss+S/gVaW5BY/rDse
         9dX1SnpxgCXstVEil0GskLzUt8i3PdULxqJyxgLrDBzaCMqS9uyZT3tLcKFfZOBSOs8F
         0rC9uAA2FbGMYV/4v/abTlRyhR+dPfKyZVC1+I9Qpk2XuReaJeO/xB27NCtafUhA1RjA
         i9Mcgt4FZJH0Oc3s9qcfNbDezC3LhL4UfUGlPo8TMXBp1PsXDvj8/UwCzIAS06O0a0gp
         PSgQ==
X-Gm-Message-State: AAQBX9ct3B5Slq178onDcMmB0AP/RO58w8HWOHBi6MdHgVTyCjVlq4D6
        QTXaf9nym3WBKNerXBVdiksfIw==
X-Google-Smtp-Source: AKy350Y1Ehajm7UApJN7ryVi+4T2kEuIMc+7Kv4o6f6TbSLPCsAdGmenWYJaFR2ifclFI2eQsY9hWA==
X-Received: by 2002:a7b:c7c6:0:b0:3ef:8b0:dbac with SMTP id z6-20020a7bc7c6000000b003ef08b0dbacmr754509wmk.31.1680856760582;
        Fri, 07 Apr 2023 01:39:20 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f5-20020a0560001b0500b002cfe3f842c8sm3960362wrz.56.2023.04.07.01.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 01:39:20 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 10:39:18 +0200
Subject: [PATCH] memory: mtk-smi: mt8365: Add SMI Support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230407-smi-driver-v1-1-036d6d8e8993@baylibre.com>
X-B4-Tracking: v=1; b=H4sIALXWL2QC/x2Oyw6CMBBFf4V07aS1GjH+inHRxwCTwNBMW2JC+
 HeLy7M4955dZRTCrF7drgQ3yrRyg+ulU2FyPCJQbKyssTdzNz3khSAKbSjQP63tjX9EZ1E1wbu
 M4MVxmE6lJh1mdFwTJOJQZAZPHIlHXdZEQS91LgQDulKl/XDBUVw5A9pYEhzo+y97f47jByB8S
 0WpAAAA
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=Oj9DT/lxZQLpb1GTgR0bpejsWFy9jETdEDcuOZxmHV0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkL9a3x7Lq9N1F0ungt3avZJRtAYDeq+QGgEX5jK3j
 Pbm4r92JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC/WtwAKCRArRkmdfjHURVXbEA
 CEZLQQUxpRnEoF4/T62/ae1W5bCjIO+y/d6AFlnAnp94WB1hMZS5NbG9lSKpAaG0+OYJOtQJ63EiIx
 tZ4/l0iKwp4h07FUFsHEnmnnE2suaE7/oH+T8JO9zTpsOuf+dq21DvSBFQVXL1VMFRFrEl7HW+AwNb
 I0FUhB7oUMbg9GCfhAVRNHTt1Kc1X3RjAQYO4h6vDN8zSrIImN8+IgMy8XMTCwdygLlycgEa6erC0y
 6qypcFXMrWeSfpX9jx/MTvDGm/8ngNeM7tHqi75D+i3hH7bVhcw7eqhR+Ncq7LKGsF4LhJWvU7pdRc
 e1SOxnXDhqL9nU0Awb7/WhBEkmPowWYBPd6VbX9G6dPkB2H2JXe1M9PmnZYlK9bnvLHEaRux31ffTZ
 mtv5sIf+mrt4Okwk+Kt6EhnkCQLJGLdFRMDN9sXb/1Lr6GgOjdRYMmwyaqFBLN7ZbQb/g7jLMqP1K0
 tAPETkWe921rHHMwxDIooGWZal/2e48AkuoihMykVA28Ej2yr1OgFntFCTMzpy6hhOwwcZ8/NqErR3
 XF++a0KwYlAWfNwVLzawTrqmdn/89UXCos2Wcmdz6zupWewMS20nJLwa1m1IAuSXfX4rgDeOC8REba
 wDlcX526m3z/NeRVQ1uVsnuzuM8NwnUg14n8LOI8p+z91YUt9XTjMqsP/9zw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8365 SMI common support.

Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
This serie add MT8365 SMI common driver support only because, to be
bisectable and avoid issue, this driver change and the related change in
the DTS should be applied in the right order (driver first).

Here the related DTS change: [1]

Regards,
Alexandre

[1]: https://lore.kernel.org/all/20230207-iommu-support-v2-7-60d5fa00e4e5@baylibre.com/
---
 drivers/memory/mtk-smi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 5a9754442bc7..6523cb510518 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -713,6 +713,11 @@ static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8195 = {
 	.has_gals = true,
 };
 
+static const struct mtk_smi_common_plat mtk_smi_common_mt8365 = {
+	.type     = MTK_SMI_GEN2,
+	.bus_sel  = F_MMU1_LARB(2) | F_MMU1_LARB(4),
+};
+
 static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{.compatible = "mediatek,mt2701-smi-common", .data = &mtk_smi_common_gen1},
 	{.compatible = "mediatek,mt2712-smi-common", .data = &mtk_smi_common_gen2},
@@ -728,6 +733,7 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{.compatible = "mediatek,mt8195-smi-common-vdo", .data = &mtk_smi_common_mt8195_vdo},
 	{.compatible = "mediatek,mt8195-smi-common-vpp", .data = &mtk_smi_common_mt8195_vpp},
 	{.compatible = "mediatek,mt8195-smi-sub-common", .data = &mtk_smi_sub_common_mt8195},
+	{.compatible = "mediatek,mt8365-smi-common", .data = &mtk_smi_common_mt8365},
 	{}
 };
 

---
base-commit: ea2dcf9394947d5d8e24cb9d52144923f6645632
change-id: 20230407-smi-driver-782270b6da2e

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

