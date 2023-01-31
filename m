Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5933683107
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjAaPN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjAaPNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:13:37 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C129B56ED2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:11:33 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so10856048wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDRV3dTpr/I1IdlDAhOzkzQeE2U7A9MUv4OTs7C9Ic0=;
        b=fdRNuWwOmD2J8LwVwU9LdwIRGl6NUPNr9RjKhhxb/oVEbmG9OehBPDVzdQa5s66Si1
         objENa14PROVzi3XlYOwtO82hNuIcp82QvpcPRmyE9PnKvTtMUvxdddUsrtYdXxxb7og
         bLq94hLu66Es1S+gIJcgdrrE+XUltHjWSreVCW3vOXjJ9JofFGvbwi26hYxyMISWFbVM
         dKPMxnwRTyke/KeD7oHAvfKyrnNGO/TscGyYoR/d/67FK+l809KkMkUFiWjKZfBiv0NT
         gDa9mYuLOu/JJDYAhiJOYPLI6pQ2c/MV3Sh7+r71Y9WBwb2jhE/vDAnAOPcjsj9Pv0JE
         AVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDRV3dTpr/I1IdlDAhOzkzQeE2U7A9MUv4OTs7C9Ic0=;
        b=lTvSaTmyYnwaM5pKwu1jixAZ7HpZJKkojD6LfwTvAvWj3c7GcvGffZSQc6H+Jw4iy/
         M9eBrSTtkxnMWJinW48vbEhQFrBujMZV/PHYoOKT/rMXZr2+Uqvd2DBQLQCEi9EEmU1v
         ts3mbiFqbao9Rww/Hq5e7X7mg2qV5rDiVVCygUu1dN5qrssYiZMMosb2Q0Syg4GXynF/
         apeEobocCHyP5Drg2OVQFp3/ZNrc6mLvpwx32qNZbAg64fCehUY90hzI1iQDx2vWp5Er
         VWZ5cPdDzDCxzkOPazQp75zXX5rN/4XtkkLaqu/Ol4D1jArlwkIB1U4q3RKHcL2nProt
         1q0Q==
X-Gm-Message-State: AO0yUKW9qkIDnGr5d5ZB4QmVS4zEOX/D/iT5bEVoTa812zmWgJb4z4HB
        2mppEtHXy+syLwU7a0nNvN9MjA==
X-Google-Smtp-Source: AK7set/2iizYZSQzebD1MVfEgv6lMNJzzvCce0t08tWnm7LHavMfZ8xs0/vr+y315lraYo4rANMjYg==
X-Received: by 2002:a05:600c:a14:b0:3dd:97d6:8f2a with SMTP id z20-20020a05600c0a1400b003dd97d68f2amr2027264wmp.33.1675177884047;
        Tue, 31 Jan 2023 07:11:24 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id t1-20020a05600c41c100b003dc47d458cdsm10651305wmh.15.2023.01.31.07.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:11:23 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 0/1] riscv: Allow to downgrade paging mode from the command line
Date:   Tue, 31 Jan 2023 16:11:14 +0100
Message-Id: <20230131151115.1972740-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new version gets rid of the limitation that prevented KASAN kernels
to use the newly introduced parameters.

While looking into KASLR, I fell onto commit aacd149b6238 ("arm64: head:
avoid relocating the kernel twice for KASLR"): it allows to use the fdt
functions very early in the boot process with KASAN enabled by simply
compiling a new version of those functions without instrumentation.

I had to change the handling of the command line parsing to make the
code self-contained in kernel/pi/cmd_early.c to avoid calling too many
__pi prefixed functions from outside this file.

I'll use this approach like arm64 to handle the extraction of the random
seedi from the device tree for KASLR.

@Ard: I copied the "pi" name but I have to admit I don't know what it
means.

Alexandre Ghiti (1):
  riscv: Allow to downgrade paging mode from the command line

 .../admin-guide/kernel-parameters.txt         |  5 +-
 arch/riscv/kernel/Makefile                    |  2 +
 arch/riscv/kernel/pi/Makefile                 | 34 ++++++++++++
 arch/riscv/kernel/pi/cmdline_early.c          | 52 +++++++++++++++++++
 arch/riscv/lib/memcpy.S                       |  2 +
 arch/riscv/lib/memmove.S                      |  2 +
 arch/riscv/mm/init.c                          | 36 ++++++++++---
 7 files changed, 126 insertions(+), 7 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/Makefile
 create mode 100644 arch/riscv/kernel/pi/cmdline_early.c

-- 
2.37.2

