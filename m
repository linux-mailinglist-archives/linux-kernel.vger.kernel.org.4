Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14816A68DA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCAI0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCAI0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:26:18 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5286537546
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:26:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l25so12343238wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 00:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677659176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfD4q2LgbRRlvJ4+bYxh6ZqsbcVB/WxMo7rj6NRQuk0=;
        b=f7dPjsGeDMkdphwBk+4dWnmbmhEKV1N7dpGkBBAUcyhUY0gcTKFFBuC1ja3NxeDB+/
         rPTxKIBV6WvchBkRLT/usr+RSymAsbd9LhEYMY3QXqDcozg6r/j6yNAXluT1sVZvsxuJ
         YAcMT7CNVOmIH3vMKAkZoAQy6ng+6gk4BX0XWTACqeGneIfVMiFUC8d9yR+1N1vlJnbe
         y45ne71uOYnjyQdPWgJnIZcWr9s1/SBmFsUFlg7vwFIE4s4mHDFPLsXbnP+3BO9hPq6T
         dnn82De3HHv9pTb7KAQ+wcCOUerZ9baKElRNGegh7lftO2JosnaJqWHps9bfpDfIViUv
         QTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677659176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfD4q2LgbRRlvJ4+bYxh6ZqsbcVB/WxMo7rj6NRQuk0=;
        b=mIvOQnhb+v/kw9m2bj5IGzaUQb0VO3MqmacY6+mmtCSRXVF7G+zkoKjMTLkjUQt56F
         ntq7EXxaWRCQWIPjXcEi/QD3xNsYuZFnI6sxbcbGSROZ+RYzATGYwsjZ36eP4b32RSIx
         n+QcT9LiE0phLDr56xi0q8xUKfJ6kgZYfBElO/bL7m3KsgvHA9dC7nuCVH/6GBx4zHiR
         gqwCpCwtKr21Vb7AcjH37F+IoYj4dvjvb6/Wl2CfO3qnlITu/xjxEM8i2OBb1b/xIqEP
         rRvPx75FyitYVPGwdUVJyOgTrdumrKVA92YErIhM+EJEgusgh/5R16sAYTSU0NwrUhM5
         PnLg==
X-Gm-Message-State: AO0yUKXN8BH9hcC/cRfK9vbseLtyVTs+av7dmCZwlkrrBSb1KWuJInK2
        srq31NgdFJOVl1vRdkagK7hJeA==
X-Google-Smtp-Source: AK7set860SjBlAUqr0i040uF9NlXD059b879x/lzjp+pMjSSaQDOynaWXtRRmOsueJGr/ZNni44PcA==
X-Received: by 2002:a5d:424a:0:b0:2ca:d5dc:bba4 with SMTP id s10-20020a5d424a000000b002cad5dcbba4mr4492855wrr.59.1677659175817;
        Wed, 01 Mar 2023 00:26:15 -0800 (PST)
Received: from alex-rivos.home (lfbn-gre-1-235-32.w90-112.abo.wanadoo.fr. [90.112.194.32])
        by smtp.gmail.com with ESMTPSA id w11-20020adff9cb000000b002c55de1c72bsm11859694wrr.62.2023.03.01.00.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 00:26:15 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v6 0/2] riscv: Use PUD/P4D/PGD pages for the linear mapping
Date:   Wed,  1 Mar 2023 09:25:50 +0100
Message-Id: <20230301082552.274331-1-alexghiti@rivosinc.com>
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

This patchset intends to improve tlb utilization by using hugepages for
the linear mapping.

base-commit-tag: v6.2-rc7

v6:
- quiet LLVM warning by casting phys_ram_base into an unsigned long

v5:
- Fix nommu builds by getting rid of riscv_pfn_base in patch 1, thanks
  Conor
- Add RB from Andrew

v4:
- Rebase on top of v6.2-rc3, as noted by Conor
- Add Acked-by Rob

v3:
- Change the comment about initrd_start VA conversion so that it fits
  ARM64 and RISCV64 (and others in the future if needed), as suggested
  by Rob

v2:
- Add a comment on why RISCV64 does not need to set initrd_start/end that
  early in the boot process, as asked by Rob

Alexandre Ghiti (2):
  riscv: Get rid of riscv_pfn_base variable
  riscv: Use PUD/P4D/PGD pages for the linear mapping

 arch/riscv/include/asm/page.h | 19 +++++++++++++++++--
 arch/riscv/mm/init.c          | 28 ++++++++++++++++++----------
 arch/riscv/mm/physaddr.c      | 16 ++++++++++++++++
 drivers/of/fdt.c              | 11 ++++++-----
 4 files changed, 57 insertions(+), 17 deletions(-)

--
2.37.2

