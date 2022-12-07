Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE566645DBF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiLGPiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLGPiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:38:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176BF60B7B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 07:38:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8947D61A74
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E494CC433D6;
        Wed,  7 Dec 2022 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670427495;
        bh=gIYSCsdNqdI8dXfIX111a9EORuoTxpENbiX41cBRPho=;
        h=From:To:Cc:Subject:Date:From;
        b=ovPBjn0bru6h+x3hc6h++tolfTYgh7jfc1jV2vw7vCTVnghrv3HE+MUfcp3xAxdLZ
         RNmOi5hiJmyyZt+5ixcgODPuaEHilPXTluUQw47QJIfDGAtHhI4MVG/bth+ayzH0id
         4qPRnqw0IyY+AQjNOZMk8rNTQNvFREMS6Lo3X0Z3ofZafqgQepjIi2zcRrFpLt1FtE
         T1zl9OVkqG9aurGN+4SbMS/0lndzv4wnn5TaZ0jF2fGdTWbycEm1gPy5w8kvbvv4CD
         +HLBRKb54GIIpcvz8aqZuWnNh5IaoBd8G+/8+6ETZSTw/m7wthCDLybSf6ybzJB96R
         j21ww/zxC6/9Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1p2wUv-00B9ZW-I4;
        Wed, 07 Dec 2022 15:38:13 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Curtin <ecurtin@redhat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jean Delvare <jdelvare@suse.de>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liu Peibao <liupeibao@loongson.cn>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Talel Shenhar <talel@amazon.com>,
        wangjianli <wangjianli@cdjrlc.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 6.2
Date:   Wed,  7 Dec 2022 15:37:58 +0000
Message-Id: <20221207153758.570431-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, aidanmacdonald.0x0@gmail.com, angelogioacchino.delregno@collabora.com, christophe.jaillet@wanadoo.fr, ecurtin@redhat.com, chenhuacai@loongson.cn, jdelvare@suse.de, lvjianmin@loongson.cn, j.neuschaefer@gmx.net, konrad.dybcio@somainline.org, krzysztof.kozlowski@linaro.org, liupeibao@loongson.cn, michael@walle.cc, philmd@linaro.org, samuel@sholland.org, sean.anderson@seco.com, shangxiaojing@huawei.com, talel@amazon.com, wangjianli@cdjrlc.com, weiyongjun1@huawei.com, ye.xingchen@zte.com.cn, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

Here's a tiny set of updates for 6.2. It's all pretty uninteresting,
and mostly focussed on the never ending of stream of Loongarch related
patches. Because ACPI wasn't bad enough, they also have DT now.

Please pull¸

	M.

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-6.2

for you to fetch changes up to 6ed54e1789a29d3f1557454cc7d2eb9c10d1d37b:

  Merge branch irq/misc-6.2 into irq/irqchip-next (2022-12-05 10:45:41 +0000)

----------------------------------------------------------------
irqchip updates for 6.2

- More APCI fixes and improvements for the LoongArch architecture,
  adding support for the HTVEC irqchip, suspend-resume, and some
  PCI INTx workarounds

- Initial DT support for LoongArch. I'm not even kidding.

- Support for the MTK CIRQv2, a minor deviation from the original version

- Error handling fixes for wpcm450, GIC...

- BE detection for a FSL controller

- Declare the Sifive PLIC as wake-up agnostic

- Simplify fishing out the device data for the ST irqchip

- Mark some data structures as __initconst in the apple-aic driver

- Switch over from strtobool to kstrtobool

- COMPILE_TEST fixes

----------------------------------------------------------------
Aidan MacDonald (1):
      irqchip/sl28cpld: Replace irqchip mask_invert with unmask_base

AngeloGioacchino Del Regno (4):
      dt-bindings: interrupt-controller: mediatek,cirq: Migrate to dt schema
      dt-bindings: interrupt-controller: mediatek,cirq: Document MT8192
      irqchip/irq-mtk-cirq: Move register offsets to const array
      irqchip/irq-mtk-cirq: Add support for System CIRQ on MT8192

Christophe JAILLET (1):
      irqchip/gic: Use kstrtobool() instead of strtobool()

Huacai Chen (7):
      irqchip/loongson-htvec: Add ACPI init support
      irqchip/loongson-htvec: Add suspend/resume support
      irqchip/loongson-eiointc: Add suspend/resume support
      irqchip/loongson-pch-pic: Add suspend/resume support
      irqchip/loongson-pch-lpc: Add suspend/resume support
      irqchip/loongarch: Adjust acpi_cascade_irqdomain_init() and sub-routines
      irqchip/loongarch-cpu: Fix a missing prototype warning

Jean Delvare (1):
      irqchip/al-fic: Drop obsolete dependency on COMPILE_TEST

Jianmin Lv (4):
      ACPI / PCI: fix LPIC IRQ model default PCI IRQ polarity
      irqchip/loongson-pch-pic: Fix translate callback for DT path
      irqchip/loongson-pch-pic: Support to set IRQ type for ACPI path
      irqchip/loongson-liointc: Support to set IRQ type for ACPI path

Konrad Dybcio (1):
      irqchip/apple-aic: Mark aic_info structs __initconst

Liu Peibao (3):
      irqchip: loongarch-cpu: add DT support
      dt-bindings: interrupt-controller: add yaml for LoongArch CPU interrupt controller
      irqchip/loongson-liointc: Fix improper error handling in liointc_init()

Marc Zyngier (4):
      Merge branch irq/loongarch-acpi into irq/irqchip-next
      Merge branch irq/loongarch-of into irq/irqchip-next
      Merge branch irq/cirq-v2 into irq/irqchip-next
      Merge branch irq/misc-6.2 into irq/irqchip-next

Samuel Holland (1):
      irqchip/sifive-plic: Support wake IRQs

Sean Anderson (1):
      irqchip/ls-extirq: Fix endianness detection

Shang XiaoJing (1):
      irqchip: gic-pm: Use pm_runtime_resume_and_get() in gic_probe()

Wei Yongjun (1):
      irqchip/wpcm450: Fix memory leak in wpcm450_aic_of_init()

wangjianli (1):
      irqchip/mips-gic: Drop repeated word in comment

ye xingchen (1):
      irqchip/st: Use device_get_match_data() to simplify the code

 .../loongarch,cpu-interrupt-controller.yaml        |  34 ++++
 .../interrupt-controller/mediatek,cirq.txt         |  33 ----
 .../interrupt-controller/mediatek,mtk-cirq.yaml    |  68 ++++++++
 arch/loongarch/include/asm/irq.h                   |   2 +-
 drivers/acpi/pci_irq.c                             |   6 +-
 drivers/irqchip/Kconfig                            |   3 +-
 drivers/irqchip/irq-apple-aic.c                    |   6 +-
 drivers/irqchip/irq-gic-pm.c                       |   2 +-
 drivers/irqchip/irq-gic-v3.c                       |   3 +-
 drivers/irqchip/irq-gic.c                          |   3 +-
 drivers/irqchip/irq-loongarch-cpu.c                |  48 ++++--
 drivers/irqchip/irq-loongson-eiointc.c             |  63 ++++++--
 drivers/irqchip/irq-loongson-htvec.c               | 176 +++++++++++++++++----
 drivers/irqchip/irq-loongson-liointc.c             |  37 ++++-
 drivers/irqchip/irq-loongson-pch-lpc.c             |  25 +++
 drivers/irqchip/irq-loongson-pch-pic.c             |  76 +++++++--
 drivers/irqchip/irq-ls-extirq.c                    |   2 +-
 drivers/irqchip/irq-mips-gic.c                     |   2 +-
 drivers/irqchip/irq-mtk-cirq.c                     |  95 +++++++++--
 drivers/irqchip/irq-sifive-plic.c                  |   6 +-
 drivers/irqchip/irq-sl28cpld.c                     |   3 +-
 drivers/irqchip/irq-st.c                           |   7 +-
 drivers/irqchip/irq-wpcm450-aic.c                  |   1 +
 23 files changed, 557 insertions(+), 144 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml
