Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C133470B605
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjEVHLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjEVHKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:10:51 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A79D6B5;
        Mon, 22 May 2023 00:10:40 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Cxd+ltFWtkddgKAA--.18579S3;
        Mon, 22 May 2023 15:10:37 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfTtnFWtkr8RuAA--.54865S2;
        Mon, 22 May 2023 15:10:35 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v11 0/2] spi: loongson: add bus driver for the loongson spi
Date:   Mon, 22 May 2023 15:10:28 +0800
Message-Id: <20230522071030.5193-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfTtnFWtkr8RuAA--.54865S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWFy3Zr48trWrJw4UuFW5Awb_yoWrKFW5pF
        W5Cas8Kr48Jr4xArs3Aay7uFyFv3y3X39rXay3tw47uryDZ34UAryktF18Zr9xAFsIy3Z2
        qFy0grs5Ga4UZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bzkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
        JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
        BIdaVFxhVjvjDU0xZFpf9x07UC_M3UUUUU=
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
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
Change in v10:
		1. Fix the compile issue about of_node_get and of_get_property no
		   declaration.
		2. set config SPI_LOONGSON_CORE invisible.
		3. Captial "spi" in commit log and Kconfig file.
		4. Write header files in alphabetical order.
		5. Use clamp_val, GENMASK() and BIT() in spi clock setting.
		6. Optimize clock and mode setting code.
		7. Use readb_poll_timeout in loongson_spi_write_read_8bit.
		8. Remove some useless dmesg print.
		9. Use device_set_node replace of_node_get.
		10. Use dev_err_probe in code.
		11. Use devm_clk_get_optional replace devm_clk_get.
		12. Remove SPI_NO_CS for drop 2k500 non common type spi.
		13. Use pcim_enable_device() and pcim_iomap_regions() in spi pci
		    driver.
		14. Passing the remapped address in loongson_spi_init_master.
		15. Remove the useless goto flag "err_out".
		16. Use pci vendor id in pci_ids.h.
		17. Use devm_platform_ioremap_resource in spi platform driver.
		18. Remove the useless item in pci_device_id.
		19. Remove the inned comma in of_device_id.
		20. Add some headfile in spi_loongson.h.
		21. Remove the useless extern for loongson_spi_init_master in
		    spi_loongson.h.
Change in v11:
		1. Use spi_get_chipselect() to replace all spi->chip_select in
		   spi driver

Yinbo Zhu (2):
  dt-bindings: spi: add loongson spi
  spi: loongson: add bus driver for the loongson spi controller

 .../bindings/spi/loongson,ls2k-spi.yaml       |  41 +++
 MAINTAINERS                                   |  10 +
 drivers/spi/Kconfig                           |  26 ++
 drivers/spi/Makefile                          |   3 +
 drivers/spi/spi-loongson-core.c               | 279 ++++++++++++++++++
 drivers/spi/spi-loongson-pci.c                |  61 ++++
 drivers/spi/spi-loongson-plat.c               |  46 +++
 drivers/spi/spi-loongson.h                    |  47 +++
 8 files changed, 513 insertions(+)

-- 
2.20.1

