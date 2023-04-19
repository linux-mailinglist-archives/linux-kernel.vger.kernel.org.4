Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9F56E783E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjDSLLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjDSLLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:20 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E402913FA1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:39 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a6c5acf6ccso14882075ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902639; x=1684494639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7zDmqn6U8Eyb17uAoVJJPhK0/Ifl27eJMXTrX2OOHM=;
        b=rzuEY2qOeKpq90xSbNAhUvw+t3I72kxsPlvEC7slbJx9oZ6mmu89DjDgnsFLhq7KuO
         Wt57Eklvz6MGerBhZn+zO7UFpZ15XNmpuuwUhsEG37gK93liaWtJlKCwrt2a/FnzUTe+
         z5HCg6VZUjUOIo9F8rfd8VaOHjPNwVA+1x+kc2wTDwm7qonkWTsRz8jC1Itvm7NSNSAY
         a5X1WkIgUhDoNCGAK2F6F/Mxe4xIl1aVgypMSHghWGGh6VIPhepcxxkeK6szAoLR/YUN
         CS3WZYDAECq7UnQZ5nHRW9sRRpHAl9XVfxsKrrcgn0szOs0qnXHXC7l5tQ1KG31eQtEE
         cRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902639; x=1684494639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7zDmqn6U8Eyb17uAoVJJPhK0/Ifl27eJMXTrX2OOHM=;
        b=IYGolZtpepndoYCdzGQ0FfifDuCl66G3IqzMbb4DCb+3xM5ibH6il8YyQ5VGSJ5l8c
         qQa5mWtgo7P/V0MbJZbBLM7rHHRRqxaKuzUSH4GgLWfIO1FEW5hqXvhlxotrTSi231X4
         PioGD09jdGcb/e+0qnq0a6iRyEMgxgPOh5Mo3fVluERdClm/+Uqo7aGtp4b9ZJxOHh1I
         ETwm6unDO/5Faaqy6s+GGQy0dPFSJLRKsgdgdumioJOw/EXhNUPS3RWzFOrNm2D6dvKz
         ME+CpwMjLPCaCcm1rZlvUYy3dMZ/siLNalOUrcMAsieUm1ralISRITl69/b8rS9ie7ao
         0m+w==
X-Gm-Message-State: AAQBX9fNIukuARz63p/fe99G5B2WxYESyn+xbaiIQm8dn2ovCa/P4d8T
        fvPW9UtyWhDJA5DqZdphS6uAzA==
X-Google-Smtp-Source: AKy350bRyAzNw2aBgYQca4A9Dl58PbRRLG96ePo7DalZ4z4sxpKHS+SDAbx+Cwj9P+bi7KJe2/jZ7A==
X-Received: by 2002:a17:902:daca:b0:1a2:19c1:a974 with SMTP id q10-20020a170902daca00b001a219c1a974mr5715862plx.68.1681902639573;
        Wed, 19 Apr 2023 04:10:39 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:38 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ved Shanbhogue <ved@rivosinc.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Peter Newman <peternewman@google.com>, x86@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [RFC PATCH 21/21] DO_NOT_MERGE riscv: dts: build qemu virt device tree
Date:   Wed, 19 Apr 2023 04:11:11 -0700
Message-Id: <20230419111111.477118-22-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419111111.477118-1-dfustini@baylibre.com>
References: <20230419111111.477118-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree for the qemu virt machine to the build. The
resulting dtb will be consumed by qemu-system-riscv64.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/Makefile      | 1 +
 arch/riscv/boot/dts/qemu/Makefile | 3 +++
 2 files changed, 4 insertions(+)
 create mode 100644 arch/riscv/boot/dts/qemu/Makefile

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index f0d9f89054f8..74d99d28522f 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -5,5 +5,6 @@ subdir-y += starfive
 subdir-y += canaan
 subdir-y += microchip
 subdir-y += renesas
+subdir-y += qemu
 
 obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
diff --git a/arch/riscv/boot/dts/qemu/Makefile b/arch/riscv/boot/dts/qemu/Makefile
new file mode 100644
index 000000000000..07252b4ff455
--- /dev/null
+++ b/arch/riscv/boot/dts/qemu/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_SOC_VIRT) += qemu-virt-cbqri.dtb
+obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
-- 
2.34.1

