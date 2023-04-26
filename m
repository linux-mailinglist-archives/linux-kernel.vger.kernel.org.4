Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62D6EEF05
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbjDZHPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbjDZHPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:15:24 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECDCE40CF;
        Wed, 26 Apr 2023 00:14:37 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxV+mDzkhkQOwAAA--.1617S3;
        Wed, 26 Apr 2023 15:10:59 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxWbJ3zkhkd2M8AA--.16320S2;
        Wed, 26 Apr 2023 15:10:56 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v9 0/2] spi: loongson: add bus driver for the loongson spi
Date:   Wed, 26 Apr 2023 15:10:43 +0800
Message-Id: <20230426071045.20753-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxWbJ3zkhkd2M8AA--.16320S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWFy3Zr48trWrJw4UuFW5Awb_yoW5KF4rpF
        W5C3Z8Kr4DJF4xArs3Jay7ua4rZ3yrXrZrXay3t34DuryDZ34UZr1ktF1rZrsrAF4ayFn2
        qFy0grs5Ga4UZrUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
        6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
        WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
        6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UYxBIdaVFxhVjvjDU0xZFpf9x07j8pnQUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loongson platform support spi hardware controller and this series patch
was to add spi driver and binding support.

Change in v2:
		1. This [PATCH v2 1/2] dt-bindings patch need depend on clk patch:
	 	   https://
		   lore.kernel.org/all/20230307115022.12846-1-zhuyinbo@loongson.cn/
		2. Remove the clock-names in spi yaml file.
		3. Add "loongson,ls7a-spi" compatible in spi yaml file.
		4. Add an || COMPILE_TEST and drop && PCI then add some CONFIG_PCI
		   macro to limit some pci code.
		5. Make the spi driver top code comment block that use C++ style.
		6. Drop spi->max_speed_hz.
		7. Add a spin_lock for loongson_spi_setup.
		8. Add a timeout and cpu_relax() in loongson_spi_write_read_8bit.
		9. Add spi_transfer_one and drop transfer and rework entire spi
		   driver that include some necessary changes.
		10. Use module_init replace subsys_initcall.
		11. About PM interface that I don't find any issue so I don't add
		    any changes.
Change in v3:
		1. This [PATCH v3 1/2] dt-bindings patch need depend on clk patch:
		   https://
		   lore.kernel.org/all/20230323025229.2971-1-zhuyinbo@loongson.cn/
		2. Drop the unused blank line in loongson,ls-spi.yaml file.
		3. Replace clock minItems with clock maxItems in yaml file.
		4. Separate spi driver into platform module, pci module and core
		   module.
		5. Replace DIV_ROUND_UP with DIV_ROUND_UP_ULL to fix compile error
		   "undefined reference to `__aeabi_uldivmod'" and  "__udivdi3 undefined"
		   that reported by test robot.
		6. Remove the spin lock.
		7. Clear the loongson_spi->hz and loongson_spi->mode in setup to fixup
		   the issue that multiple spi device transfer that maybe cause spi was
		   be misconfigured.
Change in v4:
		1. This [PATCH v4 1/2] dt-bindings patch need depend on clk patch:
		   https://
		   lore.kernel.org/all/20230323025229.2971-1-zhuyinbo@loongson.cn/
		2. Add "#include <linux/io.h>" in spi-loongson-core.c for fix the compile
		   issue which devm_ioremap no declaration.
		3. Add "EXPORT_SYMBOL_GPL(loongson_spi_dev_pm_ops)" in
		   spi-loongson-core.c for fix the compile issue which
		   loongson_spi_dev_pm_ops undefined.
Change in v5:
		1. Get rid of the clock patch's dependency and open-code the clock IDs.
		2. Fixup checkpatch issue that by installed ply and gitpython package
		   locally, but this series of patch's code doesn't have any change.
Change in v6:
		1. Remove the "#include <dt-bindings/clock/loongson,ls2k-clk.h>" in
		   yaml file.
Change in v7:
		1. Remove the "loongson,ls7a-spi" and change yaml file name as
		   "loongson,ls2k-spi.yaml".
		2. Use module_pci_driver and module_platform_driver to replace
		   module_init and module_exit.
		3. Drop ".owner	= THIS_MODULE" in spi platform driver.
		4. Add devm_spi_alloc_master devm_spi_register_master to simplify code.
		5. Add pci_disable_device() in loongson_spi_pci_unregister.
Change in v8:
		1. Add reviewed-by information for spi bindings patch.
		2. Fixup the uncorrect spi yaml file path in MAINTAINERS file.
		3. Add spi_master_suspend and spi_master_resume in spi pm function.
Change in v9:
		1. Make spi_master_suspend go first in pm suspend.

Yinbo Zhu (2):
  dt-bindings: spi: add loongson spi
  spi: loongson: add bus driver for the loongson spi controller

 .../bindings/spi/loongson,ls2k-spi.yaml       |  41 +++
 MAINTAINERS                                   |  10 +
 drivers/spi/Kconfig                           |  31 ++
 drivers/spi/Makefile                          |   3 +
 drivers/spi/spi-loongson-core.c               | 296 ++++++++++++++++++
 drivers/spi/spi-loongson-pci.c                |  72 +++++
 drivers/spi/spi-loongson-plat.c               |  47 +++
 drivers/spi/spi-loongson.h                    |  41 +++
 8 files changed, 541 insertions(+)

-- 
2.20.1

