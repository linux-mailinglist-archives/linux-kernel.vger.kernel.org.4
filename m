Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD90D67312A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjASF1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjASF0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:26:48 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E6E1AE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:26:47 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id g9so818132qtu.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvWquSrWDihZ0acdWJU0hmpgtyP5vfxrh4ZjBtKv7GY=;
        b=oVvCL60ecUhBG09j4Y1NsZFRHxe3MVE2V7Cmffled1FjHBdZnUskAjCtHgy3YWfu9c
         mPMCAS/8DS8ty4ksFnckwt9R5MQbofpmZKC9r3eABUzFFt5TyTBYFx7uZ+P/Zdbioale
         bl4TS6vHA+e5Qv3zYovsIblT1K7LkfBVCKo1JXwn3Ahsi6t/LHVKw1ACCe11Q4X67zxd
         c+gyi8m2S6r71GEvmT7nJnEdhSw8VfVIi16DuQO5iIdupZGa5/jbKLaa4OHl5k6nvItT
         oD405HVs8KDChN261QLu685xaE7UIWO/4Av1yps2ekHeYo9F8YEcszeHdaPZemxAMPcD
         gVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvWquSrWDihZ0acdWJU0hmpgtyP5vfxrh4ZjBtKv7GY=;
        b=3WUeobzBVvxgJA4lDD9ENQRSF+oKz774mCIVoZ2Ia/blQft3gJFoSxljogHidh39XN
         j+wNJCwJfK3vhvyjI9/HO+Uho51G6TFlIvHG0+GE66+C2f02T6+S+cDbwKZx1FhqZJKT
         rCM2IdO5AsfhPl4/vWa8kCFzmsq0+FMi4w/J+G18bGXD3EqZfBgOi+EleyYBknB0r/+F
         IswuGZ2mx8yBiVi+Skujk2w/p7WZSsZhivTkjCA66tRj4d6oRWKRycNLzUxHcm4/8LYL
         tVFpotTRScZDGsaTX0LElTVbV+WzzoNTnBhQ4rfeNR69dPVk8S9wsYM6u6JuBMwn6Iol
         Zf6A==
X-Gm-Message-State: AFqh2kpUSyl3lujLBJ9M2qbwNVXGzyAcaeWRQNd+Dhdeo3jRtnwjjicS
        ZtRfQ+gMhiRBb8YcUQfxQes=
X-Google-Smtp-Source: AMrXdXsjJu8KZfUuO0V9UN0rraw3kxggjI/UB7RLpcZFW/B0GdZEoVmL4URNPATKL/WkMQXZDTfqrA==
X-Received: by 2002:a05:622a:598b:b0:3a9:8f6c:2d7c with SMTP id gb11-20020a05622a598b00b003a98f6c2d7cmr14850392qtb.52.1674106006392;
        Wed, 18 Jan 2023 21:26:46 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id v21-20020ac87295000000b003a5430ee366sm507330qto.60.2023.01.18.21.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 21:26:46 -0800 (PST)
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
Subject: [PATCH v1 2/2] riscv: configs: Add nommu decfconfig for RV32
Date:   Thu, 19 Jan 2023 00:26:42 -0500
Message-Id: <20230119052642.1112171-3-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119052642.1112171-1-Mr.Bossman075@gmail.com>
References: <20230119052642.1112171-1-Mr.Bossman075@gmail.com>
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

