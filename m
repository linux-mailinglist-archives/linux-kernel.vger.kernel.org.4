Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CC9693A0C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 21:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBLUzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 15:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBLUzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 15:55:10 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF710F75D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:55:08 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id j9so7315963qvt.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPekLstCDhrZcyGnHLadPwpTLr5cjyPBku8Cb6ACLXw=;
        b=fFGOXIDJYDm93Ab74loOW+g8Vj4v3AlMLeH0eBe9hBV/SRh5etxegnsTeBVMWrdVsm
         cQZo6eJ0aYQK2q0vm1WDrdbm/d3alWR6F+nqSMsgDJhTWz4SXvkl7VwOYCn9rDkEXQFE
         yqwjWdOt7r+m2vXidPxf2Iihz6PxK379rcJnexonq14T3/4vVIStI8E9hxjQcIHa6e6N
         IcBPBTaZaSVlwVIdY5gmYxDtDuNzoZVSRhG/xLheg3HHtbp3rNdEQoawBZwanQEmA+Nu
         8nS6i9pxQhRIKEvYImMk4F3usX0P/hj7jaPfVy4teNxET7dyCO+LXQiKwimh+WKrjgd3
         EViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPekLstCDhrZcyGnHLadPwpTLr5cjyPBku8Cb6ACLXw=;
        b=4itoxPPTqCo9Nj83t6JY6Q034bJfSk5G9tGv8bki+Y9DmyjqRCb8K8BQI6bXmCfHep
         9svmX9FcDFjwwrbvv5NYOt09wyeJH3mwctFFSLKp7x3CfQUTlTEsG/hDN4qMMVRVHSsK
         UazfdY/ISR4hsT0Fz2aKdvS4k0nFmoR5kHvNf0fDbzfa9GtZWDMFzGxslpXbWv8d8ml4
         L2gI9MuRsHn6+gicX+s0674aPD47m7COgGgDhjqmNH7Bd0IEASpUD1SnzquOiR4xhTEU
         3EClsUWj6FTlrBhlCQIurXO+w1gbctqeTptDILzvULnB7v69ypuqlhkq36DVjWQxDjMV
         Oymw==
X-Gm-Message-State: AO0yUKVxuY/+7O7g4UeWb9ZahuhHXHQcGH9GqhhQRKofc3Ed4IkNPe7x
        72yUN5ijXtJvDtMR+O9bWZU=
X-Google-Smtp-Source: AK7set8DPoU4B2rtcewAMwnUFdPxbd52/8BIdCUSOwqeCXjPsIbc6C7WRwSQbd9NfZfzivtT9ioiYg==
X-Received: by 2002:a05:6214:21e1:b0:54f:b7e9:182 with SMTP id p1-20020a05621421e100b0054fb7e90182mr43409902qvj.45.1676235308045;
        Sun, 12 Feb 2023 12:55:08 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id o62-20020a374141000000b0072ad54e36b2sm8289233qka.93.2023.02.12.12.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 12:55:07 -0800 (PST)
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
Subject: [PATCH v2 0/3] Add RISC-V 32 NOMMU support
Date:   Sun, 12 Feb 2023 15:55:03 -0500
Message-Id: <20230212205506.1992714-1-Mr.Bossman075@gmail.com>
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
---

Conor Dooley (1):
  clk: k210: remove an implicit 64-bit division

Jesse Taube (1):
  riscv: configs: Add nommu defconfig for RV32

Yimin Gu (1):
  riscv: Kconfig: Allow RV32 to build with no MMU

 arch/riscv/Kconfig                           |  5 ++---
 arch/riscv/configs/rv32_nommu_virt_defconfig | 16 ++++++++++++++++
 drivers/clk/clk-k210.c                       |  2 +-
 3 files changed, 19 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/configs/rv32_nommu_virt_defconfig

-- 
2.39.0

