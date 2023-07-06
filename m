Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D4674943F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjGFDcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGFDcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:32:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD3D1BC8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 20:32:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666edfc50deso163755b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 20:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688614361; x=1691206361;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l5PFYuSIj52/sZJ3+8LDJADq0fIHUY/OVaPigx63RO0=;
        b=cBEsKWkSoLlGv8wtC+WCyTN7xQd0yQaZDPTaTTvI1e1SPr+CZVNWRTVP/kACtk4gcE
         8cU76UUbkrMR3f4q/Dv/Q7F8XBR6rutb4+NYT26XtT6p1rXsVLEn57gY2i86aIj77AkV
         NOpp1bS3nOHcPqi4utmvGbQw8IMZjHtJ1aXq+Z0CKKluXT7HHuhxdXvOMii6DcEa/x5K
         b1B+5oxWuWRXZxGFPA9GjbuvJUBGNEX1Lijhsa17/j0DR2hU6bwovqhyetS/ZMtg8wMJ
         ie2uKyIdQEhUDlOMLjMn/NsmYaDLVNYJwDY2lRhnbQHbIwsr49m48mXsFW/wdX1QqToG
         EAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614361; x=1691206361;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5PFYuSIj52/sZJ3+8LDJADq0fIHUY/OVaPigx63RO0=;
        b=IA/3oO4aTwSchm/DOgkXXgHDwr34dOetCWCR3SmMJeGzk+ypAAl2kBoWebaNkVVK5a
         M4Ezixocs3TdAausJu3BkAjMlkpdHHCYv2xz+SD/pvUAl0CzF4hepj+ItgG0EXEeCcHF
         wNLSHdRbKmC0iAews3QwWfcxBG86qxwVN8urBiR8t+/U5JImqYuoOhesF1TynmXM4SU6
         QlsypQUtrnga3L6DF6E/dNYqVSGD8Wxop1mwJ6Be5A9WzdTzwq2LaNoWSrwyobzLkWpo
         wh63Dmrb584CDfLZuBU4jKgjc/gTm6LQL9SgWXmOTDviBNmoBERxd1WsEj8uLq4fvarb
         ImGw==
X-Gm-Message-State: ABy/qLZaebgWpfU5fB+AbsjXxQRAvGNLgyDc/PEZ86Q6hOP0P4zS2STb
        glg7B1PsOAmy6eUb7ZupzVDAwuRelBppneP5hzY=
X-Google-Smtp-Source: APBJJlHBbv/XBNLZLg1kBXFLrwbRPGj/YLdy+ZtS9HAhqs+IxMadbHcjITFaQQ87f5sKJHxbPGeiow==
X-Received: by 2002:a05:6a00:ad6:b0:67a:72d5:3365 with SMTP id c22-20020a056a000ad600b0067a72d53365mr6814701pfl.6.1688614361341;
        Wed, 05 Jul 2023 20:32:41 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id fk13-20020a056a003a8d00b006589cf6d88bsm239785pfb.145.2023.07.05.20.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 20:32:40 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/3] RISC-V: Support querying vendor extensions
Date:   Wed, 05 Jul 2023 20:30:16 -0700
Message-Id: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEk1pmQC/x3MSwqAIBRG4a3EHSf4gIK2EhGWv3knFhoRSHvPG
 p7BdwplJEamoSmUcHHmPdZQbUNrsHGDYFebtNRGdroXZ4B184Xo9jTjPhE/koV0RktrlPLrQlU
 fCZ7v/zxOz/MCZKB7+2kAAAA=
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, charlie@rivosinc.com,
        evan@rivosinc.com, heiko@sntech.de, linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce extensible method of querying vendor extensions. Keys above
1UL<<63 passed into the riscv_hwprobe syscall are reserved for vendor
extensions. The appropriate vendor is resolved using the discovered
mvendorid. Vendor specific code is then entered which determines how to
respond to the input hwprobe key.

The T-Head 0.7.1 vector extension is used to complete this vendor
extension framework. If vector support is compiled in and the cpu is
T-Head c906, determined with (marchid == 0 && mimpid == 0), then the
value of the hwprobe pair is set to 1 (defined as
THEAD_ISA_EXT0_V0_7_1).

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (3):
      RISC-V: Framework for vendor extensions
      RISC-V: Add T-Head 0.7.1 vector extension to hwprobe
      RISC-V: Include documentation for hwprobe vendor extensions

 Documentation/riscv/hwprobe.rst                 | 17 +++++++
 arch/riscv/Kbuild                               |  1 +
 arch/riscv/Kconfig                              |  1 +
 arch/riscv/Kconfig.vendor                       | 14 ++++++
 arch/riscv/include/asm/extensions.h             | 16 +++++++
 arch/riscv/include/asm/hwprobe.h                |  1 +
 arch/riscv/kernel/sys_riscv.c                   | 60 +++++++++++++++++++++++--
 arch/riscv/vendor_extensions/Makefile           |  5 +++
 arch/riscv/vendor_extensions/thead/Makefile     |  8 ++++
 arch/riscv/vendor_extensions/thead/extensions.c | 24 ++++++++++
 10 files changed, 144 insertions(+), 3 deletions(-)
---
base-commit: 53cdf865f90ba922a854c65ed05b519f9d728424
change-id: 20230627-thead_vendor_extensions-0d320a311fcb
-- 
- Charlie

