Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB7F5EFBEB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiI2RYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiI2RYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:24:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496F21F01BA;
        Thu, 29 Sep 2022 10:24:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso1058149wms.5;
        Thu, 29 Sep 2022 10:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=bGeJq6EVRV3G3ZsUhhY+gmUHYWqjyGOmnCpjQGSVwc8=;
        b=gLYR4SOlzMTTP1Yuo339Pc4usVMMKLH4moFTksSgJK9P97c3gobM1GFZCm+7mT6nDF
         VSvuMJ6AzzRGbMb+01ABfYzM70BgOxo2Xsece1cJ+eUeDU+vpOWa53BhWVqK1glNlkJH
         Awv5hhxPlHixJmbkgyFWZkaKpwpuDAVP8qGzZ1WhDt6jCpFQY59JmioeD4Cg2gysi93o
         CdiCeoKS7wj2bbMTgaTGyqPt0cFHsDG4dXHeSfSBvHai/NCxRbPf9wU4OZ9tO7goywl5
         6eQ6txV5cnH5SA/718ywSVGETb2m0BeNczcnC7p0lcikDAbu7ACujMRGVZID3HHgXMD4
         1x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=bGeJq6EVRV3G3ZsUhhY+gmUHYWqjyGOmnCpjQGSVwc8=;
        b=Rp7PPZda6TvdH6GQq2hpJOzmtb7LrPKax82obPgI1HZHcqB2uCiWb5A9TIhyCqE1f6
         Q6eRvDQkyEavy4bLdhBWWd5KUB4VA2hPHCWC81cOwGSUfcysUCnbogWmBdNAI9YPSfxD
         UhmBx4W2zNvqHUQfUVgiuNTDwVSVcRd4pqsBejH3vHM4zhYwWtbv0WTEQXQoQRVR4B4r
         /AMoRenPwIbO7buDziz4vrrO59p4a/ZZ/YVo8fd+rmaRY0ZMQ86fEAwAOn6MrjNIQfOr
         GTLnQxAu1BvNSkEKWf7sH8LoZo+GBG+ng66NPzUMo8bMz7nXYTzXEwhmJBSPDElvURgJ
         tegA==
X-Gm-Message-State: ACrzQf3GZVFLZ7/I9uRwcOfo4v+Y/p163wSLbHZDra0YdcNZ45mVMr7m
        WweC7R5VLGzRnff6KcgWei5A4B12tQN1wg==
X-Google-Smtp-Source: AMsMyM4iY3w7jSKMj0VFREZ9+1K+daZXdgwz87Pg5hEcWLOWrA7wNoOh3Oiqp3GrESpsDArnm5rI3w==
X-Received: by 2002:a05:600c:4c22:b0:3b4:766a:4f76 with SMTP id d34-20020a05600c4c2200b003b4766a4f76mr11044380wmp.101.1664472241668;
        Thu, 29 Sep 2022 10:24:01 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:9174:aca4:83d8:90fd])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe852000000b0022a293ab1e9sm11815wrn.11.2022.09.29.10.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:24:01 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 0/2] RZ/G2UL separate out SoC specific parts
Date:   Thu, 29 Sep 2022 18:23:54 +0100
Message-Id: <20220929172356.301342-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

Hi All,

This patch series aims to split up the RZ/G2UL SoC DTSI into common parts
so that this can be shared with the RZ/Five SoC.

Implementation is based on the discussion [0] where I have used option#2.

The Renesas RZ/G2UL (ARM64) and RZ/Five (RISC-V) have almost the same
identical blocks to avoid duplication a base SoC dtsi (r9a07g043.dtsi) is
created which will be used by the RZ/G2UL (r9a07g043u.dtsi) and RZ/Five
(r9a07g043F.dtsi)

Sending this as an RFC to get some feedback.

r9a07g043f.dtsi will look something like below:

#include <dt-bindings/interrupt-controller/irq.h>

#define SOC_PERIPHERAL_IRQ_NUMBER(nr)	(nr + 32)
#define SOC_PERIPHERAL_IRQ(nr, na)	SOC_PERIPHERAL_IRQ_NUMBER(nr) na

#include <arm64/renesas/r9a07g043.dtsi>

/ {
   ...
   ...   
};

Although patch#2 can be merged into patch#1 just wanted to keep them separated
for easier review.

[0] https://lore.kernel.org/linux-arm-kernel/Yyt8s5+pyoysVNeC@spud/T/

Cheers,
Prabhakar

Lad Prabhakar (2):
  arm64: dts: renesas: r9a07g043: Introduce SOC_PERIPHERAL_IRQ() macro
    to specify interrupt property
  arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specific parts

 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    | 362 +++++++-----------
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |  87 +++++
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   |   2 +-
 3 files changed, 235 insertions(+), 216 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi

-- 
2.25.1

