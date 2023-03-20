Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CCC6C06EB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 01:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCTAxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 20:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCTAxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 20:53:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E65C19F28;
        Sun, 19 Mar 2023 17:53:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BF40FEC;
        Sun, 19 Mar 2023 17:53:46 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3DD53F885;
        Sun, 19 Mar 2023 17:52:59 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?q?Andr=C3=A1s=20Szemz=C3=B6?= <szemzo.andras@gmail.com>,
        Icenowy Zheng <uwu@icenowy.me>,
        Fabien Poussin <fabien.poussin@gmail.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Belisko Marek <marek.belisko@gmail.com>
Subject: [PATCH v2 0/4] ARM: dts: sunxi: Add MangoPi MQ-R board support
Date:   Mon, 20 Mar 2023 00:52:45 +0000
Message-Id: <20230320005249.13403-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is v2, mostly acknowledging the fact that there is an Allwinner D1s
version of the board as well, thus splitting the board .dts into a
shared .dtsi and a stub .dts for the ARM version. I don't have the RISC-V
version, so cannot provide (nor test) this .dts file, but creation should
be easy, being based on the shared board .dtsi file.
Since the D1/D1s .dts files are now merged, this patch set should compile
cleanly now.

======================================

The MangoPi MQ-R-T113 is a small SBC with the Allwinner T113-s3 SoC.
That is a very close relative to the Allwinner D1/D1s SoCs, but with
Arm Cortex-A7 cores, and 128 MB of SIP co-packaged DDR3 DRAM.

This series introduces the missing T113-s .dtsi, which builds on top of
the D1/D1s .dtsi, but adds the ARM specific peripherals, like the CPU
cores, the arch timer, the GIC and the PMU.
This requires to add a symlink to the RISC-V DT directory in patch 1/4,
to be able to easily reference the base .dtsi from other architecture
directories.
Since there are versions of the MQ-R boards with the Allwinner D1s,
there is shared .dtsi describing the board peripherals, plus a small
stub .dts to tie together all bits for the actual board.

Cheers,
Andre

Changelog v1 ... v2:
- rebase on top of v6.3-rc3 (including now merged D1/D1s .dtsi files)
- refine board naming, stating both RISC-V and ARM versions
- move board .dts into a shared .dtsi (to cover RISC-V version)
- fix 5V regulator node name

Andre Przywara (4):
  dts: add riscv include prefix link
  ARM: dts: sunxi: add Allwinner T113-s SoC .dtsi
  dt-bindings: arm: sunxi: document MangoPi MQ-R board names
  ARM: dts: sunxi: add MangoPi MQ-R-T113 board

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 .../devicetree/bindings/riscv/sunxi.yaml      |   5 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/sun8i-t113s-mangopi-mq-r-t113.dts     |  35 +++++
 arch/arm/boot/dts/sun8i-t113s.dtsi            |  59 ++++++++
 .../boot/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi | 126 ++++++++++++++++++
 scripts/dtc/include-prefixes/riscv            |   1 +
 7 files changed, 232 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-t113s-mangopi-mq-r-t113.dts
 create mode 100644 arch/arm/boot/dts/sun8i-t113s.dtsi
 create mode 100644 arch/arm/boot/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi
 create mode 120000 scripts/dtc/include-prefixes/riscv

-- 
2.35.7

