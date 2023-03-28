Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968826CBD6C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjC1LWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjC1LWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:22:34 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 501567EF4;
        Tue, 28 Mar 2023 04:22:22 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxJAztzSJkNA8TAA--.28937S3;
        Tue, 28 Mar 2023 19:22:21 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxOL3kzSJkalgPAA--.9160S2;
        Tue, 28 Mar 2023 19:22:18 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v4 0/2] spi: loongson: add bus driver for the loongson spi
Date:   Tue, 28 Mar 2023 19:22:08 +0800
Message-Id: <20230328112210.23089-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxOL3kzSJkalgPAA--.9160S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWFy3Zr48trWrJw4UuFW5Awb_yoW5Gry3pF
        43Cas8Kr4DJr4xArs3JayUuFyfZ3yrXr9rXFWaq398uryDZ34UZF4vgF4YvFsrAFnIvFyx
        XFyvgrs5Ga4UZw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b78Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026x
        CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
        JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
        1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
        Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
        UvcSsGvfC2KfnxnUUI43ZEXa7IU1tl1PUUUUU==
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Yinbo Zhu (2):
  dt-bindings: spi: add loongson spi
  spi: loongson: add bus driver for the loongson spi controller

 .../bindings/spi/loongson,ls-spi.yaml         |  43 +++
 MAINTAINERS                                   |  10 +
 drivers/spi/Kconfig                           |  31 ++
 drivers/spi/Makefile                          |   3 +
 drivers/spi/spi-loongson-core.c               | 304 ++++++++++++++++++
 drivers/spi/spi-loongson-pci.c                |  89 +++++
 drivers/spi/spi-loongson-plat.c               |  66 ++++
 drivers/spi/spi-loongson.h                    |  41 +++
 8 files changed, 587 insertions(+)

-- 
2.20.1

