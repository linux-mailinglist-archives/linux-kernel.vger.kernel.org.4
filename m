Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84DE607B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiJUP47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiJUP4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:56:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857B627EAEC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:56:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF44661EFC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3BCC433C1;
        Fri, 21 Oct 2022 15:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666367786;
        bh=j50IJWTM+ka8Tvy0ZYlIik8TuO6XdXeMeLuiUvXyurg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbKjGctVSH/+SRrzYRqJIVMhwq0w15beQQOedRgkQ9SV9jKk73nrXQk53jHiZIvZ9
         B4LaRJw+gP9aXeM9jFtA1oUzF1E52Rhsn6Y0ioO3o85oddYoJxcJdxqX3p3v+j1V6v
         Z2+VNwBrwL7/HoLOqf2YftT9VP6ta7X2aNWbsNygoOXGztjK+sNlu9UrG/es4BGrKl
         hXwaYbh9bxtRCRyZbL7TaOk9SfEXZ4A0veeKDoTcLtqar1UOfXYpfbdm342mYzU/ts
         oS80UbAjtqjVe3dHfJbZP4lhhbaqw7yKdxqrPqhD/5y/vepJLFek9xp5BekyWFEZcm
         d62ZZghzk2FMQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/11] ARM: mmp: select specific CPU implementation
Date:   Fri, 21 Oct 2022 17:49:37 +0200
Message-Id: <20221021155000.4108406-8-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021155000.4108406-1-arnd@kernel.org>
References: <20221021155000.4108406-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The behavior of the MMP platform code depends on whether the
CPU_PXA168/CPU_PXA910/CPU_MMP2 symbols are enabled or not.

I believe the intention here was that these can be left disabled for
a pure DT-only build, but it's not clear if that actually works. At
the minimum, the cpu_is_pxa168() and cpu_is_pxa910() checks behave
differently, which causes changes in the power management code.

For the moment, make the behavior depend on whether CONFIG_ATAGS is set
or not, to make it easier to bisect the removal of the old code later.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mmp/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index d71417d57961..da38106149c4 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -113,6 +113,8 @@ config MACH_MMP_DT
 	select PINCTRL_SINGLE
 	select ARCH_HAS_RESET_CONTROLLER
 	select CPU_MOHAWK
+	select CPU_PXA168 if ATAGS
+	select CPU_PXA910 if ATAGS
 	help
 	  Include support for Marvell MMP2 based platforms using
 	  the device tree. Needn't select any other machine while
@@ -125,6 +127,7 @@ config MACH_MMP2_DT
 	select PINCTRL_SINGLE
 	select ARCH_HAS_RESET_CONTROLLER
 	select CPU_PJ4
+	select CPU_MMP2 if ATAGS
 	select PM_GENERIC_DOMAINS if PM
 	select PM_GENERIC_DOMAINS_OF if PM && OF
 	help
-- 
2.29.2

