Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35DA6D7651
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbjDEIH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237294AbjDEIHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:07:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3DE1A5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:07:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l10-20020a05600c1d0a00b003f04bd3691eso6548196wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680682068;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hcK2E3trf1X3fQu2pfYafCoNlkzzMbic53P9GU9YSjg=;
        b=QH6GLIo9yx62qG0tuORpKBwGUzWxhT0CHl/Rn852+qO3xDg0uj5D7j37JDs87xEZHk
         cS8W+HvI4yqTHzBhZh5NfSu2cG13pUUNh4g8c6Yz1iw73iG0sb1drqZJTpVJSAfGWPkh
         3CmYMuSj3zbJecpst5FwiKE+IrNmutBUk03pp7/M5poTeLu8V6Y0I4kYJyuue/nO1evC
         58mM1Cq4O4JoRoyqp831DK3qUxVng0nsmuLQkGjOuakQMcnY9VD5hvZiJt+VwmtdiSYw
         AyDHF5V7G3nUiqscdTmci3IFQfn0U4ww+ALaMQ2GYUvkzQSZ4FJFi8f8WjUtEkEv0WW0
         WTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680682068;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcK2E3trf1X3fQu2pfYafCoNlkzzMbic53P9GU9YSjg=;
        b=sXVLw5PtzXFSo3P+CixEp40EQ4rXaey+55LJR9KuEbjiiRk451FsD1mftJRsVeOJ8/
         +Ndnp6fycSC56/Y7OcXojC1m0b8GSztQAS5tXY9890pH5PdYq8fPA6vPq13SK+RMP5r+
         kS1My6ASKuVJTO9iVDiqobxjo4NkmceOd+ibDbObCfq8S9ctxH0fS2HpUZAkWz0fr8Uz
         yR2ldrRM5GI9fX6NYi7xcn3jmh4mlVe96zi76ZQ3E6x1bC2Na8MLnfBXYWulrPWLsAtY
         aCIQflCGIUOsCb+QW2ZqiPB1CAQyGbiXyWSXhBN2MU6cm7eh0SWfv8aItAnWULfO1qFb
         yCKg==
X-Gm-Message-State: AAQBX9dLkj7MARC+4TFmLc+xDtzyOf47LF7rKebXimD/QYwZmCXDjyrJ
        8zvQFF6WiT0t+unaIjvgORhILw==
X-Google-Smtp-Source: AKy350blkAH8sowKFtZnLwupT5xq0atAtHaN/FP2kuzZTraWnNrbQeAcuKZIoSgMD4p/C7FxIeKQWA==
X-Received: by 2002:a7b:cb50:0:b0:3ee:6d88:774a with SMTP id v16-20020a7bcb50000000b003ee6d88774amr1092045wmj.14.1680682068474;
        Wed, 05 Apr 2023 01:07:48 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d4-20020a05600c3ac400b003ee8a1bc220sm1378395wms.1.2023.04.05.01.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:07:47 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 00/10] Add IOMMU support to MT8365 SoC
Date:   Wed, 05 Apr 2023 10:06:42 +0200
Message-Id: <20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABIsLWQC/3WNzQqDMBCEX0X23C3JVu3Pqe9RekjiWhc0kUQFk
 bx7Q+89Dd/AN3NA4iic4FEdEHmTJMEXoFMFbjD+wyhdYSBFF0XqihKmacW0znOICzbckrpTyzU
 xFMeaxGij8W4oll/HsZSDpCXE/fex6RKvf3ObRoV1r9xN911DTj+t2Uexkc8uTPDOOX8BWaq0b
 7IAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=7OqtyGysS4GG8JoZFWoQINnDDmOHA1NIaDmgqK4G2u0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkLSxSEfi6DpmkrTcfu8EAkLqx/FnCXgucH61zc8uS
 LoOkNnWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC0sUgAKCRArRkmdfjHURcG1D/
 426AWvKMTLV61TfBg9mt3vins/UspbZm0eGa5/SA7HHPiR/3xrwvx3nwlSB9dO+P1kBWRUk2eK9H2H
 mAJWhCKzy3mFgG4vQDXxr2K4zgWgVlWVNpRl88aPjnAm5U5c56JkltJk43xrGtSv+oMjQ1TcYPACEO
 zrDX0Qs/KvBCMLOuQmT/Ss6+LxR+E/Ahr1CsaxT/63SiThhstX6kW6XbXmvnEqcFVQyX0mQwu01jNm
 DUOZBGrRER9nEHO0lRiGTSWhlZGaHaLoG1tTGdoljjzjSZMiHBKlcxkRi0ib5Vedw2eR1bA4DDFZED
 nw45G8gjgcRfpwMx36RHMuirOpnvgpf6B/bg8ohFXBb+xZ6H0EBec8+/R8EHayB4RKycF7O+6vHxHY
 KwMx0P8RYx6ddhAmFXIfOPQW+yqzZ9CbXqCgJ0HjejLnTJvpyc01t1YO3l/ItWBsa1RpGF65qluVoz
 YW3PoLVUAia90XP6pefaM+rGWd8/hUnj/dXpvkj7r4by3stW01dk0KG6NtjJ3c6pzmGs3BVap/jFda
 OwybXhoePVi5ojezT3iNUic9mivieyOGGubj6z78TYLS5OGgFehz+7G0mqQgipamhghQIYPXhMIle1
 cw7yN1TBdDFD6mZkFYTmNZ6o84FNUOHjYs/Z0+wdA8OlCUCo5ldOgDYDcXkw==
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

This series depends to two others which add power support for MT8365 SoC
[1] [2].

Regards,
Alex

[1]: https://lore.kernel.org/all/20230203-evk-board-support-v2-0-6ec7cdb10ccf@baylibre.com/
[2]: https://lore.kernel.org/lkml/20230105170735.1637416-1-msp@baylibre.com/

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v2:
- Split power domain patch (3) in 4 patches to explain in the commit
  messages the added subsystems.
- Add an independent "mediatek,mt8365-smi-common" compatible to have
  its own LARB bus select.
- Link to v1: https://lore.kernel.org/r/20230207-iommu-support-v1-0-4f0c81fd52c1@baylibre.com

---
Alexandre Mergnat (10):
      dt-bindings: memory-controllers: mediatek,smi-common: add mt8365
      dt-bindings: memory-controllers: mediatek,smi-larb: add mt8365
      arm64: dts: mediatek: add mmsys support for mt8365 SoC
      arm64: dts: mediatek: add camsys support for mt8365 SoC
      arm64: dts: mediatek: add apu support for mt8365 SoC
      arm64: dts: mediatek: add power domain support for mt8365 SoC
      arm64: dts: mediatek: add smi support for mt8365 SoC
      arm64: dts: mediatek: add larb support for mt8365 SoC
      arm64: dts: mediatek: add iommu support for mt8365 SoC
      memory: mtk-smi: mt8365: Add SMI Support

 .../memory-controllers/mediatek,smi-common.yaml    |   2 +
 .../memory-controllers/mediatek,smi-larb.yaml      |   4 +
 arch/arm64/boot/dts/mediatek/mt8365.dtsi           | 210 +++++++++++++++++++++
 drivers/memory/mtk-smi.c                           |   7 +
 4 files changed, 223 insertions(+)
---
base-commit: 1db7fc94e6e116f43f7bf3adb33407f21bc29fd9
change-id: 20230207-iommu-support-5e620926e42e

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

