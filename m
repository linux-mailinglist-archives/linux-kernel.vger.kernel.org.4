Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EBB6A03C5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjBWIYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjBWIYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:24:44 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C167024C99
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:24:42 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l25so9548401wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NkCh/AowqYCuU7zgqG0YkYb4oopQxez3cQvz40pUaxs=;
        b=RhAY7mQUp4U96B+Jiym9qVEPn1CiYxJWT2NGE4QjO8auQi1R8vtku5RKL4sN28AH4a
         dET6hsct+g7jUMueitQaqULSml1pIBpVIh4UVtqD+GGOLkIm3ViBqEmIU1jnzyZPCO2X
         AESs5WkmjDcGRwfytFKw8w2578YQu9SmvW/3VnWXhMM17YdBiUv+oH1DvtjEWM6iqpEt
         58GoG5DQgHCXzaa+VqicCPhzKAzPGFYH5Bxqd84RWSBJRETkGDYbQVBaZSsrl8FPRQBF
         8Ix999uVP0F6iuqeyGRMFLc9fQa1bkGiL5rdT66O9QamOiqj8VEr738gXCrhK44UTw3y
         +byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkCh/AowqYCuU7zgqG0YkYb4oopQxez3cQvz40pUaxs=;
        b=3yWwE3qLq4t0lpfAIoYCbjDK0BY8IKb5CY36MXWCzpLdWUwLGKytFyyTJQui5/6xE+
         Qxv9TyGOkph87/DsQVHTWU/BPLiF19rDEALlttKmdgeYGt1o5IwWhQLS9QcznpUpZOA6
         wc8IH+eVX4rKR4kJXYmhJPtK6e3/OUjn/hLb4DTJ8JOpQo4XdkUvX/SuQOOGx6FEGnbK
         IuEAD/OG4yCBB2gMpApkgDOlh31c/cLweb4G5E6EypoNsP2z+nnJtDKnHOlH7hzhGnLA
         S1NyoT9YlWbM/ohdzaqNCJT2umvBi5E9HeHJJxttl+wJ2nzpIXhUr3RNuUiFyNs2MWQB
         49cg==
X-Gm-Message-State: AO0yUKWcQ1jsm62Ai4OmmtrRK0uzIMruAWx4ToOe0eJ4GaOdzUvvBJ+D
        7psJ1Z2VvZ/ZWm/raaSwG+YX7g==
X-Google-Smtp-Source: AK7set9k+etAhHHJfifyrCS12MhqVoE/6gxFjtGmJJM/kJJFfJR/OvWvQZARuqkvX0qL24LuBVs1xg==
X-Received: by 2002:a05:6000:18b:b0:2c5:4f35:1b2b with SMTP id p11-20020a056000018b00b002c54f351b2bmr9833138wrx.28.1677140681204;
        Thu, 23 Feb 2023 00:24:41 -0800 (PST)
Received: from alex-rivos.home (lfbn-gre-1-235-32.w90-112.abo.wanadoo.fr. [90.112.194.32])
        by smtp.gmail.com with ESMTPSA id i18-20020adfe492000000b002c56287bd2csm9858338wrm.114.2023.02.23.00.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:24:40 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v6 0/1] riscv: Allow to downgrade paging mode from the command line
Date:   Thu, 23 Feb 2023 09:24:33 +0100
Message-Id: <20230223082434.1280957-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

base-commit-tag: riscv-for-linus-6.2-rc8

v6:
- Fix llvm warning by forward declaring set_satp_mode_from_cmdline

v5:                                                                              
- Handle null command line, Thanks Björn!                                        
- Add RB/TB from Björn                                                           
                                                                                 
v4:                                                                              
- Introduce pi/ for KASAN to work                                                
                                                                                 
v3:                                                                              
- Massage commit log to make no4lvl clearer, as asked by Conor                   
- Add a note to kernel-parameters.txt regarding the impossibility to use         
  those parameters when KASAN is enabled, as suggested by Conor                  
- Add RB from Björn                                                              
                                                                                 
v2:                                                                              
- Honor CMDLINE_EXTEND and CMDLINE_FORCE as noticed by Björn

Alexandre Ghiti (1):
  riscv: Allow to downgrade paging mode from the command line

 .../admin-guide/kernel-parameters.txt         |  5 +-
 arch/riscv/kernel/Makefile                    |  2 +
 arch/riscv/kernel/pi/Makefile                 | 34 ++++++++++
 arch/riscv/kernel/pi/cmdline_early.c          | 62 +++++++++++++++++++
 arch/riscv/lib/memcpy.S                       |  2 +
 arch/riscv/lib/memmove.S                      |  2 +
 arch/riscv/mm/init.c                          | 36 +++++++++--
 7 files changed, 136 insertions(+), 7 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/Makefile
 create mode 100644 arch/riscv/kernel/pi/cmdline_early.c

-- 
2.37.2

