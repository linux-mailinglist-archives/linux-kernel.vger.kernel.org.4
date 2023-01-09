Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A3A662AF6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjAIQQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjAIQQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:16:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAC026F4;
        Mon,  9 Jan 2023 08:16:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBE55B80E3F;
        Mon,  9 Jan 2023 16:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC16C433EF;
        Mon,  9 Jan 2023 16:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673281005;
        bh=GcUJoqwzBj4P+o08/WBqKW8nNGVoR4iTgJhHoDsx6mM=;
        h=From:To:Cc:Subject:Date:From;
        b=Y0DGa8M6n4er5K6xkkqr33qBXl1W7dj7zDro0802IrhNX9LiiA9CG8JQaX3XF+zfB
         +jXUma/b5/jOMlk0aPYvJ9FK0Ycz/xz1tN/HUXwTuYLIsums9JwiYp3njC2tQBVXfY
         eOVtrUvkQsOpB8N6L0NUfsGFbO7DdQjt4XOLMfjL594Fw+MypeFhPGN1phDTntEGML
         mMmBhjWfNAToi9/UUiE4gs7BYaiSQADWgKUCI9QGA90bntv567WyMsJcCfvaReLrF/
         KDXp9SMBDSZ4QbHLXSqDJuLv2ne58eNgVcWglUP2BWUMkA1kSmqjv9RJoyX3bEihoF
         9kP1IPbh2rdTw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/3] ARM: SoC fixes
Date:   Mon,  9 Jan 2023 17:16:33 +0100
Message-Id: <20230109161636.512203-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
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

From: Arnd Bergmann <arnd@arndb.de>

These are three fixes for mistakes I discovered during the preparation
of the boardfile removal. Robert noticed the accidental removal
of PXA310 and PXA320 support because of a misplaced Kconfig statement,
and the two OMAP patches were build failures that got introduced
earlier but that I found while testing the removal.

If these look fine, I'll queue them for 6.2 and for stable backports,
basing the boardfile removal patches on top.

Arnd Bergmann (3):
  ARM: pxa: enable PXA310/PXA320 for DT-only build
  ARM: omap1: fix !ARCH_OMAP1_ANY link failures
  ARM: omap1: fix building gpio15xx

 arch/arm/mach-omap1/Kconfig     |  5 +----
 arch/arm/mach-omap1/Makefile    |  4 ----
 arch/arm/mach-omap1/gpio15xx.c  |  1 +
 arch/arm/mach-omap1/io.c        | 32 +++++++++++++++-----------------
 arch/arm/mach-omap1/mcbsp.c     | 21 ---------------------
 arch/arm/mach-omap1/pm.h        |  7 -------
 arch/arm/mach-pxa/Kconfig       |  2 ++
 include/linux/soc/ti/omap1-io.h |  4 ++--
 8 files changed, 21 insertions(+), 55 deletions(-)

-- 
2.39.0

