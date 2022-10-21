Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9126078BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiJUNm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiJUNmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:42:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DFE20B135
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:42:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so2006735wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk+4CRLnY52KPUGRKGWjJ5/58hHkL1tlde3uv6PpSFg=;
        b=K8I4x9WV+Z6ikECFtAN/koKw2xY7h7vWva7sD5RJssnFoPfsPtEJTx5gIU7bCqvXG3
         QP9SMZDeb2AxqTYJqBsUuUTq/vMqs1jRvRtQBaAVFM5PKLG/0sIbsxIabVVRuNu3Ri7t
         UnfBphPnNdY0aT7ucL/ECNVG/NlcjObYA9xEoixQdH9DdYj48Pu9nabY4O14aLzyQiIA
         AVvjBN++iWTtRMpRQ0NMgk4VWt4Nj62i4ecmh4jOuVZhlouO7StBjBxYI9WW0LtpH0nK
         YcLcP77RKcNHNnppX0SBsWPUNFwLYqSYRx+YNuZ/FJvjtXWoO2Hom8hbnWhVten5hyy+
         t5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sk+4CRLnY52KPUGRKGWjJ5/58hHkL1tlde3uv6PpSFg=;
        b=ec0QwXqVkVsvS3igLG2RkjaCvBI+ILVbGyWIqu0YUjkEVfN9MVtgqbExF5+UBszbTj
         LVTkK1Xe7CRuHEnA6TrK7zKE8qVJ2UaWMxTLBDWAGYDIf+LaYTa9B+9Kl+CNq/LUX12r
         IgU1joCXL1niUggUOYYyqxG3kUhgP2qN5SFkU18nD1UY2o2F8gbjGC6UTFj7ncEIryhS
         +FrZdbwSXX8zzumtWYzK1hp6JHm1dMyl6VxjVo0jckMLhGtaSEru9KaFJD2k/pikF9qV
         WZ8wmYrK2lKm5Nl5NUVcIwL1iOvnZcws3eTpX2/hM8DcZrlLpkzX8FzUNYrPBSsuwFek
         A0vA==
X-Gm-Message-State: ACrzQf3s1uhF2XQwM3FZw7v2KkiyzcOu8rt9DM8tFHsx8OGJlluFg1sT
        onZIMWtvX1Dp1rCfygylDyPJz7YGeKK11NhyAJg=
X-Google-Smtp-Source: AMsMyM6ld97fr+ZDx3wlPqihADksR2PpPwfly3EB/X/eLp9QsZWQC8Kx74LehY9uI/xB5x0dN8Jzww==
X-Received: by 2002:a7b:c341:0:b0:3c4:552d:2ea7 with SMTP id l1-20020a7bc341000000b003c4552d2ea7mr13447402wmj.82.1666359740179;
        Fri, 21 Oct 2022 06:42:20 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id h5-20020adfe985000000b002322bff5b3bsm22966355wrm.54.2022.10.21.06.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:42:19 -0700 (PDT)
Subject: [PATCH v5 0/3] iommu/mediatek: Add mt8365 iommu support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIALehUmMC/42Oy2rDMBBFfyVoXRW9HXXV/yhdeKRRLbCtIMWGEPzvmWSX0pqshnvh3DNX1rBmbO
 zjcGUV19xymSnYtwMLQz//IM+RMlNCKSmE5LlM08LbcjqVeubJCB86FN6gY8RA35BD7ecwEDUv40jl
 kNu51MvDsSo6X//NrYoL7jxAF10UQtlP6C9jhorvoUx3wR4YIWFSiAjBP4PfRK5616xpIBw1YMKgFM
 aXzQ+wAy2sBxGl+8Nsds2GBjA4et4aBAsvm+9gkii10ceYovpl3rbtBk4i+1zfAQAA
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 21 Oct 2022 15:42:15 +0200
Message-Id: <20221001-iommu-support-v5-0-92cdbb83bbb8@baylibre.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        devicetree@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-mediatek@lists.infradead.org, iommu@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2834; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=do/0/vPsV/SjDW7dDqa9PaE+RECnKFbeYkbnSOtyvbI=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjUqG7BYbmn23u5OcjMqm8K1Tyhfs7IsGF2BWwOB0K
 FkFu5wiJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY1KhuwAKCRArRkmdfjHURVt4EA
 Cw1dByIEJwxTQpmYdEWqWHhWJ7E6NWrIkI4cpCchUYIxxkfAiSJvB1ydTEMCDE9AJ+PpfY/4fsbFMr
 t/zy+aOKe95CDTXyXZa21ap58ig4aKEH1yN0U95aPkIA7NSD+7cG9vyTqyCL+ROreBKX9tZ+y1gcvV
 hRksKFcWwNSEAJfLK57OBcX7uSrqAzO5Mokl5iBYNwkhpoOyuYhQ5mr5xZSmAD+eX1nszPA0bM88Jr
 zCLIBKYBC+uzw/QNzXvz7/PVfecPu5W5a7IXeCRoXJw6iioVaOpuZWYTDwZbyHt+O2IbJlIBIgsWfr
 EhfoN/G5WuTUgWo0qFWZ2MtMj1GgGYM3qPU8y+YB1BVzDattO1FvOi/aux2n/jarpJGQnH74WNLXJx
 nATjdzoh7P+GLLwHNr37uCL59s5qsXgb6TyqYaFJTjKxGmIzL7uVubIHB1rFXoS9s3NOhhfnmjqklO
 1U+7FfSXmAZi5HlPZOZ8a8pipCtSCbX03tg14Nb9WZUBNtLS4m4HxWe8C8mrBCSCiTTIigpG9jp06M
 nwEFdTYY2AH3QwuTle1kYoivm+7z5OAQIecaqaG5A6eoBrwFZ4+zyh7wl05myAnkT8B810xzIZT4+j
 1pLo0DUZTDBXyMrdpMpNc0m/7JtNB2Eg9lsZo4kIMKFTIVnRxxBQiCdylKFA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series contains patches related to the support of mt8365 iommu.
Thanks for your feedback so far.

Regards,
Alex

Changes in v5:                                                                  
- Fix name file in mediatek,iommu.yaml                                          
- Rename defines to be more consistent                                          
- Rework INT_ID_PORT_WIDTH_6 check                                              
- Link to v4: https://lore.kernel.org/r/20221001-iommu-support-v4-0-f1e13438dfd2@baylibre.com

Changes in v4:
- Typo
- Rebase
- Link to v3: https://lore.kernel.org/r/20221001-iommu-support-v3-0-c7b3059b0d16@baylibre.com

Changes in v3:
- Rename "mt8365-larb-port.h" to "mediatek,mt8365-larb-port.h"
- Rework the macros which retrieve larb/port ID to improve human readability
- Link to v2: https://lore.kernel.org/r/20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com

Changes in v2:
- Rebase.
- Change M4U_PORT_APU_READ & M4U_PORT_APU_WRITE port to avoid display
  conflict in larb0. These definitions are used for vpu0 device node.
- Add dual license.
- Retitle commit.
- Rename to int_id_port_width for more detail.
- Fix typo.
- Set banks_enable and banks_num in mt8365_data to fix kernel panic at boot.
- Link to v1 - https://lore.kernel.org/lkml/20220530180328.845692-1-fparent@baylibre.com/

To: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux.dev
Cc: linux-mediatek@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Fabien Parent <fparent@baylibre.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

---
Fabien Parent (3):
      dt-bindings: iommu: mediatek: add binding documentation for MT8365 SoC
      iommu/mediatek: add support for 6-bit encoded port IDs
      iommu/mediatek: add support for MT8365 SoC

 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |  2 +
 drivers/iommu/mtk_iommu.c                          | 25 +++++-
 .../dt-bindings/memory/mediatek,mt8365-larb-port.h | 90 ++++++++++++++++++++++
 3 files changed, 116 insertions(+), 1 deletion(-)
---
base-commit: 11082343e3bf2953a937509f0316cabf69dbf908
change-id: 20221001-iommu-support-f409c7e094e6

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
