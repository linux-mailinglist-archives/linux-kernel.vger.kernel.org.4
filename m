Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AA66D7667
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbjDEII3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbjDEIIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:08:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193D01BC6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:07:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so17742890wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680682078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33253isHt4S+J+nSLFy8mmWQtMLkRh8HjGdIrP7lEuQ=;
        b=Yc0/OBGpl7E8efDzxB5jgr2ofIfukmILIBfP2QyerHUtDy5nkPLJ3RoLd5pgQS9eZP
         eXgMfqiWxFlb3SGYMfy7+KO33PVHgc5o+iTysoWqWRKVqLAHoUZYn56XnIsnIDxwQspD
         VPZUEktSxHQVUb5SvQnC82cCQue8ELO5rxTkBGzTqhjeleM6aqQFk3q0jtggEjqYGNog
         s2exPDJI4a7khjCU3mqDzSM1BWyOYA2LXjlUFbZFbuLsDRvC3VcNywbTmoxBqSAXwlR8
         uCD7I5dAJNY4TcHBU+MwdrAycwdtxDIypzdNqmiQ8FQaP/ZE5C2/GLT+lc0qVy1rZYHh
         zMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680682078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33253isHt4S+J+nSLFy8mmWQtMLkRh8HjGdIrP7lEuQ=;
        b=eA+k3TaqlCT/Xq1rY2Z3a6fhrOKLbrH5mzVPMePXq2YEqzDuvabFfNBQH35UqvfSUU
         Jt1SrV6BsL0hTnEbGLZQ8rdQdf0klGAylhwXaJgk+Zhtaar2EDQLS/kMOVMGA25XZJv4
         Ckz2BQpClPrjetIlCqTS2dX9IVipOb/39g0fJzKKyS7Qgw/s5J6ZKn5Cwm5StTvLuKKp
         X8NmgXdqnxexKSvtCrSJXhboWWEGLE79gYYAEp0DPxSzIOImVcq0NcKbeN5xU9GBBtvU
         J9v2JMBPrlyVfcHdr1JeVOOFTa/IAOXJRfdEfXUq+6izazGKiTJJGxsdaFLom0ptGb9W
         fDfw==
X-Gm-Message-State: AAQBX9c0agLc6atfncxxBGqGsHaHqWou+D9s532NNaU22aaeSCw0iwN9
        NCsOrypytOIK+vfU6pcBpfhTUQ==
X-Google-Smtp-Source: AKy350a6vYxum9a+B7CUUnBSWwVcA/VkgqgawFsnIiacY7QtYMO9m0nHPcUziXUysydrFPVUfZdi4Q==
X-Received: by 2002:a7b:c5c1:0:b0:3ef:67fc:ff02 with SMTP id n1-20020a7bc5c1000000b003ef67fcff02mr4088941wmk.7.1680682078427;
        Wed, 05 Apr 2023 01:07:58 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d4-20020a05600c3ac400b003ee8a1bc220sm1378395wms.1.2023.04.05.01.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:07:58 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 05 Apr 2023 10:06:52 +0200
Subject: [PATCH v2 10/10] memory: mtk-smi: mt8365: Add SMI Support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v2-10-60d5fa00e4e5@baylibre.com>
References: <20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com>
In-Reply-To: <20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=z26cWVr1UM3WDlPLOHdYFNM2IHS6opWfJrlRsd4fTCY=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkLSxTsz6MktT8KmhJmOCte7lvIAMRb5YfYP6mGtBz
 Tuody/mJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC0sUwAKCRArRkmdfjHURW48EA
 CY1vLd79NTra4MIV+COGshV23I/tjs0l86iK561zWyv6IFf6I6eV4l5XJo9t0pM+H35/79rGeCNZw9
 Ru96C6/1sPUSEK7MccPSyavM/1pMv0VY9DbyFYsoKmcPcNjrAWpiCMTNYhkN/NpMNOPPTRHcBn5Ts9
 lB2jkZkcwEX+aVYIoJY9Nn3lAUyLFs2G4EX5ut430Q52qgF/6tLgXNg9htaYK3BsL4hJkD/jQ0BJaJ
 ezvB8rnPno5pS5W90Bi/MM8R/bCKZn5JQsjw2CGPPEmHFBksYCMrg+1eaQSEvqJlgNYSA8LeDQ87V1
 tKmPavZBUH+5zTRA0boN4bNO6d5e4+CQk8xEoPPQZwFmdtuxyJHhLzad+okWzOyfk7vVd8Rh+oIXQO
 MC1Dz2eRp/sV1QlHsZqJoPLP3wHgTeQG2w5iY6EIGQE50CXQXQ0JAbk0PaZq7FgTXK+bGwVk6Wk8cc
 HVxN57HMFJxvd3gZJaFKPak98NrK0jEA4XAZVF9SftZmO/7dCn7t85UsVSBqck4IkVr0ZW8BFm81vB
 qcgUoLW4uo+NI+9Zfzp059IUV+jdZieNKI1rryphymiuGNSTPH6u9F32VoIjcDVfY8CAX5HvSIrIvH
 CDxM9Aw0ddm8mRxjyK8nevYIlQcbu9RvAlkTtiwjR23FqNevGEdAtFNb2rGg==
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

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/memory/mtk-smi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 5a9754442bc7..477b5d1ffd46 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -713,6 +713,12 @@ static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8195 = {
 	.has_gals = true,
 };
 
+static const struct mtk_smi_common_plat mtk_smi_common_mt8365 = {
+	.type     = MTK_SMI_GEN2,
+	.has_gals = true,
+	.bus_sel  = F_MMU1_LARB(2) | F_MMU1_LARB(4),
+};
+
 static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{.compatible = "mediatek,mt2701-smi-common", .data = &mtk_smi_common_gen1},
 	{.compatible = "mediatek,mt2712-smi-common", .data = &mtk_smi_common_gen2},
@@ -728,6 +734,7 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{.compatible = "mediatek,mt8195-smi-common-vdo", .data = &mtk_smi_common_mt8195_vdo},
 	{.compatible = "mediatek,mt8195-smi-common-vpp", .data = &mtk_smi_common_mt8195_vpp},
 	{.compatible = "mediatek,mt8195-smi-sub-common", .data = &mtk_smi_sub_common_mt8195},
+	{.compatible = "mediatek,mt8365-smi-common", .data = &mtk_smi_common_mt8365},
 	{}
 };
 

-- 
2.25.1

