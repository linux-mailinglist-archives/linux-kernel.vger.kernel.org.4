Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51186E6A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjDRQ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjDRQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:58:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62F710CA;
        Tue, 18 Apr 2023 09:58:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so185746wmb.3;
        Tue, 18 Apr 2023 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681837108; x=1684429108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPhxtAgQ/bMNA5WHF5uw25eom2+Kj3BS0BdTTjEj1+Q=;
        b=HUHKq9sZ1yGyf2mc1IPIqTKFjj9Hi+aTiYJAq4k8fZ/4GeHAXqZv+fuTNKJk11LsTD
         pzqfn16ceVx0bbfO/bDZEH7PoEPRFXBLjMbfqF0pSlZK3PfWH/Mwe2FiVK/R5WIeukd9
         ZnU+LYlmJsd5XVXlNTLxs+dB+6yM4yGedue+ra5M5RABibNCsI+CWhjWmj0U7c0UBlRK
         SAnI81t1UEoNvT5TFykfWFysEWExXoaOsAqLhOsmpeg342tF4luJ8vSZX5SpStRNMKVw
         zy3ledFUAH48uXWxPYeWLASu8Gdie+rm1LSld1hsy2fMw1Eh66OtMMRZo8sGFTgdGWMA
         oTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837108; x=1684429108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPhxtAgQ/bMNA5WHF5uw25eom2+Kj3BS0BdTTjEj1+Q=;
        b=hXTuNosGZKzbbRbCcaR2h1l8uWUGI3IQVKtzGrTpzc10ntU5U4dBwgl93jDufOHDMr
         yWkIvtBPBd3l8ohi1EoTBE1VHLfWZfrGeRwx9IlnR3/gL0/PZFw7x7AvmLIOcALKTT+5
         l3n3lzc08+/B6fXjBCTxIHCdqWEBpcUs/FZiSW0d3zpKvkMZUkoEx/Cc6SAx7bRTSKzL
         zKl9z/ig5KTwilcLFyv0r0iJ2dhdJ+GbvebAOd03a86WmmrV1y+f4Vh7GVs175OK2GyD
         GUzzjj7CgMF7I/i3Lmk7xsirjUhC1s2exo56i99x7C9vSRpM2nM0p0Zq0+4BVbvKCTzu
         Dqgg==
X-Gm-Message-State: AAQBX9cBl0To2hqZmlTt9tA9vJfrpRtFwtz2MHwOeb2loNPPShhGIssm
        p5C4XudLpGqC/AKuXlgHORdC1QDIJEY=
X-Google-Smtp-Source: AKy350bGzDRhoH7nzvmd87M2Dk7sNiIhHgCn88WDa9xSnquUzf+ypOvDy0/0vYL4doFhgCr6NM/ksw==
X-Received: by 2002:a7b:ce07:0:b0:3f0:373d:c32b with SMTP id m7-20020a7bce07000000b003f0373dc32bmr14276017wmc.30.1681837107552;
        Tue, 18 Apr 2023 09:58:27 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id v22-20020a7bcb56000000b003f049a42689sm15501732wmj.25.2023.04.18.09.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:58:27 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/4] OpenRISC floating point context support
Date:   Tue, 18 Apr 2023 17:58:09 +0100
Message-Id: <20230418165813.1900991-1-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for storing and restoring the OpenRISC floating point
context as well as user space API's and regsets.

To support these patches an architecture change had to be made.  The OpenRISC
fpu status and control register FPCSR is now read/writeable by user space as of
architecture spec revision 1.4:

 - https://openrisc.io/revisions/r1.4

Previous to this FPCSR reads and writes from user-mode would just be ignored,
reads and writes to non permissioned special purpose registers (SPR's) are
no-ops.

The patch is split into 3 main parts, the first patch being a cleanup to
handling exceptions noticed while working on this.

 1. Add support to context saving and switching
 2. Add support for SIGFPE and sigcontext
 3. Add regset for ptrace register reading/writing

The series has been tested with the glibc test suite and all math tests are
passing.  Patched projects include:

 - GCC - patches upstream to fix issue with resetting exceptions in libgcc
 - glibc - https://github.com/stffrdhrn/or1k-glibc/commits/or1k-hard-float
 - qemu - https://github.com/stffrdhrn/qemu/commits/or1k-user-fpcsr

I have not worked on binutils-gdb patches yet.

Stafford Horne (4):
  openrisc: Properly store r31 to pt_regs on unhandled exceptions
  openrisc: Support storing and restoring fpu state
  openrisc: Support floating point user api
  openrisc: Add floating point regset

 arch/openrisc/include/asm/ptrace.h          |  4 +--
 arch/openrisc/include/uapi/asm/elf.h        |  3 +-
 arch/openrisc/include/uapi/asm/ptrace.h     |  4 +++
 arch/openrisc/include/uapi/asm/sigcontext.h |  1 +
 arch/openrisc/kernel/entry.S                | 31 +++++++++++++----
 arch/openrisc/kernel/head.S                 |  4 +--
 arch/openrisc/kernel/ptrace.c               | 37 +++++++++++++++++++++
 arch/openrisc/kernel/signal.c               |  2 ++
 arch/openrisc/kernel/traps.c                | 27 +++++++++++++--
 9 files changed, 99 insertions(+), 14 deletions(-)

-- 
2.39.1

