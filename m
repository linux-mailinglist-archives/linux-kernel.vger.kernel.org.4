Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981335F58E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJEROm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiJEROc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:14:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D57B1E2;
        Wed,  5 Oct 2022 10:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99234B81EC5;
        Wed,  5 Oct 2022 17:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE015C43141;
        Wed,  5 Oct 2022 17:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664990067;
        bh=xre7D3p9wYeZj6+yx2KL0N77FmYsyYWWTka8j0VWX5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SZBCD8h7uQuNhjlcSS96cGwI5xKybHLO7BvB+He2Kt2jTfSBYPnOOKFhT8+a9PBO/
         kTjYOM49Ya6AyKQS18MRMbx3QWxJQlxoU8uEWN2iBABWJzznTregD2EPz9tEaG91Ft
         7f4jU+tifiXFq6g70/xYOPRMnX3C4UggqSymuP8moI47GWOAvNTJtGcdnbPGFCBZPl
         qXMQTvEmhDCTEFNCzxdGFe7soaJr0Mlmxf+iu079ppqlqKCmQ7I1zSBzhLFM7bgpi1
         oS9EvwHXKhta0Y3PDdnxsKwn2EetNc1nklRMmip1ksqYBXdHUsLisjo2uc7Hd/fgUY
         94dLuNr7SlJGw==
From:   Conor Dooley <conor@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 2/6] serial: sifive: select by default if SOC_SIFIVE
Date:   Wed,  5 Oct 2022 18:13:45 +0100
Message-Id: <20221005171348.167476-3-conor@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005171348.167476-1-conor@kernel.org>
References: <20221005171348.167476-1-conor@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

With the aim of dropping direct selects of drivers from Kconfig.socs,
default the SiFive serial drivers to the value of SOC_SIFIVE.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/tty/serial/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 2a18a42a5004..768f1138c9fb 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -972,6 +972,7 @@ config SERIAL_OMAP_CONSOLE
 config SERIAL_SIFIVE
 	tristate "SiFive UART support"
 	depends on OF
+	default SOC_SIFIVE
 	select SERIAL_CORE
 	help
 	  Select this option if you are building a kernel for a device that
@@ -981,6 +982,7 @@ config SERIAL_SIFIVE
 config SERIAL_SIFIVE_CONSOLE
 	bool "Console on SiFive UART"
 	depends on SERIAL_SIFIVE=y
+	default SOC_SIFIVE
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
-- 
2.37.3

