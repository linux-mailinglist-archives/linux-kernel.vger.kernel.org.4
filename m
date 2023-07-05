Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8D6748CA5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjGETBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjGETBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:01:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6280319AD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:00:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-262e839647eso8026a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688583641; x=1691175641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2aefKDjie+XpptlnykMS4cjK4bXnjT0kz0bBmi0t14U=;
        b=bBeWNn4QoiUU5WmJ9K/HMlqyJhTj+wXsBHEvd0uGz2MQnsimK3tohAPlu74IT/69YY
         U7WseCSzhKFXSkVwIpubzNpMLDTJN4v79Fx5s3gsOq1P7dcO2RrtNAb6T867Gd4UoNny
         04u0Wz0miji0CvK5q3GwOmrS0V9Fbpna8xqVWSEWEw+BxRGFqickCZHCgI0ncSPfQfxt
         BgwAWyARnAYVtjU2Hd4O1PADwr78MAV8z4dcbJ6AMs8u0C9xp7QSy3/zWRLuqoXixr9b
         sz/jlM52lXgAREg7lI63e4ZMxx2LteDx9lHj9eJtFEiBiD2E/+cX+vM3rOdsOKXsIIrh
         cb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688583641; x=1691175641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aefKDjie+XpptlnykMS4cjK4bXnjT0kz0bBmi0t14U=;
        b=JL1CSsq+vEYnp5iz5S7JYEOTPI2kpmapMZ3M07ewu7n7AvtS6byTGulZxneRgTLDv1
         vdvj8lMhPY8Ype5Q0ftHjTNzMrGH5WgKaQyEzbIu9iIwAci28DpE2BGb7MMxKEaC5KSm
         Oqbs8vmIWeH26gfmVyt5Ki+22h72QSVYL9+aAwHWWUyrrja3yy6CsRv5z9sACgo5yYz9
         9hlNOk6f8k/BxeYP7gQiD3UZzoD+uYxiCHkmD+IyARKEOg4Qx/KXieNxkUu8tg/0illq
         KuVSnu77irVbzP3zLThWiDtRqGXuLEb0590Hli5XKCC01LGM2oPRJFjivF+a+Tx4tkQl
         37fg==
X-Gm-Message-State: ABy/qLZbu4ZBGoNptBTbqgTLSeaH4akH+ylywRU0t78i7oT3aOHe34zh
        0rEf/US6Dk9KI94xhNBJekUQLaVmsRGo1o8EaVA=
X-Google-Smtp-Source: APBJJlGxMtaefB5OYIH9A9tG4cey2jb2WUJlQHyarT2zV+fGHrgpUf+CVv6hEz+oGku5pKoWhIpl7w==
X-Received: by 2002:a17:90a:4985:b0:261:1141:b716 with SMTP id d5-20020a17090a498500b002611141b716mr16407697pjh.33.1688583641465;
        Wed, 05 Jul 2023 12:00:41 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902aa8700b001b0358848b0sm19323359plr.161.2023.07.05.12.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:00:41 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com
Subject: [RESEND PATCH v3 0/2] RISC-V: mm: Make SV48 the default address space
Date:   Wed,  5 Jul 2023 11:59:40 -0700
Message-ID: <20230705190002.384799-1-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sv48 the default address space for mmap as some applications
currently depend on this assumption. Also enable users to select
desired address space using a non-zero hint address to mmap. Previous
kernel changes caused Java and other applications to be broken on sv57
which this patch fixes.

Documentation is also added to the RISC-V virtual memory section to explain
these changes.

Charlie Jenkins (2):
  RISC-V: mm: Restrict address space for sv39,sv48,sv57
  RISC-V: mm: Update documentation and include test

 Documentation/riscv/vm-layout.rst             | 22 +++++++++
 arch/riscv/include/asm/elf.h                  |  2 +-
 arch/riscv/include/asm/pgtable.h              | 21 ++++++--
 arch/riscv/include/asm/processor.h            | 34 ++++++++++---
 tools/testing/selftests/riscv/Makefile        |  2 +-
 tools/testing/selftests/riscv/mm/.gitignore   |  1 +
 tools/testing/selftests/riscv/mm/Makefile     | 21 ++++++++
 .../selftests/riscv/mm/testcases/mmap.c       | 49 +++++++++++++++++++
 8 files changed, 139 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/mm/.gitignore
 create mode 100644 tools/testing/selftests/riscv/mm/Makefile
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap.c

-- 
2.41.0

