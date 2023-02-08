Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676B768ECA9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjBHKS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjBHKSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:18:35 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532E247400
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:18:06 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j1so12062338pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3p5TTVCxHUnLOH1pkeavvbt9JRZNuXtyIw1YqMkZt0=;
        b=NcGj0r1OIPBPtu0db4eoVdKvDIViDhN5iuQpq2ovbMIrWqsAak+31s3+mlOv2NLy7P
         JcYbIX8kODKUF1SoFQSXzeuDJquC1bW8gwFDtL4D2rR5/wT48wgkv398aIL+LIX6k4mg
         dLCEOGsmt+3N0LEpAc30PoGmFuHSzLe553QgbqKFMWbADSm9wPJ5NLLa/An8e1s42Psl
         G5cOq0B3bOinux4QrSG7Anc7qV4khUdxlomh40t1ToTKHvSU6Ll7KlRq+EXZu+iLMoR7
         tx1gom0Jcxbf3+P1W9g9TPt96CNib2OLENotAG4LiJa8IW6nK94pQnmVWi8QbtNTBAsN
         +g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3p5TTVCxHUnLOH1pkeavvbt9JRZNuXtyIw1YqMkZt0=;
        b=phE5AuYFeWK1coHbUDb9DX3Lh/CxQc31wscyLX66iowuk5EB54D9QTOVh94wQY9aWg
         n+2Hkbb7FNKlmmfHT2YJDbWsOxu86rDPvXiAfWwlQQ3ZM7RhXSPTCO3kWPoNKrpQ6eQR
         qazGdff7JLNbh6/+1SLVrabEXNe3U/p4h5iQ0PU3kM0ZB54mfduOomz4J4VY2/0iDK++
         GnThBwgoPEApblyztSJbWM9kf2hB/O0TEct50xrjuVfU6EazQ9PhID9FUF/GdGC+evo5
         3w4RFb+8qE8gUAHskrXURy0dqkyAX1hL4kMPIEBOGwR19WTxDH1FeKMm8cL7vyybbUa/
         5Qgw==
X-Gm-Message-State: AO0yUKViGbOFAb3UsBGsYahmtwXe5iDb8GkH5SUCyA049thtbFm4/yls
        1QqDg7LmZ60yId2J0UEFB2w=
X-Google-Smtp-Source: AK7set/UIWseGROU/V3PSTpIajcVjPMghekwnQqyUJ5XExLemHjgRzXvTGmItDDRz5zOg0L8i3dtOA==
X-Received: by 2002:a17:902:c70a:b0:199:49fc:610d with SMTP id p10-20020a170902c70a00b0019949fc610dmr1022924plp.15.1675851485492;
        Wed, 08 Feb 2023 02:18:05 -0800 (PST)
Received: from localhost.localdomain ([112.20.108.204])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709028d9700b0019926c7757asm3991058plo.289.2023.02.08.02.18.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Feb 2023 02:18:04 -0800 (PST)
From:   chris.chenfeiyang@gmail.com
X-Google-Original-From: chenfeiyang@loongson.cn
To:     w@1wt.eu, paulmck@kernel.org
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, arnd@arndb.de,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        chris.chenfeiyang@gmail.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Add LoongArch support to nolibc
Date:   Wed,  8 Feb 2023 18:17:49 +0800
Message-Id: <cover.1675851111.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feiyang Chen <chenfeiyang@loongson.cn>

Add statx() and make stat() rely on statx() when available.
Add support for LoongArch (32 and 64 bit) to nolibc.
It was tested on LoongArch64 only.

The latest QEMU support full-system emulation of a LoongArch64
machine, but for the moment we need to specify the firmware manually.
https://github.com/loongson/Firmware/tree/main/LoongArchVirtMachine

QEMU_ARGS_loongarch  = -M virt -bios edk2-loongarch64-code.fd ...

v2:
- Mention that statx() will also benefit other architectures.
- Make stat() rely on statx() when available.
- Put the whitespace changes into one commit.

Feiyang Chen (5):
  tools/nolibc: Include linux/fcntl.h and remove duplicate code
  tools/nolibc: Add statx() and make stat() rely on statx() when
    available
  tools/nolibc: Add support for LoongArch
  selftests/nolibc: Add support for LoongArch
  selftests/nolibc: Adjust indentation for Makefile

 tools/include/nolibc/arch-loongarch.h   | 200 ++++++++++++++++++++++++
 tools/include/nolibc/arch.h             |   2 +
 tools/include/nolibc/sys.h              |  53 ++++++-
 tools/include/nolibc/types.h            |   5 -
 tools/testing/selftests/nolibc/Makefile |  78 ++++-----
 5 files changed, 295 insertions(+), 43 deletions(-)
 create mode 100644 tools/include/nolibc/arch-loongarch.h

-- 
2.39.0

