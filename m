Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3646868FDE4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjBIDYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjBIDY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:24:27 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917DB3580
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:24:25 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v18-20020a17090ae99200b00230f079dcd9so4868207pjy.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 19:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qKunBXC3vQ45FVVBeIZmijePAOg8/w3l9r8B7emsY08=;
        b=m9f+D936Lynz8XfhzqYAPeS/gqaRhHAhH45wb77Vehe0foBNIiaUrjCzh22yFC+0mK
         dW7jpoad/pVZo49x0Gvfq4bSkv7iXTtEKpsB7loVtxytqmBpME7Lz62+pMb2jaBXOuTh
         0TYNRi52BzoAP1e5yHopuT3YTrEyxBlk4OwSNt2QgXgM154QaEMNeWQ0RRia7wA3fuUG
         dPWrCWZVUwz12Lqvg5gFgB25yleiPMma4Gku2hm6Yx0E5iNvk06MmZNI9PdtzU/gcGn9
         M0ugKYNaeZSGH4vOv/2eHeWu1bR124S/4sfXtojudOeNj9iDCV2BOeiP2YWUU35S4bff
         /f5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKunBXC3vQ45FVVBeIZmijePAOg8/w3l9r8B7emsY08=;
        b=gIv2WDDneZgqmYd2oZEUbRC63W5oYITCCLeB2paIpmfjSDiZsquc14J8jRbaNHIkSO
         90i9Pmqw9fLD9I0/POQ4uWozx51aiCO9K3V9Tz4Jw895L+nSmiOY4ennkIeq5uw65Y49
         kti9bX8Kqyyvmu5ApJkjtwAjr8HuZt5YtmW478TeN6mCKcmjKUCftHmIo50ZoqDm6x6I
         jGIUa8AAg4HH2NOmbsCwhoNH7yxAiQwpQMkGqg5laoR9hkNJSzdzoBo17g1x6+iT/gyt
         Q0TE9c8kuKHgD/X3fows4TL0EXsUdw5FERBCT02sBtRx37lRB+Wmxzc6xZKsw3e5bvL2
         ALYg==
X-Gm-Message-State: AO0yUKVBqvDC5dwWFdF2LLi/Ys82TitiN7ZWGO5HwePaMH231d8jYZZF
        f4H3fWK30Tmqq+fkzo0TAjg=
X-Google-Smtp-Source: AK7set/DkLLYt3R1VK/wnJ0Ej7bGTH7R6PF4H6QPNl5GJOp344SFGftIIHiCCF//lA+MRKbB9GmASQ==
X-Received: by 2002:a17:902:d2cf:b0:195:e590:c7c6 with SMTP id n15-20020a170902d2cf00b00195e590c7c6mr9981058plc.22.1675913064918;
        Wed, 08 Feb 2023 19:24:24 -0800 (PST)
Received: from localhost.localdomain ([112.20.108.204])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902eac500b00192820d00d0sm216086pld.120.2023.02.08.19.24.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Feb 2023 19:24:24 -0800 (PST)
From:   chris.chenfeiyang@gmail.com
X-Google-Original-From: chenfeiyang@loongson.cn
To:     w@1wt.eu, paulmck@kernel.org
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, arnd@arndb.de,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        chris.chenfeiyang@gmail.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Add LoongArch support to nolibc
Date:   Thu,  9 Feb 2023 11:24:11 +0800
Message-Id: <cover.1675907639.git.chenfeiyang@loongson.cn>
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

Add statx() and make stat() rely on statx() if necessary.
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

v3:
- Add #if defined(__NR_statx) guard.
- Keep the check for statx() from the first version.
- Mention that we may use statx() everywhere in the future.
- struct statx stat -> struct statx statx.

Feiyang Chen (5):
  tools/nolibc: Include linux/fcntl.h and remove duplicate code
  tools/nolibc: Add statx() and make stat() rely on statx() if necessary
  tools/nolibc: Add support for LoongArch
  selftests/nolibc: Add support for LoongArch
  selftests/nolibc: Adjust indentation for Makefile

 tools/include/nolibc/arch-loongarch.h   | 200 ++++++++++++++++++++++++
 tools/include/nolibc/arch.h             |   2 +
 tools/include/nolibc/sys.h              |  58 ++++++-
 tools/include/nolibc/types.h            |   5 -
 tools/testing/selftests/nolibc/Makefile |  78 ++++-----
 5 files changed, 300 insertions(+), 43 deletions(-)
 create mode 100644 tools/include/nolibc/arch-loongarch.h

-- 
2.39.0

