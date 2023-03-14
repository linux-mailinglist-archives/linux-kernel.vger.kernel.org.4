Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DE86BA136
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjCNVKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCNVKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:10:46 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096CC18B0D;
        Tue, 14 Mar 2023 14:10:33 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id bo10so13436836qvb.12;
        Tue, 14 Mar 2023 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678828232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gFGKOv/gsoVIy8/SJ0JWX6aXeqfw2gjMFT5w7VG7REY=;
        b=pcxc6CU22/fuEYmub2qnTMBjE38I2bfwMO+vN/5//rLZgB+7tjqg1jorWV8aTjG+ul
         m27De5cQlqk7sCdxMT24ih9wxa6ZHvQWslS5ld9PT+1aOQZm09NawtWp/lZKLMehX5w+
         j4mmK8h4+Tz2TVP66HAiuugBfNlKJuQskh5qS2kVDvv5uMixmSpmptLiw7wyMJmzN0eg
         mV+B0D+krz4SneOEjQQoiadSQdSLzkU5JUaYhkW7Y435hbUjrC/PgnUaVhTNwAdHWk44
         zQ8DHVbqwy2z9PTpcWibYzIMmGFWi8Wo8FYgiTLhvlXmkjBU3aKtmloxYZLVnWU3ccS4
         ZKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678828232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFGKOv/gsoVIy8/SJ0JWX6aXeqfw2gjMFT5w7VG7REY=;
        b=fdVpZdi3D8YEZdGF9Yd+2JIghZJx8Q+1+mMX7c9zdprVf5nhfVmPtqnUMVbn5nHs/n
         Spb8GF6DHMn2AwbDoa82wavDTnNCOpFVtnVZdCfCwQ18JJ8gUWCGY2HLM/MEqrhQNIVV
         BqVCdCUoaUgZ1vpJ7wAuTFRF63hUtfa9zZQNskFvX5jWpcTJj6GHKBQgyM1ONySEhBUV
         oTSJd6AQgvOAWZdj2pqSYo4XiN0JLiMlYHwRYRcE6IHmm9mVvtd9inbzX7NpiFmwGz0V
         kUxIdRjq1qBXW9ulQ2IX6rF6yGA8okHtdk5n107e1XLJNqePoqneaA3gcAOBIIH+QHjg
         vTDA==
X-Gm-Message-State: AO0yUKUoWwPbitczYxysa/QyW9l/nhZbU0xuxZFczDPX/mkMRBZV15i0
        +7iNjy0Rhr5L/tkJSb5vHIk=
X-Google-Smtp-Source: AK7set8s5PLApjeu1ZkOkOWsjBPp5MpES5WSbkTRdnCH2mkXb8zMiahzcjThB3wmKpu24GYSRxUV+w==
X-Received: by 2002:a05:622a:1ba6:b0:3b8:3a7c:d204 with SMTP id bp38-20020a05622a1ba600b003b83a7cd204mr61380513qtb.58.1678828232116;
        Tue, 14 Mar 2023 14:10:32 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id ef14-20020a05620a808e00b0073b967b9b35sm2429498qkb.106.2023.03.14.14.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 14:10:31 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH v1] RISCV: CANAAN: Make K210_SYSCTL depend on CLK_K210
Date:   Tue, 14 Mar 2023 17:10:30 -0400
Message-Id: <20230314211030.3953195-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.39.0
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

CLK_K210 is no longer a dependency of SOC_CANAAN,
but K210_SYSCTL depends on CLK_K210. This patch makes K210_SYSCTL
depend on CLK_K210. Also fix whitespace errors.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/all/42446784-a88b-df09-41e9-5f685b4df6ee@infradead.org
Fixes: 3af577f9826f ("RISC-V: stop directly selecting drivers for SOC_CANAAN")
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 drivers/soc/canaan/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/canaan/Kconfig b/drivers/soc/canaan/Kconfig
index 2527cf5757ec..caf3705d8917 100644
--- a/drivers/soc/canaan/Kconfig
+++ b/drivers/soc/canaan/Kconfig
@@ -2,9 +2,9 @@
 
 config SOC_K210_SYSCTL
 	bool "Canaan Kendryte K210 SoC system controller"
-	depends on RISCV && SOC_CANAAN && OF
+	depends on RISCV && SOC_CANAAN && OF && COMMON_CLK_K210
 	default SOC_CANAAN
-        select PM
-        select MFD_SYSCON
+	select PM
+	select MFD_SYSCON
 	help
 	  Canaan Kendryte K210 SoC system controller driver.
-- 
2.39.0

