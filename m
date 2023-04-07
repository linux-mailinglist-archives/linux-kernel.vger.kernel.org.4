Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B4E6DAAF0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbjDGJei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjDGJea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:34:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC1249D2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:34:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v1so41849560wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680860066; x=1683452066;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ln9BxAKEXuVoxH2HckKeGNcJ9/KjvIORXclz6cNl4Y=;
        b=LckGPPw6zvn3CmEhSJQqKRDWWrLv5eaxjLYpLQeiryoblq8s8m1FqdFmby2xzyqoTl
         fnMBK+x6RTrmsC7c4sn/hbEtja3j671nsxuOwEF+fvSB9R5GiUL6zT4/M04jIrXHxI+R
         OQuziRZ1jTehx+MnPlp9Z+H9ofaBOtZcZXLaclcXCP6s6BrrQB1WscW9eVKOkvow9AHv
         a06+vpWP5nm5M5NqvCzVkNT1DcSHsizx4lY4Ou8SMdpY+QT6zwnQtnxaQMoMq1ugV0/n
         JZz/dykQ1sv8OiBjoNBHS3V1ZL3OlWgRkVAdFZLURrbiCCq61Cnt7Z0hg2S4W2UiKpjt
         +OQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680860066; x=1683452066;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Ln9BxAKEXuVoxH2HckKeGNcJ9/KjvIORXclz6cNl4Y=;
        b=uYfglb5LGr8vyPxxDSrR6TzwptBrydqjARcqdX1VRdGVeLNqZcLd5byjuNxwyZ2gFE
         99/xBEN/h38sfm+5Q5MlBflTHH5Lllrfg0bJ0Rn+F80UFLdRrPzbd3sPXZh/fZUzzXoU
         rDtyuEYCH+zQfgUI3NRonX8IeSAzURXzEhhySi9a0FUhrpfE7gW0xPRzO5Ird51zpxp2
         PVgao3Wr7ec/NS1UN6/SCP6m9qGcj6xTuVNf78AseqdzSCHjzsyUHd7KJEzuOiNEXzXc
         RQxw4kRda2ZvH5VChMSY8sr61kOLYuAaYxqkkF0kg6/y3/dGjlp8lGdR2c9DuvvCmq2Q
         CLPg==
X-Gm-Message-State: AAQBX9dxMQEk0hIDEZrjCqrS/vQT2dHOg8aVB7kdtfz6qOenfuTJc3bW
        5FQ52c0PA8+pv+nuxm9j3tFUyFSMJTUMqdBRTu0=
X-Google-Smtp-Source: AKy350Y3h2qLQtdWkoPbwePzNWCOBj9MkKF6rfng+ssZtYLPWDL4Db22EB1jYP2LIyu0SrYXaXhzZA==
X-Received: by 2002:a5d:6050:0:b0:2ce:9f35:59b9 with SMTP id j16-20020a5d6050000000b002ce9f3559b9mr861315wrt.17.1680860066707;
        Fri, 07 Apr 2023 02:34:26 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id s13-20020a5d510d000000b002d64fcb362dsm4020432wrt.111.2023.04.07.02.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 02:34:26 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v3 0/7] Add IOMMU support to MT8365 SoC
Date:   Fri, 07 Apr 2023 11:34:11 +0200
Message-Id: <20230207-iommu-support-v3-0-97e19ad4e85d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJTjL2QC/33NTQqDMBAF4KuUrJsyGY39WfUepYskjjWgiSQaE
 PHuHbostKvhPXjfbCJT8pTF7bCJRMVnHwOH6ngQrjfhRdK3nAUCVoBwlj6O4yLzMk0xzVJTg3D
 FhmokwRtrMkmbTHA9r8IyDFz2Ps8xrZ8fRfF5/OKKkiDrDtxFda1Gp+7WrIO3iU4ujuLJWMG/A
 DLQQKs7A0A16S9g3/c3ol/h3/MAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2347; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=4UXsmr49uDjmMpGfehKlAgZZ1i56DNjep473+yVwvr8=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkL+Oh0rMZN18zMym9uiPGi4aTLMTfbNFxh/WXPNAI
 K/YRvkCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC/joQAKCRArRkmdfjHURYPuD/
 9lF7yggmKSNUWetM76yvDbf8JXt4dtpIIAETmZ87Tgf7zEceoiQjLZYAMlwjvrkpCGSo85t46/wFzN
 oYiKIDEqrC0jeXXwicYfkzf+LeKu+eETh2fua910naMxV1KU87oWawSVqzCNxMyjZ4MhRZAkPgN1ZD
 Q3anM65eQXMBAbAY5OvB/LIx3+NKnHpMaeKOeWfMLGiwX4aI8fWM56eP/54jdCMdOz+/3AH358iVrv
 OKu+HOWfYhnhptIK0PAzw5fPbRJ+ECgen+44Qd3Voq3PODQKKoNcMeI9luuzeP6YMkVYc7TLPay67R
 Z1Yw2oZHkY2mDYkdQsADZga0XQAjRTv24NQLkvB/0BEa36xrphnUnYwsntbQJOMTO/b1SYBLc8fY9S
 D3jQTO7opN9hZ9qY5SKojBoS4RpFwcqCz7DLq+Kr66jSQMo0XK5enfF+lBYWEgXwqMGvcyeTGrMJYR
 YGT8otyhOdDlHChGULBFx5gijwxics4RAgvF/bARnp5TIxfiCb8oQnaSRQABTJSr9huircwetoGHmd
 HbzY5FZ51tNeB9s/fudgnoPg/ow+cW0KB/Hcza/0KIqtdPUkZIDC/43De39GBQwnAJLHkDaHEuLPuj
 Shainm8GRtqIOcHPIu3EUFBDPFAXQ2DYtZsUUV0KORnm37Byj5DnuSw8BYlQ==
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

This commits are based on the Fabien Parent <fparent@baylibre.com> work.

The purpose of this series is to add the following HWs / IPs support for
the MT8365 SoC:
- System Power Manager
- MultiMedia Memory Management Unit "M4U" (IOMMU)
  - Smart Multimedia Interface "SMI"
    - Local arbiter "LARB"

This series depends to 3 others which:
- improve mt8365 support [1]
- add power support for MT8365 SoC [2]
- add smi driver support and bindings for MT8365 SoC [3]

Regards,
Alex

[1]: https://lore.kernel.org/all/20230203-evk-board-support-v2-0-6ec7cdb10ccf@baylibre.com/
[2]: https://lore.kernel.org/lkml/20230105170735.1637416-1-msp@baylibre.com/
[3]: https://lore.kernel.org/all/20230407-smi-driver-v2-0-8da6683cdb5c@baylibre.com/

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v3:
- SMI driver support and bindings patches have been removed from
  this series and sent it in another one which should be merged before
  this one.
  - "dt-bindings: memory-controllers: mediatek,smi-larb: add mt8365"
  - "dt-bindings: memory-controllers: mediatek,smi-common: add mt8365"
  - "memory: mtk-smi: mt8365: Add SMI Support"
- Link to v2: https://lore.kernel.org/r/20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com

Changes in v2:
- Split power domain patch (3) in 4 patches to explain in the commit
  messages the added subsystems.
- Add an independent "mediatek,mt8365-smi-common" compatible to have
  its own LARB bus select.
- Link to v1: https://lore.kernel.org/r/20230207-iommu-support-v1-0-4f0c81fd52c1@baylibre.com

---
Alexandre Mergnat (7):
      arm64: dts: mediatek: add mmsys support for mt8365 SoC
      arm64: dts: mediatek: add camsys support for mt8365 SoC
      arm64: dts: mediatek: add apu support for mt8365 SoC
      arm64: dts: mediatek: add power domain support for mt8365 SoC
      arm64: dts: mediatek: add smi support for mt8365 SoC
      arm64: dts: mediatek: add larb support for mt8365 SoC
      arm64: dts: mediatek: add iommu support for mt8365 SoC

 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 210 +++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)
---
base-commit: 1db7fc94e6e116f43f7bf3adb33407f21bc29fd9
change-id: 20230207-iommu-support-5e620926e42e

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

