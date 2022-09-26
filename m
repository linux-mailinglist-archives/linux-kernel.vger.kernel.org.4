Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C5F5E9C04
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiIZI1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiIZI12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:27:28 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F65636DEA;
        Mon, 26 Sep 2022 01:27:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MbbRM1qnWz6R5Gc;
        Mon, 26 Sep 2022 16:25:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP4 (Coremail) with SMTP id gCh0CgAHf45oYjFjX1aNBQ--.36343S4;
        Mon, 26 Sep 2022 16:27:21 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] allow gpio simulator be used as interrupt controller
Date:   Mon, 26 Sep 2022 08:44:25 +0000
Message-Id: <20220926084428.1792815-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHf45oYjFjX1aNBQ--.36343S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWDCr17Cw4Utw47AF4ruFg_yoW8AryfpF
        W3Cr4fJr1vqF13Ar9xtFy8Cr9Ivrn8Jrn8Gwn2kF48Gr1xCFyUXrW7tryrXryUJrW7Xw4U
        ZrWFyF18Gryqyr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5zhl50pqjm3046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

This series allow gpio simulator be used as interrupt controller, the use
case is mockup some device which using GPIO as interrupt controller, such
as mcp2515 CAN device. With the dts [1], we can mockup a mcp2515 device,
and trigger irq by following commands:

 $ echo pull-down > /sys/bus/gpio/devices/gpiochip0/sim_gpio0/pull
 $ echo pull-up > /sys/bus/gpio/devices/gpiochip0/sim_gpio0/pull

v1 -> v2:
 - add use case to gpio-sim.rst

--[1]---------------------------------------------------------
/dts-v1/;

#include <dt-bindings/interrupt-controller/irq.h>

/ {
	clk24m: clk24m {
		compatible = "fixed-clock";
		clock-output-names = "clk24m";
		clock-frequency = <24000000>;
		#clock-cells = <0>;
	};

	gpio-sim {
		compatible = "gpio-simulator";

		bank0: bank0 {
			gpio-controller;
			#gpio-cells = <2>;
			ngpios = <16>;

			interrupt-controller;
			#interrupt-cells = <2>;

			line_b-hog {
				gpio-hog;
				gpios = <0 1>;
				input;
				line-name = "irq-sim";
			};
		};
	};

	spi: spi {
		compatible = "spi-mockup";

		#address-cells = <1>;
		#size-cells = <0>;

		can0: can@1 {
			compatible = "microchip,mcp2515";
			reg = <1>;
			clocks = <&clk24m>;
			interrupt-parent = <&bank0>;
			interrupts = <0 IRQ_TYPE_EDGE_BOTH>;
		};

	};
};
------------------------------><-----------------------------

Wei Yongjun (3):
  genirq/irq_sim: Allow both one and two cell bindings
  gpio: sim: make gpio simulator can be used as interrupt controller
  gpio: sim: document use case for interrupt controller

 Documentation/admin-guide/gpio/gpio-sim.rst | 44 +++++++++++++++++++++
 drivers/gpio/gpio-sim.c                     |  2 +-
 kernel/irq/irq_sim.c                        |  1 +
 3 files changed, 46 insertions(+), 1 deletion(-)

-- 
2.34.1

