Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89275E9518
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiIYRwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiIYRwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:52:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BCB1F629
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:52:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 30so6285309edw.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=tKIChjssk9qrfQZXpSX5zD6aIatsPePkOhcMo1qow4g=;
        b=Pmmlj3lT76utLBHuu2eVq7J7WxDwU4qJHC1HgjjZdWljTsQBb6ewQh2J/C7SqUXgCN
         u69G0QtqpddFf5wBa2APijOHMNSj0skQ4sW0w52RaaHHnFp+mhJn6TCbfa+Gez9Fwybw
         jdvdfp+X2Rgj1Cse7c1c1F8SmwEz/DYSg2vvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tKIChjssk9qrfQZXpSX5zD6aIatsPePkOhcMo1qow4g=;
        b=lyjgrUbIX/EEJDt7Yux3VcvX9PkTDhBm+RvZ6eaL/XO/dZ9rUiJdUQKHFVCeeLowtE
         zy/qIy8TXUWIVLqduKZgWiYJKwc1lU5Q+TMc39kWNN0sbJaOdnRRBKNsqi87r3tbepYi
         SkQjtIjhmzEN5IQJWrn4qu2NdqgzKHdXfBbvmCGd1xc83hSDmLcklVvMRvUTeco57M4y
         kwWS4gmVXkS1eyIE2YVSvO4y+0aCNpeYaJVT/wT59T77rMsPQZDuyLTEaTceTOhCSjkw
         VUYT4l4e8qEqFuKghWbxDbskXjlFFRYh7vwUxAoe5+FGBTX4Hnv2pows++LOF/JzlVbo
         3boA==
X-Gm-Message-State: ACrzQf1DKJDnfvbzqpEa9MCsX+Vt3BGsZ/20lcYTk575gsEM1+5NRqcP
        S78choHQVmhwnPSF8fKopsrvtzNPXoE6KA==
X-Google-Smtp-Source: AMsMyM4Kx2cZYORTXn6rNexr6JP9tU03J3wrYfA9VDWomLSa/cKrdR5EXdtuhXTPkZr5BHVRwa/nEg==
X-Received: by 2002:a05:6402:2802:b0:43a:9098:55a0 with SMTP id h2-20020a056402280200b0043a909855a0mr18339228ede.179.1664128336243;
        Sun, 25 Sep 2022 10:52:16 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-232-92-192.retail.telecomitalia.it. [95.232.92.192])
        by smtp.gmail.com with ESMTPSA id f23-20020a056402161700b0045703d699b9sm3252594edv.78.2022.09.25.10.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:52:15 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-can@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org
Subject: [RFC PATCH v4 0/5] can: bxcan: add support for ST bxCAN controller
Date:   Sun, 25 Sep 2022 19:52:04 +0200
Message-Id: <20220925175209.1528960-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds support for the basic extended CAN controller (bxCAN)
found in many low- to middle-end STM32 SoCs.

The driver design (one core module and one driver module) was inspired
by other ST drivers (e. g. drivers/iio/adc/stm32-adc.c,
drivers/iio/adc/stm32-adc-core.c) where device instances share resources.
The shared resources functions are implemented in the core module, the
device driver in a separate module.

The driver has been tested on the stm32f469i-discovery board with a
kernel version 5.19.0-rc2 in loopback + silent mode:

ip link set can0 type can bitrate 125000 loopback on listen-only on
ip link set up can0
candump can0 -L &
cansend can0 300#AC.AB.AD.AE.75.49.AD.D1

For uboot and kernel compilation, as well as for rootfs creation I used
buildroot:

make stm32f469_disco_sd_defconfig
make

but I had to patch can-utils and busybox as can-utils and iproute are
not compiled for MMU-less microcotrollers. In the case of can-utils,
replacing the calls to fork() with vfork(), I was able to compile the
package with working candump and cansend applications, while in the
case of iproute, I ran into more than one problem and finally I decided
to extend busybox's ip link command for CAN-type devices. I'm still
wondering if it was really necessary, but this way I was able to test
the driver.

Changes in v4:
- Remove "st,stm32f4-bxcan-core" compatible. In this way the can nodes
 (compatible "st,stm32f4-bxcan") are no longer children of a parent
  node with compatible "st,stm32f4-bxcan-core".
- Add the "st,gcan" property (global can memory) to can nodes which
  references a "syscon" node containing the shared clock and memory
  addresses.
- Replace the node can@40006400 (compatible "st,stm32f4-bxcan-core")
  with the gcan@40006600 node ("sysnode" compatible). The gcan node
  contains clocks and memory addresses shared by the two can nodes
  of which it's no longer the parent.
- Add to can nodes the "st,gcan" property (global can memory) which
  references the gcan@40006600 node ("sysnode compatibble).
- Add "dt-bindings: arm: stm32: add compatible for syscon gcan node" patch.
- Drop the core driver. Thus bxcan-drv.c has been renamed to bxcan.c and
  moved to the drivers/net/can folder. The drivers/net/can/bxcan directory
  has therefore been removed.
- Use the regmap_*() functions to access the shared memory registers.
- Use spinlock to protect bxcan_rmw().
- Use 1 space, instead of tabs, in the macros definition.
- Drop clock ref-counting.
- Drop unused code.
- Drop the _SHIFT macros and use FIELD_GET()/FIELD_PREP() directly.
- Add BXCAN_ prefix to lec error codes.
- Add the macro BXCAN_RX_MB_NUM.
- Enable time triggered mode and use can_rx_offload().
- Use readx_poll_timeout() in function with timeouts.
- Loop from tail to head in bxcan_tx_isr().
- Check bits of tsr register instead of pkts variable in bxcan_tx_isr().
- Don't return from bxcan_handle_state_change() if skb/cf are NULL.
- Enable/disable the generation of the bus error interrupt depending
  on can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING.
- Don't return from bxcan_handle_bus_err() if skb is NULL.
- Drop statistics updating from bxcan_handle_bus_err().
- Add an empty line in front of 'return IRQ_HANDLED;'
- Rename bxcan_start() to bxcan_chip_start().
- Rename bxcan_stop() to bxcan_chip_stop().
- Disable all IRQs in bxcan_chip_stop().
- Rename bxcan_close() to bxcan_ndo_stop().
- Use writel instead of bxcan_rmw() to update the dlc register.

Changes in v3:
- Remove 'Dario Binacchi <dariobin@libero.it>' SOB.
- Add description to the parent of the two child nodes.
- Move "patterProperties:" after "properties: in top level before "required".
- Add "clocks" to the "required:" list of the child nodes.
- Remove 'Dario Binacchi <dariobin@libero.it>' SOB.
- Add "clocks" to can@0 node.
- Remove 'Dario Binacchi <dariobin@libero.it>' SOB.
- Remove a blank line.
- Remove 'Dario Binacchi <dariobin@libero.it>' SOB.
- Fix the documentation file path in the MAINTAINERS entry.
- Do not increment the "stats->rx_bytes" if the frame is remote.
- Remove pr_debug() call from bxcan_rmw().

Changes in v2:
- Change the file name into 'st,stm32-bxcan-core.yaml'.
- Rename compatibles:
  - st,stm32-bxcan-core -> st,stm32f4-bxcan-core
  - st,stm32-bxcan -> st,stm32f4-bxcan
- Rename master property to st,can-master.
- Remove the status property from the example.
- Put the node child properties as required.
- Remove a blank line.
- Fix sparse errors.
- Create a MAINTAINERS entry.
- Remove the print of the registers address.
- Remove the volatile keyword from bxcan_rmw().
- Use tx ring algorithm to manage tx mailboxes.
- Use can_{get|put}_echo_skb().
- Update DT properties.

Dario Binacchi (5):
  dt-bindings: arm: stm32: add compatible for syscon gcan node
  dt-bindings: net: can: add STM32 bxcan DT bindings
  ARM: dts: stm32: add CAN support on stm32f429
  ARM: dts: stm32: add pin map for CAN controller on stm32f4
  can: bxcan: add support for ST bxCAN controller

 .../bindings/arm/stm32/st,stm32-syscon.yaml   |    2 +
 .../bindings/net/can/st,stm32-bxcan.yaml      |   83 ++
 MAINTAINERS                                   |    7 +
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi        |   30 +
 arch/arm/boot/dts/stm32f429.dtsi              |   29 +
 drivers/net/can/Kconfig                       |   12 +
 drivers/net/can/Makefile                      |    1 +
 drivers/net/can/bxcan.c                       | 1110 +++++++++++++++++
 8 files changed, 1274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml
 create mode 100644 drivers/net/can/bxcan.c

-- 
2.32.0

