Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBE5627C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiKNLiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbiKNLid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:38:33 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FFBBE7F;
        Mon, 14 Nov 2022 03:38:29 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8DxPdm0KHJjteMGAA--.20740S3;
        Mon, 14 Nov 2022 19:38:28 +0800 (CST)
Received: from loongson-PC.loongson.cn (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxTuCwKHJjCZMSAA--.50121S2;
        Mon, 14 Nov 2022 19:38:28 +0800 (CST)
From:   Liu Peibao <liupeibao@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] irqchip: loongarch-cpu: add DT support
Date:   Mon, 14 Nov 2022 19:38:22 +0800
Message-Id: <20221114113824.1880-1-liupeibao@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxTuCwKHJjCZMSAA--.50121S2
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQAKCmNw3mQUUAAAss
X-Coremail-Antispam: 1Uk129KBjvdXoWrWFWDKr48CFW8WFW7Wr1ftFb_yoWxXrb_uF
        1Iya45CryDCFyjyayqvr4rJ343JFWUXFyFka1DtF18XFn0yr15WFnrZ3y3Zr1vqFW5Jrn3
        trs0yr4rAF17CjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        17kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjxUcVc_UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches add the DT support for LoongArch compatible CPU interrupt
controller.

V1 -> V2: patch2/2: update commit log and remove redundant description in yaml.

Liu Peibao (2):
  irqchip: loongarch-cpu: add DT support
  dt-bindings: interrupt-controller: add yaml for LoongArch CPU
    interrupt controller

 .../loongarch,cpu-interrupt-controller.yaml   | 34 +++++++++++++++++++
 drivers/irqchip/irq-loongarch-cpu.c           | 19 +++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml

-- 
2.20.1

