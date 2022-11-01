Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E3261446D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 06:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiKAFys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 01:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKAFym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 01:54:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B1B14029
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=PfJarf9OujD0jxdJbIQ9WPjhLg0Bdxql4iSHEXIdul8=; b=EqX3bkwyVL0ndltH/Wyg8qYYKK
        2a47eCMm9XtO4KQHogXuUWyZ1wXZgWyZN0iiJ01tKvtgnJIAdimAHCTWF6HM4PF9Mz+TEcbtO5LuS
        1qJ+9/KBUyab55o8AR85yeWMQhkF1DcsdeKUbJdXJCewUJnB8uLnrsS7NU53b3RVdNotS3/0sCRPn
        TDjMbzQgbOpdno6A6/YjuM8xM1Sj/Aey+ZVB/Cfp1I8xv5fSFMmLV4Z4hU+xc7uBGGnhXeLe7GiP6
        NUUDwvC0TGprFJqUkyV+Fo8efzRqi1QW82DC8UaoMbtNkFabd0FlcezczMsl5bw4eDW9tSOYhmKFe
        TMXdNxvg==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opkEU-004M6c-S4; Tue, 01 Nov 2022 05:54:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] mfd: intel_soc_pmic: allow COMPILE_TEST or I2C_DESIGNWARE_PLATFORM
Date:   Mon, 31 Oct 2022 22:54:33 -0700
Message-Id: <20221101055433.16891-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus expressed a desire to have intel_soc_pmic_crc.o (INTEL_SOC_PMIC,
for Crystal Cove) be built on an "allmodconfig" build, when
I2C_DESIGNWARE_PLATFORM=m, to enhance build test coverage.

The PMIC driver won't work in this case since it requires
I2C_DESIGNWARE_PLATFORM=y to operate properly, but adding
"|| COMPILE_TEST" does improve the build test coverage.

Link: https://lore.kernel.org/all/CAHk-=wg=hh8xkPjiySnjAyR66AG64eyZ1Y9gHw+MCs8uuSZReA@mail.gmail.com/
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 drivers/mfd/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -603,7 +603,7 @@ config INTEL_SOC_PMIC
 	bool "Support for Crystal Cove PMIC"
 	depends on HAS_IOMEM && I2C=y && GPIOLIB && COMMON_CLK
 	depends on (X86 && ACPI) || COMPILE_TEST
-	depends on I2C_DESIGNWARE_PLATFORM=y
+	depends on I2C_DESIGNWARE_PLATFORM=y || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
