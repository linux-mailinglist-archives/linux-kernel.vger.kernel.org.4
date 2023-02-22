Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E7569FE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjBVWNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjBVWNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:13:38 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38CD43903
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:13:18 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h19so6385473qtk.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z6qTlZo0B5zwmjrQDNbY8GBoG16wNTWMqzL5FJPT030=;
        b=NiEIN87upqy8gWiOjlONI8p1m9+YLoABx6IeL3vcJW6HzL6S0t5vwIvH7vj7ymAaqZ
         bMjOCPRgaC9CwV6NzmbXn3Q1Qr40MGYyld8bqrF1DEIIk3GWRrAOIhHQ/iOO7dmFfC+V
         yYpNWsJ36tpfeebDFUvfY38aj3EZ1DQSKI5qN9QsxUxPGWg53YjMQ6Avpiy3GR0m6sRg
         TFpYJi/J1KJAzWzy6XTjGN/BElUxf4HMf3NbiCcRkt6j/7HBYQt3hs1CnqM6mMshuodY
         lBuW9brYGoLqvQy7+MBMFsg8KVyyOcGWk6gl9zT3Jrf/sHzBqiGDIdnbD/OBLiggFhPu
         vT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6qTlZo0B5zwmjrQDNbY8GBoG16wNTWMqzL5FJPT030=;
        b=uDhpuKzWI2Uc0nAEuLckP/iGrn3z1MdS2hwIDESy8fOtP0wMvsN0j4mtgMJfrj1TBr
         ICEx3YHKayzwYwL1Pmys0OR8gVoMcQx20c3WMnxfsVlsTS78bhxLq6r8+A4x3RVZ3Pgx
         1C3NdempHG1iU+hpIaffXxKzAJVbyfQR5P7GB9jgZ3PvfJOzXbFzrEL3ELPzgE11LmS7
         V1hMx2JUaLK2j+UdT5wV9EnzyHkEz2pM6XHWhgpt866gPLKCoTRzPEVnkCOFSOYKJfN0
         A6A9eQliC0/Tmwo4y/FyuYZT+yoi4bsrRxh/oDh2dcaPoVR56awtuAA1i2dqcu7E+QP9
         G/7w==
X-Gm-Message-State: AO0yUKUehrhQG3n6/lSo/qbZpcR3saBypPhQbzwn39ro1feg8T9IP9TS
        mjPfYZDbIEfQXyFqh/PnmwwIpntFnQ==
X-Google-Smtp-Source: AK7set8Yo6rLPh8jELoV7w6B8Y/16hGTNwnlcvKhtsuepxNT3aL0pG9xHSj4CT7L58/chEMai1qVJg==
X-Received: by 2002:a05:622a:1190:b0:3bb:7875:1bd7 with SMTP id m16-20020a05622a119000b003bb78751bd7mr18738945qtk.5.1677103997629;
        Wed, 22 Feb 2023 14:13:17 -0800 (PST)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id ey17-20020a05622a4c1100b003b86b088755sm4902460qtb.15.2023.02.22.14.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 14:13:17 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/6] x86-64: Remove global variables from boot
Date:   Wed, 22 Feb 2023 17:12:55 -0500
Message-Id: <20230222221301.245890-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is on top of the parallel boot v10 series.

Remove the global variables initial_gs, initial_stack, and
early_gdt_descr from the 64-bit boot code.  The stack, GDT, and GSBASE
can be determined from the CPU number.

Brian Gerst (6):
  x86/smpboot: Use CPU number instead of APIC ID for single CPU startup
  x86/smpboot: Use current_task to get idle thread
  x86/smpboot: Remove initial_stack on 64-bit
  x86/smpbppt: Remove early_gdt_descr on 64-bit
  x86/smpboot: Remove initial_gs
  x86/smpboot: Simplify boot CPU setup

 arch/x86/include/asm/processor.h |   6 +-
 arch/x86/include/asm/realmode.h  |   1 -
 arch/x86/include/asm/smp.h       |   1 -
 arch/x86/kernel/acpi/sleep.c     |   5 +-
 arch/x86/kernel/asm-offsets.c    |   1 +
 arch/x86/kernel/head_64.S        | 108 ++++++++++++-------------------
 arch/x86/kernel/smpboot.c        |   6 +-
 arch/x86/xen/xen-head.S          |   2 +-
 kernel/smpboot.c                 |   2 +-
 9 files changed, 53 insertions(+), 79 deletions(-)

-- 
2.39.2

