Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F70A748325
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGELpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjGELpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:45:12 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24D01990
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 04:45:00 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b89b75dc1cso4279145ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 04:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688557500; x=1691149500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/7mU7LG0/LoivTbyL8zN+ZBZKcFo4rglaRaqylxhfQ=;
        b=Ltfa/6PMTzVFKvupHYoIu25JvZQEj8+TG279VMGSVCFID+E3BGc5M/0cOuZAjs8bL2
         z9Cgl0L5iCAGnnQ/SuOGo7Tlk2zQTK9bQPleevr+vBadbtzutwf63D4nRPP3IF+qUaFx
         EvP//jSB2BrpV79rZnIxTxbFyGU2bFXfQ00+rYLUlKKiHn2sM+6/jwg1lRkSLa9Axgpj
         Txv/dFC2aNPc+fLwMIpNaBCDQ/ZOdivCtVpmurWLgY2ltsQ8x9kA03yypVf4nBnyOGiw
         Zc7G9su5n0GMnMCvvb8mRkoltS9mmH76Z7KN16SNl20HeoY+KKNBQTu61nHeHB/My8I5
         vr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688557500; x=1691149500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/7mU7LG0/LoivTbyL8zN+ZBZKcFo4rglaRaqylxhfQ=;
        b=a/f64R/pLqSG2VpqHHQCr7odyUeWb0fghED8OcBcGR2CEMGog93lxfwi1wM2lg4tBg
         gyxaCx1LAHuzi/Cs9B8dDOsTn58Hv78Q009k+rp0UOuU/x1xxgz10MhiLHzgA4Sx6s+d
         LiiROZHcpo3kzAtZ/1P494yXnfjx6yD0w7EizUt3NBFWDjcRVE072uS2RGJo9Ax2UUBj
         3EpOM+7OWYEF3phiBtENJWSoDzwYchRbSBBBgu5qQ/o+gR2XYNLDKFueEztwKxmb1RNs
         s6Z1GHS5v3NMJ0vJ5a7gZ+eolnOiVTAkt7S0+/l52SxM7Fi5P3Bnq3crZOW8C0paNcvV
         jo1A==
X-Gm-Message-State: ABy/qLbEIRLsROh/y6eWNREI/lUZJj7ERuqI+lCzGtsRhZJ0Dpu317gz
        2ICagKuIbuwYg9/6SSyVtqFxag==
X-Google-Smtp-Source: APBJJlE+p5F5PIvo05kj7fIPA1p9K+VjhFZ7LXhkzaKK45+ZK+JAauB4t1oRak5U+mKJZRNdHuxLkA==
X-Received: by 2002:a17:90a:f40a:b0:263:f674:490e with SMTP id ch10-20020a17090af40a00b00263f674490emr1749692pjb.3.1688557499886;
        Wed, 05 Jul 2023 04:44:59 -0700 (PDT)
Received: from PF2E59YH-BKX.inc.bytedance.com ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a194300b00263f6687690sm1177900pjh.18.2023.07.05.04.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 04:44:59 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     conor@kernel.org, sunilvl@ventanamicro.com, ardb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com, cuiyunhui@bytedance.com
Subject: [PATCH v3 3/4] riscv: obtain SMBIOS entry from FFI
Date:   Wed,  5 Jul 2023 19:42:50 +0800
Message-Id: <20230705114251.661-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230705114251.661-1-cuiyunhui@bytedance.com>
References: <20230705114251.661-1-cuiyunhui@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RISC-V, Coreboot does not support EFI booting, only supports
devicetree, and RISC-V does not have reserved address segments.
To support Coreboot on RISC-V platforms that require DMI
functionality, SMBIOS entry need to be passed through FFI.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/ffi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/ffi.c b/arch/riscv/kernel/ffi.c
index 147d06a5acff..b959d16fe0b3 100644
--- a/arch/riscv/kernel/ffi.c
+++ b/arch/riscv/kernel/ffi.c
@@ -8,6 +8,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
+#include <linux/ffi.h>
 
 static u64 acpi_rsdp;
 
@@ -35,4 +36,5 @@ u64 __init riscv_acpi_rsdp(void)
 void __init ffi_init(void)
 {
 	ffi_acpi_root_pointer();
+	ffi_smbios_root_pointer();
 }
-- 
2.20.1

