Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383FB69F2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBVKnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjBVKn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:43:29 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915C03756D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:43:27 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l25so6848041wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UhT58sinHFct4qgunNLg5u/XIFyEJ64KsH0nJ4Jq3VI=;
        b=E3mhp2S/pYriP6lLsQo4TfjWLohTGpgIU2xyChC0o8I7Tvs9Rzs1Z2ECShnsif5isZ
         p8yChvV92xDtZrlY6vOpN1bUKw2fg4krL8iebjbD5mSa97vZcPEDq/Gy+M1o9i+88SEl
         qAvCVJb9D0ey+keKZvwPX3JohXCzLuP34j9S1EyaVYHw8BlfgaA9yIyBF0V/HtrkVxvV
         VDqzl34G0c5PRTA9qkXd4fhFKeyM7i+ApRiewpCnFSQsabhnbuw9N8O+u6+VxYZowzM3
         J+t+KVVw1GQKpgWT0E/fmfCu3dxn0qqjjYTHIO3WE5+b3P+Z9xxkKJjOJhMHEj71F8WW
         QOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhT58sinHFct4qgunNLg5u/XIFyEJ64KsH0nJ4Jq3VI=;
        b=WV3oSWODa7A/7NhR2+5ZgGTzjz+hE65SkJKLXqiKtspDktC2eNefb9nV27GR1x3IYj
         IeTBqvWMXv5jSGKNtdZdMgquerzL/kliITMDYzg9DmmBViWIsPyh+VfTu8r3Oe/e2uwj
         mD9k/wjY4QTQ+65NNnpYM29epGfxtUPnvu0bc7WFY5OAhsV6PD/Cw2/c8SBES3z9Jqum
         erC7lCxLDcz6erdmo14MmeCb1kS/ytDBreobV1QzQcRNeNDrJy6z+q22MpQCq+UJWHse
         l9PJaFPi8xyRkaRLI1s8cwRPUSc/tyrs3LrpmhWG5phPQDZFmYlrz1xjGdm9eXQd3/OW
         xb2w==
X-Gm-Message-State: AO0yUKVFwuTG+PxHq04dRLh6ZpTkY97cpFXxUWP0QGLeEr/KzJ+ZN4X0
        cNlHPS5Bt61uDkJ9mMvkyQ2SuQ==
X-Google-Smtp-Source: AK7set97crFvqEY9KymyVgzh9ZbKxig7GJ92PiQcr3HEodbwNfUwX5oCC7Jv573SDTcXPhgm66t+IQ==
X-Received: by 2002:adf:ea88:0:b0:2c5:5a65:79a0 with SMTP id s8-20020adfea88000000b002c55a6579a0mr4953341wrm.53.1677062606035;
        Wed, 22 Feb 2023 02:43:26 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-gre-1-235-32.w90-112.abo.wanadoo.fr. [90.112.194.32])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d5149000000b002c550eb062fsm5798294wrt.14.2023.02.22.02.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 02:43:25 -0800 (PST)
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
Subject: [PATCH v5 0/1] riscv: Allow to downgrade paging mode from the command line
Date:   Wed, 22 Feb 2023 11:43:21 +0100
Message-Id: <20230222104322.1197763-1-alexghiti@rivosinc.com>
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
                                                                                 
base-commit-tag: v6.2-rc7

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
 arch/riscv/kernel/pi/Makefile                 | 34 ++++++++++++
 arch/riscv/kernel/pi/cmdline_early.c          | 55 +++++++++++++++++++
 arch/riscv/lib/memcpy.S                       |  2 +
 arch/riscv/lib/memmove.S                      |  2 +
 arch/riscv/mm/init.c                          | 36 ++++++++++--
 7 files changed, 129 insertions(+), 7 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/Makefile
 create mode 100644 arch/riscv/kernel/pi/cmdline_early.c

-- 
2.37.2

