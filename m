Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECC1600A03
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJQJM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiJQJMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:12:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B207E1275C;
        Mon, 17 Oct 2022 02:12:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n12so17429968wrp.10;
        Mon, 17 Oct 2022 02:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uXahj3ItpGR0T2qFyurrngY0xMNOuQK04rAbGGKXwg8=;
        b=T1YEkzHbvBFPw6bVHeAtex0uCKQnDI8cVLHbej+rFZDjaj8k0w6de65Z/eZYN99O/q
         yRGdzP7R32VWRwcJy2R6jcIA81/wPVUBQgwXiqyvGU9ry/dpbdxm+3iPPPAwUTPcDfKM
         DxxtrA+m4vsH7dnp7ILArBYf1h9BU1S2uJmyqFbTYzm4rumhAkWBDkqV1y8EZpAI2gL1
         5bNKfbu3q4fQIjCr0MV4HW+Z1UJoEdzQRDOjw0NMUt0ogFpHRdIaR+MOzIegaojUqaLu
         e45zoL0+0IFBum2N4+0A1D8JZeV2fNPaiHvRjrpeDR9JnoIK7/0kKXMzQaWW7K2lXc3B
         S+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXahj3ItpGR0T2qFyurrngY0xMNOuQK04rAbGGKXwg8=;
        b=rSYxZWNsZl/zEULnVcPvFbumPHAdmpRYc5Qj/r47bFslkmnSLTsJDviIZSIx+vsOQx
         2wdMGNNNC7w9KIPsA9pYw4Gy6fmKJ9k8p8GIKpsQyGC6FShaRrr36J9BD9sKxTmYNYBS
         KORTpLTwuvJKDSDz0BQN/9vFHavsih1gzspHrKeSrhiZaAQpS1I19DirBs8ZxipIGzhO
         k51oNJlPymp3FT5VvNeSuhd57+8TgBeoFDVXYXgyONrVH/hMnfzI8/Wv8GTbBcmRDFNg
         3yxbaIniRYnsjDFU7e2vXcd/rDTYMnt0bkb576GVWwgU1EIzFxtbRkPsOKOWaQAAssSf
         o+qQ==
X-Gm-Message-State: ACrzQf0jR+/WtNbFAZzX80z3Gtg0YDqmZBlLcZ2bJBmlR9BDhMJZLeqP
        7cvg+MDLJAULaZ9dUc4jnjw=
X-Google-Smtp-Source: AMsMyM7EgRpR3UtNzunxY9ssX+lJSt0/yeLT9iytC+8eoVn8Tr4Ffx7ttEuYsZLaBvGT8n3LJWBdwA==
X-Received: by 2002:adf:de8f:0:b0:22e:361b:6a05 with SMTP id w15-20020adfde8f000000b0022e361b6a05mr5773321wrl.311.1665997937143;
        Mon, 17 Oct 2022 02:12:17 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fc4d:6548:d8bd:5bd])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d400e000000b0022ae401e9e0sm7921503wrp.78.2022.10.17.02.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:12:16 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC RESEND PATCH 0/2] RZ/G2UL separate out SoC specific parts
Date:   Mon, 17 Oct 2022 10:11:59 +0100
Message-Id: <20221017091201.199457-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

RFC-> RESEND RFC
* Patches rebased on [1]

RFC: [2]

[0] https://lore.kernel.org/linux-arm-kernel/Yyt8s5+pyoysVNeC@spud/T/
[1] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[2] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220929172356.301342-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

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

