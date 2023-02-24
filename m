Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9816A1964
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjBXKDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBXKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:03:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC4164D74
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:02:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l25so12925002wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DgTiDDsfaHP7jVew0rXgrkZhb05V4kPRInLQ8/UIVxU=;
        b=SmTacAhXaRqBZ9fg0/Pw7HwF4ypCxgeWSOEEpguNsAWFgbxZ6RW0G8FWQfT2Grz/zH
         YuFAJJlBt5NWeJSEF8pDOFnWP9k5MoVG+N4mffLhbvnP8WDDhfphepvAtr8lDCu6GAQ6
         kGHIa6rBH5T8OTDxya8R73Lm1H3Zqq+iTpibbZqbiJ/SLlPqWpC6FVExaPjTtv9LIMW3
         upCo2N/z9TcJRLCcsaN36Q+nl13uG1tIUNhzRHWNc79xQ2CvkIpYIk4PP9/v7r5p14Fa
         EUVB6f+X/cdGR6pJG3+zKW9TkQ+TEHHe8dpWL4w2DiX/uuioqYO/syE3OqC47re2VbJW
         2LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgTiDDsfaHP7jVew0rXgrkZhb05V4kPRInLQ8/UIVxU=;
        b=QAI4eptQfoSZ128tfeoGtriBxJ8MhC7hlgQfcu4lvPvgsboxXQsJBzw4IKSOy/K09p
         2KtjbfuV6TC7ZNAymrwDnFYCxn43kfLHRfAAqUkoNgTz9dEvEr17wSe32Y1yIqZyqcWm
         oCvDjJbGyuTnmpMgNFm08jhFHqpdWcCmJTKqWVVJpkLfxQxSRqicU7rX59bZcHBeZdUJ
         hwEHDsB3RBeq90ODUizX4bVTliVlQNQKVHnHem5LAvcK0FpRYU/RDoOU/Yy2CybG1/wr
         lhp0eztgq9ODMFyCB5HMD/SnsGfG6/G7MWqCoUXrRwg50WQflLwnQGPnqUZ50Gud5vjw
         aQjg==
X-Gm-Message-State: AO0yUKXSjpHf7AcN5XIaJYHP+DHUg+cY102EnADkUWk8bqo2W5f+hkw7
        yqGshirGayd+P9MXyf128vs+HA==
X-Google-Smtp-Source: AK7set8mY1ChiX0wV8ujiGBzXbIYnfB2xYPTAyRwTS+YhheiWY3mHU8T0lZoOqgaQ1NDGWtOicy93Q==
X-Received: by 2002:a5d:5486:0:b0:2be:c41:4758 with SMTP id h6-20020a5d5486000000b002be0c414758mr11725398wrv.38.1677232944108;
        Fri, 24 Feb 2023 02:02:24 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-gre-1-235-32.w90-112.abo.wanadoo.fr. [90.112.194.32])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d4b8f000000b002c561805a4csm14572802wrt.45.2023.02.24.02.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 02:02:23 -0800 (PST)
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
Subject: [PATCH v7 0/1] riscv: Allow to downgrade paging mode from the command line
Date:   Fri, 24 Feb 2023 11:02:17 +0100
Message-Id: <20230224100218.1824569-1-alexghiti@rivosinc.com>
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

base-commit: eb9be8310c58 ("RISC-V: add a spin_shadow_stack declaration")

v7:
- Rebased on top of for-next which introduces lots of errors (thanks to
  the patchwork CI)
- Add __NO_FORTIFY to avoid undefined __pi_fortify_panic
- Add an alias to our newly introduced strlen
- Remove __init as sections are already prefixed in the Makefile
- Introduce new section for kernel/pi/string.c to quiet the following
  warnings (once we have all the string functions, we'll be able to get
  rid of this):

warning: orphan section `.init__bug_table' from `arch/riscv/kernel/pi/string.pi.o' being placed in section `.init__bug_table'
warning: orphan section `.init.srodata.cst8' from `arch/riscv/kernel/pi/string.pi.o' being placed in section `.init.srodata.cst8'

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
 arch/riscv/kernel/pi/Makefile                 | 37 +++++++++++
 arch/riscv/kernel/pi/cmdline_early.c          | 62 +++++++++++++++++++
 arch/riscv/kernel/vmlinux.lds.S               |  7 +++
 arch/riscv/lib/memcpy.S                       |  2 +
 arch/riscv/lib/memmove.S                      |  2 +
 arch/riscv/lib/strlen.S                       |  1 +
 arch/riscv/mm/init.c                          | 36 +++++++++--
 9 files changed, 147 insertions(+), 7 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/Makefile
 create mode 100644 arch/riscv/kernel/pi/cmdline_early.c

-- 
2.37.2

