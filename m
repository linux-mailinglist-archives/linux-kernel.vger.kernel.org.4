Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB3A655B37
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 22:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLXVQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 16:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXVQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 16:16:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259572AC0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 13:15:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 65E8ACE01BD
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 21:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54926C433D2;
        Sat, 24 Dec 2022 21:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671916555;
        bh=kR/Ls8oU711kk7Apo0h6/pv5vyQu/KJ/RCK7hENF8CA=;
        h=From:To:Cc:Subject:Date:From;
        b=idHcWzvA+nF4aRpEchMBZJqvNuF60qGs8GMpj4ATQaEo82nH9kwH1BeLKqcmJywz/
         pajDgOFp/lbNhfPtt6SppgcnjDxvs4uMtq9pcWJhGbnJWogg32lKKOzAYdt4RXNOFC
         IHJ6GStiJOCylvh1LdbEMP6JSUXfVgDhr8kJnLxwT354KOFwZEQQ4lSwMzNoyR02e0
         KIQHzrpHoOI9Bk06ERWkux1IH3TwjfPUsdEVbnk/LdP7bU7Scc+fd0ZXj6Vv23n38k
         rnDA/1KYpkrFsy3ySosVlyF+RboXzXFqRVKKar+oYD4I3MLLz5Mt/8D9w01AneF/4H
         gWtXsTcCRI8Wg==
Received: by pali.im (Postfix)
        id 67B71720; Sat, 24 Dec 2022 22:15:52 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        Martin Kennedy <hurricos@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] powerpc/85xx: p2020: Create one unified machine description
Date:   Sat, 24 Dec 2022 22:14:17 +0100
Message-Id: <20221224211425.14983-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series unifies all P2020 boards and machine descriptions into
one generic unified P2020 machine description. With this generic machine
description, kernel can boot on any P2020-based board with correct DTS
file.

Tested on CZ.NIC Turris 1.1 board with has Freescale P2020 processor.
Kernel during booting correctly detects P2020 and prints:
[    0.000000] Using Freescale P2020 machine description

Changes in v2:
* Added patch "p2020: Move i8259 code into own function" (separated from the next one)
* Renamed CONFIG_P2020 to CONFIG_PPC_P2020
* Fixed descriptions

Link to v1: https://lore.kernel.org/linuxppc-dev/20220819191557.28116-1-pali@kernel.org/

Pali Rohár (8):
  powerpc/85xx: Mark mpc85xx_rdb_pic_init() as static
  powerpc/85xx: Mark mpc85xx_ds_pic_init() as static
  powerpc/85xx: p2020: Move all P2020 machine descriptions to p2020.c
  powerpc/85xx: p2020: Move i8259 code into own function
  powerpc/85xx: p2020: Unify .setup_arch and .init_IRQ callbacks
  powerpc/85xx: p2020: Define just one machine description
  powerpc/85xx: p2020: Enable boards by new config option
    CONFIG_PPC_P2020
  powerpc: dts: turris1x.dts: Remove "fsl,P2020RDB-PC" compatible string

 arch/powerpc/boot/dts/turris1x.dts        |   2 +-
 arch/powerpc/platforms/85xx/Kconfig       |  22 ++-
 arch/powerpc/platforms/85xx/Makefile      |   1 +
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  |  25 +--
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |  46 +-----
 arch/powerpc/platforms/85xx/p2020.c       | 193 ++++++++++++++++++++++
 6 files changed, 215 insertions(+), 74 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/p2020.c

-- 
2.20.1

