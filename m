Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE0C6C81E3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjCXPye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCXPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:54:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C630D18ABC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:54:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i9so2309783wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679673269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b6Ngv7vLHp3FF75hEwebNFD1hG5vOf7sA7KcWcOgjlU=;
        b=Hxv6mt7/oyXVS542hr3tqu/KjMizfnZiF3ALCk/BGy17uinbxGYwY4yRdCGwqIKNhL
         VkVy6Thgx2At9vVvRGgE9qgzmQ5mR/xjCpmN/bHeww50tZUpfmYSR1kbB74EgvyACQwZ
         OmRB8HrsCvaHz5Csly8l0V0FF647Nl0tPNl0iFimG4bJrfgO5zp+dKX4G+9qmROVWYl8
         p6K30LzQV9ghXpJYXaTI8z7oPHA+DjAGwrcjK4KnXvlhRylYVpU/w0vItaMNJERluM6k
         ErUIUVFSgf+Vsq7TLLx0tF2uMMcURF3enyxnN7GCJ3qSZyLIBR/dk6+HddWxeS4A0Bok
         Pp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679673269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6Ngv7vLHp3FF75hEwebNFD1hG5vOf7sA7KcWcOgjlU=;
        b=2SEXgjj1dm8BZLYjI1oFeOLTCkQfLBlJZByS3qyio4CAwF+uYq32RJLUx58626rKXP
         IoMbRzTlY6vk5WJOICbiYEh7yYonWN1xLBWee8sNzxYmje+uW3Kw95GLnbkb9b5lkUzf
         NmFJLEKXZHN+/sumzPsT+XvkXiMhVFEx8o35LVWec4zGgg3jDg5Mjij3QJBGo3xe2wRv
         Yd7P/X3KgHAcaynEqC2osNRHFTPKreSkl9/ZhRCbp9tOdSscYKAFK50rpKyc+CUt9ogh
         VfVuctDEs8j3ttxBkG7GBoawVWFGL9MsJC+Qz4vOS1VAPOdKvKp07kDBYNJSPWPEgYnf
         R8qQ==
X-Gm-Message-State: AAQBX9dDA1OCW8/FqiWZ5XOR+995eHt1XARLpRGE7R3VjHZUdscIEpY3
        gvIPFx+2Ovyc5HnZAVUjksP6SA==
X-Google-Smtp-Source: AKy350Zl7H1gg9oVuKX3qg/cXgl51EjhrkA/2eBShL5nrN8+IyprgXSHeuxVL1r0qLjsJp/PpT2aGA==
X-Received: by 2002:adf:e3cd:0:b0:2cf:f467:54d9 with SMTP id k13-20020adfe3cd000000b002cff46754d9mr2664167wrm.53.1679673269318;
        Fri, 24 Mar 2023 08:54:29 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4e05000000b002d75909c76esm11767972wrt.73.2023.03.24.08.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:54:29 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v9 0/3] riscv: Use PUD/P4D/PGD pages for the linear mapping
Date:   Fri, 24 Mar 2023 16:54:18 +0100
Message-Id: <20230324155421.271544-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset intends to improve tlb utilization by using hugepages for
the linear mapping.

As reported by Anup in v6, when STRICT_KERNEL_RWX is enabled, we must
take care of isolating the kernel text and rodata so that they are not
mapped with a PUD mapping which would then assign wrong permissions to
the whole region: it is achieved the same way as arm64 by using the
memblock nomap API which isolates those regions and re-merge them afterwards
thus avoiding any issue with the system resources tree creation.

base-commit-tag: v6.3-rc1

v9:
- Remove new API and arm64 patches as it created more issues than it
  solved, thanks Anup for reporting those bugs!
- Add a patch that moves the linear mapping creation outside of setup_vm_final
- Use nomap API like arm64
- Removed RB from Andrew and Anup as the patch changed its logic
- Fix kernel rodata size computation

v8:
- Fix rv32, as reported by Anup
- Do not modify memblock_isolate_range and fixes comment, as suggested by Mike
- Use the new memblock API for crash kernel too in arm64, as suggested by Andrew
- Fix arm64 double mapping (which to me did not work in v7), but ends up not
  being pretty at all, will wait for comments from arm64 reviewers, but
  this patch can easily be dropped if they do not want it.

v7:
- Fix Anup bug report by introducing memblock_isolate_memory which
  allows us to split the memblock mappings and then avoid to map the
  the PUD which contains the kernel as read only
- Add a patch to arm64 to use this newly introduced API

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

Alexandre Ghiti (3):
  riscv: Get rid of riscv_pfn_base variable
  riscv: Move the linear mapping creation in its own function
  riscv: Use PUD/P4D/PGD pages for the linear mapping

 arch/riscv/include/asm/page.h |  19 ++++++-
 arch/riscv/mm/init.c          | 102 ++++++++++++++++++++++++++--------
 arch/riscv/mm/physaddr.c      |  16 ++++++
 drivers/of/fdt.c              |  11 ++--
 4 files changed, 118 insertions(+), 30 deletions(-)

-- 
2.37.2

