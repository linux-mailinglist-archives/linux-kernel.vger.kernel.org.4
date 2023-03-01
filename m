Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7176A6438
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCAA1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCAA1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:27:01 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD3415880;
        Tue, 28 Feb 2023 16:27:00 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id w23so12621810qtn.6;
        Tue, 28 Feb 2023 16:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677630419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2e0ffjzBgpw/mSpMPgFDPU3Iu4DLibmhol76pOXRIs=;
        b=JvUxM5yaXhG1yLskvHq/jdt/crTRoc2cpek2vwFU9tHZ8PWilIci1ft4Rv4MnUzyDS
         DppkOAAsR7vaj4gBF+hd2iwr6YEqhwFVOypMzzR4Dsnho6g1kbRSLjOWH+JA4/dsJrSh
         /DAD2n95qaAfNduS1P0nlcux57ipcj2cMnmRBtH7r3QHA/ZcAIFkqSAcEqBsYktlCGl3
         EZgYPgVgRWSvfL2RXhVobMdiE8d4GH0VFB9GeoKO94NjgCIh15Lqq5wZZsloI6sldkGB
         O9eMRe8AHzGTVhhRF83y55Hr6tR0BudvS7NPVmudLIY52p+T1+wK8kJoSn1kn5619SPI
         ajZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677630419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2e0ffjzBgpw/mSpMPgFDPU3Iu4DLibmhol76pOXRIs=;
        b=3BtXlvN/jM3BS0KZ/HVvGyWYEcJcBEkU3bm/JhNazmG7QRglVqzd8iw4fa0ghX38wg
         SEDBTNrBkx+/CR2G1+oJbOlb12Z4RwtS4gTlouH/Y7hyYYGzWRFjoiu8z6Pn9zr6JUoY
         P9/Ibr+gJaHVl68F/dv1pe47p4n4NGhqDx78U2xp/G1cggCDkSd14NuB4qkvtv2RHqa1
         u6K138GBiNzPXfa03V5C4LLd7E6Mo82+QFHAbF9sHMAqQmJgj838RYneFxk30+vCco/p
         dZufQQh4vAi4CBJ1FLPGG4obGXlvzHRxgUnjRlg63XJfFUCthnHeSbdpoS0tzSgK/ChW
         NCDQ==
X-Gm-Message-State: AO0yUKXfU5cC+6yAHD+nhTGsvsQiEXhet6dMaocIyD5//eFHhYf8xs0D
        XjyjBzYEA0OyWtfSMemADZA=
X-Google-Smtp-Source: AK7set8ZrXnrEKvBEmgZA3GMxTz87fkxaL3fF2SH5BuHhWPp6/NLV3fXU6uI2/NbwAoVDP0lMQf5BQ==
X-Received: by 2002:ac8:7f16:0:b0:3b6:3995:2ec2 with SMTP id f22-20020ac87f16000000b003b639952ec2mr8856720qtk.19.1677630419223;
        Tue, 28 Feb 2023 16:26:59 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id t8-20020ac85888000000b003bb8c60cdf1sm7576698qta.78.2023.02.28.16.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:26:58 -0800 (PST)
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
Subject: [PATCH v3 0/3]  Add RISC-V 32 NOMMU support
Date:   Tue, 28 Feb 2023 19:26:54 -0500
Message-Id: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
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

This patch-set aims to add NOMMU support to RV32.
Many people want to build simple emulators or HDL
models of RISC-V this patch makes it possible to
run linux on them.

Yimin Gu is the original author of this set.
Submitted here:
https://lists.buildroot.org/pipermail/buildroot/2022-November/656134.html

Though Jesse T rewrote the Dconf.

The new set:
https://lists.buildroot.org/pipermail/buildroot/2022-December/658258.html
---
V1->V2:
 - Add Conor's clock patch for implicit div64
 - Fix typo in commit title 3/3
 - Fix typo in commit description 2/3
V2->V3
 - Change from defconfig file to a PHONY config
---

Conor Dooley (1):
  clk: k210: remove an implicit 64-bit division

Jesse Taube (1):
  riscv: configs: Add nommu PHONY defconfig for RV32

Yimin Gu (1):
  riscv: Kconfig: Allow RV32 to build with no MMU

 arch/riscv/Kconfig     | 5 ++---
 arch/riscv/Makefile    | 4 ++++
 drivers/clk/clk-k210.c | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.39.0

