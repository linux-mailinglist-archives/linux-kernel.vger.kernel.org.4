Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0929D7278CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjFHH2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbjFHH2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:28:37 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D92371BEA;
        Thu,  8 Jun 2023 00:28:28 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxL_Abg4Fk5XMAAA--.1776S3;
        Thu, 08 Jun 2023 15:28:27 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxC8oVg4Fka+EGAA--.13745S2;
        Thu, 08 Jun 2023 15:28:25 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v12 0/2] spi: loongson: add bus driver for the loongson spi
Date:   Thu,  8 Jun 2023 15:28:17 +0800
Message-Id: <20230608072819.25930-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxC8oVg4Fka+EGAA--.13745S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
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
Change in v12:
		1. Reword the dt-bindings patch title.
		2. Use a specific spi compatible in dt-bindings and spi driver.
		3. Add Cc list for the reviewers of the previous version.
		4. Add a static for rdiv[12] array in loongson_spi_set_clk.
		5. Fixup the compile warning for spi HZ that reported by robot.
		6. Use "#define LOONGSON_... BIT(0)" in readb_poll_timeout.
		7. Add a error code return that when write spi failed.
		8. Use spi_controller* instead of spi_master* in all cases.
		9. Check for the error first which for clock gain.
		10. Drop the ->remove() in spi pci driver.
		11. Drop the comma for the terminator entry in pci_device_id.
		12. Adjust the head file in spi driver.
		13. Use forward declarations for device and spi_controller.

Yinbo Zhu (2):
  spi: add loongson spi bindings
  spi: loongson: add bus driver for the loongson spi controller

 .../bindings/spi/loongson,ls2k-spi.yaml       |  41 +++
 MAINTAINERS                                   |  10 +
 drivers/spi/Kconfig                           |  26 ++
 drivers/spi/Makefile                          |   3 +
 drivers/spi/spi-loongson-core.c               | 275 ++++++++++++++++++
 drivers/spi/spi-loongson-pci.c                |  55 ++++
 drivers/spi/spi-loongson-plat.c               |  47 +++
 drivers/spi/spi-loongson.h                    |  49 ++++
 8 files changed, 506 insertions(+)

-- 
2.20.1

