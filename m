Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB5C6B4234
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjCJOAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjCJOAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:00:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFF0112A58;
        Fri, 10 Mar 2023 06:00:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B12BB822BF;
        Fri, 10 Mar 2023 14:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990C2C4339B;
        Fri, 10 Mar 2023 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678456829;
        bh=R+aNQ2IomzRQdSTKJnVX3oPGOyIiRzPDND+HRf7aPI0=;
        h=From:To:Cc:Subject:Date:From;
        b=Qb9QXgOArCM3c3j11ny4vRgLytx4TuwhR/v1DJbg6b5LZOHKqFyhbd4rG35ET74KI
         0asBNh27HvLIVBlRkT0b6vMjVqzVNsKafrfOJz/gNIMRE4Hcb2/QXOMsi/HZ31JCRY
         9ZoZCasjzG5rLFWIpDoxm/kqLcB/Uz+GRYwEPn2ppaPF7Rm38boI2wwjMWw1RCXirR
         aKw0lfYG80hgGCAXDzMBJMZQ9A+1NwsmZaq2lWr06PxND0IS9+jZhk6AujCIcJ6Bnb
         1ZufFC2pF0lXEP/3Qz9xxvH9S67bKQ28iSZf+l111wUl3Cz+WCEwLA5Vl4QrgP7GMR
         BX2n9WwTwVBNw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: x86-android-tablets: add CONFIG_PMIC_OPREGION dependency
Date:   Fri, 10 Mar 2023 15:00:15 +0100
Message-Id: <20230310140023.223612-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added call to intel_soc_pmic_exec_mipi_pmic_seq_element()
requires that function to be defined:

x86_64-linux-ld: drivers/platform/x86/x86-android-tablets/lenovo.o: in function `lenovo_yt3_init':
lenovo.c:(.init.text+0x72): undefined reference to `intel_soc_pmic_exec_mipi_pmic_seq_element'
x86_64-linux-ld: lenovo.c:(.init.text+0x8b): undefined reference to `intel_soc_pmic_exec_mipi_pmic_seq_element'

Fixes: 9b1d2662b8c5 ("platform/x86: x86-android-tablets: Add touchscreen support for Lenovo Yoga Tab 3 Pro YT3-X90F")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/x86-android-tablets/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/x86-android-tablets/Kconfig b/drivers/platform/x86/x86-android-tablets/Kconfig
index 2b3daca5380b..c31e4df34f80 100644
--- a/drivers/platform/x86/x86-android-tablets/Kconfig
+++ b/drivers/platform/x86/x86-android-tablets/Kconfig
@@ -6,6 +6,7 @@
 config X86_ANDROID_TABLETS
 	tristate "X86 Android tablet support"
 	depends on I2C && SPI && SERIAL_DEV_BUS && ACPI && EFI && GPIOLIB
+	depends on PMIC_OPREGION
 	help
 	  X86 tablets which ship with Android as (part of) the factory image
 	  typically have various problems with their DSDTs. The factory kernels
-- 
2.39.2

