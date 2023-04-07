Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7346DAAB4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjDGJOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjDGJOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:14:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C167A8F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:14:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m2so41815046wrh.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 02:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680858844; x=1683450844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wuqJ3NJSgCZO0KTwOialPWQBgLhEbjc4bx2H+jW2qg=;
        b=HNuTTSYZbOUQAPBqHTfl7H0KFLeNCmBSAlxUlubupMhOHWwNQX7gFMQvX2qd+/g6Br
         Q8B2M9kpRg4kTYh0DpI408C8L+TLkj5J5eR7cNmIEninDkXt0vocGH1skpHpoa2seyqk
         Et6CPDUgY/OCG6gnfzrLD5Pd/lPKPqA2oMZAXeOf88P8xIvE9iWlwoo4HceMpDfMOina
         wElzOKii4Tw20GzTYGASf+eYnIAfjJQtU62qIlRuqkfmJCihiY+dur3rNbgD8hEZKX+I
         /k/MnCjIkLOpvbWLB8wtijx/K6jOQAPKGHL8qImw7PzXzwIqQeFfqObuehrh/ebLxWUR
         1tbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680858844; x=1683450844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wuqJ3NJSgCZO0KTwOialPWQBgLhEbjc4bx2H+jW2qg=;
        b=fY0zEh5IIGnjxBiOjvku1tmOdmSD1u/wUMNwCQed0YO/kCKsQar5+o+CU59iiedStT
         gqXO5g3ZAt0fthtTOBBgfZF/LOrIpU+Fp28jI3PYHjZ2sdBsmyK+aMIuFKmDu5+6imdN
         NAwlTJusTgF0MdoqQdMr42S/T8OTbbTt0EFfSsy2Bfwor59NEUM0wajaAIy0ImRil3z6
         hxRndv0QUZcKkzO9IetYdZ0DPKDSqV3CiFXGkxHtQkqFZzafOxjKGFF0zr1rEcGCkULI
         idS3PSpJMeRTJhpYxVBChfTmk24RVEfwf4v5MeQXfpGsgY8WZ+Rxyi4uuEIxdNMpp1rd
         mA3Q==
X-Gm-Message-State: AAQBX9e8ebbpQeZju3FSJlcFCieuOiv3UjGMaSjnksMrOW+J9ssRWTs/
        3YW/IGHmjbDB5Fm/xVIGYmP/nA==
X-Google-Smtp-Source: AKy350bxY50SgH2Hy5SgJ/V3cCDFecii0IL92XTMoom6qTEgvwZttd/LLHHjmQUF/RXNh0HfefYpNQ==
X-Received: by 2002:adf:e643:0:b0:2ef:b32d:f54a with SMTP id b3-20020adfe643000000b002efb32df54amr523144wrn.33.1680858844242;
        Fri, 07 Apr 2023 02:14:04 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id k22-20020a7bc416000000b003f04f0c5a6fsm4026429wmi.26.2023.04.07.02.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 02:14:03 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 11:13:51 +0200
Subject: [PATCH v2 1/3] memory: mtk-smi: mt8365: Add SMI Support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230407-smi-driver-v2-1-8da6683cdb5c@baylibre.com>
References: <20230407-smi-driver-v2-0-8da6683cdb5c@baylibre.com>
In-Reply-To: <20230407-smi-driver-v2-0-8da6683cdb5c@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=WjdOKn4CNCGCL7Lz1uy2ciMySKdsHm1qKtgJMaQs14k=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkL97ZvbpRspLALhiKU8/NiiqCdZPzY7s3KtdRLwlQ
 I+nMncuJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC/e2QAKCRArRkmdfjHURfqiD/
 wIWom0hIvuKv5lKnL+jKLiTqW2HHBKLSlyk7G0nOr7xQbxRn3IA2QhwbhG0ngNdq86GffH/W0Pwlwy
 8pXHY3lFHRZZe/GATtihD8WF9UGfngW2YxmzkR8/AYErq1JESIJHvW4pvDVEGUJQY3nAJ0A9I5hUCu
 llhZ2oQKp/eUYB2I35n5iEJMZbIVChJulAHMpfTrOsEoJHf9DMD+ZUsozwyASoPxUDkqNbgnjsvlxp
 +yN21T8U3N4YA7z7Li9DRTkdFzh+jNtM1tACIR7qdqJeH7WDWXIY7IaRmhBF1EdLUmNN8ZB9MWjO7p
 OoWSCwwwm8iZ2240G+ggOjOBI0yt6BbGaSNqjF3bQrUdGVKbSdUDRG5MauEkhDHq44eVn0cxjdpUL+
 Z1qEQSbvML7lf6yGj4sMv6ztJKwFoslR1lEnAkjSLj6AgUaILci8Vyrj0eWZf9ZclOvzb07W5mv3/B
 U9O454Cf4uW89JcAOJNJzjo/w2a8NuJ6IqYESeWJsTBRKrJUlwszlT1XCkyqNdqzfgcyhso9jjzf0X
 oRtUUXRpHPP5RfIQ385xYAXAh5cvpt8iNgoncHY96XPn/i0gvXRZvW1ojdq6I0v1yS9vGeB/+YSUoK
 KuKQNa8zyDNK2EF/q24OQN2FCSA+U3xp17auk1jhvVhFX8al+l+ukXLJNNhw==
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
 

-- 
2.25.1

