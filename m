Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEACC693A0E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 21:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBLUzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 15:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBLUzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 15:55:12 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C9AF75D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:55:11 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id 5so11919808qtp.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvWquSrWDihZ0acdWJU0hmpgtyP5vfxrh4ZjBtKv7GY=;
        b=WNWzEb8TKQjRiPhehEQX7DRiF0/Z63jHq43yArV/dBCmlAsI1tKxNiT81JcFwOqny0
         yu+MxWkK0EunFt8gijrANji4vbcteVxEkBlBDwbebRpUOtoaSGAw4PFS507An51wz8yi
         n2rcek9j14B+HNpZDw2q1d6n+bpi3CzPQ/5FSHQif1tg8DkbbP4F/gplofGk8Us7wUZP
         yO7LlAo/6P+ZoYa6POP11pScfnmiLiiIFDDVMQu9HkWKJ3RoV3+hxYBsl7cSXshCNkCx
         jKAychv4pUqiToMrhSVaWoJWboi4U7GtXMLI+pnJ8w18LFWwXPiroigNwc/lZ1ED1dbk
         RhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvWquSrWDihZ0acdWJU0hmpgtyP5vfxrh4ZjBtKv7GY=;
        b=CKxZT7dnl97Fj2sflumvMhynQNI3Akh9TYjOSU/YfXVvHXSmgQoYMnrb706OEs0IHT
         tJZEozc2fzaY7I24zhb/1Bq/NPhg3vBUUOF+NGsWBhdUPu0JgdxhokZqkQzqlM6wTydx
         icKJv+f4qfm2Bjwrb/ClxT9jZc6QXtsZgzrGp7AUTkfiT0bEpRXE3uCx3/l34gE69Ib3
         zed9OetTIIejAPEUFH9ZqK0qgjSxguuwxHUiru2Aw+DHFp5NOi9SMZQpqFQOpRuH6ecP
         EcZMo1+VEWRc3EgAwVhlROkFv1jIT9ruH4r6OlMf69TTiRcfmGfEFI3UhzLwmkNyj0J5
         Z6Uw==
X-Gm-Message-State: AO0yUKWTRBigeB+ehfPQzPd8nihSo3X5Zy1tnapwySyTTJXlGcchXhDp
        1PwencBOeLSy/RMKXi6FduA=
X-Google-Smtp-Source: AK7set/xtp4Wf2aA37Exq3ClOp0kX71cmUo1VJxyVPprCWafZdvKJIGxNGYF41HOd0BCPxlMuXvyWg==
X-Received: by 2002:ac8:5cca:0:b0:3ab:ceb9:10fd with SMTP id s10-20020ac85cca000000b003abceb910fdmr40007531qta.25.1676235310522;
        Sun, 12 Feb 2023 12:55:10 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id o62-20020a374141000000b0072ad54e36b2sm8289233qka.93.2023.02.12.12.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 12:55:10 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2 3/3] riscv: configs: Add nommu defconfig for RV32
Date:   Sun, 12 Feb 2023 15:55:06 -0500
Message-Id: <20230212205506.1992714-4-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230212205506.1992714-1-Mr.Bossman075@gmail.com>
References: <20230212205506.1992714-1-Mr.Bossman075@gmail.com>
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

32bit risc-v can be configured to run without MMU. This patch adds
an example configuration for RV32 nommu virtual machine.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Cc: Yimin Gu <ustcymgu@gmail.com>
---
 arch/riscv/configs/rv32_nommu_virt_defconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 arch/riscv/configs/rv32_nommu_virt_defconfig

diff --git a/arch/riscv/configs/rv32_nommu_virt_defconfig b/arch/riscv/configs/rv32_nommu_virt_defconfig
new file mode 100644
index 000000000000..460907253a80
--- /dev/null
+++ b/arch/riscv/configs/rv32_nommu_virt_defconfig
@@ -0,0 +1,16 @@
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_MMU is not set
+CONFIG_COMPAT_32BIT_TIME=y
+CONFIG_SOC_VIRT=y
+CONFIG_NONPORTABLE=y
+CONFIG_ARCH_RV32I=y
+CONFIG_BINFMT_FLAT=y
+CONFIG_SLOB=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
+CONFIG_EXT2_FS=y
+CONFIG_PRINTK_TIME=y
-- 
2.39.0

