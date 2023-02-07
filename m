Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FC068CC6E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBGCJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBGCJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:09:51 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074D020065
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 18:09:51 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r18so9489553pgr.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 18:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t2R4Y9BugjZxBru4uI7Lx5wAt6TYg7t074pOgVYye8E=;
        b=lNOlZD+5V8nUreql8W9A+qDr4wrT9YB+MUB2mZwi8dg7i5zLJDI4UrhlDGAAS0Wv+x
         /ANoZlzhDXuQKAehf7Ek9haEgVOhFP/nktYYftJ/05dTbAJjpKR+B0/SU6R/kZD6l0BE
         aGp2ut44NrzxEkciRcGtNlIxM6GM1JyaSEId1Zgp+0FKTKHm/GuGm2mQotsMZ/20Ljv9
         rH+okBG5f9PJ/jUaSH2lfS5/QbnpfZD+t6ufW4QfzWPrEZH6+x0MpdHWIY1Nhk6rNEfq
         lDHzHrM6mk1sKws+AB3mkqqkP+yMgmm8gALlkD8mV8y99GP9NEAA7eF56Kh2Si8MoNpm
         Bdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2R4Y9BugjZxBru4uI7Lx5wAt6TYg7t074pOgVYye8E=;
        b=G+pws5SUdx5a/fWUhPuX9hOSOFEMcFvfkPhDY+PweASx9uB6Z5j30vMBpK0yhNQYqw
         aHtZVaWaoZjFKTj4o0SvDrptrEaoaBKOGOrryvTSFmaoZOrxN5potPotxWHdo7S2viEG
         uQLzmAScpVHFB9YSqlx8qm5/ekBL7S+4oiOSwCxhHKtstQlFx3WSKVXtue/nGzIxDL+Z
         1Yf66Qjz9CuY0DFLuOhLxB6/eq06JTp9l6iU8rDYM7CSCegzwSletYHZgq12eP52DJfT
         K6GVJfR+sr0MSLl8JJxWRa9NsLaktVbxE0AiuFn3f75YfBXyaoXe1utb2N9IqiZnjiEk
         Bmzg==
X-Gm-Message-State: AO0yUKXa1/UOJxyusRVDeSKl+Aka77s+A3N+NyUsPh8eW3MQpxLvPsgN
        PaRkc5CAM1wDsVyAqIvHhvk=
X-Google-Smtp-Source: AK7set8P+8Tyeug8YnzFi0k2BWMjzEYOH2in+brOqernlAo8WHDuk+fjg8+Ermr6nIP9kszwOpzixQ==
X-Received: by 2002:aa7:9a0d:0:b0:590:753d:78f5 with SMTP id w13-20020aa79a0d000000b00590753d78f5mr1403975pfj.20.1675735790360;
        Mon, 06 Feb 2023 18:09:50 -0800 (PST)
Received: from localhost.localdomain ([112.20.108.204])
        by smtp.gmail.com with ESMTPSA id d198-20020a621dcf000000b00593225b379dsm7843765pfd.106.2023.02.06.18.09.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Feb 2023 18:09:49 -0800 (PST)
From:   chris.chenfeiyang@gmail.com
X-Google-Original-From: chenfeiyang@loongson.cn
To:     w@1wt.eu, paulmck@kernel.org
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, chenhuacai@kernel.org,
        jiaxun.yang@flygoat.com, arnd@arndb.de,
        chris.chenfeiyang@gmail.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add LoongArch support to nolibc
Date:   Tue,  7 Feb 2023 10:09:39 +0800
Message-Id: <cover.1675734681.git.chenfeiyang@loongson.cn>
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

Add statx() support to implement sys_stat().
Add support for LoongArch (32 and 64 bit) to nolibc.
It was tested on LoongArch64 only.

The latest QEMU support full-system emulation of a LoongArch64
machine, but for the moment we need to specify the firmware manually.
https://github.com/loongson/Firmware/tree/main/LoongArchVirtMachine

QEMU_ARGS_loongarch  = -M virt -bios edk2-loongarch64-code.fd ...

Feiyang Chen (3):
  nolibc: Add statx() support to implement sys_stat()
  nolibc: Add support for LoongArch
  selftests/nolibc: Add support for LoongArch

 tools/include/nolibc/arch-loongarch.h   | 223 ++++++++++++++++++++++++
 tools/include/nolibc/arch.h             |   2 +
 tools/include/nolibc/sys.h              |  36 +++-
 tools/include/nolibc/types.h            |  46 +++++
 tools/testing/selftests/nolibc/Makefile |  78 +++++----
 5 files changed, 345 insertions(+), 40 deletions(-)
 create mode 100644 tools/include/nolibc/arch-loongarch.h

-- 
2.39.0

