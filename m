Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CD760D6BE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiJYWGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJYWGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:06:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECAF286D6;
        Tue, 25 Oct 2022 15:06:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k8so14736755wrh.1;
        Tue, 25 Oct 2022 15:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SkWFdDFpA2ET/e9kHATFDJrw30e54fmgfWvyavm263M=;
        b=A2RonXpa0rFb4YytEH1Z5+99MJaAl/mVWZzNqQ6EQRWGLl1Pco/PQ/opjEz0hTKxhC
         uyn6V7aiH7V21Gw1DiODqEBSeLWqJ/vy1M4kQQ/JoCrZVmaWz8lZVJygGBePG0DFa9mI
         KTt0s9CqhVkjTdFJrFMr6AR37vg9dnA0BrIJO7pD+3F6L2ZYzaii5WGqV1+4sQ4QCxX8
         9RnATpPBanielQGojIwyXsmK3QndMiGyit62HUB7vsBzXseIlIEhenOn/9v3nJI6kGGI
         jMz2yrTXtG6JqzDfUqXPhaMRobqyHLA9TlgbmxPKs2S4Gfl43mkbtSCgqX3OevAZ9OY6
         CcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkWFdDFpA2ET/e9kHATFDJrw30e54fmgfWvyavm263M=;
        b=Vo/OsLeJzoXBTei6GIlZHscA1hfYbPNd6MNSYUcsYerVEq1hfBDRl6fXOwxoViYeph
         zZPpJzHGieKkOSLTwSFqXLfRKSb9QBwj0Dhuma6yWvvGyg4Da6U/2M6Bmj8pU7nVufv7
         jQKATk3vR3K0txrp4S1eAAPotLJ5QPNXPC3gnOwyUzKOGVgvIWZF6LCk0l4H1SX8zvlP
         y2Am4X7/UefjIeIeoOWcEXF2QmGRNTd9G+J0AkeuICtTdCFFiT2UzbvLWb636ygib5wB
         RZAG6x+E5yMMwYS8ZXGtGQYmL9m+r/oC1R7TF790U3T+ekA+1dGicO/hYkM1ohsZ0cbz
         TQcw==
X-Gm-Message-State: ACrzQf3oQKSyAGMu9eRvwXopxS6StG1i1JKLh52VRKj1LV1JnxTIDiWw
        gC4aMm1oTr2PprkJCf5vISo=
X-Google-Smtp-Source: AMsMyM6S2hCm+V5CuUIkT7HUDf8wqISyruffcau/S2wjKVy5wCFulcnX5ktIboGrM8eoVZNxd0ohXw==
X-Received: by 2002:a05:6000:1ac8:b0:231:909f:a4ba with SMTP id i8-20020a0560001ac800b00231909fa4bamr27793833wry.675.1666735603495;
        Tue, 25 Oct 2022 15:06:43 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:1d2a:d2a2:361e:a475])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a342933727sm210534wms.3.2022.10.25.15.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:06:42 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/2] RZ/G2UL separate out SoC specific parts
Date:   Tue, 25 Oct 2022 23:06:27 +0100
Message-Id: <20221025220629.79321-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
(r9a07g043f.dtsi)

r9a07g043f.dtsi (RZ/Five SoC DTSI) will look something like below:

#include <dt-bindings/interrupt-controller/irq.h>

#define SOC_PERIPHERAL_IRQ(nr)	(nr + 32)

#include <arm64/renesas/r9a07g043.dtsi>

/ {
   ...
   ...   
};

Although patch#2 can be merged into patch#1 just wanted to keep them separated
for easier review.

Changes for v2:
- Fixed review comments pointed by Geert
 - Changed the SOC_PERIPHERAL_IRQ() macro

RFC-> RESEND RFC
* Patches rebased on top of renesas-arm-dt-for-v6.2 [1].

RESEND:
- https://patchwork.kernel.org/project/linux-renesas-soc/cover/20221017091201.199457-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

RFC:
- https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220929172356.301342-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

[0] https://lore.kernel.org/linux-arm-kernel/Yyt8s5+pyoysVNeC@spud/T/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/log/?h=renesas-arm-dt-for-v6.2

Cheers,
Prabhakar

Lad Prabhakar (2):
  arm64: dts: renesas: r9a07g043: Introduce SOC_PERIPHERAL_IRQ() macro
    to specify interrupt property
  arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specific parts

 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    | 347 ++++++++----------
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |  72 ++++
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   |   2 +-
 3 files changed, 220 insertions(+), 201 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi

-- 
2.25.1

