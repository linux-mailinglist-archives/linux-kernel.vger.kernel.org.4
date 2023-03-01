Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C206A643D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCAA1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCAA1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:27:03 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F9BC15F;
        Tue, 28 Feb 2023 16:27:02 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h19so12607007qtk.7;
        Tue, 28 Feb 2023 16:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677630421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/MyxgPKxQn9hh5x2nb//eurUMI1TwFNKVvwtxDYylE=;
        b=NuI2G4KbKwo/PAuNAKZEkDmoR0NVEBT6OEtd4HOsq+CmCK4Ggibq3XGzOgzN5EQD3z
         xjqzyRsrCzdMQP8aS4kOMaJ0nwd/49iGKls3+xfVo06TtW8v+kflV4YhcgE4+ryBD7+X
         LlNE1QAvjujKk9Tx1JLQtaPKvaYfX4APKtKUs3ADnrIGirku+vH6KDxhW3GvP0HfFTbu
         zf2kb5Sxdn01s3ZPaydtlW7PeYfXGOPRnLnYXhQJQwnWUvFL2H2myVNb2tSneF/H3Mav
         39T4L6VaQFOt1aGS5ELTfz4qr930VjYGQBiilNnaSAwJwGFno9NI7ATpVT+ZPhn9Oi8B
         CTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677630421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/MyxgPKxQn9hh5x2nb//eurUMI1TwFNKVvwtxDYylE=;
        b=wIc+nrEt4YCD99TqV/CytcxLPqpE99z3FhPAuABo3dG5mZ9LYb/6ZbwcqdawGcEH8+
         6ZAH8/11zmFQCdG7iggHzaBtCbL+MBeVsrAfTeO2iC/1h33EQLA8tvjYUPItVCxqtW5c
         V766n5dQar9Rj3T/YlR728eWHu/Ki9VzE2wevlZOzM3AKMf0FPmcN4+/LskOc8Th5hAP
         pyLcMDLbLmWUtV97QqIL4mFCzZfo7w1436pvabLOoN2tZ1OpPI/0NdbXtH2w7DJ4n6UW
         PnFKzlSFmOvzJ9Z7NYQFGyGpp4oCOLR/R3ZFTIduoXjavrmIcSdfx7YN2HkoeQI5X0Nh
         OI1Q==
X-Gm-Message-State: AO0yUKVcJk/EeR0oY7Yq9/+ljW8GFKBuv3poPSj2FIp478uoIyUMBlGw
        YRW+XfhCi8fMRFP/7JEsaGU=
X-Google-Smtp-Source: AK7set8V1wa1E6m4iqzrwXb7JVVMTDBwt0TSn/UDCQ5rLdFX0jxAYz/eYaCqUujiBmSzcznc6syVZA==
X-Received: by 2002:ac8:5e49:0:b0:3bf:afd1:8c98 with SMTP id i9-20020ac85e49000000b003bfafd18c98mr7916982qtx.0.1677630421189;
        Tue, 28 Feb 2023 16:27:01 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id t8-20020ac85888000000b003bb8c60cdf1sm7576698qta.78.2023.02.28.16.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:27:00 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Yimin Gu <ustcymgu@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v3 2/3] riscv: Kconfig: Allow RV32 to build with no MMU
Date:   Tue, 28 Feb 2023 19:26:56 -0500
Message-Id: <20230301002657.352637-3-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yimin Gu <ustcymgu@gmail.com>

Some RISC-V 32bit cores do not have an MMU, and the kernel should be
able to build for them. This patch enables the RV32 to be built with
no MMU support.

Signed-off-by: Yimin Gu <ustcymgu@gmail.com>
CC: Jesse Taube <Mr.Bossman075@gmail.com>
Tested-by: Waldemar Brodkorb <wbx@openadk.org>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1->V2:
 - Fix typo in commit description
V2->V3:
 - No change
---
 arch/riscv/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c5e42cc37604..d1f661425790 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -177,8 +177,8 @@ config MMU
 
 config PAGE_OFFSET
 	hex
-	default 0xC0000000 if 32BIT
-	default 0x80000000 if 64BIT && !MMU
+	default 0xC0000000 if 32BIT && MMU
+	default 0x80000000 if !MMU
 	default 0xff60000000000000 if 64BIT
 
 config KASAN_SHADOW_OFFSET
@@ -279,7 +279,6 @@ config ARCH_RV32I
 	select GENERIC_LIB_ASHRDI3
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_UCMPDI2
-	select MMU
 
 config ARCH_RV64I
 	bool "RV64I"
-- 
2.39.0

