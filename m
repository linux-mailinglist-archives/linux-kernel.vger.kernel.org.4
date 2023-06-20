Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC25B736701
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjFTJIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjFTJIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:08:22 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E908AC2;
        Tue, 20 Jun 2023 02:08:19 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Cxd+mCbJFkkSMHAA--.12734S3;
        Tue, 20 Jun 2023 17:08:18 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxTMp8bJFkG30hAA--.19516S2;
        Tue, 20 Jun 2023 17:08:16 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Yun <liuyun@loongson.cn>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v4 0/2] soc: loongson2_pm: add power management support
Date:   Tue, 20 Jun 2023 17:08:09 +0800
Message-Id: <20230620090811.721-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxTMp8bJFkG30hAA--.19516S2
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

Loongson-2 platform support Power Management Controller (ACPI) and this
series patch was to add PM driver that base on dts and PM binding support.

Change in v4:
		1. The patch "[PATCH v3 1/3] loongarch: export some arch-specific
		   pm interfaces" had been merged into linux-next tree thus this
		   v4 series patch need drop it and need depend on it and it's
		   patch link was:
https://lore.kernel.org/all/20230615091757.24686-2-zhuyinbo@loongson.cn/
		2. Remove the pmc label in dt-binding patch.
		3. Add the Co-developed-by for driver patch.
		4. Simplify the loongson2_suspend_valid_state that "return
		   (state == PM_SUSPEND_MEM)".
		5. Use Using loongson2_pm_irq_enable() to replace.
		   loongson2_power_button_irq_enable().
		6. Remove the "oneOf" in dt-bindings patch.
		7. Replace "suspend-address" that use "loongson,suspend-address".
		8. Use u64 type that for "loongson,suspend-address".
		9. Rename "pm" to "power-mangement" in dt-bindings patch.
		10. Add the reivewed-by for dt-bindings patch.
Change in v3:
		1. Reword the [1/3] patch commit log and title.
		2. Use the old naming for suspend interface for the [1/3] and
		   [3/3] patch.
		3. Combine some small function in the driver patch.
		4. Rename 'pwrbt' to 'button' in the driver patch.
		5. Use the specific compatible in yaml file.
Change in v2:
		1. Fixup the "suspend-address" description.
		2. Remove the "return -EINVAL" in PM driver probe when firmware
		   no configure "suspend-address" property in dts in oder to
		   other PM state to work.

Yinbo Zhu (2):
  soc: dt-bindings: add loongson-2 pm
  soc: loongson2_pm: add power management support

 .../soc/loongson/loongson,ls2k-pmc.yaml       |  52 +++++
 MAINTAINERS                                   |   7 +
 drivers/soc/loongson/Kconfig                  |  10 +
 drivers/soc/loongson/Makefile                 |   1 +
 drivers/soc/loongson/loongson2_pm.c           | 215 ++++++++++++++++++
 5 files changed, 285 insertions(+)

-- 
2.20.1

