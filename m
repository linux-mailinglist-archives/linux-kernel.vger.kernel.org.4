Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F9C73BB88
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjFWPWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjFWPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:22:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71071AC;
        Fri, 23 Jun 2023 08:22:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A1CB61A94;
        Fri, 23 Jun 2023 15:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16AFC433C8;
        Fri, 23 Jun 2023 15:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687533758;
        bh=sRj5H73scWO/9TBS+e2MwEJ4mooOFaJ0HbXk3SIJWAM=;
        h=From:To:Cc:Subject:Date:From;
        b=g5i0UUMm4sK9b+44ZtTnyAGB15oqq45T8zvGFnZlw7UWNvTOHaMpxcHU3sk2ieLBj
         N2j1PBm5Ewl+dSuQsuug7lBu1PAu09qzehGzGN9XQZdsYB1XiIWIYvSffIyxB+UGMe
         vMb1yWtjb2v+vhns3FARfi/Ppr3o98Oub/GBGkcruBfunUYXqrrr94yEC4eMLKygc2
         5cO6fHOSYd9UFuCNlkhf0XtU7ShyaDDKOmp7nn1L/C1oXmA2LEd9ZvtJCAHmfCCu7A
         1R+SuuslDJeeWi/XWllcgULrdPzkWnjyN0XUDjjYpRDxAO59Yac3x16Vqh1FMmUp7B
         yMqjfclwyFQow==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Henning Schild <henning.schild@siemens.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hans de Goede <hdegoede@redhat.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] leds: simatic-ipc-leds-gpio: restore LEDS_CLASS dependency
Date:   Fri, 23 Jun 2023 17:22:29 +0200
Message-Id: <20230623152233.2246285-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A recent rework accidentally lost the dependency on LEDS_CLASS, which
leads to a link error when LED support is disbled:

x86_64-linux-ld: drivers/leds/simple/simatic-ipc-leds.o: in function `simatic_ipc_leds_probe':
simatic-ipc-leds.c:(.text+0x10c): undefined reference to `devm_led_classdev_register_ext'

Add back the dependency that was there originally.

Fixes: a6c80bec3c935 ("leds: simatic-ipc-leds-gpio: Add GPIO version of Siemens driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/leds/simple/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
index 44fa0f93cb3b3..02443e745ff3b 100644
--- a/drivers/leds/simple/Kconfig
+++ b/drivers/leds/simple/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config LEDS_SIEMENS_SIMATIC_IPC
 	tristate "LED driver for Siemens Simatic IPCs"
+	depends on LEDS_CLASS
 	depends on SIEMENS_SIMATIC_IPC
 	help
 	  This option enables support for the LEDs of several Industrial PCs
-- 
2.39.2

