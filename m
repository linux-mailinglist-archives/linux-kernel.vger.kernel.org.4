Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F1872BB35
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjFLIwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjFLIv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:51:57 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A8C2F5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:51:53 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.124])
        by gateway (Coremail) with SMTP id _____8BxZ+ml3IZkWpgDAA--.5900S3;
        Mon, 12 Jun 2023 16:51:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.124])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXMqj3IZkl2cVAA--.53102S4;
        Mon, 12 Jun 2023 16:51:47 +0800 (CST)
From:   YingKun Meng <mengyingkun@loongson.cn>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        YingKun Meng <mengyingkun@loongson.cn>
Subject: [ PATCH v2 0/3] Add Loongson I2S controller support
Date:   Mon, 12 Jun 2023 16:50:48 +0800
Message-Id: <20230612085048.3039471-1-mengyingkun@loongson.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxXMqj3IZkl2cVAA--.53102S4
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQAADGSFuYEEQQAGsX
X-Coremail-Antispam: 1Uk129KBj93XoWxJr4fXF1UKr1ftw1fCr17Arc_yoW8Zw4xpa
        nxC393WFW5tF4ayFn3tFy8JrWrAryrCFsxJanrX34UGr9Fv3WUu343tF15ZFW3CryUKFyq
        9ry8G3y8G3ZxG3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset adds support for Loongson I2S controller, and
introduce a ASoC machine driver for loongson platform.

The Loongson I2S controller is available on Loongson
7a2000/2k2000 chips, works as a PCI device. It has two
private DMA controllers used to playback and capture.
Each DMA controller has one channel.

The ASoC machine driver adds support for audio device which
using loongson I2S controller to tranfser the audio data.
The audio device uses "PRP0001" as its ACPI device ID, which
provides a means to use the existing DT-compatible device
identification in ACPI.


Thanks.

---
v2:
* Use ACPI bindings to reference I2S and codec nodes.
* Add 'required' restriction for sound-dai property in
  dt-bindings.
* Fix build errors from lkp@intel.com.
* Replace pci_xxx() APIs with pcim_xxx() APIs.
* mirror changes in log printing.

v1:
* Add support for Loongson I2S controller.

Yingkun Meng (3):
  ASoC: Add support for Loongson I2S controller
  ASoC: loongson: Add Loongson ASoC Sound Card Support
  ASoC: dt-bindings: Add support for Loongson audio card

 .../sound/loongson,ls-audio-card.yaml         |  70 +++
 sound/soc/Kconfig                             |   1 +
 sound/soc/Makefile                            |   1 +
 sound/soc/loongson/Kconfig                    |  26 +
 sound/soc/loongson/Makefile                   |   8 +
 sound/soc/loongson/loongson_card.c            | 237 +++++++++
 sound/soc/loongson/loongson_i2s.c             | 213 ++++++++
 sound/soc/loongson/loongson_i2s.h             |  70 +++
 sound/soc/loongson/loongson_i2s_pci.c         | 500 ++++++++++++++++++
 9 files changed, 1126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml
 create mode 100644 sound/soc/loongson/Kconfig
 create mode 100644 sound/soc/loongson/Makefile
 create mode 100644 sound/soc/loongson/loongson_card.c
 create mode 100644 sound/soc/loongson/loongson_i2s.c
 create mode 100644 sound/soc/loongson/loongson_i2s.h
 create mode 100644 sound/soc/loongson/loongson_i2s_pci.c


base-commit: 62a97bea5cce5317d6d7630f7bcf0cdf5333e269
-- 
2.33.0

